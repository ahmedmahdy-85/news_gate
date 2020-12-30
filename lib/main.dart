import 'package:flutter/material.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/reg.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/confirmation.dart';
import 'screens/main_screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[400],
        accentColor: Colors.yellow[900],
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        Confirmation.id: (context) => Confirmation(),
        Home.id: (context) => Home(),
      },
    );
  }
}
