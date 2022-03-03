import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma_app/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_miarma_app/models/auth/login/login_dto.dart';
import 'package:flutter_miarma_app/resources/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarma_app/resources/repository/auth_repository/auth_repository_impl.dart';
import 'package:flutter_miarma_app/styles.dart';
import 'package:flutter_miarma_app/ui/home_screen.dart';
import 'package:flutter_miarma_app/ui/menu_screen.dart';
import 'package:flutter_miarma_app/utils/constants.dart';
import 'package:flutter_miarma_app/utils/preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    return BlocProvider(
      create: (context) {
        return LoginBloc(authRepository);
      },
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
            child: BlocConsumer<LoginBloc, LoginState>(
              listenWhen: (context, state) {
                return state is LoginSuccessState || state is LoginErrorState;
              },
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  PreferenceUtils.setString(
                      Constants.SHARED_BEARER_TOKEN, state.loginResponse.token);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuScreen()));
                } else if (state is LoginErrorState) {
                  _showSnackbar(context, state.message);
                }
              },
              buildWhen: (context, state) {
                return state is LoginInitialState || state is LoginLoadingState;
              },
              builder: (context, state) {
                if (state is LoginInitialState) {
                  return _buildForm(context);
                } else if (state is LoginLoadingState) {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MiarmaApp',
          style: CustomStyles.loginTitleText,
        ),
        Container(
          margin: const EdgeInsets.only(top: 50.0, bottom: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        suffixIcon: Icon(Icons.visibility_off),
                        hintText: 'Contraseña',
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
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final loginDto = LoginDto(
                          email: emailController.text,
                          password: passwordController.text);
                      BlocProvider.of<LoginBloc>(context)
                          .add(DoLoginEvent(loginDto));
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
                        'Entrar'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            '¿Has olvidado tu contraseña?',
            style: CustomStyles.secondaryLinkText,
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 25.0),
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
        Container(
          margin: const EdgeInsets.only(bottom: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.facebook,
                color: Colors.blue,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Continuar con Facebook',
                  style: CustomStyles.secondaryLinkText,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿No tienes una cuenta?',
              style: CustomStyles.secondaryText,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: Text(
                  'Regístrate',
                  style: CustomStyles.secondaryLinkText,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
