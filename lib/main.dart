import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application/theme/theme_service.dart';
import 'injection.dart' as di;
import 'presentation/advice/advice_page.dart';
import 'theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl<ThemeService>().init();
  runApp(ChangeNotifierProvider(
    create: (context) => di.sl<ThemeServiceImpl>(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeServiceImpl>(
      builder: (context, themeService, child) {
        return MaterialApp(
          title: 'Crypto App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: const AdvicePage(),
        );
      },
    );
  }
}
