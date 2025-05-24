part of '../blocs.dart';

@freezed
abstract class EventState with _$EventState {
  const factory EventState({
    @Default(false) bool isLoading,
    @Default(BasePageBreak<Event>()) BasePageBreak<Event> events,
    @Default(Event()) Event currentEvent,
  }) = _EventState;

  factory EventState.initial() => EventState();
}
