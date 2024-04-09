import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/RoutineRequestDetailRequesterPage.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_ActualLineInput/data/ActualLineInputStructure.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/data/RoutineRequestDetailRequesterPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/data/RoutineRequestDetailRequesterPage_event.dart';

List<ActualLineDataModel> actualLineData = [];
bool newCreate = true;
int dataCount = 0;

Future searchActualLineData(
    String reqNo, String custFull, String samplingDate) async {
  Map<String, String> qParams = {
    'reqNo': reqNo,
    'custFull': custFull,
  };
  dataCount = 0;
  print("in searchActualLineData");
  try {
    /* final response = await http
        .get(Uri.parse("$url/ActualLineData_searchActualLineData"),
            headers: qParams)
        .timeout(Duration(seconds: timeOut));
 */
    final response = await http
        .post(Uri.parse("$url/ActualLineData_searchActualLineData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      actualLineData = ActualLineDataModelFromJson(response.body);
      if (actualLineData.length > 0) {
        if (actualLineData[0].reqNo == "") {
          newCreate = true;
          for (int i = 0; i < actualLineData.length; i++) {
            actualLineData[i].reqNo = reqNo;
            actualLineData[i].samplingDate = samplingDate;
          }
        } else {
          newCreate = false;
        }
        for (int i = 0; i < actualLineData.length; i++) {
          //if (actualLineData[i].sampleNo != 0) {
          dataCount++;
          //}
        }
      } else {
        alertError("DATA NOT FOUND");
      }
      return 1;
    } else {
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

Future<void> saveActualLineData() async {
  Map<String, String> qParams = {
    'data': ActualLineDataModelToJson(actualLineData),
  };
  print("in saveActualLineData");
  try {
    final response = await http
        .post(Uri.parse("$url/ActualLineData_saveActualLineData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("SAVE RESULT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
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
  //return 0;
}

List<ActualLineDataModel> dataEditReportName = [];

Future<void> submitEditReportName() async {
  Map<String, String> qParams = {
    'data': ActualLineDataModelToJson(dataEditReportName),
  };
  print("in KAC submitEditReportName");
  try {
    final response = await http
        .post(Uri.parse("$url/ActualLineData_submitEditReportName"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("EDIT REPORT NAME COMPLETE");
      searchActualLineData(dataEditReportName[0].reqNo,
          dataEditReportName[0].custFull, dataEditReportName[0].samplingDate);

      /* contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData); */
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
}
