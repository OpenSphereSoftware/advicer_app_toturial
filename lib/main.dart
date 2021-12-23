import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'application/theme/theme_service.dart';
import 'injection.dart' as di;
import 'presentation/advice/advice_page.dart';
import 'theme.dart';

Future initializeApp({required Client client}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(client: client);
  await di.sl<ThemeService>().init();
}

Future main() async {
  await initializeApp(client: Client());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => di.sl<ThemeService>(),
        child: const MaterialAppi());
  }
}

class MaterialAppi extends StatelessWidget {
  const MaterialAppi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
        title: 'Crypto App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        home: const AdvicePage(),
      );
    });
  }
}
