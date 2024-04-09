/* import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubWidget/SammaryRequestData%20copy/data/SummaryRequestDataStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubWidget/SammaryRequestData%20copy/data/SummaryRequestData_event.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';

class ManageDataSummaryRequestData extends Bloc<SummaryRequestDataEvent, int> {
  ManageDataSummaryRequestData() : super(0);

  @override
  Stream<int> mapEventToState(SummaryRequestDataEvent event) async* {
    if (event == SummaryRequestDataEvent.clearAndSearch) {
      yield 0;
    } else if (event == SummaryRequestDataEvent.fetchSummaryRequestDataBP) {
      yield* fetchSummaryRequestData("BANGPOO"); //ทำไม่ทันเลยต้องแยกตัว
    } else if (event == SummaryRequestDataEvent.fetchSummaryRequestDataRY) {
      yield* fetchSummaryRequestData("RAYONG"); //ทำไม่ทันเลยต้องแยกตัว
    } else if (event == SummaryRequestDataEvent.searchSummaryRequestData) {
      yield 0;
    }
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

List<ModelSummaryRequestData> summaryItemDataBuffBP = [];
List<ModelSummaryRequestData> summaryItemDataBuffRY = [];

Stream<int> fetchSummaryRequestData(String branch) async* {
  print('in steam $branch');
  Map<String, String> qParams = {
    'Branch': branch,
  };
  EasyLoading.show(status: 'loading...');
  print("in fetchSummaryRequestData");
  try {
    final response = await http
        .post(Uri.parse("$url/SummaryDataPage_fetchSummaryRequestData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      if (response.body != "error") {
        List<ModelSummaryRequestData> buffer =
            modelSummaryRequestDataFromJson(response.body);
        if (buffer.length > 10) {
          buffer.removeRange(10, buffer.length);
        }
        if (branch == "BANGPOO") {
          print("IN BP");
          summaryItemDataBuffBP = buffer;
        } else {
          print("IN RAYONG");
          summaryItemDataBuffRY = buffer;
        }
        yield 2;
      } else {
        alertError("System Error");
      }
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
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