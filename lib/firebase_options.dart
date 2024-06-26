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
    apiKey: 'AIzaSyB2bh4vqNobHA3G19wNWAxhfZZJkaDKxC0',
    appId: '1:301443102586:web:08478a0194157bbd3748c3',
    messagingSenderId: '301443102586',
    projectId: 'skin-detection-440e4',
    authDomain: 'skin-detection-440e4.firebaseapp.com',
    storageBucket: 'skin-detection-440e4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1N1kL9wVpbdHc1FjkthstwxlNWJyRL3s',
    appId: '1:301443102586:android:c67948e72f22a6a13748c3',
    messagingSenderId: '301443102586',
    projectId: 'skin-detection-440e4',
    storageBucket: 'skin-detection-440e4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFhjib8DfoiCam9Sg02r2B9nO_ZvGpFcQ',
    appId: '1:301443102586:ios:1955d048a81dabdb3748c3',
    messagingSenderId: '301443102586',
    projectId: 'skin-detection-440e4',
    storageBucket: 'skin-detection-440e4.appspot.com',
    iosClientId: '301443102586-4hnuf6p2m30o4m6f6i55e323hg3gjkfh.apps.googleusercontent.com',
    iosBundleId: 'com.example.aloria',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFhjib8DfoiCam9Sg02r2B9nO_ZvGpFcQ',
    appId: '1:301443102586:ios:1955d048a81dabdb3748c3',
    messagingSenderId: '301443102586',
    projectId: 'skin-detection-440e4',
    storageBucket: 'skin-detection-440e4.appspot.com',
    iosClientId: '301443102586-4hnuf6p2m30o4m6f6i55e323hg3gjkfh.apps.googleusercontent.com',
    iosBundleId: 'com.example.aloria',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB2bh4vqNobHA3G19wNWAxhfZZJkaDKxC0',
    appId: '1:301443102586:web:31015652d44050ef3748c3',
    messagingSenderId: '301443102586',
    projectId: 'skin-detection-440e4',
    authDomain: 'skin-detection-440e4.firebaseapp.com',
    storageBucket: 'skin-detection-440e4.appspot.com',
  );
}
