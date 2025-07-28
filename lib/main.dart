import 'package:flutter/material.dart';
import 'package:quotidien/pages/add_task.dart';
import 'package:quotidien/pages/history.dart';
import 'package:quotidien/pages/home_page.dart';
import 'package:quotidien/pages/sign_in.dart';
import 'package:quotidien/pages/sign_up.dart';
import 'package:quotidien/pages/splash_screen.dart';
import 'package:quotidien/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/welcome':(context) => const Welcome(),
        '/signin':(context)=> const SignIn(),
        '/signup': (context)=> const SignUp(),
        '/homepage':(context)=> const HomePage(),
        '/history':(context)=> const History(),
        '/addtask':(context)=> const AddTask(),
      },
    );
  }
}
