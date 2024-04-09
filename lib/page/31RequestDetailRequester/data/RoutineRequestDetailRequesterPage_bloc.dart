import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPDF/ShowPDF.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/RoutineRequestDetailRequesterPage.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_Report/data/KACReportStructure.dart';
import 'RoutineRequestDetailRequesterPage_event.dart';
import 'package:url_launcher/url_launcher.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ManageDataRoutineRequestDetailRequesterPage
    extends Bloc<RoutineRequestDetailRequesterPageEvent, int> {
  ManageDataRoutineRequestDetailRequesterPage() : super(0);

  @override
  Stream<int> mapEventToState(
      RoutineRequestDetailRequesterPageEvent event) async* {
    if (event == RoutineRequestDetailRequesterPageEvent.clearState) {
      yield* clearState();
    } else if (event ==
        RoutineRequestDetailRequesterPageEvent.searchRequestData) {
      yield* searchRequestData();
    } else if (event == RoutineRequestDetailRequesterPageEvent.cancelRequest) {
      yield* cancelRequest();
    } else if (event == RoutineRequestDetailRequesterPageEvent.cancelSample) {
      yield* cancelSample();
    } else if (event == RoutineRequestDetailRequesterPageEvent.cancelItem) {
      yield* cancelItem();
    } else if (event ==
        RoutineRequestDetailRequesterPageEvent.submitReconfirmResult) {
      yield* submitReconfirmResult();
    } else if (event ==
        RoutineRequestDetailRequesterPageEvent.submitCompleteResult) {
      yield* submitCompleteResult();
    } else if (event ==
        RoutineRequestDetailRequesterPageEvent.submitCompleteAllResult) {
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

//
List<ModelFullRequestData> requestData = [];
List<ModelFullRequestData> sampleData = []; // index = sample
List<List<ModelFullRequestData>> itemData =
    []; // index1 = sampleNo, index2 = itemNO

Stream<int> searchRequestData() async* {
  EasyLoading.show(status: 'loading...');
  yield 0;
  print("IN searchRequesterDataRequester");
  final SharedPreferences prefs = await _prefs;
  String reqNo =
      prefs.getString('RoutineRequestDetailRequesterPage_reqNo') ?? "";
  Map<String, String> qParams = {
    'reqNo': reqNo,
  };
  final response = await http
      .post(
          Uri.parse("$url/RoutineRequestDetailRequesterPage_searchRequestData"),
          body: qParams)
      .timeout(Duration(seconds: timeOut));
  if (response.statusCode == 200) {
    print('already get data');
    sampleData.clear();
    requestData.clear();
    itemData.clear();
    requestData = modelFullRequestDataFromJson(response.body);
    int bufferSampleNo = 0;
    double buff;
    //print('1');
    //print(requestData);
    //print(requestData[0].inputDataDate.toString());
    //print('2');
    for (int i = 0; i < requestData.length; i++) {
      //requestData[i].resultBuff = requestData[i].resultApprove;
      //Convert to resutl ts side
      if (requestData[i].itemReportName.toString() == '' ||
          requestData[i].itemReportName.toString() == '-') {
        requestData[i].itemReportName = requestData[i].itemName.toString() +
            ' ' +
            requestData[i].resultApproveUnit.toString();
      }
      //approve result to complete 23-02-06
      //if (requestData[i].resultComplete == '') {
      try {
        buff = (double.parse(requestData[i].resultApprove) +
                double.parse(requestData[i].std1) -
                double.parse(requestData[i].std2)) *
            double.parse(requestData[i].std3) /
            double.parse(requestData[i].std4);
        buff = ((buff +
                double.parse(requestData[i].std5) -
                double.parse(requestData[i].std6)) *
            double.parse(requestData[i].std7) /
            double.parse(requestData[i].std8));
        requestData[i].resultComplete = buff.toStringAsFixed(2);
      } on Exception catch (e) {
        requestData[i].resultComplete = requestData[i].resultApprove;
        //print(e);
      }
      //}
      //requestData[i].resultComplete = buff.toStringAsFixed(2);
      requestData[i].resultCompleteSymbol = requestData[i].resultApproveSymbol;
      requestData[i].resultCompleteUnit = requestData[i].resultApproveUnit;
      requestData[i].resultCompleteFile = requestData[i].resultApproveFile;
      /* if (int.tryParse(requestData[i].sampleNo) != bufferSampleNo) {
        bufferSampleNo = int.tryParse(requestData[i].sampleNo) ?? 1;
        //print("bufferSampleNo : $bufferSampleNo");
        sampleData.add(requestData[i]);
        itemData.add([]);
      } */
      //print(itemData.length);
      if (i == 0) {
        bufferSampleNo = 1;
        sampleData.add(requestData[i]);
        itemData.add([]);
      } else if (requestData[i].sampleNo != requestData[i - 1].sampleNo) {
        bufferSampleNo++;
        sampleData.add(requestData[i]);
        itemData.add([]);
      }
      itemData[(bufferSampleNo) - 1].add(requestData[i]);
    }
    print("revise :" + requestData[0].reviseNo.toString());
    /*  print(itemData[0].length);
    print(itemData[0][1].itemName);
    print("itemData : ${itemData.length}");
    print("itemData[2] : ${itemData[2].length}");
    print("itemData[2] : ${itemData[2][2].itemName}"); */
    EasyLoading.dismiss();
    yield 1;
  } else {
    alertNetworkError();
    //yield 0;
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
  final response = await http.post(
      Uri.parse("$url/RoutineRequestDetailRequesterPage_cancelRequest"),
      body: qParams);
  if (response.statusCode == 200) {
    print("cancelRequestData OK");
    contextRoutineRequestDetail
        .read<ManageDataRoutineRequestDetailRequesterPage>()
        .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
    yield 1;
  } else {
    alertNetworkError();
    // yield 0;
  }
}

List<ModelFullRequestData> cancelSampleData = [];
Stream<int> cancelSample() async* {
  print("IN cancelSample");
  Map<String, String> qParams = {
    'cancelSampleData': modelFullRequestDataToJson(cancelSampleData),
  };
  final response = await http.post(
      Uri.parse("$url/RoutineRequestDetailRequesterPage_cancelSample"),
      body: qParams);
  if (response.statusCode == 200) {
    print("cancelSample OK");
    contextRoutineRequestDetail
        .read<ManageDataRoutineRequestDetailRequesterPage>()
        .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);

    yield 1;
  } else {
    alertNetworkError();
    //yield 0;
  }
}

List<ModelFullRequestData> cancelItemData = [];
Stream<int> cancelItem() async* {
  print("IN cancelItem");
  Map<String, String> qParams = {
    'cancelItemData': modelFullRequestDataToJson(cancelItemData),
  };
  final response = await http.post(
      Uri.parse("$url/RoutineRequestDetailRequesterPage_cancelItem"),
      body: qParams);
  if (response.statusCode == 200) {
    contextRoutineRequestDetail
        .read<ManageDataRoutineRequestDetailRequesterPage>()
        .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
    yield 1;
  } else {
    alertNetworkError();
    // yield 0;
  }
}

List<ModelFullRequestData> reconfirmResultData = [];
Stream<int> submitReconfirmResult() async* {
  print("IN submitReconfirmResult");
  Map<String, String> qParams = {
    'reconfirmResultData': modelFullRequestDataToJson(reconfirmResultData),
  };
  final response = await http.post(
      Uri.parse("$url/RoutineRequestDetailRequesterPage_submitReconfirmResult"),
      body: qParams);
  if (response.statusCode == 200) {
    print("RECONFIRM OK");
    contextRoutineRequestDetail
        .read<ManageDataRoutineRequestDetailRequesterPage>()
        .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);

    yield 1;
  } else {
    alertNetworkError();
    //yield 0;
  }
}

List<ModelFullRequestData> completeResultData = [];
Stream<int> submitCompleteResult() async* {
  print("IN submitCompleteResult");
  Map<String, String> qParams = {
    'completeResultData': modelFullRequestDataToJson(completeResultData),
  };
  final response = await http.post(
      Uri.parse("$url/RoutineRequestDetailRequesterPage_submitCompleteResult"),
      body: qParams);
  if (response.statusCode == 200) {
    print("COMPLETE OK");
    alertSuccess("COMPLETE");
    /* contextRoutineRequestDetail
        .read<ManageDataRoutineRequestDetailRequesterPage>()
        .add(RoutineRequestDetailRequesterPageEvent.searchRequestData); */
    yield 1;
  } else {
    alertNetworkError();
    //yield 0;
  }
}

List<ModelFullRequestData> completeAllResultData = [];
Stream<int> submitCompleteAllResult() async* {
  print("IN submitCompleteAllResult");
  Map<String, String> qParams = {
    'completeAllResultData': modelFullRequestDataToJson(completeAllResultData),
  };
  final response = await http.post(
      Uri.parse(
          "$url/RoutineRequestDetailRequesterPage_submitCompleteAllResult"),
      body: qParams);
  if (response.statusCode == 200) {
    alertSuccess("COMPLETE");
    contextRoutineRequestDetail
        .read<ManageDataRoutineRequestDetailRequesterPage>()
        .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
    yield 1;
  } else {
    alertNetworkError();
    //yield 0;
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
        .post(
            Uri.parse(
                "$urlE/RoutineRequestDetailRequesterPage_saveApproveReport"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      /* showPDF(response.body, contextBG); */
      alertSuccess("APPROVE REPORT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
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

List<ModelFullRequestData> rejectReportData = [];
Future<void> saveRejectReport() async {
  Map<String, String> qParams = {
    'user': userName,
    'rejectReportData': modelFullRequestDataToJson(rejectReportData),
  };
  print("in saveRejectReport");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$urlE/RoutineRequestDetailRequesterPage_saveRejectReport"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("REJECT REPORT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
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

String reqNoDelete = "";
Future<void> submitDeleteReport() async {
  Map<String, String> qParams = {
    'user': userName,
    'reqNo': reqNoDelete,
  };
  print("in submitDeleteReport");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$url/RoutineRequestDetailRequesterPage_submitDeleteReport"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("DELETE REPORT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
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

String reqNoDeleteActual = "";
Future<void> submitDeleteAcutal() async {
  Map<String, String> qParams = {
    'user': userName,
    'reqNo': reqNoDeleteActual,
  };
  print("in submitDeleteAcutal");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$url/RoutineRequestDetailRequesterPage_submitDeleteAcutal"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("DELETE ACTUAL DATA COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
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
        .post(Uri.parse("$url/RoutineRequestDetailRequesterPage_reprintTag"),
            body: qParams)
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
  EasyLoading.show(status: 'loading...');
  print(">>${reqNo}");
  print(">>${selectedPrinter}");
  try {
    final response = await http
        .post(Uri.parse("$urlE/KACReportData_LoadReport"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      // print(response.body);
      EasyLoading.dismiss();
      showPDF(response.body, contextBG);
    } else {
      EasyLoading.dismiss();
      alertNetworkError();
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

List<ModelFullRequestData> dataEditFactor = [];

Future<void> submitEditStd() async {
  Map<String, String> qParams = {
    'data': modelFullRequestDataToJson(dataEditFactor),
  };
  print("in submitEditStd");
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestDetailRequesterPage_editFactorStd"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("EDIT STD COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
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

List<ModelFullRequestData> dataEditReportName = [];

Future<void> submitEditReportName() async {
  Map<String, String> qParams = {
    'data': modelFullRequestDataToJson(dataEditReportName),
  };
  print("in submitEditReportName");
  try {
    final response = await http
        .post(
            Uri.parse("$url/RoutineRequestDetailRequesterPage_editReportName"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("EDIT REPORT NAME COMPLETE");
      /*  contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData); */
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

List<KACReportDataModel> historyReportData = [];
Future searchHistoryApproveReport(String reqNo) async {
  Map<String, String> qParams = {
    'reqNo': reqNo,
  };
  print("in searchHistoryApproveReport");

  final response = await http.post(
      Uri.parse(
          "$urlE/RoutineRequestDetailRequesterPage_searchHistoryApproveReport"),
      body: qParams);
  if (response.statusCode == 200) {
    historyReportData.clear();
    List<KACReportDataModel> databuff =
        KACReportDataModelFromJson(response.body);
    try {
      var countData = 0;
      historyReportData.add(KACReportDataModel());
      historyReportData[countData].reviseNo = databuff[0].reviseNo;
      historyReportData[countData].name = databuff[0].incharge;
      historyReportData[countData].time0 = databuff[0].inchargeTime_0;
      historyReportData[countData].time1 = databuff[0].inchargeTime_1;
      historyReportData[countData].time2 = databuff[0].inchargeTime_2;
      historyReportData[countData].time3 = databuff[0].inchargeTime_3;

      countData++;

      if (databuff[0].subLeader != '' && databuff[0].subLeader != '-') {
        historyReportData.add(KACReportDataModel());
        historyReportData[countData].name = databuff[0].subLeader;
        historyReportData[countData].time0 = databuff[0].subLeaderTime_0;
        historyReportData[countData].time1 = databuff[0].subLeaderTime_1;
        historyReportData[countData].time2 = databuff[0].subLeaderTime_2;
        historyReportData[countData].time3 = databuff[0].subLeaderTime_3;
        historyReportData[countData].remark0 =
            databuff[0].subLeaderRejectRemark_0;
        historyReportData[countData].remark1 =
            databuff[0].subLeaderRejectRemark_1;
        historyReportData[countData].remark2 =
            databuff[0].subLeaderRejectRemark_2;
        historyReportData[countData].remark3 =
            databuff[0].subLeaderRejectRemark_3;

        countData++;
      }
      if (databuff[0].gl != '' && databuff[0].gl != '-') {
        historyReportData.add(KACReportDataModel());
        historyReportData[countData].time0 = databuff[0].gLTime_0;
        historyReportData[countData].name = databuff[0].gl;
        historyReportData[countData].time1 = databuff[0].gLTime_1;
        historyReportData[countData].time2 = databuff[0].gLTime_2;
        historyReportData[countData].time3 = databuff[0].gLTime_3;
        historyReportData[countData].remark0 = databuff[0].gLRejectRemark_0;
        historyReportData[countData].remark1 = databuff[0].gLRejectRemark_1;
        historyReportData[countData].remark2 = databuff[0].gLRejectRemark_2;
        historyReportData[countData].remark3 = databuff[0].gLRejectRemark_3;

        countData++;
      }
      if (databuff[0].dgm != '' && databuff[0].dgm != '-') {
        historyReportData.add(KACReportDataModel());
        historyReportData[countData].name = databuff[0].dgm;
        historyReportData[countData].time0 = databuff[0].dGMTime_0;
        historyReportData[countData].time1 = databuff[0].dGMTime_1;
        historyReportData[countData].time2 = databuff[0].dGMTime_2;
        historyReportData[countData].time3 = databuff[0].dGMTime_3;
        historyReportData[countData].remark0 = databuff[0].dGMRejectRemark_0;
        historyReportData[countData].remark1 = databuff[0].dGMRejectRemark_1;
        historyReportData[countData].remark2 = databuff[0].dGMRejectRemark_2;
        historyReportData[countData].remark3 = databuff[0].dGMRejectRemark_3;

        countData++;
      }
      if (databuff[0].jp != '' && databuff[0].jp != '-') {
        historyReportData.add(KACReportDataModel());
        historyReportData[countData].name = databuff[0].jp;
        historyReportData[countData].time1 = databuff[0].jPTime_1;
        historyReportData[countData].time2 = databuff[0].jPTime_2;
        historyReportData[countData].time3 = databuff[0].jPTime_3;
        historyReportData[countData].time0 = databuff[0].jPTime_0;
        historyReportData[countData].remark1 = databuff[0].jPRejectRemark_1;
        historyReportData[countData].remark2 = databuff[0].jPRejectRemark_2;
        historyReportData[countData].remark3 = databuff[0].jPRejectRemark_3;
        historyReportData[countData].remark0 = databuff[0].jPRejectRemark_0;
        countData++;
      }
    } catch (err) {
      print(err);
    }
    return 1;
  } else {
    alertNetworkError();
    return 0;
  }
}
