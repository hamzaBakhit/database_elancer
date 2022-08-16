import 'package:database_elancer/screens/app/home_screen.dart';
import 'package:database_elancer/screens/auth/login_screen.dart';
import 'package:database_elancer/screens/core/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,

        //****************** START LOCALIZATION ****************\\
        // localizationsDelegates:  const [
        //   AppLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        localizationsDelegates: AppLocalizations.localizationsDelegates,

        //*********
        //   supportedLocales: const [
        //   // arabic language
        //   Locale('ar'),
        //   // english language
        //   Locale('en'),
        // ],
        supportedLocales: AppLocalizations.supportedLocales,

        locale: const Locale('ar'),
        //******************* END LOCALIZATION *******************\\
        initialRoute: '/launch_screen',
        routes: {
          '/launch_screen': (_) => LaunchScreen(),
          '/login_screen': (_) => LoginScreen(),
          '/home_screen': (_) => HomeScreen(),
        },
      ),
    );
  }
}
