import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDk1-QBZEv6h3fb7c35ObQseHJTpAOTSRM',
    appId: '1:679787306757:android:1e25e64bd2e8cc31a7e16c',
    messagingSenderId: '679787306757',
    projectId: 'works-with-tab',
    storageBucket: 'works-with-tab.appspot.com',

  );

  static FirebaseOptions get currentPlatform {
    switch(defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform');
  }
}