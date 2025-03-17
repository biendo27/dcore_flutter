part of '../services.dart';

mixin DeepLinkService {
  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription<Uri>? _uriStreamController;

  static void init() {
    _uriStreamController = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri == null) return;
      AppConfig.context?.read<PageCubit>().navigationFromService(uri);
    });
  }

  void dispose() {
    _uriStreamController?.cancel();
  }
}
