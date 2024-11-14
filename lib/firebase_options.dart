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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCcpgHLhkHGnMIbF4ncKk0Mr8Sqq1b7w9Q',
    appId: '1:877381791108:web:b3f572452682207b13c1d1',
    messagingSenderId: '877381791108',
    projectId: 'bilu-f9a54',
    authDomain: 'bilu-f9a54.firebaseapp.com',
    storageBucket: 'bilu-f9a54.firebasestorage.app',
    measurementId: 'G-NR3F7QQSYB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW4eXnxrk_pI1iiMaL3eJSgQOAsg-gCMQ',
    appId: '1:877381791108:android:915dca9062a108e113c1d1',
    messagingSenderId: '877381791108',
    projectId: 'bilu-f9a54',
    storageBucket: 'bilu-f9a54.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCx_yQJL61Vafngsp8V0aS-VO2BwQCnoUE',
    appId: '1:877381791108:ios:1d46bc522f04e0bf13c1d1',
    messagingSenderId: '877381791108',
    projectId: 'bilu-f9a54',
    storageBucket: 'bilu-f9a54.firebasestorage.app',
    iosBundleId: 'com.example.bilu2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCx_yQJL61Vafngsp8V0aS-VO2BwQCnoUE',
    appId: '1:877381791108:ios:1d46bc522f04e0bf13c1d1',
    messagingSenderId: '877381791108',
    projectId: 'bilu-f9a54',
    storageBucket: 'bilu-f9a54.firebasestorage.app',
    iosBundleId: 'com.example.bilu2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCcpgHLhkHGnMIbF4ncKk0Mr8Sqq1b7w9Q',
    appId: '1:877381791108:web:494cc4695b46df1213c1d1',
    messagingSenderId: '877381791108',
    projectId: 'bilu-f9a54',
    authDomain: 'bilu-f9a54.firebaseapp.com',
    storageBucket: 'bilu-f9a54.firebasestorage.app',
    measurementId: 'G-Y2TJC23P3V',
  );
}
