import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Helpers
import '../extensions/datetime_extension.dart';
import 'app_colors.dart';
import 'app_styles.dart';

/// A utility class that holds commonly used functions
/// This class has no constructor and all variables are `static`.
@immutable
class AppUtils {
  const AppUtils._();

  /// A random value generator
  static Random randomizer([int? seed]) => Random(seed);

  /// A utility method to map an integer to a color code
  /// Useful for color coding class erps
  static Color getRandomColor([int? seed, List<Color>? colors]) {
    final rInt = seed != null ? (seed + DateTime.now().minute) : null;
    final _colors = colors ?? AppColors.primaries;
    return _colors[randomizer(rInt).nextInt(_colors.length)];
  }

  /// A utility method to convert 0/1 to false/true
  static bool boolFromInt(int i) => i == 1;

  /// A utility method to convert true/false to 1/0
  // ignore: avoid_positional_boolean_parameters
  static int boolToInt(bool b) => b ? 1 : 0;

  /// A utility method to convert DateTime to API
  /// accepted date JSON format
  static String dateToJson(DateTime date) {
    return date.toDateString('yyyy-MM-dd');
  }

  /// A utility method to convert DateTime to API
  /// accepted datetime JSON format
  static String dateTimeToJson(DateTime date) {
    return date.toDateString('yyyy-MM-dd HH:mm:ss');
  }

  /// A utility method to convert JSON 24hr time string
  /// to a [TimeOfDay] object
  static TimeOfDay timeFromJson(String time) {
    final dateTime = DateFormat.Hms().parse(time);
    return TimeOfDay.fromDateTime(dateTime);
  }

  /// A utility method to convert a [TimeOfDay] object
  /// to a JSON API accepted 24hr time string
  static String timeToJson(TimeOfDay time) {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final hourLabel = addLeadingZeroIfNeeded(time.hour);
    final minuteLabel = addLeadingZeroIfNeeded(time.minute);
    return '$hourLabel:$minuteLabel';
  }

  /// A utility method to convert any instance to null
  static T? toNull<T>(Object? _) => null;

  /// A utility method to remove nulls from int list
  static List<int>? removeNulls(List<dynamic>? list) {
    return list?.whereType<int>().toList();
  }

  /// A utility method to clean spaces from input
  static String cleanWhitespace(String input) {
    return input.replaceAll(' ', '');
  }

  /// Helper method to show toast message
  static void showFlushBar({
    required BuildContext context,
    required String message,
    IconData? icon = Icons.error_rounded,
    double? iconSize = 26,
    Color? iconColor = Colors.redAccent,
  }) {
    Flushbar<void>(
      message: message,
      messageSize: 15,
      messageColor: AppColors.textWhite80Color,
      animationDuration: Durations.slow,
      borderRadius: Corners.rounded(9),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 85),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      backgroundColor: const Color.fromARGB(218, 48, 48, 48),
      boxShadows: Shadows.universal,
      icon: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      shouldIconPulse: false,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      duration: const Duration(milliseconds: 1300),
    ).show(context);
  }
}

/// A utility class that holds commonly used regular expressions
/// employed throughout the entire app.
/// This class has no constructor and all variables are `static`.
@immutable
class Regexes {
  const Regexes._();

  /// The regular expression for validating emails in the app.
  static RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+",
  );

  /// The regular expression for validating contacts in the app.
  static RegExp contactRegex = RegExp(r'^(03|3)\d{9}$');

  /// The regular expression for validating ids in the app.
  static RegExp idRegex =
      RegExp(r'^([1-9]\d{8}|[1-9]\d{11})$');

  /// The regular expression for validating names in the app.
  static RegExp nameRegex = RegExp(r'^[a-z A-Z]+$');

  /// The regular expression for validating zip codes in the app.
  static RegExp zipCodeRegex = RegExp(r'^\d{5}$');

  /// The regular expression for validating credit card numbers in the app.
  static RegExp creditCardNumberRegex =
      RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11})$');

  /// The regular expression for validating credit card CVV in the app.
  static RegExp creditCardCVVRegex = RegExp(r'^[0-9]{3}$');

  /// The regular expression for validating credit card expiry in the app.
  static RegExp creditCardExpiryRegex = RegExp(r'(0[1-9]|10|11|12)/[0-9]{2}$');

  /// The regular expression for validating otp in the app.
  static final RegExp otpDigitRegex = RegExp(r'^[0-9]{1}$');
}

/// A utility class that holds all the timings used throughout
/// the entire app by things such as animations, tickers etc.
///
/// This class has no constructor and all variables are `static`.
@immutable
class Durations {
  const Durations._();

  static const fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const normal = Duration(milliseconds: 300);
  static const medium = Duration(milliseconds: 500);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}
