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
    apiKey: 'AIzaSyCRXfqqTiBbrZJCFNq2BoHZja4pigq-BiY',
    appId: '1:583402201140:web:0e8fde9f65ec45e751aa61',
    messagingSenderId: '583402201140',
    projectId: 'fir-73e7d',
    authDomain: 'fir-73e7d.firebaseapp.com',
    storageBucket: 'fir-73e7d.appspot.com',
    measurementId: 'G-HDM2TPGS97',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVZIspKUh7f89XUOGjvJdSyxj4K8xXdQg',
    appId: '1:583402201140:android:8f3db18e14c8666751aa61',
    messagingSenderId: '583402201140',
    projectId: 'fir-73e7d',
    storageBucket: 'fir-73e7d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBL-N_loe4K6ibO3eOm6xCshl1kVhQJFgg',
    appId: '1:583402201140:ios:96bc7373a02b857e51aa61',
    messagingSenderId: '583402201140',
    projectId: 'fir-73e7d',
    storageBucket: 'fir-73e7d.appspot.com',
    iosBundleId: 'com.example.firebase',
  );
}
