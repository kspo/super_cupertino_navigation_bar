import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:untitled/samples/apple_all_shortcuts.dart';
import 'package:untitled/samples/apple_clock.dart';
import 'package:untitled/samples/apple_contacts.dart';
import 'package:untitled/samples/apple_folders.dart';
import 'package:untitled/samples/apple_messages.dart';
import 'package:untitled/samples/apple_music.dart';
import 'package:untitled/samples/apple_shortcuts_gallery.dart';
import 'package:untitled/samples/apple_store.dart';
import 'package:untitled/samples/apple_tips.dart';
import 'package:untitled/samples/github_inbox.dart';
import 'package:untitled/samples/github_issues.dart';
import 'package:untitled/samples/home.dart';
import 'package:untitled/samples/playground.dart';
import 'package:untitled/samples/whatsapp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: false,
      ).copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          scaffoldBackgroundColor: const Color(0xff424242),
          cardColor: const Color(0xff1e1d1d),
          iconTheme: const IconThemeData(color: CupertinoColors.systemBlue),
          cardTheme: CardTheme(
            color: const Color(0xff1e1d1d),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          )),
      themeMode: ThemeMode.dark,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialWithModalsPageRoute(
              builder: (_) => const Home(title: 'Flutter Demo Home Page'),
              settings: settings,
            );
          case '/play':
            return MaterialWithModalsPageRoute(
                builder: (_) => const Playground(), settings: settings);
          case '/githubinbox':
            return MaterialWithModalsPageRoute(
                builder: (_) => const GithubInbox(), settings: settings);
          case '/githubissues':
            return MaterialWithModalsPageRoute(
                builder: (_) => const GithubIssues(), settings: settings);
          case '/apple_music':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleMusic(), settings: settings);
          case '/store':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleStore(), settings: settings);
          case '/contacts':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleContacts(), settings: settings);
          case '/messages':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleMessages(), settings: settings);
          case '/allshorts':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleAllShortcuts(), settings: settings);
          case '/whatsapp':
            return MaterialWithModalsPageRoute(
                builder: (_) => const Whatsapp(), settings: settings);
          case '/clock':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleClock(), settings: settings);
          case '/folders':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleFolders(), settings: settings);
          case '/tips':
            return MaterialWithModalsPageRoute(
                builder: (_) => const AppleTips(), settings: settings);
          case '/gallery':
            return MaterialWithModalsPageRoute(
                builder: (_) => const ShortcutsGallery(), settings: settings);
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomPageRoute extends CupertinoPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  CustomPageRoute({builder}) : super(builder: builder);
}
