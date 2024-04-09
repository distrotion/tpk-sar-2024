import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'ManageChartDataStructure.dart';

List<HistoryChartModel> historyChartData = [];

Future searchHistoryChartData(String customerName, String itemName,
    String section, String max, String min) async {
  Map<String, String> qParams = {
    'custFull': customerName,
    'itemName': itemName,
    'section': section,
  };
  print("in searchChartData");
  /*  print('max = $max min = $min');
  min = "1";  */
  final response = await http
      .get(Uri.parse("$url/Widget_SearcHistoryChartData"), headers: qParams);
  if (response.statusCode == 200) {
    print("respone");
    List<HistoryChartModel> buffer = [];
    buffer = historyChartModelFromJson(response.body);
    historyChartData = buffer.reversed.toList();

    if (historyChartData.length == 0) {
      String buff_min = "0";
      String buff_max = "0";
      try {
        if (double.parse(min) >= 0) {
          buff_min = min;
        }
      } on Exception catch (e) {
        buff_min = "0";
      }
      try {
        if (double.parse(max) >= 0) {
          buff_max = max;
        }
      } on Exception catch (e) {
        buff_max = "0";
      }
      historyChartData.add(HistoryChartModel(
          samplingDate: "0",
          resultApprove: "0",
          resultApproveUnit: "0",
          stdMax: buff_max,
          stdMin: buff_min));
    } else {
      for (int i = 0; i < historyChartData.length; i++) {
        try {
          if (double.parse(historyChartData[i].stdMax) >= 0) {}
        } on Exception catch (e) {
          historyChartData[i].stdMax = "0";
        }
        try {
          if (double.parse(historyChartData[i].stdMin) >= 0) {}
        } on Exception catch (e) {
          historyChartData[i].stdMin = "0";
        }
      }
    }
    return 1;
  } else {
    print("where is my server");
    return 0;
  }
}
