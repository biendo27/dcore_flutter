import 'package:firebase_core/firebase_core.dart';

import 'config/services/firebase/firebase_options_dev.dart' as dev;
import 'config/services/firebase/firebase_options_prod.dart' as prod;
import 'config/services/firebase/firebase_options_stg.dart' as stg;

enum Flavor {
  dev,
  stg,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    return switch (appFlavor) {
      Flavor.dev => 'DCore Dev',
      Flavor.stg => 'DCore Staging',
      Flavor.prod => 'DCore',
      _ => 'DCore',
    };
  }

  static FirebaseOptions get firebaseOptions {
    return switch (appFlavor) {
      Flavor.dev => dev.DefaultFirebaseOptions.currentPlatform,
      Flavor.stg => stg.DefaultFirebaseOptions.currentPlatform,
      Flavor.prod => prod.DefaultFirebaseOptions.currentPlatform,
      _ => throw UnsupportedError('No Firebase options set for this flavor')
    };
  }
}
