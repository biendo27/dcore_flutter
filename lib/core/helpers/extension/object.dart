part of '../helpers.dart';

extension DateTimeDataHelper on DateTime {
  String parseString(String format) {
    return DateFormat(format).format(this);
  }

  String get localeDate {
    return DateFormat.yMMMMd().format(this);
  }

  String get localeTime {
    return DateFormat.Hm().format(this);
  }

  String get localeDateAndTime {
    return DateFormat.yMMMMd().add_Hm().format(this);
  }

  String get localTimeAgo {
    return DateFormat('HH:mm').format(toLocal());
  }

  String get localDateAgo {
    return DateFormat('dd/MM/yyyy').format(toLocal());
  }

  String get dateTimeAgo {
    return '$localDateAgo $localTimeAgo';
  }

  String get adaptLocalDate {
    if (difference(DateTime.now()).inDays == 0) {
      return localTimeAgo;
    }
    return dateTimeAgo;
  }

  DateTime get dateValue {
    DateTime localDate = toLocal();
    return DateTime(localDate.year, localDate.month, localDate.day);
  }

  DateTime get timeValue {
    DateTime localDate = toLocal();
    return DateTime(0, 0, 0, localDate.hour, localDate.minute);
  }

  String get dateTimeString {
    DateTime localDate = toLocal();
    return DateFormat('dd/MM/yyyy HH:mm').format(localDate);
  }

  String get timeDateString {
    DateTime localDate = toLocal();
    return DateFormat('HH:mm dd/MM/yyyy').format(localDate);
  }

  String get dateValueString {
    DateTime localDate = toLocal();
    return DateFormat('dd/MM/yyyy').format(localDate);
  }

  String get dateMonthValueString {
    DateTime localDate = toLocal();
    return DateFormat('dd/MM').format(localDate);
  }

  String get timeValueString {
    DateTime localDate = toLocal();
    return DateFormat('HH:mm').format(localDate);
  }

  String diffTime(DateTime startAt) {
    if (difference(startAt).inDays < 1) {
      return '$timeValueString - ${startAt.timeValueString} ${startAt.dateValueString}';
    }
    return '$dateTimeString - ${startAt.dateTimeString}';
  }

  String get dayOfWeek {
    // Check day different with today
    DateTime now = DateTime.now();
    if (toLocal().difference(now).inDays == 0) {
      return AppConfig.context!.text.today;
    }
    if (toLocal().difference(now).inDays == 1) {
      return AppConfig.context!.text.tomorrow;
    }
    if (toLocal().difference(now).inDays == -1) {
      return AppConfig.context!.text.yesterday;
    }

    String day = DateFormat('EEEE').format(this);
    return switch (day) {
      'Monday' => AppConfig.context!.text.monday,
      'Tuesday' => AppConfig.context!.text.tuesday,
      'Wednesday' => AppConfig.context!.text.wednesday,
      'Thursday' => AppConfig.context!.text.thursday,
      'Friday' => AppConfig.context!.text.friday,
      'Saturday' => AppConfig.context!.text.saturday,
      'Sunday' => AppConfig.context!.text.sunday,
      _ => day,
    };
  }
}

extension StringDateExtension on String {
  DateTime get toUTCDateTime {
    try {
      final formats = [
        'dd/MM/yyyy HH:mm:ss',
        'dd/MM/yyyy HH:mm',
        'dd/MM/yyyy',
        'yyyy-MM-dd HH:mm:ss',
        'yyyy-MM-dd HH:mm',
        'yyyy-MM-dd',
        'MM/dd/yyyy HH:mm:ss',
        'MM/dd/yyyy HH:mm',
        'yyyy-MM-ddTHH:mm:ssZ', // ISO 8601
        'yyyy-MM-ddTHH:mm:ss', // ISO 8601 without timezone
        'dd-MM-yyyy HH:mm:ss',
        'dd-MM-yyyy HH:mm',
        'dd-MM-yyyy',
      ];

      for (var format in formats) {
        try {
          DateTime dateTime = DateFormat(format).parse(this).toUtc();
          return dateTime;
        } catch (_) {
          continue;
        }
      }

      // If none of the formats work, throw an exception
      throw FormatException('Failed to parse date: $this');
    } catch (e) {
      // If all parsing attempts fail, throw an exception
      throw FormatException('Failed to parse date: $this', e);
    }
  }

  String get toUTCDateTimeString {
    return toUTCDateTime.toIso8601String();
  }
}

extension DateTimeDateExtension on DateTime {
  String get toUTCDateTimeString {
    return toIso8601String();
  }

  String get toLocalDateTimeString {
    return toLocal().toIso8601String();
  }

  String get toLocalDateString {
    return DateFormat('dd/MM/yyyy').format(toLocal());
  }

  String get toUTCDateString {
    return DateFormat('dd/MM/yyyy').format(toUtc());
  }

  int diffTimeInSeconds(DateTime other) {
    DateTime localDate = toLocal();
    int diffTime = localDate.difference(other).inSeconds;
    return diffTime > 0 ? diffTime : 0;
  }
}

extension OpEx on Color {
  Color op(double opacity) => withValues(alpha: opacity);
}

extension AppLocalizationsHelper on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this);
}

extension MapHelper on Map<String, dynamic> {
  Map<String, String> get toMapString {
    return map((key, value) => MapEntry(key, value.toString()));
  }
}

extension LogFormatterHelper on dynamic {
  String get formatLogData {
    final dynamic data = this;
    if (data == null) return '';
    if (data is FormData) {
      return data.formatFormData;
    }
    if (data is String) {
      try {
        // Try to parse as JSON first
        final jsonData = json.decode(data);
        return '\nDATA: ${jsonData.formatJsonData}';
      } catch (_) {
        // If not JSON, return as plain string
        return '\nDATA: $data';
      }
    }
    return '\nDATA: ${data.formatJsonData}';
  }

  String get formatJsonData {
    if (this is Map || this is List) {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      return '\n${encoder.convert(this)}';
    }
    return toString();
  }
}

extension FormDataFormatter on FormData {
  String get formatFormData {
    final List<String> formDataParts = [];

    if (fields.isNotEmpty) {
      final fieldString = fields.map((e) => '    ${e.key}: ${e.value}').join('\n');
      formDataParts.add('  Fields:\n$fieldString');
    }

    if (files.isNotEmpty) {
      final fileString = files.map((e) => '    ${e.key}: ${e.value.filename}').join('\n');
      formDataParts.add('  Files:\n$fileString');
    }

    return formDataParts.isNotEmpty ? '\nFORM DATA:\n${formDataParts.join('\n')}' : '';
  }
}

extension StackTraceFormatter on StackTrace? {
  String get formatStackTrace {
    if (this == null) return '';
    return toString().split('\n').take(10).join('\n');
  }
}
