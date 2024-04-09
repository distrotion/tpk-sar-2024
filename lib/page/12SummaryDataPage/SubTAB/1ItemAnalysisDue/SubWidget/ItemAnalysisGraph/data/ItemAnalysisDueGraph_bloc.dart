import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/1ItemAnalysisDue/SubWidget/ItemAnalysisGraph/data/ItemAnalysisDueGraphStructure.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';

List<ModelItemAnalysisDueGrpah> ItemAnalysisDueGrpahBuffBP = [];
List<ModelItemAnalysisDueGrpah> ItemAnalysisDueGrpahBuffRY = [];

Future<int> fetchItemAnalysisDueGrpah(String branch) async {
  print('fetchItemAnalysisDueGrpah');
  Map<String, String> qParams = {
    'Branch': branch,
  };
  EasyLoading.show(status: 'loading...');
  print("in fetchItemAnalysisDueGrpah");
  try {
/*     final response = await http
        .post(Uri.parse("$url/ItemAnalysisDue_fetchItemAnalysisDueGrpah"),
            body: qParams)
        .timeout(Duration(seconds: timeOut)); */
    final response = await http
        .post(
            Uri.parse(
                "$urlE/SummaryDataPage/ItemAnalysisDue_fetchItemAnalysisDueGrpah"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      if (response.body != "error") {
        //remove date 0 data
        if (branch == "BANGPOO") {
          print("IN BP");
          List<ModelItemAnalysisDueGrpah> bufferBP =
              modelItemAnalysisDueGrpahFromJson(response.body);
          for (int i = 0; i < bufferBP.length; i++) {
            if (bufferBP[i].countReceive == 0 &&
                bufferBP[i].countWaitAnalysis == 0 &&
                bufferBP[i].countWaitRecheck == 0 &&
                bufferBP[i].countWaitReconfirm == 0 &&
                bufferBP[i].countWaitApprove == 0) {
              bufferBP.removeAt(i);
              i--;
            }
          }
          if (bufferBP.length > 10) {
            bufferBP.removeRange(0, bufferBP.length - 10);
          }
          ItemAnalysisDueGrpahBuffBP = bufferBP;
        } else {
          print("IN RAYONG");
          List<ModelItemAnalysisDueGrpah> bufferRY =
              modelItemAnalysisDueGrpahFromJson(response.body);
          for (int i = 0; i < bufferRY.length; i++) {
            if (bufferRY[i].countReceive == 0 &&
                bufferRY[i].countWaitAnalysis == 0 &&
                bufferRY[i].countWaitRecheck == 0 &&
                bufferRY[i].countWaitReconfirm == 0 &&
                bufferRY[i].countWaitApprove == 0) {
              bufferRY.removeAt(i);
              i--;
            }
          }
          if (bufferRY.length > 10) {
            bufferRY.removeRange(0, bufferRY.length - 10);
          }
          ItemAnalysisDueGrpahBuffRY = bufferRY;
        }
      }
    } else {
      alertError("System Error");
    }
    print("normal");
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
 */