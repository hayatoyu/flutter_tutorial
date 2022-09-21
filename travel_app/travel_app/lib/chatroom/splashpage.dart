import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/allConstants/allconstants.dart';
import 'package:travel_app/provider/authprovider.dart';
import 'package:travel_app/chatroom/chathomepage.dart';
import 'package:travel_app/chatroom/loginpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 20),
      () {
        checkSignedIn();
      }
    );
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if(isLoggedIn) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const ChatHomePage())
      );
      return;
    }
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => const LoginPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome To Smart Talk",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizes.dimen_18
              ),
            ),
            Image.asset(
              'assets/images/splash.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Smartest Chat Application",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizes.dimen_18
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              color: AppColors.lightGrey,
            )
          ],
        ),
      ),
    );
  }
}