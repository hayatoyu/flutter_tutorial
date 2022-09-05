import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_contact_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;

  
  GoogleContacts? contacts;
  bool IsLoading = false;

  Future getUserContact() async {
    const host = "people.googleapis.com";
    const endPoint =
        "/v1/people/me/connections";
    final header = await _currentUser.authHeaders;

    setState(() {
      IsLoading = true;
    });
    print("loading contacts...");

    final response = await http.get(
        Uri(
            scheme: 'https',
            host: host,
            path: endPoint,
            queryParameters: {
              'personFields': 'names,emailAddresses',
              'pageSize': '200',
              'sources': [
                'READ_SOURCE_TYPE_PROFILE',
                'READ_SOURCE_TYPE_CONTACT'
              ]
            }),
        headers: header);
    setState(() {
      IsLoading = false;
    });

    if (response.statusCode == 200) {
      print("Google API works");
      setState(() {
        contacts = googleContactsFromJson(response.body);
      });
    } else {
      print("Google API error");
    }
    print(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn = GoogleSignIn(scopes: [
      "https://www.googleapis.com/auth/contacts.readonly",
    ]);
    _googleSignIn.onCurrentUserChanged.listen((user) {
      setState(() {
        if (user != null) {
          _currentUser = user;
          getUserContact();
        }
      });
      user != null ? print(_currentUser.displayName) : null;
    });

  }

  Widget LoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "See contacts",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 16,
        ),
        OutlinedButton(
          onPressed: () async {
            try {
              await _googleSignIn.signIn();
            } on Exception catch (e) {
              print(e);
            }
          },
          style: OutlinedButton.styleFrom(
            primary: Colors.grey,
            minimumSize: Size(88,36),
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))
            )
          ).copyWith(
            side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if(states.contains(MaterialState.pressed)) {
                return BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1
                );
              }
              return const BorderSide();
            })
          ),
          autofocus: false,
          child: const Text(
            'Google Sign In',
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () async {    
            /*        
            try {
              
              await FacebookAuth.instance.webInitialize(
                appId: '1726154931056260', 
                cookie: true, 
                xfbml: true, 
                version: 'v14.0'
              );
            } on Exception catch(e) {

            }
            */ 
          },
          style: OutlinedButton.styleFrom(
            primary: Colors.grey,
            minimumSize: Size(88,36),
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))
            )
          ).copyWith(
            side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if(states.contains(MaterialState.pressed)) {
                return BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1
                );
              }
              return const BorderSide();
            })
          ),
          autofocus: false,
          child: const Text(
            'Facebook Sign In',
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
        
      ],
    );
  }

  Widget getContactWidget() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final currentContact = contacts!.connections[index];
          return ListTile(
            title: currentContact.names != null
                ? Text(currentContact.names!.first.displayName)
                : const Text("No Name"),
            subtitle: currentContact.emailAddresses != null
                ? Text(currentContact.emailAddresses!.first.value)
                : null,
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: contacts!.connections.length);
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
        child: IsLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : contacts != null && _currentUser != null
                ? getContactWidget()
                : LoginWidget(),
      ),
    );
  }
}
