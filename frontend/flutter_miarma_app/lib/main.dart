import 'package:flutter/material.dart';
import 'package:flutter_miarma_app/utils/preferences.dart';
import 'ui/login_screen.dart';
import 'ui/menu_screen.dart';
import 'ui/register_screen.dart';

void main() {
  runApp(const MyApp());
  PreferenceUtils.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiarmaApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MenuScreen()
      },
    );
  }
}
