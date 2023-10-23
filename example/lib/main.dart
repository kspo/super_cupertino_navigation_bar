import 'package:example/general.dart';
import 'package:example/root_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Brightness>(
        valueListenable: General.instance.notifier,
        builder: (_, mode, __) {
          return CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(brightness: mode),
            localizationsDelegates: const <LocalizationsDelegate<Object>>[
              // ... app-specific localization delegate(s) here
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale('en', 'US'), // English
              Locale('he', 'IL'), // Hebrew
              // ... other locales the app supports
            ],
            routes: {
              '/': (context) => const RootScreen(),
            },
          );
        });
  }
}
