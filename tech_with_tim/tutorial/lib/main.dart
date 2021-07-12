//import 'dart:html';

import 'package:flutter/material.dart';
import 'myHomePage.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hayatos App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: MyHomePage(),
    );
  }
}



/*
class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Hello Word!");
  }
}
*/