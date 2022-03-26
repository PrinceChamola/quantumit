import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantumit/utils/sharedpreference_helper.dart';
import 'package:quantumit/view/homepage_screen.dart';
import 'package:quantumit/view/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SharedPreferencesHelper.getLoginValue(SharedPreferencesHelper.loginKey) ?
      HomePageScreen() : SignInScreen(),
    );
  }
}
