import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/allConstants/allconstants.dart';
import 'package:travel_app/provider/authprovider.dart';
import 'package:travel_app/chatroom/chathomepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in canceled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in Successful');
        break;
      default:
        break;
    }
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
                vertical: Sizes.dimen_30, horizontal: Sizes.dimen_20),
            children: [
              vertical50,
              const Text(
                'Welcome to Smart Talk',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Sizes.dimen_26, fontWeight: FontWeight.bold),
              ),
              vertical30,
              const Text(
                'Login to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Sizes.dimen_22, fontWeight: FontWeight.w500),
              ),
              vertical50,
              Center(child: Image.asset('assets/images/back.png')),
              vertical50,
              GestureDetector(
                onTap: () async {
                  bool isSuccess = await authProvider.handleGoogleSignIn();
                  if (isSuccess) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatHomePage()));
                  }
                },
                child: Image.asset('assets/images/google_login.jpg'),
              ),
            ],
          ),
          Center(
            child: authProvider.status == Status.authenticating
                ? const CircularProgressIndicator(
                    color: AppColors.lightGrey,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
