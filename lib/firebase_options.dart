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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeyetYPG-4uMuZtI5MAb4FLMuegntb4kE',
    appId: '1:255404280562:android:255c2cc53a09456f585e6b',
    messagingSenderId: '255404280562',
    projectId: 'my-notes-practise-app',
    storageBucket: 'my-notes-practise-app.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDCT4pxD3e8_1iojXGK8d463DqI5szS4DY',
    appId: '1:255404280562:web:a4e8edcbeeb8f432585e6b',
    messagingSenderId: '255404280562',
    projectId: 'my-notes-practise-app',
    authDomain: 'my-notes-practise-app.firebaseapp.com',
    storageBucket: 'my-notes-practise-app.appspot.com',
    measurementId: 'G-X35P54D97R',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDCT4pxD3e8_1iojXGK8d463DqI5szS4DY',
    appId: '1:255404280562:web:7674be5115315a71585e6b',
    messagingSenderId: '255404280562',
    projectId: 'my-notes-practise-app',
    authDomain: 'my-notes-practise-app.firebaseapp.com',
    storageBucket: 'my-notes-practise-app.appspot.com',
    measurementId: 'G-8ZVZ065H2W',
  );

}