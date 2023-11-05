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
    apiKey: 'AIzaSyDmEzYRsAFBZb76zajWVABGa2x_91QQbSA',
    appId: '1:644938166888:web:c408a2e7f1ce9f540641dd',
    messagingSenderId: '644938166888',
    projectId: 'crudflutter-d5c71',
    authDomain: 'crudflutter-d5c71.firebaseapp.com',
    storageBucket: 'crudflutter-d5c71.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJ-0RVy3yxniMu6gmod8tmwA0eQqAVcIk',
    appId: '1:644938166888:android:5785adc34e71ab1f0641dd',
    messagingSenderId: '644938166888',
    projectId: 'crudflutter-d5c71',
    storageBucket: 'crudflutter-d5c71.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVeQUd-cmJLRQH7gpkMckPNB9uLk0EZz8',
    appId: '1:644938166888:ios:1aa7993d7604762d0641dd',
    messagingSenderId: '644938166888',
    projectId: 'crudflutter-d5c71',
    storageBucket: 'crudflutter-d5c71.appspot.com',
    iosBundleId: 'com.example.flutterFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVeQUd-cmJLRQH7gpkMckPNB9uLk0EZz8',
    appId: '1:644938166888:ios:fa649c35ce8d6fe10641dd',
    messagingSenderId: '644938166888',
    projectId: 'crudflutter-d5c71',
    storageBucket: 'crudflutter-d5c71.appspot.com',
    iosBundleId: 'com.example.flutterFirebase.RunnerTests',
  );
}
