import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';

String bufferExcel = "";

Future getHistoryDataExcel(String custFull) async {
  Map<String, String> qParams = {
    'Custfull': custFull,
  };
  print("in getHistoryDataExcel $custFull");
  try {
    final response = await http
        .post(Uri.parse("$urlE/Widget_HistoryDataExcel"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    //print(response.body);
    if (response.statusCode == 200) {
      /* final bytes = response.body;
      await file.writeAsBytes(bytes.t); */
      bufferExcel = response.body;
      print(bufferExcel);
      
      print("in getHistoryDataExcel response complete");
      return 1;
    } else {
      print("where is my server");
      return 0;
    }
  } catch (e) {
    print(e);
  }
}
