import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarma_app/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:flutter_miarma_app/blocs/image_pick_block/image_pick_bloc.dart';
import 'package:flutter_miarma_app/models/post/post_dto.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository.dart';
import 'package:flutter_miarma_app/resources/repository/posts_repository.dart/post_repository_impl.dart';
import 'package:flutter_miarma_app/styles.dart';
import 'package:flutter_miarma_app/ui/menu_screen.dart';
import 'package:flutter_miarma_app/utils/constants.dart';
import 'package:flutter_miarma_app/utils/preferences.dart';
import 'package:image_picker/image_picker.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  late PostRepository postRepository;

  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool isPublic = true;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
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
          return CreatePostBloc(postRepository);
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
          child: BlocConsumer<CreatePostBloc, CreatePostState>(
            listenWhen: (context, state) {
              return state is CreatePostSuccessState ||
                  state is PostCreateError;
            },
            listener: (context, state) {
              if (state is CreatePostSuccessState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuScreen()));
              } else if (state is PostCreateError) {
                _showSnackbar(context, state.message);
              }
            },
            buildWhen: (context, state) {
              return state is CreatePostInitial ||
                  state is CreatePostLoadingState;
            },
            builder: (context, state) {
              if (state is CreatePostInitial) {
                return _buildForm(context);
              } else if (state is CreatePostLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return _buildForm(context);
              }
            },
          ),
        ),
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
                            Image.file(
                              File(state.pickedFile.path),
                              width: 300,
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  PreferenceUtils.setString(
                                      Constants.SHARED_POST_IMAGE_PATH,
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
                            'assets/images/mock_post_photo.png',
                            width: 300,
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Titulo',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Title not valid'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: contentController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Descripción',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 5.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'You need to write some content'
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
                      const Text('Hacer post público'),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final postDto = PostDto(
                            titulo: titleController.text.toString(),
                            contenido: contentController.text.toString(),
                            public: isPublic);
                        BlocProvider.of<CreatePostBloc>(context).add(CreatePost(
                            postDto,
                            PreferenceUtils.getString(
                                Constants.SHARED_POST_IMAGE_PATH)!));
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
                          'Publicar'.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
