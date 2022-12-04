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
    apiKey: 'AIzaSyAX1InXIaWlDm0PAw6IEiQ7eT2CGhT_hsc',
    appId: '1:582378144196:web:8b1b938fcba2d64dec2491',
    messagingSenderId: '582378144196',
    projectId: 'algotrade-c5836',
    authDomain: 'algotrade-c5836.firebaseapp.com',
    storageBucket: 'algotrade-c5836.appspot.com',
    measurementId: 'G-2B7Q14CEZG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFWC2xaxZKmCc_hfiFCVoJgWiAql7txLE',
    appId: '1:582378144196:android:5ee0412671170956ec2491',
    messagingSenderId: '582378144196',
    projectId: 'algotrade-c5836',
    storageBucket: 'algotrade-c5836.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwHKtFnssyNn6rtdoXhPm1aSUb39zTflU',
    appId: '1:582378144196:ios:8fdbc9230ded10c3ec2491',
    messagingSenderId: '582378144196',
    projectId: 'algotrade-c5836',
    storageBucket: 'algotrade-c5836.appspot.com',
    iosClientId: '582378144196-vjmpo75gvgt6l47kpg4gfa1t74ruppjo.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectAlgoTrade',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwHKtFnssyNn6rtdoXhPm1aSUb39zTflU',
    appId: '1:582378144196:ios:8fdbc9230ded10c3ec2491',
    messagingSenderId: '582378144196',
    projectId: 'algotrade-c5836',
    storageBucket: 'algotrade-c5836.appspot.com',
    iosClientId: '582378144196-vjmpo75gvgt6l47kpg4gfa1t74ruppjo.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectAlgoTrade',
  );
}
