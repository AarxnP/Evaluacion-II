// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA5UbpETvhJ5eaJNdQTg3TbwUNPzqfMAlY',
    appId: '1:967198652298:web:995153d901b88c3c543a73',
    messagingSenderId: '967198652298',
    projectId: 'app-1-e2c18',
    authDomain: 'app-1-e2c18.firebaseapp.com',
    databaseURL: 'https://app-1-e2c18-default-rtdb.firebaseio.com',
    storageBucket: 'app-1-e2c18.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIc7tsErET9hm6lDTclCGIZPXsqcp1TWw',
    appId: '1:967198652298:android:5c58e441f32a5077543a73',
    messagingSenderId: '967198652298',
    projectId: 'app-1-e2c18',
    databaseURL: 'https://app-1-e2c18-default-rtdb.firebaseio.com',
    storageBucket: 'app-1-e2c18.appspot.com',
  );

}