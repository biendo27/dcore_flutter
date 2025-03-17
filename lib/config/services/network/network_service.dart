part of '../services.dart';

@lazySingleton
class NetworkService {
  final String baseUrl;
  final int connectTimeout;
  final int receiveTimeout;
  final String token;
  final String refreshToken;

  NetworkService({
    @Named(DIKey.baseUrl) required this.baseUrl,
    @Named(DIKey.connectTimeout) this.connectTimeout = 30000,
    @Named(DIKey.receiveTimeout) this.receiveTimeout = 30000,
    @Named(DIKey.token) this.token = '',
    @Named(DIKey.refreshToken) this.refreshToken = '',
  });

  Map<String, dynamic> get headers => {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

  Map<String, dynamic> get thirdPartyHeaders => {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };

  Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        validateStatus: (status) => status != null && status >= 200 && status < 500,
      ),
    );

    return dio;
  }

  Dio createDioThirdParty() {
    final dio = Dio(
      BaseOptions(
        headers: thirdPartyHeaders,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        validateStatus: (status) => status != null && status >= 200 && status < 500,
      ),
    );

    return dio;
  }
}
