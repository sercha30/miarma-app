import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

import '../styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(CustomStyles.bodyPadding),
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
                    'Regístrate para ver las fotos y vídeos de tus amigos',
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
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
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
                  height: 350,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: 'Nick o email',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0))),
                          onSaved: (String? value) {},
                          validator: (String? value) {},
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: 'Nombre',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0))),
                          onSaved: (String? value) {},
                          validator: (String? value) {},
                        ),
                        TextFormField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: 'Apellidos',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0))),
                          onSaved: (String? value) {},
                          validator: (String? value) {},
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: 'Nick',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0))),
                          onSaved: (String? value) {},
                          validator: (String? value) {},
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: 'Contraseña',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0))),
                          onSaved: (String? value) {},
                          validator: (String? value) {},
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {});
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                    'Al registarte, aceptas nuestros Términos, Política de Datos y Política de Cookies.',
                    style: CustomStyles.secondaryText,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes una cuenta?',
                      style: CustomStyles.secondaryText,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Inicia sesión',
                          style: CustomStyles.secondaryLinkText,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
