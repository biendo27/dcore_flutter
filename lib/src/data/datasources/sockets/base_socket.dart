part of 'sockets.dart';

abstract class BaseSocket {
  final String socketName;
  final String socketUrl;
  late Socket socket;
  List<String> listenerEvents = [];

  BaseSocket({
    this.socketName = 'BASE',
    this.socketUrl = 'ws://dev.venusshop.top:3000',
  });

  void initSocket() {
    socket = io(
      socketUrl,
      OptionBuilder().setTransports(['websocket'])
          // .disableAutoConnect() // disable auto-connection
          .setExtraHeaders({'Authorization': 'Bearer ${AppGlobalValue.accessToken}'}).build(),
    );
    LogDev.one('INITIALIZED $socketName SOCKET SUCCESSFULLY');
  }

  void initDefaultListener({
    dynamic Function(dynamic)? onConnectSuccess,
    dynamic Function(dynamic)? onDisconnectSuccess,
    dynamic Function(dynamic)? onError,
    dynamic Function(dynamic)? onReconnect,
    dynamic Function(dynamic)? onReconnectFailed,
    void Function(String)? updateUserSocketId,
  }) {
    socket.onConnect((data) {
      LogDev.one('CONNECTED TO $socketName SOCKET SUCCESSFULLY');
      onConnectSuccess?.call(data);
      updateUserSocketId?.call(socket.id ?? '');
    });

    socket.onDisconnect((data) {
      LogDev.one('DISCONNECTED FROM $socketName SOCKET SUCCESSFULLY');
      onDisconnectSuccess?.call(data);
    });

    socket.onError((data) {
      LogDev.one('ERROR FROM $socketName SOCKET: $data');
      onError?.call(data);
    });

    socket.onReconnect((data) {
      LogDev.one('RECONNECTED TO $socketName SOCKET SUCCESSFULLY');
      onReconnect?.call(data);
      updateUserSocketId?.call(socket.id ?? '');
    });

    socket.onReconnectFailed((data) {
      LogDev.one('RECONNECT FAILED TO $socketName SOCKET');
      onReconnectFailed?.call(data);
    });
  }

  void initConnection() {
    socket.connect();
  }

  void closeConnection() {
    socket.disconnect();
  }

  void initListener();
  void initEmitter();
  void addListener(String event, dynamic Function(dynamic) callback) {
    socket.on(event, (data) {
      callback(data);
      LogDev.data('LISTEN $socketName SOCKET EVENT: $event \r\nDATA: $data');
    });
    listenerEvents.add(event);
  }

  void removeListener(String event) {
    socket.off(event);
    LogDev.one('REMOVE LISTENER $socketName SOCKET EVENT: $event');
  }

  void removeAllListener() {
    // socket.offAny();
    for (var event in listenerEvents) {
      removeListener(event);
    }
  }
}
