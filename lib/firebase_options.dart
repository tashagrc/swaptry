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
    apiKey: 'AIzaSyDoZCEF8m8AfUyfY8J0_EOxj_7ux-S1f3I',
    appId: '1:756398379505:web:ef781db8be8c8f3a553450',
    messagingSenderId: '756398379505',
    projectId: 'swaptry-c875a',
    authDomain: 'swaptry-c875a.firebaseapp.com',
    storageBucket: 'swaptry-c875a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5kya19-esWv_9souC1RQPELnRcuvgXGc',
    appId: '1:756398379505:android:40b74fde24bf6fbe553450',
    messagingSenderId: '756398379505',
    projectId: 'swaptry-c875a',
    storageBucket: 'swaptry-c875a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASI2gZS3mP1hz1JYwCaRJ4Kuwi_UaaNhQ',
    appId: '1:756398379505:ios:01b8bd335feb451b553450',
    messagingSenderId: '756398379505',
    projectId: 'swaptry-c875a',
    storageBucket: 'swaptry-c875a.appspot.com',
    iosClientId: '756398379505-v2f1ssdh9lkonng0ts4h0rofnkl9bciq.apps.googleusercontent.com',
    iosBundleId: 'com.example.swaptry',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASI2gZS3mP1hz1JYwCaRJ4Kuwi_UaaNhQ',
    appId: '1:756398379505:ios:01b8bd335feb451b553450',
    messagingSenderId: '756398379505',
    projectId: 'swaptry-c875a',
    storageBucket: 'swaptry-c875a.appspot.com',
    iosClientId: '756398379505-v2f1ssdh9lkonng0ts4h0rofnkl9bciq.apps.googleusercontent.com',
    iosBundleId: 'com.example.swaptry',
  );
}