library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui' as ui;

//* Import all dependencies here
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:app_links/app_links.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:camera/camera.dart';
import 'package:dcore/flavors.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gal/gal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:unity_ads_plugin/unity_ads_plugin.dart';

//* Import all files here
import '../../core/constants/constants.dart';
import '../../core/helpers/helpers.dart';
import '../../core/responses/responses.dart';
import '../../core/utils/utils.dart';
import '../../src/data/models/models.dart';
import '../../src/presentation/blocs/blocs.dart';
import '../../src/presentation/pages/message/message.dart';
import '../di/di.dart';
import '../routes/routes.dart';
import '../share/share.dart';

//* Export all service files here
part 'ads/ad_mob_service.dart';
part 'ads/unity_ads_service.dart';
part 'app/app_service.dart';
part 'app/isolate_service.dart';
part 'app/route_observer_service.dart';
part 'device/camera_service.dart';
part 'device/device_info_service.dart';
part 'device/hydrated_service.dart';
part 'device/local_store_service.dart';
part 'device/storage_service.dart';
part 'file/file_service.dart';
part 'file/media_service.dart';
part 'network/dio_service.dart';
part 'network/interceptor_service.dart';
part 'network/network_service.dart';
part 'notification/notification_service.dart';
part 'notification/notification_setting_service.dart';
part 'deeplink/deep_link_service.dart';
part 'location/geolocator_service.dart';
part 'iap/in_app_service.dart';
part 'livestream/live_service.dart';
part 'location/map_service.dart';
