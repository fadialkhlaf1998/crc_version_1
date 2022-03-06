import 'dart:math';
import 'package:crc_version_1/app_localization.dart';
import 'package:crc_version_1/helper/app.dart';
import 'package:crc_version_1/helper/global.dart';
import 'package:crc_version_1/helper/myTheme.dart';
import 'package:crc_version_1/view/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void set_local(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  @override
  void initState() {
    super.initState();
    Global.load_language().then((language) {
      setState(() {
        _locale= Locale(language);
      });
      Get.updateLocale(Locale(language));
    });

  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: myTheme.myTheme,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        locale: _locale,
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        localizationsDelegates: const [
          App_Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (local, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == local!.languageCode) {
              Global.lang_code=supportedLocale.languageCode;
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },

        home: IntroView()
    );
  }

}
