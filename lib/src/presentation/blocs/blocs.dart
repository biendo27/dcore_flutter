library;

//* Import all default dart libraries here
import 'dart:async';
import 'dart:convert';
import 'dart:io';

//* Import all dependencies here
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:camera/camera.dart' hide ImageFormat;
import 'package:cloud_firestore/cloud_firestore.dart' as db;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
// import 'package:zalo_flutter/zalo_flutter.dart';

//* Import all local files here
import '../../../config/di/di.dart';
import '../../../config/routes/routes.dart';
import '../../../config/services/services.dart';
import '../../../config/share/share.dart';
import '../../../config/themes/themes.dart';
import '../../../core/base/base.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/utils.dart';
import '../../data/datasources/sockets/sockets.dart';
import '../../data/models/models.dart';
import '../../domain/repositories/repositories.dart';
import '../../domain/usecases/usecases.dart';

//? Affiliate Bloc
part 'affiliate/affiliate_cubit.dart';
part 'affiliate/affiliate_state.dart';
//* Export all the blocs here
//? Auth Bloc
part 'auth/auth_bloc.dart';
part 'auth/auth_event.dart';
part 'auth/auth_state.dart';
//? Base Bloc
part 'blocs.freezed.dart';
part 'blocs.g.dart';
//? Camera Bloc
part 'camera/camera_cubit.dart';
part 'camera/camera_state.dart';
//? Cart Bloc
part 'cart/cart_cubit.dart';
part 'cart/cart_state.dart';
//? Comment Bloc
part 'comment/comment_cubit.dart';
part 'comment/comment_state.dart';
//? Config Bloc
part 'config/config_cubit.dart';
part 'config/config_state.dart';
//? Create Post Bloc
part 'create_post/create_post_cubit.dart';
part 'create_post/create_post_state.dart';
//? Delivery Address Bloc
part 'delivery_address/delivery_address_cubit.dart';
part 'delivery_address/delivery_address_state.dart';
//? Download Bloc
part 'download/download_cubit.dart';
part 'download/download_state.dart';
//? Event Bloc
part 'event/event_cubit.dart';
part 'event/event_state.dart';
//? Flash Sale Bloc
part 'flash_sale/flash_sale_cubit.dart';
part 'flash_sale/flash_sale_state.dart';
//? Gift Bloc
part 'gift/gift_cubit.dart';
part 'gift/gift_state.dart';
//? Hashtag Bloc
part 'hashtag/hashtag_cubit.dart';
part 'hashtag/hashtag_state.dart';
//? Home Search Bloc
part 'home_search/home_search_cubit.dart';
part 'home_search/home_search_state.dart';
//? In App Bloc
part 'in_app/in_app_cubit.dart';
part 'in_app/in_app_state.dart';
//? Live Bloc
part 'live/live_cubit.dart';
part 'live/live_state.dart';
//? Live Censor Bloc
part 'live_censor/live_censor_cubit.dart';
part 'live_censor/live_censor_state.dart';
//? Live Comment Bloc
part 'live_comment/live_comment_cubit.dart';
part 'live_comment/live_comment_state.dart';
//? Live Event Bloc
part 'live_event/live_event_cubit.dart';
part 'live_event/live_event_state.dart';
//? Live Gift Bloc
part 'live_gift/live_gift_cubit.dart';
part 'live_gift/live_gift_state.dart';
//? Live Heart Bloc
part 'live_heart/live_heart_cubit.dart';
//? Live Mission Bloc
part 'live_mission/live_mission_cubit.dart';
part 'live_mission/live_mission_state.dart';
//? Live Request Bloc
part 'live_request/live_request_cubit.dart';
part 'live_request/live_request_state.dart';
//? Live Setting Bloc
part 'live_setting/live_setting_cubit.dart';
part 'live_setting/live_setting_state.dart';
//? Live Socket Bloc
part 'live_socket/live_socket_cubit.dart';
part 'live_socket/live_socket_state.dart';
//? Live Viewer Bloc
part 'live_viewer/live_viewer_cubit.dart';
part 'live_viewer/live_viewer_state.dart';
//? Message Bloc
part 'message/message_cubit.dart';
part 'message/message_state.dart';
//? Moderation Bloc
part 'moderation/moderation_cubit.dart';
part 'moderation/moderation_state.dart';
//? Notification Bloc
part 'notification/notification_cubit.dart';
part 'notification/notification_state.dart';
//? Order Bloc
part 'order/order_cubit.dart';
part 'order/order_state.dart';
//? Order Action Bloc
part 'order_action/order_action_cubit.dart';
part 'order_action/order_action_state.dart';
//? Order List Bloc
part 'order_list/order_list_cubit.dart';
part 'order_list/order_list_state.dart';
//? Order Payment Method Bloc
part 'order_payment_method/order_payment_method_cubit.dart';
part 'order_payment_method/order_payment_method_state.dart';
//? Order Review Bloc
part 'order_review/order_review_cubit.dart';
part 'order_review/order_review_state.dart';
//? Page Bloc
part 'page/page_cubit.dart';
part 'page/page_state.dart';
//? Post Bloc
part 'post/post_cubit.dart';
part 'post/post_state.dart';
//? Product Bloc
part 'product/product_cubit.dart';
part 'product/product_state.dart';
//? Product Filter Bloc
part 'product_filter/product_filter_cubit.dart';
part 'product_filter/product_filter_state.dart';
//? Product Suggest Bloc
part 'product_suggest/product_suggest_cubit.dart';
part 'product_suggest/product_suggest_state.dart';
//? Profile Bloc
part 'profile/profile_cubit.dart';
part 'profile/profile_state.dart';
//? Profile Preview Bloc
part 'profile_preview/profile_preview_cubit.dart';
part 'profile_preview/profile_preview_state.dart';
//? Rank Bloc
part 'rank/rank_cubit.dart';
part 'rank/rank_state.dart';
//? Receipt Bloc
part 'receipt/receipt_cubit.dart';
part 'receipt/receipt_state.dart';
//? Refund Banking Bloc
part 'refund_banking/refund_banking_cubit.dart';
part 'refund_banking/refund_banking_state.dart';
//? Report Bloc
part 'report/report_cubit.dart';
part 'report/report_state.dart';
//? Review Bloc
part 'review/review_cubit.dart';
part 'review/review_state.dart';
//? Search Bloc
part 'search/search_cubit.dart';
part 'search/search_state.dart';
//? Setting Bloc
part 'setting/locale_cubit.dart';
part 'setting/theme_cubit.dart';
part 'setting/theme_mode_cubit.dart';
//? Sound Bloc
part 'sound/sound_cubit.dart';
part 'sound/sound_state.dart';
//? Store Home Bloc
part 'store_home/store_home_cubit.dart';
part 'store_home/store_home_state.dart';
//? User Bloc
part 'user/user_cubit.dart';
part 'user/user_state.dart';
//? User List Bloc
part 'user_list/user_list_cubit.dart';
part 'user_list/user_list_state.dart';
//? Video Bloc
part 'video/video_cubit.dart';
part 'video/video_state.dart';
//? Wallet Bloc
part 'wallet/wallet_cubit.dart';
part 'wallet/wallet_state.dart';

//? gift Bloc
part 'gift_shop/gift_shop_cubit.dart';
part 'gift_shop/gift_shop_state.dart';
