part of '../blocs.dart';

@freezed
abstract class LiveCommentState with _$LiveCommentState {
  const factory LiveCommentState({
    @Default(false) bool isLoading,
    @Default(Live()) Live currentLive,
    @Default(BasePageBreak<Comment>()) BasePageBreak<Comment> liveComments,
    @Default(LiveExtraInfo()) LiveExtraInfo liveExtraInfo,
    @Default(false) bool isAllCommentLoaded,
    @Default(0) int pinTime,
  }) = _LiveCommentState;

  factory LiveCommentState.initial() => LiveCommentState();
}

extension LiveCommentStateExtension on LiveCommentState {
  int get lastCommentId {
    int lastIndex = liveComments.data.length - 1;
    int lastCommentId = liveComments.data.isEmpty ? 0 : liveComments.data[lastIndex].id;
    if (lastCommentId == 0 && liveComments.data.length > 1) {
      lastCommentId = liveComments.data[lastIndex - 1].id;
    }
    return lastCommentId;
  }
}
