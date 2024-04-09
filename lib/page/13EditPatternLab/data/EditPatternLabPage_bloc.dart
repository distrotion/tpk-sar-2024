import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/13EditPatternLab/EditPatternLab.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPDF/ShowPDF.dart';
import 'EditPatternLabPge_event.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ManageDataEditPatternLabPage extends Bloc<EditPatternLabPageEvent, int> {
  ManageDataEditPatternLabPage() : super(0);

  @override
  Stream<int> mapEventToState(EditPatternLabPageEvent event) async* {
    if (event == EditPatternLabPageEvent.clearState) {
      yield* clearState();
    } else if (event == EditPatternLabPageEvent.searchPatternData) {
      yield* searchPatternData();
    } else if (event == EditPatternLabPageEvent.cancelRequest) {
      yield* cancelRequest();
    } else if (event == EditPatternLabPageEvent.cancelSample) {
      yield* cancelSample();
    } else if (event == EditPatternLabPageEvent.submitReconfirmResult) {
      yield* submitReconfirmResult();
    } else if (event == EditPatternLabPageEvent.submitCompleteResult) {
      yield* submitCompleteResult();
    } else if (event == EditPatternLabPageEvent.submitCompleteAllResult) {
      yield* submitCompleteAllResult();
    }

    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

Stream<int> clearState() async* {
  yield 0;
}

List<ModelFullRequestData> patternData = [];
/* List<ModelFullRequestData> sampleData = []; // index = sample
List<List<ModelFullRequestData>> itemData =
    []; // index1 = sampleNo, index2 = itemNO
 */
String custFullSearch = '';
Stream<int> searchPatternData() async* {
  EasyLoading.show(status: 'loading...');
  yield 0;
  print("IN searchPatternData");
  /* final SharedPreferences prefs = await _prefs;
  String reqNo = prefs.getString('EditPatternLabPage_reqNo') ?? ""; */
  Map<String, String> qParams = {
    'custFull': custFullSearch,
  };
  final response = await http
      .post(Uri.parse("$urlE/EditPatternLabPage_searchPatternData"),
          body: qParams)
      .timeout(Duration(seconds: timeOut));
  if (response.statusCode == 200) {
    print('already get data');
    patternData.clear();
    //print(response.body);
    patternData = modelFullRequestDataFromJson(response.body);
    EasyLoading.dismiss();
    yield 1;
  } else {
    print('errror');
    //print("where is my server");
    yield 0;
  }
}

/* Stream<int> selectResult() async* {
  print("1");
  yield 0;
  await Future.delayed(
    Duration(milliseconds: 500),
  );
  print("2");
  yield 1;
} */

List<ModelFullRequestData> cancelRequestData = [];
Stream<int> cancelRequest() async* {
  print("IN cancelRequest");
  Map<String, String> qParams = {
    'cancelRequestData': modelFullRequestDataToJson(cancelRequestData),
  };
  final response = await http
      .post(Uri.parse("$url/EditPatternLabPage_cancelRequest"), body: qParams);
  if (response.statusCode == 200) {
    print("cancelRequestData OK");
    contextRoutineRequestDetail
        .read<ManageDataEditPatternLabPage>()
        .add(EditPatternLabPageEvent.searchPatternData);
    yield 1;
  } else {
    print("where is my server");
    yield 0;
  }
}

List<ModelFullRequestData> cancelSampleData = [];
Stream<int> cancelSample() async* {
  print("IN cancelSample");
  Map<String, String> qParams = {
    'cancelSampleData': modelFullRequestDataToJson(cancelSampleData),
  };
  final response = await http
      .post(Uri.parse("$url/EditPatternLabPage_cancelSample"), body: qParams);
  if (response.statusCode == 200) {
    print("cancelSample OK");
    contextRoutineRequestDetail
        .read<ManageDataEditPatternLabPage>()
        .add(EditPatternLabPageEvent.searchPatternData);

    yield 1;
  } else {
    print("where is my server");
    yield 0;
  }
}

List<ModelFullRequestData> reconfirmResultData = [];
Stream<int> submitReconfirmResult() async* {
  print("IN submitReconfirmResult");
  Map<String, String> qParams = {
    'reconfirmResultData': modelFullRequestDataToJson(reconfirmResultData),
  };
  final response = await http.post(
      Uri.parse("$url/EditPatternLabPage_submitReconfirmResult"),
      body: qParams);
  if (response.statusCode == 200) {
    print("RECONFIRM OK");
    contextRoutineRequestDetail
        .read<ManageDataEditPatternLabPage>()
        .add(EditPatternLabPageEvent.searchPatternData);

    yield 1;
  } else {
    print("where is my server");
    yield 0;
  }
}

List<ModelFullRequestData> completeResultData = [];
Stream<int> submitCompleteResult() async* {
  print("IN submitCompleteResult");
  Map<String, String> qParams = {
    'completeResultData': modelFullRequestDataToJson(completeResultData),
  };
  final response = await http.post(
      Uri.parse("$url/EditPatternLabPage_submitCompleteResult"),
      body: qParams);
  if (response.statusCode == 200) {
    print("COMPLETE OK");
    alertSuccess("COMPLETE");
    /* contextRoutineRequestDetail
        .read<ManageDataEditPatternLabPage>()
        .add(EditPatternLabPageEvent.searchPatternData); */
    yield 1;
  } else {
    print("where is my server");
    yield 0;
  }
}

List<ModelFullRequestData> completeAllResultData = [];
Stream<int> submitCompleteAllResult() async* {
  print("IN submitCompleteAllResult");
  Map<String, String> qParams = {
    'completeAllResultData': modelFullRequestDataToJson(completeAllResultData),
  };
  final response = await http.post(
      Uri.parse("$url/EditPatternLabPage_submitCompleteAllResult"),
      body: qParams);
  if (response.statusCode == 200) {
    alertSuccess("COMPLETE");
    contextRoutineRequestDetail
        .read<ManageDataEditPatternLabPage>()
        .add(EditPatternLabPageEvent.searchPatternData);
    yield 1;
  } else {
    print("where is my server");
    yield 0;
  }
}

List<ModelFullRequestData> apprvoeReportData = [];
Future<void> saveApproveReport() async {
  Map<String, String> qParams = {
    'user': userName,
    'apprvoeReportData': modelFullRequestDataToJson(apprvoeReportData),
  };
  print("in saveApproveReport");
  try {
    final response = await http
        .post(Uri.parse("$urlE/EditPatternLabPage_saveApproveReport"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      showPDF(response.body, contextBG);
      //alertSuccess("APPROVE REPORT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataEditPatternLabPage>()
          .add(EditPatternLabPageEvent.searchPatternData);
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

String reqNoDelete = "";
Future<void> submitDeleteReport() async {
  Map<String, String> qParams = {
    'user': userName,
    'reqNo': reqNoDelete,
  };
  print("in submitDeleteReport");
  try {
    final response = await http
        .post(Uri.parse("$url/EditPatternLabPage_submitDeleteReport"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("DELETE REPORT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataEditPatternLabPage>()
          .add(EditPatternLabPageEvent.searchPatternData);
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

String selectedPrinter = '';
List<ModelFullRequestData> dataReprint = [];
Future<void> reprintTag() async {
  Map<String, String> qParams = {
    'data': modelFullRequestDataToJson(dataReprint),
    'printer': selectedPrinter,
  };
  print("in reprintTag");
  try {
    final response = await http
        .post(Uri.parse("$url/EditPatternLabPage_reprintTag"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
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
}

Future<void> loadReport(String reqNo) async {
  Map<String, String> qParams = {
    'ReqNo': reqNo,
    'printer': selectedPrinter,
  };
  try {
    final response = await http
        .post(Uri.parse("$urlE/KACReportData_LoadReport"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      //print(response.body);
      showPDF(response.body, contextBG);
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
}

/* void getImage(String url, String userId, sessionToken) async {
  var uri = Uri.parse(url);

  Map body = {'Session': sessionToken, 'UserId': userId};
  try {
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: utf8.encode(json.encode(body)));

    if (response.contentLength == 0) {
      return;
    }
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath/$userId.png');
    await file.writeAsBytes(response.bodyBytes);
    displayImage(file);
  } catch (value) {
    print(value);
  }
}
 */