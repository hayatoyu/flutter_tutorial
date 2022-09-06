import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FBLogin2 extends StatefulWidget {
  FBLogin2({super.key});

  LoginResult? result;
  Map<String,dynamic>? userData;

  @override
  State<FBLogin2> createState() => _FBLogin2State();
}

class _FBLogin2State extends State<FBLogin2> {

  Future<void> getUserData() async {
    widget.result = await FacebookAuth.i.login(
      permissions: ['email','public_profile','user_friends'],
    );
    if(widget.result!.status == LoginStatus.success) {
      widget.userData = await FacebookAuth.i.getUserData(
        fields: "name,email,id,friends"
      );
    }
    print(widget.userData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in via Facebook'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 10
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              OutlinedButton(
                onPressed: getUserData,
                child: const Text('Log in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}