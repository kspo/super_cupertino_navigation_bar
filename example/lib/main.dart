import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:untitled/samples/apple_all_shortcuts.dart';
import 'package:untitled/samples/apple_clock.dart';
import 'package:untitled/samples/apple_contacts.dart';
import 'package:untitled/samples/apple_folders.dart';
import 'package:untitled/samples/apple_itunes.dart';
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
import 'package:untitled/web_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: false,
      ).copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff000000),
        cardColor: const Color(0xff1B1B1B),
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: CupertinoColors.systemBlue),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
      ],
      title: 'Flutter Demo',
      builder: (context, Widget? child) => WebFrame(
        child: child!,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CustomPageRoute(
              builder: (_) => const Home(title: 'Flutter Demo Home Page'),
              settings: settings,
            );
          case '/apple_tunes':
            return CustomPageRoute(
                builder: (_) => const AppleItunes(), settings: settings);
          case '/play':
            return CustomPageRoute(
                builder: (_) => const Playground(), settings: settings);
          case '/githubinbox':
            return CustomPageRoute(
                builder: (_) => const GithubInbox(), settings: settings);
          case '/githubissues':
            return CustomPageRoute(
                builder: (_) => const GithubIssues(), settings: settings);
          case '/apple_music':
            return CustomPageRoute(
                builder: (_) => const AppleMusic(), settings: settings);
          case '/store':
            return CustomPageRoute(
                builder: (_) => const AppleStore(), settings: settings);
          case '/contacts':
            return CustomPageRoute(
                builder: (_) => const AppleContacts(), settings: settings);
          case '/messages':
            return CustomPageRoute(
                builder: (_) => const AppleMessages(), settings: settings);
          case '/allshorts':
            return CustomPageRoute(
                builder: (_) => const AppleAllShortcuts(), settings: settings);
          case '/whatsapp':
            return CustomPageRoute(
                builder: (_) => const Whatsapp(), settings: settings);
          case '/clock':
            return CustomPageRoute(
                builder: (_) => const AppleClock(), settings: settings);
          case '/folders':
            return CustomPageRoute(
                builder: (_) => const AppleFolders(), settings: settings);
          case '/tips':
            return CustomPageRoute(
                builder: (_) => const AppleTips(), settings: settings);
          case '/gallery':
            return CustomPageRoute(
                builder: (_) => const ShortcutsGallery(), settings: settings);
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomPageRoute extends MaterialWithModalsPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);

  CustomPageRoute({builder, RouteSettings? settings}) : super(builder: builder);
}
