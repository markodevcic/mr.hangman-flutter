import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangman/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );

  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('hr', 'HR'),
          Locale('en', 'US'),
        ],
        fallbackLocale: const Locale('en', 'US'),
        path: 'assets/translations',
        child: StartHangman(),
      ),
    ),
  );
}

class StartHangman extends StatelessWidget {
  const StartHangman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.pressStart2p().fontFamily,
        splashFactory: NoSplash.splashFactory,
      ),
      home: SplashScreen(),
    );
  }
}
