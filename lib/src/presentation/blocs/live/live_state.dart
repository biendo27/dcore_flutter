part of '../blocs.dart';

@freezed
abstract class LiveState with _$LiveState {
  const factory LiveState({
    @Default(false) bool isLoading,
    @Default(BasePageBreak<Live>()) BasePageBreak<Live> liveList,
    @Default(BasePageBreak<LiveSchedule>()) BasePageBreak<LiveSchedule> myScheduleList,
    @Default(BasePageBreak<BreakSchedule>()) BasePageBreak<BreakSchedule> breakScheduleList,
    @Default(BasePageBreak<Product>()) BasePageBreak<Product> liveOtherProducts,
    @Default(Live()) Live currentLive,
    @Default(Live()) Live nearestLive,
    @Default(BreakSchedule()) BreakSchedule currentBreakSchedule,
    @Default(LiveBooth()) LiveBooth liveBooth,
    @Default(UsageTerm()) UsageTerm voucherUsageTerms,
  }) = _LiveState;

  factory LiveState.initial() => LiveState();
  factory LiveState.fromJson(Map<String, dynamic> json) => _$LiveStateFromJson(json);
}

extension LiveStateExtension on LiveState {
  Map<DateTime, List<Live>> get myLiveScheduleMap {
    // split by myScheduleList.data.startAt
    // key: startAt date value, ignore time
    // value: [Live]

    Map<DateTime, List<Live>> result = {};
    // for (var live in myScheduleList.data) {
    //   if (live.details.startAt == null) continue;
    //   result[live.details.startAt!.dateValue] = [...(result[live.startAt!.dateValue] ?? []), live];
    // }
    return result;
  }

  Live get currentLiveSchedule => myLiveScheduleMap.values.first.first;

  Live get recentLiveSchedule {
    // final DateTime now = DateTime.now();

    // // Filter valid schedules (not started and has startAt)
    // final upcomingSchedules = myScheduleList.data.where((element) =>
    //   element.startAt != null &&
    //   element.status == LiveStatus.notStarted
    // ).toList();

    // if (upcomingSchedules.isEmpty) {
    //   return Live(); // Return empty Live if no upcoming schedules
    // }

    // // Sort by closest to now
    // upcomingSchedules.sort((a, b) {
    //   final aDiff = a.startAt!.dateValue.difference(now).abs();
    //   final bDiff = b.startAt!.dateValue.difference(now).abs();
    //   return aDiff.compareTo(bDiff);
    // });

    // // Return the closest one
    // return upcomingSchedules.first;
    return Live();
  }

  Product get pinProduct {
    return currentLive.products.firstWhere((element) => element.isPinned, orElse: () => Product());
  }

  int getConditionCount(int index) {
    return switch (index) {
      0 => currentLive.totalCoin,
      1 => currentLive.totalOrder,
      2 => currentLive.totalLike,
      _ => 0,
    };
  }

  int getProgressCount(int index) {
    return switch (index) {
      0 => currentLive.totalGiveCoin,
      1 => currentLive.totalPurchasedOrder,
      2 => currentLive.likesCount,
      _ => 0,
    };
  }
}
