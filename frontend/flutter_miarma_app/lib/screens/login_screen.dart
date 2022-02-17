import 'package:flutter/material.dart';
import 'package:flutter_miarma_app/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
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
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 5.0))),
                          onSaved: (String? value) {},
                          validator: (String? value) {},
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                                suffixIcon: Icon(Icons.visibility_off),
                                hintText: 'Contraseña',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 5.0))),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
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
                                'Entrar'.toUpperCase(),
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
            ),
          ),
        ),
      ),
    );
  }
}
