import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebaseoptions.dart';
import 'package:travel_app/provider/authprovider.dart';
import 'provider/chatprovider.dart';
import 'provider/homeprovider.dart';
import 'provider/profileprovider.dart';
import 'chatroom/splashpage.dart';
import 'utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({Key? key, required this.prefs}) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            googleSignIn: GoogleSignIn(), 
            firebaseAuth: FirebaseAuth.instance, 
            firebaseFirestore: firebaseFirestore, 
            prefs: prefs
          ),
        ),
        Provider<ProfileProvider>(
          create: (_) => ProfileProvider(
            prefs: prefs, 
            firebaseFirestore: firebaseFirestore, 
            firebaseStorage: firebaseStorage
          ),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(firebaseFirestore: firebaseFirestore),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: prefs,
            firebaseStorage: firebaseStorage,
            firebaseFirestore: firebaseFirestore
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Smart Talk",
        theme: appTheme,
        home: const SplashPage(),
      ),
    );
  }
}
