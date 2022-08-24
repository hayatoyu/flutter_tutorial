import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_contact_model.dart';
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
  GoogleContacts? contacts;
  bool IsLoading = false;

  Future getUserContact() async {
    const host = "people.googleapis.com";
    const endPoint =
        "/v1/people/me/connections?personFields=names,emailAddresses";
    final header = await _currentUser.authHeaders;

    setState(() {
      IsLoading = true;
    });
    print("loading contacts...");

    final response = await http.get(
        Uri(
            scheme: 'https',
            host: host,
            path: '/v1/people/me/connections',
            queryParameters: {
              'personFields': 'names,emailAddresses',
              'pageSize': '30',
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
          "See contacts saved in your gmail",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 16,
        ),
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

  Widget getContactWidget() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final currentContact = contacts!.connections[index];
          if(currentContact.names != null) {
            return ListTile(
              title: Text(currentContact.names!.first.displayName),
            );
          } else {
            return const ListTile(
              title: Text("No Name"),
            );
          }
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
