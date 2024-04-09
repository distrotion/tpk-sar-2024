import 'package:intl/intl.dart';

String toDateOnly(String dateIn) {
  var buff = "";
  try {
    buff = DateFormat("dd-MM-yyyy").format(DateTime.parse(dateIn));
  } on Exception catch (e) {}
  return buff;
}

String toDateTime(String dateIn) {
  var buff = "";
  if (dateIn == '') {
    return '';
  } else {
    try {
      buff = DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.parse(dateIn));
    } on Exception catch (e) {}
  }
  return buff;
}
