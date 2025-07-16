import 'package:bmi/feature/bmi/screens/bmi_input_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1D1E33),
          centerTitle: true,
        ),
      ),
      home: const BMIInputScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
