part of '../services.dart';

mixin HydrateBlocService {
  static Future<void> init() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb ? HydratedStorageDirectory.web : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
  }
}
