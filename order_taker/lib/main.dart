import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_taker/themes/themes.dart';

import 'views/resources/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(child: OrderTaker()),
  );
}

class OrderTaker extends StatelessWidget {
  const OrderTaker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        navigatorKey: navigatorKey,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: Routes.auth,
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: appBarColor,
            iconTheme: const IconThemeData(color: accentBlackColor),
            elevation: 0,
          ),
          textTheme: TextTheme(
            headline1: GoogleFonts.roboto(
              color: accentBlackColor,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
            headline2: GoogleFonts.roboto(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: complementaryColor,
            ),
            headline3: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: accentBlackColor,
            ),
            headline4: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: accentBlackColor,
            ),
            headline5: GoogleFonts.roboto(
              color: accentBlackColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            headline6: GoogleFonts.roboto(
              color: accentBlackColor,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
            // subtitle1: GoogleFonts.roboto(
            //   color: accentColor,
            //   fontSize: 35,
            //   fontStyle: FontStyle.italic,
            //   fontWeight: FontWeight.bold,
            // ),
            subtitle2: GoogleFonts.roboto(
              color: accentBlackColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
