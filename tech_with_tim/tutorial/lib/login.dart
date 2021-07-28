import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myHomePage.dart';
import 'auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello World!"),
        ),
        body: Body());
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = null;

  void click() {
    signInWithGoogle().then((user) => {
      this.user = user,
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => MyHomePage(user.displayName!))
      )
    });
    
  }

  Widget googleLoginButton() {
    return OutlinedButton(
      onPressed: this.click, 
      style: ShapeBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: 
    );
  }
}
