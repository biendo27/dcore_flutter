part of '../base.dart';

@pragma('vm:entry-point')
Future<BaseResponseList<T>> requestListIsolate<T>({
  required Future<BaseResponseList<T>> Function() apiCall,
})  async {
  BaseResponseList<T> result = await apiCall();
  return result;
}

@pragma('vm:entry-point')
Future<BaseResponse<T>> requestIsolate<T>({
  required Future<BaseResponse<T>> Function() apiCall,
}) async {
  BaseResponse<T> result = await apiCall();
  return result;
}

mixin DataStateConvertible {
  DataState<T> convertToDataState<T>(HttpResponse<T> httpRP) {
    if (httpRP.response.statusCode == HttpStatus.ok || httpRP.response.statusCode == HttpStatus.created) {
      return DataSuccess<T>(data: httpRP.data);
    }
    return DataError<T>(
      error: DioException(
        error: httpRP.response.statusMessage,
        response: httpRP.response,
        type: DioExceptionType.badResponse,
        requestOptions: httpRP.response.requestOptions,
      ),
    );
  }

  Future<BaseResponse<T>> request<T>({
    required Future<BaseResponse<T>> Function() apiCall,
    bool enableIsolate = false,
    bool enableErrorMessages = true,
  }) async {
    try {
      BaseResponse<T> response;
      if (enableIsolate) {
        response = await Isolate.run(apiCall);
        // response = await IsolateService.handleApiCall(apiCall) as BaseResponse<T>;
        return response;
      }
      response = await apiCall();
      return response;
    } on DioException catch (e) {
      if (enableErrorMessages) {
        DMessage.showMessage(
          type: MessageType.error,
          message: e.response?.data['message'],
        );
      }
      if (kDebugMode) rethrow;
      return Future.error(e);
    }
  }

  Future<BaseResponseList<T>> requestList<T>({
    required Future<BaseResponseList<T>> Function() apiCall,
    bool enableIsolate = false,
    bool enableErrorMessages = true,
  }) async {
    try {
      BaseResponseList<T> response;
      if (enableIsolate) {
        response = await Isolate.run(apiCall);
        // response = await IsolateService.handleApiCallList(apiCall) as BaseResponseList<T>;
        return response;
      }
      response = await apiCall();
      return response;
    } on DioException catch (e) {
      if (enableErrorMessages) {
        DMessage.showMessage(
          type: MessageType.error,
          message: e.response?.data['message'],
        );
      }
      if (kDebugMode) rethrow;
      DMessage.showMessage(
        type: MessageType.error,
        message: e.response?.data['message'],
      );
      return Future.error(e);
    }
  }

  Future<T> requestThirdParty<T>({
    required Future<T> Function() apiCall,
    bool enableIsolate = false,
    bool enableErrorMessages = true,
  }) async {
    try {
      T response;
      if (enableIsolate) {
        response = await Isolate.run(apiCall);
        return response;
      }
      response = await apiCall();
      return response;
    } on DioException catch (e) {
      if (enableErrorMessages) {
        DMessage.showMessage(
          type: MessageType.error,
          message: e.response?.data['message'],
        );
      }
      if (kDebugMode) rethrow;
      return Future.error(e);
    }
  }

  Future<List<T>> requestThirdPartyList<T>({
    required Future<List<T>> Function() apiCall,
    bool enableIsolate = false,
    bool enableErrorMessages = true,
  }) async {
    try {
      List<T> response = [];
      if (enableIsolate) {
        response = await Isolate.run(apiCall);
        return response;
      }
      response = await apiCall();
      return response;
    } on DioException catch (e) {
      if (enableErrorMessages) {
        DMessage.showMessage(
          type: MessageType.error,
          message: e.response?.data['message'],
        );
      }
      if (kDebugMode) rethrow;
      return Future.error(e);
    }
  }
}
