part of '../services.dart';

mixin FlutterIsolateService {
  @pragma('vm:entry-point')
  static void _initIsolate(String message) {
    LogDev.one('Received: $message');
  }

  static Future<void> init() async {
    FlutterIsolate.spawn(_initIsolate, "Isolate Service Init");
  }
}

mixin IsolateService {
  static IsolateWorker? isolateWorker;

  static Future<void> init() async {
    Completer<IsolateWorker> completer = Completer<IsolateWorker>.sync();
    isolateWorker = await IsolateWorker.spawn();
    completer.complete(isolateWorker!);
  }

  static void close() {
    isolateWorker?.close();
    isolateWorker = null;
  }

  static Future<BaseResponse> handleApiCall(Future<BaseResponse> Function() apiCall) async {
    return await isolateWorker!.handleApiCall(apiCall);
  }

  static Future<BaseResponseList> handleApiCallList(Future<BaseResponseList> Function() apiCall) async {
    return await isolateWorker!.handleApiCallList(apiCall);
  }
}

class IsolateWorker {
  final SendPort _mainSendPort;
  final ReceivePort _mainReceiptPost;
  final Map<int, Completer<BaseResponse>> _activeRequests = {};
  final Map<int, Completer<BaseResponseList>> _activeRequestsList = {};
  int _idCounter = 0;
  bool _closed = false;

  Future<BaseResponse> handleApiCall(Future<BaseResponse> Function() apiCall) async {
    if (_closed) throw StateError('ISOLATE SERVICE CLOSED');
    final completer = Completer<BaseResponse>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _mainSendPort.send((id, apiCall));
    return await completer.future;
  }

  Future<BaseResponseList> handleApiCallList(Future<BaseResponseList> Function() apiCall) async {
    if (_closed) throw StateError('ISOLATE SERVICE CLOSED');
    final completer = Completer<BaseResponseList>.sync();
    final id = _idCounter++;
    _activeRequestsList[id] = completer;
    _mainSendPort.send((id, apiCall));
    return await completer.future;
  }

  IsolateWorker._(this._mainReceiptPost, this._mainSendPort) {
    _mainReceiptPost.listen(_mainIsolatehandleResponses);
    LogDev.info('--- ISOLATE SERVICE INITIAL ---');
  }

  static Future<IsolateWorker> spawn() async {
    // Create a receive port and add its initial message handler
    final RawReceivePort rawMainReceivePort = RawReceivePort();
    final Completer<(ReceivePort, SendPort)> connection = Completer<(ReceivePort, SendPort)>.sync();
    rawMainReceivePort.handler = (initialMessage) {
      final SendPort mainSendPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(rawMainReceivePort),
        mainSendPort,
      ));
    };

    // Spawn the isolate.
    try {
      await Isolate.spawn(
        _startWorkerIsolate,
        rawMainReceivePort.sendPort,
        debugName: 'IsolateService',
        // onError: initPort.sendPort,
        // onExit: initPort.sendPort,
      );
    } on Object {
      rawMainReceivePort.close();
      rethrow;
    }

    final (ReceivePort mainReceiptPort, SendPort mainSendPort) = await connection.future;
    return IsolateWorker._(mainReceiptPort, mainSendPort);
  }

  static void _startWorkerIsolate(SendPort workerSendPort) {
    final workerReceivePort = ReceivePort();
    workerSendPort.send(workerReceivePort.sendPort);
    _workerIsolateHandleCommand(workerReceivePort, workerSendPort);
  }

  static void _workerIsolateHandleCommand(
    ReceivePort workerReceivePort,
    SendPort workerSendPort,
  ) {
    workerReceivePort.listen((message) async {
      if (message is String) {
        if (message == IsolateConstants.isolateServiceClose) {
          workerReceivePort.close();
          return;
        }

        AppGlobalValue.accessToken = message;
        return;
      }

      //* Handle the request
      final (int id, Future<BaseResponse> Function() apiCall) = message as (int, Future<BaseResponse> Function());
      try {
        final BaseResponse response = await apiCall();
        workerSendPort.send((id, response));
      } catch (e) {
        workerSendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  void _mainIsolatehandleResponses(dynamic message) {
    final (int id, BaseResponse response) = message as (int, BaseResponse);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _mainReceiptPost.close();
  }

  void close() {
    if (_closed) return;
    _closed = true;
    _mainSendPort.send(IsolateConstants.isolateServiceClose);
    if (_activeRequests.isEmpty) _mainReceiptPost.close();
    LogDev.info('--- ISOLATE SERVICE CLOSE ---');
  }
}
