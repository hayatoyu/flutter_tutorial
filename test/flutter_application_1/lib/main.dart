import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/facebook_dev/fblogin.dart';
import 'package:flutter_application_1/facebook_dev/fblogin2.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const LoginScreen()
      home: LoginScreen(),
    );
  }
}
