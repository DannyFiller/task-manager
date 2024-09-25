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
    apiKey: 'AIzaSyBZfokzVfPB53Il1jIE1xWMPo557ALtfic',
    appId: '1:695358435054:web:beeb07ab53c2636ec80dff',
    messagingSenderId: '695358435054',
    projectId: 'task-manager-c7c7c',
    authDomain: 'task-manager-c7c7c.firebaseapp.com',
    storageBucket: 'task-manager-c7c7c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvfg57ptbf0AScenhrd7OfGJHGNPZJxSg',
    appId: '1:695358435054:android:abd0e1cc7576ad71c80dff',
    messagingSenderId: '695358435054',
    projectId: 'task-manager-c7c7c',
    storageBucket: 'task-manager-c7c7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSf_sbj9sDTczBlyHLvOisgW6CoLJjwV0',
    appId: '1:695358435054:ios:45b4c8e728ac3a37c80dff',
    messagingSenderId: '695358435054',
    projectId: 'task-manager-c7c7c',
    storageBucket: 'task-manager-c7c7c.appspot.com',
    iosBundleId: 'com.example.taskManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBSf_sbj9sDTczBlyHLvOisgW6CoLJjwV0',
    appId: '1:695358435054:ios:45b4c8e728ac3a37c80dff',
    messagingSenderId: '695358435054',
    projectId: 'task-manager-c7c7c',
    storageBucket: 'task-manager-c7c7c.appspot.com',
    iosBundleId: 'com.example.taskManager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBZfokzVfPB53Il1jIE1xWMPo557ALtfic',
    appId: '1:695358435054:web:fb0b3b942cf81acbc80dff',
    messagingSenderId: '695358435054',
    projectId: 'task-manager-c7c7c',
    authDomain: 'task-manager-c7c7c.firebaseapp.com',
    storageBucket: 'task-manager-c7c7c.appspot.com',
  );
}
