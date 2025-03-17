part of '../constants.dart';

mixin NetworkConstant {
  static const int receiveTimeout = 30000;
  static const int connectTimeout = 30000;

  static const String contentType = 'Content-Type';
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'application/x-www-form-urlencoded';
  static const String contentTypeFormData = 'multipart/form-data';
  static const String authorization = 'Authorization';
}