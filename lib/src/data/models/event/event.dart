part of '../models.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String image,
    @Default('') String description,
    @Default(null) DateTime? startTime,
    @Default(null) DateTime? endTime,
    @Default('') String content,
    @Default(Voucher()) Voucher voucher,
    @Default(0) int status,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
