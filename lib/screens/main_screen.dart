// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:q/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? token;

  checkUserLoginState() async {
    await SharedPrefs.getToken().then((value) {
      setState(() {
        token = value;
      });
    });
  }

//
  @override
  void initState() {
    checkUserLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return token != null ? HomeScreen() : LoginScreen();
  }
}
