part of '../base.dart';

@JsonSerializable(createFactory: false)
@Freezed(genericArgumentFactories: true)
sealed class BasePageBreak<T> with _$BasePageBreak<T> {
  const factory BasePageBreak({
    @Default(0) int currentPage,
    @Default([]) List<T> data,
    @Default('') String firstPageUrl,
    @Default(0) int from,
    @Default(0) int lastPage,
    @Default('') String lastPageUrl,
    @Default('') String nextPageUrl,
    @Default('') String path,
    @Default(0) int perPage,
    @Default('') String prevPageUrl,
    @Default(0) int to,
    @Default(0) int total,
  }) = _BasePageBreakData;

  factory BasePageBreak.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BasePageBreakFromJson(json, fromJsonT);

  
  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) => _$BasePageBreakToJson(this, toJsonT);
}

extension BasePageBreakExtension on BasePageBreak {
  bool get isLastPage => lastPage == currentPage && currentPage > 0;
  int get nextPage => isLastPage ? currentPage : currentPage + 1;
}

