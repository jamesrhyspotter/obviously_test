import 'package:intl/intl.dart';

String formatTo2DP({required double number}) {
  final numberFormat = NumberFormat('0.00');
  return numberFormat.format(number);
}

List<String> splitAmountByDecimal({required double amount}) {
  final List<String> splitCurrency = '$amount'.split('.');

  return [splitCurrency.first, '.${splitCurrency.last.padRight(2, '0').substring(0, 2)}'];
}

double convertStringToCurrencyAmount({required String string}) {
  final List<String> splitCurrency = string.split('.');

  String leading = splitCurrency.first;
  String trailing = splitCurrency.length == 2 ? '.${splitCurrency[1]}'.padRight(2, '0') : '.00';

  return double.parse('$leading$trailing');
}

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    return 'TODAY';
  } else if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day - 1) {
    return 'YESTERDAY';
  } else {
    final formatter = DateFormat('d MMMM');
    return formatter.format(dateTime).toUpperCase();
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
