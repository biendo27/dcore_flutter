part of 'di.dart';

@module
abstract class NetworkModule {
  @Named(DIKey.baseUrl)
  @lazySingleton
  String get baseUrl => EnvConstant.apiBaseUrl;

  @Named(DIKey.connectTimeout)
  int get connectTimeout => int.parse(EnvConstant.connectTimeout);

  @Named(DIKey.receiveTimeout)
  int get receiveTimeout => int.parse(EnvConstant.receiveTimeout);

  @Named(DIKey.token)
  String get token => AppGlobalValue.accessToken;

  @Named(DIKey.refreshToken)
  String get refreshToken => AppGlobalValue.refreshToken;

  @Named(DIKey.appInterceptor)
  @lazySingleton
  Interceptor get appInterceptor => AppInterceptors();

  @Named(DIKey.thirdPartyInterceptor)
  @lazySingleton
  Interceptor get thirdPartyInterceptor => ThirdPartyInterceptors();

  @Named(DIKey.appDio)
  @lazySingleton
  Dio appDio(
    NetworkService networkService,
    @Named(DIKey.appInterceptor) Interceptor interceptor,
  ) {
    final dio = networkService.createDio();
    dio.interceptors.add(interceptor);
    return dio;
  }

  @Named(DIKey.thirdPartyDio)
  @lazySingleton
  Dio thirdPartyDio(
    NetworkService networkService,
    @Named(DIKey.thirdPartyInterceptor) Interceptor interceptor,
  ) {
    final dio = networkService.createDioThirdParty();
    dio.interceptors.add(interceptor);
    return dio;
  }
}
