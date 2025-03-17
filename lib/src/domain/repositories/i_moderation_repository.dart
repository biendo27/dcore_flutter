part of 'repositories.dart';

abstract interface class IModerationRepository {
  Future<ModerationResponse> checkVideoBelowOneMinute(File video);
  Future<ModerationResponse> checkVideoAboveOneMinute(File video);
} 