import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/screens/home.dart';
import 'package:todoapp/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());


}



class MyApp extends StatefulWidget {
  const MyApp({super.key});



  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home:  splash_screen(),


    );
  }
}

