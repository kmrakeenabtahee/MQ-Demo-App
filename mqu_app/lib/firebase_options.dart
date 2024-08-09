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
    apiKey: 'AIzaSyCGtKUH-CJjl8wpvJ3kXpStDUsnC1MBvM0',
    appId: '1:781363875775:web:480b04fd049f7c8a4a1b0a',
    messagingSenderId: '781363875775',
    projectId: 'mquapp-52a89',
    authDomain: 'mquapp-52a89.firebaseapp.com',
    storageBucket: 'mquapp-52a89.appspot.com',
    measurementId: 'G-ZRDCG6SXJM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMqtUISzLAGA5qEHQycTjAAD3dT3wYgtI',
    appId: '1:781363875775:android:c16fe44cd68b40fd4a1b0a',
    messagingSenderId: '781363875775',
    projectId: 'mquapp-52a89',
    storageBucket: 'mquapp-52a89.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPcjSvqvh1CSTXUxSqwTVFGrkuinR6_AE',
    appId: '1:781363875775:ios:eacb5b92212ae3934a1b0a',
    messagingSenderId: '781363875775',
    projectId: 'mquapp-52a89',
    storageBucket: 'mquapp-52a89.appspot.com',
    iosBundleId: 'com.example.mquApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPcjSvqvh1CSTXUxSqwTVFGrkuinR6_AE',
    appId: '1:781363875775:ios:eacb5b92212ae3934a1b0a',
    messagingSenderId: '781363875775',
    projectId: 'mquapp-52a89',
    storageBucket: 'mquapp-52a89.appspot.com',
    iosBundleId: 'com.example.mquApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCGtKUH-CJjl8wpvJ3kXpStDUsnC1MBvM0',
    appId: '1:781363875775:web:99e5e1fce589a5f04a1b0a',
    messagingSenderId: '781363875775',
    projectId: 'mquapp-52a89',
    authDomain: 'mquapp-52a89.firebaseapp.com',
    storageBucket: 'mquapp-52a89.appspot.com',
    measurementId: 'G-QG8W7M05T9',
  );
}
