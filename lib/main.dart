import 'package:bmi/feature/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 788),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'BMI Calculator',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF0A0E21),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1D1E33),
              centerTitle: true,
            ),
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}