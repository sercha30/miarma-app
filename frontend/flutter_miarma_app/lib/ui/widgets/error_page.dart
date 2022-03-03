import 'package:flutter/material.dart';
import 'package:flutter_miarma_app/styles.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final Function retry;

  const ErrorPage({Key? key, required this.message, required this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no-content-photo.png',
            width: 300,
          ),
          Text(
            'No hay posts',
            style: CustomStyles.noContentTitleText,
          ),
          Text(
            'Parece que nadie ha publicado nada aún...',
            style: CustomStyles.noContentSubText,
          ),
          ElevatedButton(
            onPressed: () => retry,
            child: const Text(
              'Actualizar',
            ),
          ),
        ],
      ),
    );
  }
}
