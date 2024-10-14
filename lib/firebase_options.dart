// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
///
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
    apiKey: 'AIzaSyB79cVbf7UIfIuOYZPXwJkolnXcEsH-_wM',
    appId: '1:81360212564:web:d227c97b696bb1af4fc0bd',
    messagingSenderId: '81360212564',
    projectId: 'swabi-ac71c',
    authDomain: 'swabi-ac71c.firebaseapp.com',
    storageBucket: 'swabi-ac71c.appspot.com',
    measurementId: 'G-TEX1CR3C1H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB79cVbf7UIfIuOYZPXwJkolnXcEsH-_wM',
    appId: '1:81360212564:android:cd7f438db5264ecd96d3c1',
    messagingSenderId: '81360212564',
    projectId: 'swabi-ac71c',
    storageBucket: 'swabi-ac71c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcMTE9r5NAMX8GUaUXVhSkyepPswoV9rk',
    appId: '1:81360212564:ios:c66db283d07d261d4fc0bd',
    messagingSenderId: '81360212564',
    projectId: 'swabi-ac71c',
    storageBucket: 'swabi-ac71c.appspot.com',
    iosBundleId: 'com.phoenixfx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcMTE9r5NAMX8GUaUXVhSkyepPswoV9rk',
    appId: '1:81360212564:ios:c77bdb8c83bffacb4fc0bd',
    messagingSenderId: '81360212564',
    projectId: 'swabi-ac71c',
    storageBucket: 'swabi-ac71c.appspot.com',
    iosBundleId: 'com.example.pheonixfx',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB79cVbf7UIfIuOYZPXwJkolnXcEsH-_wM',
    appId: '1:81360212564:web:5b863561cacbc28f4fc0bd',
    messagingSenderId: '81360212564',
    projectId: 'swabi-ac71c',
    authDomain: 'swabi-ac71c.firebaseapp.com',
    storageBucket: 'swabi-ac71c.appspot.com',
    measurementId: 'G-D1NEQFBK87',
  );
}
