part of 'sockets.dart';

@Named(DIKey.socketLive)
@LazySingleton(as: BaseSocket)
class SocketLive extends BaseSocket {
  SocketLive() : super(socketName: 'LIVE', socketUrl: 'ws://dev.venusshop.top:3000');

  @override
  void initEmitter() {
    socket.emit('msg', 'test');
  }

  @override
  void initListener() {
    socket.on('msg', (data) => LogDev.one(data));
  }
}
