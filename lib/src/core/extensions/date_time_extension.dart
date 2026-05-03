import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatRelative() {
    final now = DateTime.now();
    if (year == now.year && month == now.month && day == now.day) {
      return DateFormat.Hm().format(this);
    }
    return DateFormat.MMMd().format(this);
  }
}
