// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/screens/splash_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:change_app_package_name/change_app_package_name.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:quran/l10n/l10n.dart'; //sesuaikan sama yg atas
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; //harus di view-commanpalatte-dartRestartanalyzserver
import 'package:provider/provider.dart';
import 'package:quran/provider/language_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: Provider.of<LanguageProvider>(context).locale,
        supportedLocales: L10n.all,
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
