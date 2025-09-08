

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;











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
    apiKey: 'AIzaSyCukBhm2GEUpongM7V1C6DPtRu2A1Cjql0',
    appId: '1:228662284834:web:60513681b1d33d7735f07b',
    messagingSenderId: '228662284834',
    projectId: 'my-task-app-123',
    authDomain: 'my-task-app-123.firebaseapp.com',
    storageBucket: 'my-task-app-123.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaiTN3y2sgsmdQUwDP02CVbcJfsNogezQ',
    appId: '1:228662284834:android:efe5460184375d7c35f07b',
    messagingSenderId: '228662284834',
    projectId: 'my-task-app-123',
    storageBucket: 'my-task-app-123.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAO-WVjDQPXN81LujLaiPrzOWWlanxeMuk',
    appId: '1:228662284834:ios:dcde4ab6f3a644f435f07b',
    messagingSenderId: '228662284834',
    projectId: 'my-task-app-123',
    storageBucket: 'my-task-app-123.firebasestorage.app',
    iosBundleId: 'com.example.taskManager',
  );
}
