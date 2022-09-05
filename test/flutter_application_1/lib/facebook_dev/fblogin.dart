import 'dart:math';
import 'dart:io' show Platform;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_contact_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FBLogin extends StatefulWidget {
  FBLogin({super.key});

  final plugin = FacebookLogin(
    debug: true
  );

  @override
  State<FBLogin> createState() => _FBLoginState();
}

class _FBLoginState extends State<FBLogin> {

  String? _sdkVersion;
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _email, _imageUrl;

  @override
  void initState() {
    super.initState();
    _getSdkVersion();
    _updateLoginInfo();
  }

  Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile, FacebookAccessToken accessToken, String? email) {
    final avatarUrl = _imageUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(avatarUrl != null)
          Center(
            child: Image.network(avatarUrl),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('User: '),
            Text(
              '${profile.firstName} ${profile.lastName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
        const Text('Access Token: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        if (email != null)
          Text(
            'Email: $email'
          )
      ],
    );
  }

  Future<void> _onPressedLogInButton() async {
    await widget.plugin.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]
    );
    await _updateLoginInfo();
  }

  Future<void> _onPressedExpressLogInButton(BuildContext context) async {
    final res = await widget.plugin.expressLogin();
    if(res.status == FacebookLoginStatus.success) {
      await _updateLoginInfo();
    } else {
      await showDialog<Object>(
        context: context, 
        builder: (context) => const AlertDialog(
          content: Text("Can't make express log in. Try regular log in"),
        )
      );
    }
  }

  Future<void> _onPressedLogOutButton() async {
    await widget.plugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateLoginInfo() async {
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email, imageUrl;
    
    if(token != null) {      
      profile = await plugin.getUserProfile();
      if(token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    setState(() {
      _token = token;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
      print('_token = ${_token.toString()}');
      print('_profile = ${_profile.toString()}');
      print('_email = $_email');
      print('_imageUrl = $_imageUrl');
    });
    
  }



  @override
  Widget build(BuildContext context) {
    final isLogin = (_token != null && _profile != null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login via Facebook Example')
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 8.0
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              if(_sdkVersion != null)
                Text('SDK v$_sdkVersion'),
              if(isLogin)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10
                  ),
                  child: _buildUserInfo(context, _profile!, _token!, _email),
                ),
              isLogin
                ? OutlinedButton(
                  onPressed: _onPressedLogOutButton,
                  child: const Text('Log Out'),
                )
                : OutlinedButton(
                  onPressed: _onPressedLogInButton,
                  child: const Text('Log In'),
                ),
              if(!isLogin && Platform.isAndroid)
                OutlinedButton(
                  onPressed: () => _onPressedExpressLogInButton(context),
                  child: const Text('Express Log In'),
                )
            ],
          ),
        ),
      ),
    );
  }
}