part of '../models.dart';

@freezed
abstract class LiveCensorForm with _$LiveCensorForm {
  const factory LiveCensorForm({
    @Default('') String categoryName,
    @Default([]) List<Censor> data,
  }) = _LiveCensorForm;

  factory LiveCensorForm.fromJson(Map<String, dynamic> json) => _$LiveCensorFormFromJson(json);
}

@freezed
abstract class LiveCensorResultForm with _$LiveCensorResultForm {
  const factory LiveCensorResultForm({
    @Default('') String categoryName,
    @Default([]) List<CensorResult> data,
  }) = _LiveCensorResultForm;

  factory LiveCensorResultForm.fromJson(Map<String, dynamic> json) => _$LiveCensorResultFormFromJson(json);
}

extension LiveCensorFormX on LiveCensorForm {
  LiveCensorResultForm get toLiveCensorResultForm {
    return LiveCensorResultForm(
      categoryName: categoryName,
      data: data.map((e) => e.toCensorResult).toList(),
    );
  }
}
