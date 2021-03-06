import 'package:flutter/material.dart';
import 'package:quest/Screens/paper_page.dart';
import 'package:quest/Screens/upload_paper.dart';
import 'package:quest/Screens/welcome_screen.dart';
import 'package:quest/Screens/year_page.dart';
import 'Screens/login_screen.dart';
import 'Screens/registration_screen.dart';
import 'Screens/welcome_screen.dart';
import 'Screens/profile_page.dart';
import 'Screens/VerificationScreen.dart';
import 'Screens/Resource_page.dart';
import 'Screens/resource_page_teacher.dart';
import 'Screens/paper_page_teacher.dart';
import 'Screens/upload_paper.dart';
import 'Screens/predictionpagr.dart';
import 'Screens/paper_book_video.dart';
import 'Screens/syllubuspage.dart';
import 'Screens/predictionanspage.dart';
import 'Screens/resource_page_admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: WelcomeScreen(),
      routes: {
        ResourceScreen2.id: (context) => ResourceScreen2(),
        FinalAnswer.id: (context) => FinalAnswer(),
        Syllubus.id: (context) => Syllubus(),
        PredictionPage.id: (context) => PredictionPage(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        VerifyScreen.id: (context) => VerifyScreen(),
        ResourceScreen.id: (context) => ResourceScreen(),
        YearScreen.id: (context) => YearScreen(),
        PaperScreen.id: (context) => PaperScreen(),
        ResourceScreen1.id: (context) => ResourceScreen1(),
        PaperScreen1.id: (context) => PaperScreen1(),
        UploadScreen.id: (context) => UploadScreen(),
        PBVScreen.id: (context) => PBVScreen(),
      },
    );
  }
}
