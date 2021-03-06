import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  final String adviceText;
  const AdviceField({Key? key, required this.adviceText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
            color: themeData.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          '''" $adviceText "''',
          textAlign: TextAlign.center,
          style: themeData.textTheme.headline1!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
