part of '../blocs.dart';

@freezed
abstract class LiveSocketState with _$LiveSocketState {
  const factory LiveSocketState({
    @Default(false) bool isLoading,
    @Default(SocketLiveStatus.none) SocketLiveStatus status,
    @Default('') String roomId,
  }) = _LiveSocketState;

  factory LiveSocketState.initial() => LiveSocketState();
}

enum SocketLiveStatus {
  none,
  connected,
  disconnected,
  connecting,
  disconnecting,
  error,
}
