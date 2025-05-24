part of '../constants.dart';

mixin EnvKey {
  static const String baseUrl = 'BASE_URL';
  static const String apiBaseUrl = 'API_BASE_URL';
  static const String baseUrlStorage = 'BASE_URL_STORAGE';
  static const String connectTimeout = 'CONNECT_TIMEOUT';
  static const String receiveTimeout = 'RECEIVE_TIMEOUT';
  static const String appEnv = 'APP_ENVIRONMENT';
}

mixin EnvMode {
  static const String dev = 'dev';
  static const String stg = 'stg';
  static const String prod = 'prod';
}

class EnvConstant {
  static const String baseUrl = String.fromEnvironment(EnvKey.baseUrl);
  static const String baseUrlStorage = String.fromEnvironment(EnvKey.baseUrlStorage);
  static const String apiBaseUrl = String.fromEnvironment(EnvKey.apiBaseUrl);
  static const String connectTimeout = String.fromEnvironment(EnvKey.connectTimeout);
  static const String receiveTimeout = String.fromEnvironment(EnvKey.receiveTimeout);
  static const String appEnv = String.fromEnvironment(EnvKey.appEnv);


  static bool get isDevelopment => appEnv == EnvMode.dev;
  static bool get isStaging => appEnv == EnvMode.stg;
  static bool get isProduction => appEnv == EnvMode.prod;
}
