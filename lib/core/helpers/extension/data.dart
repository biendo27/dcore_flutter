part of '../helpers.dart';

extension StringDataHelper on String {
  bool get isEmailValid {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(this);
  }

  bool get isPasswordValid {
    return RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(this);
  }

  bool get isPhoneNumberValid {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(this);
  }

  bool get hasLowerCase {
    return RegExp(r'^(?=.*[a-z])').hasMatch(this);
  }

  bool get hasUpperCase {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(this);
  }

  bool get hasNumber {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(this);
  }

  bool get hasSpecialCharacter {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(this);
  }

  bool get hasMinLength {
    return RegExp(r'^(?=.{8,})').hasMatch(this);
  }

  String get imageURL {
    // debugPrint('FETCH IMAGE FROM: ${dotenv.env[EnvTypes.baseUrlStorage]!}$this');
    // return '${dotenv.env[EnvTypes.baseUrlStorage]!}$this';
    debugPrint('FETCH IMAGE FROM: $this');
    return this;
  }

  String get videoURL {
    // debugPrint('FETCH VIDEO FROM: ${dotenv.env[EnvTypes.baseUrlStorage]!}$this');
    // return '${dotenv.env[EnvTypes.baseUrlStorage]!}$this';
    debugPrint('FETCH VIDEO FROM: $this');
    return this;
  }

  String get capilitize {
    return this[0].toUpperCase() + substring(1);
  }

  String get splitCamelCase {
    return replaceAllMapped(RegExp(r'([A-Z])'), (Match m) => ' ${m[0]}').trim();
  }

  // /SomeThingPath => Some Thing Path
  String get pathToCamelCase {
    String path = splitCamelCase;
    return path.substring(1).trim();
  }

  String get toPascalCase {
    return splitMapJoin(' ', onNonMatch: (m) => m[0].toUpperCase() + m.substring(1));
  }

  bool get containsHtmlTag {
    return RegExp(r'<[^>]*>').hasMatch(this);
  }

  String get parseHtml {
    return parse(this).documentElement?.text ?? '';
  }
}

extension StringDataParser on String {
  int get toInt {
    return int.tryParse(this) ?? 0;
  }

  double get toDouble {
    return double.tryParse(this) ?? 0;
  }
}

extension DoubleDataHelper on double {
  String toCurrency() {
    return NumberFormat().format(this);
  }

  String get currency {
    return NumberFormat().format(this);
  }

  String get currencyVND {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    return '${currencyFormatter.format(this)} đ';
  }

  String get formattedDecimal {
    String res = toStringAsFixed(1);
    return res.endsWith('.0') ? res.replaceAll('.0', '') : res;
  }

  String get shortCurrency {
    String formatNumber(double value, String suffix) {
      return '${(value).formattedDecimal}$suffix';
    }

    return switch (this) {
      < 1000 => toCurrency(),
      < 1000000 => formatNumber(this / 1000, 'K'),
      < 1000000000 => formatNumber(this / 1000000, 'M'),
      < 1000000000000 => formatNumber(this / 1000000000, 'B'),
      < 1000000000000000 => formatNumber(this / 1000000000000, 'T'),
      _ => toCurrency(),
    };
  }

  String get rating => formattedDecimal;
}

extension IntDataHelper on int {
  String toCurrency() {
    return NumberFormat().format(this);
  }

  String get currency {
    return NumberFormat().format(this);
  }

  String get currencyVND {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    return '${currencyFormatter.format(this)} đ';
  }

  String get shortCurrency {
    String formatNumber(double value, String suffix) {
      String res = value.toStringAsFixed(1);
      return '${res.endsWith('.0') ? res.replaceAll('.0', '') : res}$suffix';
    }

    return switch (this) {
      < 1000 => toCurrency(),
      < 1000000 => formatNumber(this / 1000, 'K'),
      < 1000000000 => formatNumber(this / 1000000, 'M'),
      < 1000000000000 => formatNumber(this / 1000000000, 'B'),
      < 1000000000000000 => formatNumber(this / 1000000000000, 'T'),
      _ => toCurrency(),
    };
  }

  String get getCountTime => this > 9 ? '9+' : '$this';
}

extension NumberDataHelper on num {
  String toCurrency() {
    return NumberFormat().format(this);
  }

  String get currency {
    return NumberFormat().format(this);
  }

  String get currencyVND {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    return '${currencyFormatter.format(this)} đ';
  }

  String get formattedDecimal {
    String res = toStringAsFixed(1);
    return res.endsWith('.0') ? res.replaceAll('.0', '') : res;
  }

  String get shortCurrency {
    String formatNumber(double value, String suffix) {
      return '${(value).formattedDecimal}$suffix';
    }

    return switch (this) {
      < 1000 => toCurrency(),
      < 1000000 => formatNumber(this / 1000, 'K'),
      < 1000000000 => formatNumber(this / 1000000, 'M'),
      < 1000000000000 => formatNumber(this / 1000000000, 'B'),
      < 1000000000000000 => formatNumber(this / 1000000000000, 'T'),
      _ => toCurrency(),
    };
  }

  String get formatTime {
    if (this < 0) return '00:00';

    final hours = (this ~/ 60).toString().padLeft(2, '0');
    final minutes = (this % 60).toString().padLeft(2, '0');

    return '$hours:$minutes';
  }

  String get formatDuration {
    if (this < 0) return '00:00:00';

    final hours = (this ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((this % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  String get rating {
    String res = toStringAsFixed(1);
    return res.endsWith('.0') ? res.replaceAll('.0', '') : res;
  }

  String get getCountTime => this > 9 ? '9+' : '$this';
}
