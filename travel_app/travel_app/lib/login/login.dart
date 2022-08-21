import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/profile/profile.dart';
import 'loggedpage.dart';
import 'signin.dart';


class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const FlutterLogo(size: 150),
              const SizedBox(height: 50),
              _signInButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      primary: Colors.grey,
      minimumSize: Size(88,36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2))
      )
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
        if(states.contains(MaterialState.pressed)) {
          return BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1
          );
        }
        return const BorderSide();
      })
    );
    return OutlinedButton(
      style: outlineButtonStyle,
      onPressed: () async {
        /*
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context){
              return LoggedPage();
            })
        );
        */
        GoogleSignInAccount? _currentUser = await _googleSignIn.signIn();
        
      }, 
      child: Text('Sign in with Google'),
      );
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ] 
);