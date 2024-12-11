import 'package:intl/intl.dart';

extension AppDateTimeExtension on DateTime {
  static String convertServerDateToDDMMYYYY(String date) {
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
      String displayDate = DateFormat("dd MMM, yyyy").format(tempDate);
      return displayDate;
    } catch (e) {
      return date;
    }
  }

  static String convertServerDateToYY(String date) {
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
      String displayDate = DateFormat("yy").format(tempDate);
      return displayDate;
    } catch (e) {
      return date;
    }
  }

  static String convertServerDateToYYYY(String date) {
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
      String displayDate = DateFormat("yyyy").format(tempDate);
      return displayDate;
    } catch (e) {
      return date;
    }
  }

  static String convertDDMMYYYY(String date) {
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(date);
      String displayDate = DateFormat("dd/MM/yyyy").format(tempDate);
      return displayDate;
    } catch (e) {
      return date;
    }
  }

  String get dateWithDDMMYYYY {
    try {
      // DateTime tempDate = DateFormat("yyyy-MM-dd").format(this);
      String displayDate = DateFormat("dd/MM/yyyy").format(this);
      return displayDate;
    } catch (e) {
      return toString();
    }
  }

  /// converts this `dateTime` to `String` to show in UI
  String get dateWithYear {
    final converted = DateFormat('dd MMM, yyyy').format(this);
    return converted;
  }

  /// converts this `dateTime` to `String` to show in UI
  String get dateWithoutYear {
    final converted = DateFormat('dd MMM').format(this);
    return converted;
  }

  String get dateForDB {
    final converted = DateFormat('yyyy-MM-dd').format(this);
    return converted;
  }

  /// calculates age from this `dateTime`
  int get calculateAge {
    final currentDate = DateTime.now();
    var age = currentDate.year - year;
    final month1 = currentDate.month;
    final month2 = month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final day1 = currentDate.day;
      final day2 = day;
      if (day2 > day1) {
        age--;
      }
    }
    return age + 1;
  }

  /// converts this `dateTime` to Verbose DateTime Representation
  String get verboseDateTimeRepresentation {
    final now = DateTime.now();
    final justNow = now.subtract(const Duration(minutes: 1));
    final localDateTime = toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just Now';
    }

    final roughTimeString = DateFormat('jm').format(this);

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }

    final yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday';
    }

    if (now.difference(localDateTime).inDays < 4) {
      final weekday = DateFormat('EEEE').format(localDateTime);

      return '$weekday, $roughTimeString';
    }

    return '${DateFormat('d/M/y').format(this)}, $roughTimeString';
  }

  /// converts this `dateTime` to Verbose Date Representation
  String get verboseDate {
    final now = DateTime.now();
    final localDateTime = toLocal();

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Today';
    }

    final yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday';
    }

    if (now.difference(localDateTime).inDays < 4) {
      final weekday = DateFormat('EEEE').format(localDateTime);

      return weekday;
    }

    return DateFormat('yMd').format(this);
  }

  String get timeString {
    return DateFormat('hh:mm aa').format(this);
  }

  static DateTime parseTimeString(String timeString) {
    final timeComponents = timeString.split(' ');
    final time = timeComponents[0];
    final period = timeComponents[1];
    final hourMinute = time.split(':');
    var hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);

    // Adjust hour for PM times
    if (period == 'PM' && hour != 12) {
      hour += 12;
    }

    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour,
      minute,
    );
  }
}
