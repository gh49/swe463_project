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
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCFcsCfdha3OSJpREBgW2ou80tkr8bDEK8',
    appId: '1:390331907236:web:06752673bb2475f3b0ba31',
    messagingSenderId: '390331907236',
    projectId: 'swe463project-55757',
    authDomain: 'swe463project-55757.firebaseapp.com',
    storageBucket: 'swe463project-55757.appspot.com',
    measurementId: 'G-FEGBZE3BDD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAj8W5PRmHcsqikIWwwTUer0X8MfvKuCcA',
    appId: '1:390331907236:android:a7c42d54c488ae06b0ba31',
    messagingSenderId: '390331907236',
    projectId: 'swe463project-55757',
    storageBucket: 'swe463project-55757.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwvrSyZTnjxME8u3zwNNNO64n7uSUY2Sk',
    appId: '1:390331907236:ios:dc5a3b38f3554744b0ba31',
    messagingSenderId: '390331907236',
    projectId: 'swe463project-55757',
    storageBucket: 'swe463project-55757.appspot.com',
    iosBundleId: 'com.example.swe463Project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwvrSyZTnjxME8u3zwNNNO64n7uSUY2Sk',
    appId: '1:390331907236:ios:f3ce00c2a5cc7264b0ba31',
    messagingSenderId: '390331907236',
    projectId: 'swe463project-55757',
    storageBucket: 'swe463project-55757.appspot.com',
    iosBundleId: 'com.example.swe463Project.RunnerTests',
  );
}
