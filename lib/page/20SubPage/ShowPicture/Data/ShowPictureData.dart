import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'ShowPictureStructure.dart';



List<HistoryChartModel> historyChartData = [];
String picture = "";

Future getPicture(String path) async {
  Map<String, String> qParams = {
    'path': path,
  };
  print("in searchPicture $path");
  try {
    final response = await http
        .post(Uri.parse("$urlE/Widget_getPicture"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    //print(response.body);
    if (response.statusCode == 200) {
      picture = response.body;
      print("in searchPicture response complete");
      return 1;
    } else {
      print("where is my server");
      return 0;
    }
  } catch (e) {
    print(e);
  }
}
