import 'package:advicer/injection.dart';
import 'package:advicer/presentation/advice/advice_page.dart';
import 'package:advicer/theme.dart';
import 'package:flutter/material.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: AdvicePage(),
    );
  }
}


