import 'package:flutter/material.dart';
import 'package:todo_sat_c9/ui/screens/home/home_screen.dart';
import 'package:todo_sat_c9/ui/screens/splash/splash_screen.dart';
import 'package:todo_sat_c9/ui/utils/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeScreen.routeName: (_) => HomeScreen()
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}