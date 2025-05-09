part of '../services.dart';

abstract class BaseInterceptor extends Interceptor {
  final String prefix;
  final bool request;
  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;
  final bool error;
  final int maxRetries;

  BaseInterceptor({
    this.prefix = '',
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.maxRetries = 3,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!request) {
      handler.next(options);
      return;
    }

    final List<String> messageParts = [
      '$prefix REQUEST[${options.method}] => PATH: ${options.uri}',
      if (requestHeader) ...[
        'HEADER: ${options.headers}',
        'Method: ${options.method}',
        'ResponseType: ${options.responseType}',
        'FollowRedirects: ${options.followRedirects}',
        'ConnectTimeout: ${options.connectTimeout}',
        'SendTimeout: ${options.sendTimeout}',
        'ReceiveTimeout: ${options.receiveTimeout}',
        'Extra: ${options.extra}',
      ],
      if (requestBody) _getDataString(options.data),
    ];

    LogDev.info(messageParts.join('\n'));
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!responseBody && !responseHeader) {
      handler.next(response);
      return;
    }

    final List<String> messageParts = [
      '$prefix RESPONSE[${response.statusCode}] => PATH: ${response.realUri.path}',
    ];

    if (responseHeader) {
      messageParts.addAll([
        'StatusCode: ${response.statusCode}',
        if (response.isRedirect == true) 'Redirect: ${response.realUri}',
        'Headers:',
        ...response.headers.map.entries.map((e) => '  ${e.key}: ${e.value.join('\r\n\t')}'),
      ]);
    }

    if (responseBody && response.data != null) {
      messageParts.add(_getDataString(response.data));
    }

    LogDev.data(messageParts.join('\n'));
    handler.next(response);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (error) {
      final List<String> messageParts = [
        '$prefix ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      ];

      if (err.response?.statusCode == null) {
        messageParts.addAll([
          'Error Type: ${err.type}',
          'Error Message: ${err.message}',
          'Stack Trace:\n${_formatStackTrace(err.stackTrace)}',
        ]);
      }

      if (err.response != null) {
        messageParts.add(_getDataString(err.response?.data));
      }

      LogDev.fatal(messageParts.join('\n'));
    }

    if (_shouldRetry(err)) {
      final result = await _retryRequest(err);
      if (result != null) {
        return handler.resolve(result);
      }
    }

    return handler.next(err);
  }

  String _getDataString(dynamic data) {
    if (data == null) return '';
    if (data is FormData) {
      return _formatFormData(data);
    }
    return '\nDATA: ${_formatJsonData(data)}';
  }

  String _formatFormData(FormData data) {
    final List<String> formDataParts = [];

    if (data.fields.isNotEmpty) {
      final fieldString = data.fields.map((e) => '    ${e.key}: ${e.value}').join('\n');
      formDataParts.add('  Fields:\n$fieldString');
    }

    if (data.files.isNotEmpty) {
      final fileString = data.files.map((e) => '    ${e.key}: ${e.value.filename}').join('\n');
      formDataParts.add('  Files:\n$fileString');
    }

    return formDataParts.isNotEmpty ? '\nFORM DATA:\n${formDataParts.join('\n')}' : '';
  }

  String _formatJsonData(dynamic data) {
    if (data is Map || data is List) {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      return '\n${encoder.convert(data)}';
    }
    return data.toString();
  }

  String _formatStackTrace(StackTrace? stackTrace) {
    if (stackTrace == null) return '';
    return stackTrace.toString().split('\n').take(10).join('\n');
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.receiveTimeout;
  }

  Future<Response?> _retryRequest(DioException err) async {
    final options = err.requestOptions;
    final retryCount = options.extra['retryCount'] ?? 0;

    if (retryCount >= maxRetries) return null;

    options.extra['retryCount'] = retryCount + 1;
    try {
      LogDev.info('$prefix Retrying request (${retryCount + 1}/$maxRetries)');
      return await Dio().fetch(options);
    } catch (e) {
      return null;
    }
  }
}

class AppInterceptors extends BaseInterceptor {
  AppInterceptors() : super(prefix: '[App]');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _addHeaders(options);

    super.onRequest(options, handler);
  }

  void _addHeaders(RequestOptions options) {
    final hasNoToken = AppGlobalValue.accessToken.isEmpty;
    final hasNoAuthHeader = !options.headers.containsKey(NetworkConstant.authorization);

    if (hasNoToken) {
      options.headers['language'] = _getCurrentLanguage();
      return;
    }

    if (hasNoAuthHeader) {
      options.headers[NetworkConstant.authorization] = 'Bearer ${AppGlobalValue.accessToken}';
    }
  }

  String _getCurrentLanguage() {
    return AppConfig.context!.read<LocaleCubit>().state.localeData.languageCode;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _checkResponseAuthentication(response);
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    _handleErrorResponses(err);
    await super.onError(err, handler);
  }

  void _checkResponseAuthentication(Response response) {
    final statusCode = response.statusCode;
    switch (statusCode) {
      case HttpStatus.unauthorized:
        _handleUnauthorized();
        break;
      case HttpStatus.gone:
        _handleOtpNotVerify();
        break;
      case HttpStatus.forbidden:
        DMessage.showMessage(type: MessageType.error, message: 'Không tìm thấy tài nguyên');
        break;
    }
  }

  void _handleErrorResponses(DioException err) {
    final statusCode = err.response?.statusCode;
    switch (statusCode) {
      case HttpStatus.unauthorized:
        _handleUnauthorized();
        break;
      case HttpStatus.gone:
        _handleOtpNotVerify();
        break;
      case HttpStatus.forbidden:
        DMessage.showMessage(type: MessageType.error, message: 'Không tìm thấy tài nguyên');
        break;
    }
  }

  void _handleUnauthorized() {
    String currentRouteName = AppConfig.context!.read<PageCubit>().state.currentRouteName;
    if (currentRouteName == RoutePath.login) return;

    AppGlobalValue.accessToken = '';
    AppConfig.context?.read<UserCubit>().clearData();
    DMessage.showMessage(type: MessageType.error, message: 'Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại');
    DNavigator.goNamed(RouteNamed.login);
  }

  void _handleOtpNotVerify() {
    AppConfig.context?.read<AuthBloc>().add(ResendOTPEvent());
    DNavigator.goNamed(RouteNamed.otp);
  }
}

class ThirdPartyInterceptors extends BaseInterceptor {
  ThirdPartyInterceptors() : super(prefix: '[Third Party]');

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!error) {
      await super.onError(err, handler);
      return;
    }

    _handleErrorResponses(err);
    await super.onError(err, handler);
  }

  void _handleErrorResponses(DioException err) {
    final List<String> messageParts = [
      '$prefix ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    ];

    if (err.response?.statusCode == null) {
      messageParts.addAll([
        'Error Type: ${err.type}',
        'Error Message: ${err.message}',
        'Stack Trace:\n${_formatStackTrace(err.stackTrace)}',
      ]);
    }

    if (err.response != null) {
      messageParts.add(_getDataString(err.response?.data));
    }

    LogDev.fatal(messageParts.join('\n'));
  }
}
