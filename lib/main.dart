import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twinzy/screens/splash-screen/splash-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:twinzy/shared/shared.dart';
import 'package:twinzy/theme/colors.dart';
import 'package:twinzy/widgets/buttom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sharedCheck = prefs.getString('phone');
  user!["email"] = prefs.getString('email');
  user!["firstName"] = prefs.getString('firstName');
  user!["id"] = prefs.getString('id');
  user!["password"] = prefs.getString('password');
  user!["phone"] = prefs.getString('phone');
  user!["lastName"] = prefs.getString('lastName');
  // local = prefs.getString('local')!;
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: local, supportedLocales: ['en', 'ar']);
  await Firebase.initializeApp();
  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Twinzy',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  labelStyle: TextStyle(fontSize: 15.0)),
              primarySwatch: primaryColor,
              backgroundColor: background,
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontFamily: 'Segoe',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              fontFamily: 'Segoe'),
          home: sharedCheck == null ? SplashScreen() : const HomePage(),
        ),
      ),
    );
  }
}
