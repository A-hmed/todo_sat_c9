import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sat_c9/providers/list_provider.dart';
import 'package:todo_sat_c9/ui/screens/auth/login/login.dart';
import 'package:todo_sat_c9/ui/screens/auth/register/register.dart';
import 'package:todo_sat_c9/ui/screens/home/home_screen.dart';
import 'package:todo_sat_c9/ui/screens/splash/splash_screen.dart';
import 'package:todo_sat_c9/ui/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(ChangeNotifierProvider(
      create: (_){
        return ListProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: AppTheme.lightTheme,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}