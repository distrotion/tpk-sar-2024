/* import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubWidget/SammaryItemData/data/SummaryItemDataStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubWidget/SammaryItemData/data/SummaryItemData_event.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';

class ManageDataSummaryItemData extends Bloc<SummaryItemDataEvent, int> {
  ManageDataSummaryItemData() : super(0);

  @override
  Stream<int> mapEventToState(SummaryItemDataEvent event) async* {
    if (event == SummaryItemDataEvent.clearAndSearch) {
      yield 0;
    } else if (event == SummaryItemDataEvent.fetchSummaryItemDataBP) {
      yield* fetchSummaryItemData("BANGPOO"); //ทำไม่ทันเลยต้องแยกตัว
    } else if (event == SummaryItemDataEvent.fetchSummaryItemDataRY) {
      yield* fetchSummaryItemData("RAYONG"); //ทำไม่ทันเลยต้องแยกตัว
    } else if (event == SummaryItemDataEvent.searchSummaryItemData) {
      yield 0;
    }
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

List<ModelSummaryItemData> summaryItemDataBuffBP = [];
List<ModelSummaryItemData> summaryItemDataBuffRY = [];

Stream<int> fetchSummaryItemData(String branch) async* {
  print('in steam $branch');
  Map<String, String> qParams = {
    'Branch': branch,
  };
  EasyLoading.show(status: 'loading...');
  print("in fetchSummaryItemData");
  try {
    final response = await http
        .post(Uri.parse("$url/SummaryDataPage_fetchSummaryItemData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      if (response.body != "error") {
        List<ModelSummaryItemData> buffer =
            modelSummaryItemDataFromJson(response.body);


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