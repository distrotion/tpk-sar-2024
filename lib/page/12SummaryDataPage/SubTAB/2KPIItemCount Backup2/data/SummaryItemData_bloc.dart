/* import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/page/12ItemAnalysisDue/SubTAB/ItemAnalysisDue/SammaryItemData/data/SummaryItemDataStructure.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';

List<ModelSummaryItemData> summaryItemDataBuffBP = [];
List<ModelSummaryItemData> summaryItemDataBuffRY = [];

Future<int> fetchSummaryItemData(String branch) async {
  print('fetchSummaryItemData');
  Map<String, String> qParams = {
    'Branch': branch,
  };
  EasyLoading.show(status: 'loading...');
  print("in fetchSummaryItemData");
  try {
    final response = await http
        .post(Uri.parse("$url/ItemAnalysisDue_fetchSummaryItemData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      if (response.body != "error") {
        List<ModelSummaryItemData> buffer =
            modelSummaryItemDataFromJson(response.body);

        //remove date 0 data
        for (int i = 0; i < buffer.length; i++) {
          if (buffer[i].countReceive == 0 &&
              buffer[i].countWaitAnalysis == 0 &&
              buffer[i].countWaitRecheck == 0 &&
              buffer[i].countWaitReconfirm == 0 &&
              buffer[i].countWaitApprove == 0) {
            buffer.removeAt(i);
            i--;
          }
        }

        if (buffer.length > 10) {
          buffer.removeRange(0, buffer.length - 10);
        }
        if (branch == "BANGPOO") {
          print("IN BP");
          summaryItemDataBuffBP = buffer;
        } else {
          print("IN RAYONG");
          summaryItemDataBuffRY = buffer;
        }
      }
    } else {
      alertError("System Error");
    }
    return 2;
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 2;
  } on Error catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 2;
  }
}





/* 
Future<int> fetchSummaryRequestData() async {
  Map<String, String> qParams = {
    'user': userName,
    //'apprvoeReportData': modelFullRequestDataToJson(apprvoeReportData),
  };
  print("in fetchSummaryRequestData");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$url/RoutineRequestDetailRequesterPage_saveApproveReport"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("APPROVE REPORT COMPLETE");
    } else {
      print("nodata");
      alertNetworkError();
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    alertNetworkError();
  }
  return 0;
}
 */ */