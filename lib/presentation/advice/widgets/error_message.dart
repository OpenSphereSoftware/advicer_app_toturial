import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          color: Colors.redAccent,
          size: 40,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Ups, there was something going wrong, try again!',
          textAlign: TextAlign.center,
          style: themeData.textTheme.headline1!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
