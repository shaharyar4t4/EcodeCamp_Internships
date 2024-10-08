import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/pages/HomePage.dart';
import 'package:expense_tracker/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async{
  //initialize hive
  await Hive.initFlutter();

  //open hive box
  await Hive.openBox("expense_database2");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create:(context) =>  ExpenseData(),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: splash_screen(),
        ),
    );
  }
}

