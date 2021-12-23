
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      key: const Key("customButton"),
      onTap: onPressed,
      child: Material(
        elevation: 16,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: themeData.colorScheme.secondary,
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            'Get Advice',
            textAlign: TextAlign.center,
            style: themeData.textTheme.headline1!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
