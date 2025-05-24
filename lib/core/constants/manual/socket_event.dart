part of '../constants.dart';

mixin LiveSocketListenerEvent {
  static String newComment(roomId) => 'laravel_database_$roomId';
  static String newGift(roomId) => 'laravel_database_$roomId-gift';
  static String userJoin(roomId) => 'laravel_database_$roomId-join';
  static String userLeave(roomId) => 'laravel_database_$roomId-leave';
  static String newHeart(roomId) => 'laravel_database_$roomId-like';
  static String newViewer(roomId) => '$roomId';
  static String newPinComment(roomId) => 'laravel_database_$roomId-pin-comment';
  static String newOrderLive(roomId) => 'laravel_database_$roomId-order-live';
  static String newPinProduct(roomId) => 'laravel_database_$roomId-pin-product';
  static String newUserReceiveGift(roomId) => 'laravel_database_$roomId-give-gift';
  static String newSettingGift(roomId) => 'laravel_database_$roomId-setting-gift';
}
