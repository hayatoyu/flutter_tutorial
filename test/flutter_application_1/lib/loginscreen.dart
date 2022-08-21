import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn = GoogleSignIn(
      scopes: [
        "https://www.googleapis.com/auth/contacts.readonly",        
      ]
    );
    _googleSignIn.onCurrentUserChanged.listen(
      (user) { 
        setState(() {
          _currentUser = user!;
        });
        print(_currentUser.displayName);
      }
    );
  }

  Widget LoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("See contacts saved in your gmail",style: TextStyle(fontSize: 24),),
        const SizedBox(height: 16,),
        FloatingActionButton(
          backgroundColor: Colors.grey[900],
          onPressed: () async {
            try {
              await _googleSignIn.signIn();
            } on Exception catch (e) {
              print(e);
            }
          },
          child: const Text(
            "Google Sign in",
            style: TextStyle(color: Colors.white),
          ),          
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact app"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: LoginWidget(),
      ),
    );
  }
}