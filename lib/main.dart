import 'package:flutter/material.dart';
import 'package:sign_in_sign_out_with_firebase/screens/home.dart';
import 'package:sign_in_sign_out_with_firebase/screens/login.dart';
import 'package:sign_in_sign_out_with_firebase/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login And Registration',
      theme: ThemeData(
   
        primarySwatch: Colors.red,
      ),
      home: const Login_screen(),
    );
  }
}

