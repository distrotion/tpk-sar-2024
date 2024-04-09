import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'ManageChartDataStructure.dart';

List<HistoryChartModel> historyChartData = [];

Future searchHistoryChartData(String itemID, String itemName, String section,
    String max, String min) async {
  Map<String, String> qParams = {
    'itemID': itemID,
    'itemName': itemName,
    'section': section,
  };
  //print(itemID);
  print("in searchChartData");
  /*  print('max = $max min = $min');
  min = "1";  */
  final response = await http
      .post(Uri.parse("$url/Widget_SearcHistoryChartData2"), body: qParams);
  if (response.statusCode == 200) {
    //print("respone");
    List<HistoryChartModel> buffer = [];
    buffer = historyChartModelFromJson(response.body);

    //find mean data
    try {
      for (int i = 0; i < buffer.length; i++) {
        double dataSum = 0;
        int dataCount = 1;
        if (i + 1 < buffer.length) {
          for (int j = i; j < buffer.length; j) {
            if (j + 1 < buffer.length) {
              if (buffer[j].samplingDate == buffer[j + 1].samplingDate) {
                if (dataCount == 1) {
                  dataSum = double.parse(buffer[j].resultApprove) +
                      double.parse(buffer[j + 1].resultApprove);
                } else {
                  dataSum = dataSum + double.parse(buffer[j + 1].resultApprove);
                }
                dataCount++;
                buffer.removeAt(j + 1);
              } else if (dataCount != 1) {
                /* print(("1 : " + dataSum.toString()));
                print(("2: " + dataCount.toString()));
                print("3 : " + (dataSum / dataCount).toString()); */
                buffer[j].resultApprove =
                    (dataSum / dataCount).toStringAsFixed(2);
                /* print("4 :" + buffer[j].resultApprove); */
                i = j;
                break;
              } else {
                i = j;
                break;
              }
            } else {
              if (dataCount != 1) {
                buffer[j].resultApprove =
                    (dataSum / dataCount).toStringAsFixed(2);
              }
              i = j;
              break;
            }
          }
        }
      }
    } on Exception catch (e) {
      print(e);
    }

    if (buffer.length > 10) {
      buffer.removeRange(10, buffer.length);
    }
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
