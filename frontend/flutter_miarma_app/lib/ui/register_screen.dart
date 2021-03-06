import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma_app/blocs/image_pick_block/image_pick_bloc.dart';
import 'package:flutter_miarma_app/blocs/register_bloc/register_bloc.dart';
import 'package:flutter_miarma_app/models/auth/register/register_dto.dart';
import 'package:flutter_miarma_app/resources/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarma_app/resources/repository/auth_repository/auth_repository_impl.dart';
import 'package:flutter_miarma_app/utils/constants.dart';
import 'package:flutter_miarma_app/utils/preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_button/sign_button.dart';

import '../styles.dart';
import 'login_screen.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthRepository authRepository;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  bool isPublic = true;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return RegisterBloc(authRepository);
        }),
        BlocProvider(create: (context) {
          return ImagePickBlocBloc();
        })
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _createBody(context),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(CustomStyles.bodyPadding),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listenWhen: (context, state) {
                return state is RegisterSuccessState ||
                    state is RegisterErrorState;
              },
              listener: (context, state) {
                if (state is RegisterSuccessState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                } else if (state is RegisterErrorState) {
                  _showSnackbar(context, state.message);
                }
              },
              buildWhen: (context, state) {
                return state is RegisterInitialState ||
                    state is RegisterLoadingState;
              },
              builder: (context, state) {
                if (state is RegisterInitialState) {
                  return _buildForm(context);
                } else if (state is RegisterLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _buildForm(context);
                }
              },
            )),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'MiarmaApp',
            style: CustomStyles.loginTitleText,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Reg??strate para ver las fotos y v??deos de tus amigos',
              style: CustomStyles.registerSubText,
              textAlign: TextAlign.center,
            ),
          ),
          SignInButton(
            btnText: 'Entrar con Facebook',
            buttonType: ButtonType.facebook,
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Stack(alignment: AlignmentDirectional.center, children: [
              const Divider(
                color: CustomStyles.secondaryTextColor,
                thickness: 1.0,
              ),
              Container(
                width: 50.0,
                color: Colors.white,
                child: Text(
                  'O',
                  style: CustomStyles.secondaryText,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 700,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                    listenWhen: (context, state) {
                      return state is ImageSelectedSuccessState;
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return state is ImagePickBlocInitial ||
                          state is ImageSelectedSuccessState;
                    },
                    builder: (context, state) {
                      if (state is ImageSelectedSuccessState) {
                        print('PATH ${state.pickedFile.path}');
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(state.pickedFile.path),
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  PreferenceUtils.setString(
                                      Constants.SHARED_AVATAR_IMAGE_PATH,
                                      state.pickedFile.path);
                                },
                                child: const Text('Subir imagen'))
                          ],
                        );
                      }
                      return Center(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<ImagePickBlocBloc>(context).add(
                                const SelectImageEvent(ImageSource.gallery));
                          },
                          child: Image.asset(
                            'assets/images/mock-avatar.png',
                            width: 150,
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Nick o email',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || !value.contains('@'))
                          ? 'Email not valid'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Nombre',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'You need to write your name'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Apellidos',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'You need to write your last name'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Nick',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'You need to write your nick'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Contrase??a',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'You need to write your password'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: password2Controller,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Repita su contrase??a',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'You need to write again your password'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: birthdateController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Fecha de nacimiento',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'You need to write your birthdate'
                          : null;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isPublic,
                          onChanged: (value) {
                            setState(() {
                              isPublic = value!;
                            });
                          }),
                      const Text('Hacer perfil p??blico'),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final registerDto = RegisterDto(
                            nick: usernameController.text,
                            email: emailController.text,
                            nombre: nameController.text,
                            apellidos: lastNameController.text,
                            fechaNacimiento: birthdateController.text,
                            public: isPublic,
                            password: passwordController.text,
                            password2: password2Controller.text);
                        BlocProvider.of<RegisterBloc>(context).add(
                            DoRegisterEvent(
                                registerDto,
                                PreferenceUtils.getString(
                                    Constants.SHARED_AVATAR_IMAGE_PATH)!));
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        decoration: BoxDecoration(
                            color: CustomStyles.loginButtonColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Registrarse'.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Al registarte, aceptas nuestros T??rminos, Pol??tica de Datos y Pol??tica de Cookies.',
              style: CustomStyles.secondaryText,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '??Ya tienes una cuenta?',
                style: CustomStyles.secondaryText,
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Inicia sesi??n',
                    style: CustomStyles.secondaryLinkText,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
