import 'package:flutter/material.dart';
import 'package:quest_app/Screens/welcome_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/registration_screen.dart';
import 'Screens/welcome_screen.dart';
import 'Screens/profile_page.dart';
import 'Screens/VerificationScreen.dart';
import 'Screens/Resource_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        VerifyScreen.id: (context) => VerifyScreen(),
        ResourceScreen.id: (context) => ResourceScreen(),
      },
    );
  }
}
