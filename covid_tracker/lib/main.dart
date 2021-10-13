import 'package:covid_tracker/data_sorce.dart';
import 'package:covid_tracker/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  // GestureBinding.instance!.resamplingEnabled = true; //
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryBlack,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
