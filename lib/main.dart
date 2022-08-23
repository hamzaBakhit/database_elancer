import 'package:database_elancer/database/db_controller.dart';
import 'package:database_elancer/prefs/shared_pref_controller.dart';
import 'package:database_elancer/provider/languageProvider.dart';
import 'package:database_elancer/provider/products_provider.dart';
import 'package:database_elancer/screens/app/products/products_screen.dart';
import 'package:database_elancer/screens/auth/login_screen.dart';
import 'package:database_elancer/screens/auth/register_screen.dart';
import 'package:database_elancer/screens/core/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initialPreferences();
  await DbController().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<LanguageProvider>(
              create: (context) => LanguageProvider()),
          ChangeNotifierProvider<ProductsProvimainder>(
              create: (context) => ProductsProvimainder()),
        ],
        builder: (context, widget) => MaterialApp(
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

          locale: Locale(Provider.of<LanguageProvider>(context).language),
          //******************* END LOCALIZATION *******************\\
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (_) => LaunchScreen(),
            '/login_screen': (_) => LoginScreen(),
            '/products_screen': (_) => ProductsScreen(),
            '/register_screen': (_) => RegisterScreen(),
          },
        ),
      ),
    );
  }
}
