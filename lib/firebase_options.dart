// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
        return windows;

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
    apiKey: 'AIzaSyD9w7tecHyYt9cI_638xW6h1JfD1Uu1_8Q',
    appId: '1:912175833319:web:055542fc6977ba80dd0242',
    messagingSenderId: '912175833319',
    projectId: 'muysser-4c16c',
    authDomain: 'muysser-4c16c.firebaseapp.com',
    storageBucket: 'muysser-4c16c.appspot.com',
    measurementId: 'G-5B7ZKLMY2M',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD9w7tecHyYt9cI_638xW6h1JfD1Uu1_8Q',
    appId: '1:912175833319:web:59bda1a1b56bf2f7dd0242',
    messagingSenderId: '912175833319',
    projectId: 'muysser-4c16c',
    authDomain: 'muysser-4c16c.firebaseapp.com',
    storageBucket: 'muysser-4c16c.appspot.com',
    measurementId: 'G-WB8J0TW83G',
  );
}
