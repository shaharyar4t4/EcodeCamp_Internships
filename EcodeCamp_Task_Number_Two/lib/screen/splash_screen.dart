
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screen/home.dart';

import '../const.dart';


class splash_screen extends StatefulWidget{
  @override
  State<splash_screen> createState() => _splash_screenState();

}


class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {

      // this code specific for Replace the page and not show the splash screen
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));

    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: tdBGcolor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                  image: DecorationImage(
                    image: AssetImage('assets/image/wapp.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}