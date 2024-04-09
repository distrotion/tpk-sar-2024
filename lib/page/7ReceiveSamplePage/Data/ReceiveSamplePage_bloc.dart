import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/11ApproveResultPage/ApproveResultPage.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'ReceiveSamplePageStructure.dart';
import 'ReceiveSamplePage_event.dart';

//----------------------------------------------------------------

class ManageDataReceiveSample extends Bloc<ReceiveSampleEvent, int> {
  ManageDataReceiveSample() : super(0);

  @override
  Stream<int> mapEventToState(ReceiveSampleEvent event) async* {
    if (event == ReceiveSampleEvent.fetchRequestData) {
      yield* fetchRequestData();
    } else if (event == ReceiveSampleEvent.clearState) {
      yield* clearState();
    } else if (event == ReceiveSampleEvent.receiveSample) {
      yield* receiveSample();
    } else if (event == ReceiveSampleEvent.rejectSample) {
      yield* rejectSample();
    }
  }
}

List<ModelTableReceiveiSample> dataTable = [];

List<SearchReceiveSample> searchBranch = [];

Stream<int> fetchRequestData() async* {
  yield 0;
  Map<String, String> qParams = {
    'searchBranch': searchReceiveSampleToMap(searchBranch),
  };
  print("in fetchData");
  try {
    final response = await http
        .post(Uri.parse("$url/ReceiveSamplePage_fetchRequestData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200 && response.body != "error") {
      dataTable = ModelTableReceiveiSampleFromJson(response.body);
      yield 1;
    } else {
      alertError("SYSTEM ERROR");
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    alertNetworkError();
  }
}

String sampleCode = "";
List<ModelFullRequestData> sampleData = [];

Future<int> searchSampleData() async {
  Map<String, String> qParams = {
    'sampleCode': sampleCode,
  };
  EasyLoading.show(status: 'loading...');
  print("in searchSampleData22222");
  try {
    final response = await http
        .post(Uri.parse("$url/ReceiveSamplePage_SearchSampleData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      //print(response.body);
      if (response.body != "error") {
        if (response.body != '[]') {
          sampleData = modelFullRequestDataFromJson(response.body);
          return 1;
        } else {
          alertError("SAMPLE NOT FOUND");
          return 0;
        }
      } else {
        alertError("SYSTEM ERROR");
        return 0;
      }
    } else {
      alertNetworkError();
      return 0;
    }
  } on TimeoutException catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
    return 0;
  } on Error catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
    return 0;
  }
}
/* List<ModelSampleData> sampleData = [];

Stream<int> searchSampleData() async* {
  Map<String, String> qParams = {
    'sampleCode': sampleCode,
  };
  print("in searchSampleData");
  final response = await http.get(
      Uri.parse("$url/ReceiveSamplePage_SearchSampleData"),
      headers: qParams);
  if (response.statusCode == 200) {
    print("repone ${response.body}");
    print("repone ${response.body.length}");
    itemInSample = "";
    sampleData = modelSampleDataFromMap(response.body);
    for (int i = 0; i < sampleData.length; i++) {
      itemInSample = itemInSample + sampleData[i].itemName + " ";
    }
    yield 2;
  } else {
    print("where is my server");
    yield 0;
  }
} */

Stream<int> clearState() async* {
  //print("inclear");
  yield 0;
}

String dueDate = "";
Stream<int> receiveSample() async* {
  var now = DateTime.now();
  var analysisDue = new DateTime(now.year, now.month, now.day + 3);
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'sampleCode': sampleCode,
    'userName': userName,
    //'analysisDue': DateFormat("yyyy-MM-dd").format(analysisDue),
    'dueDate': dueDate,
  };
  print("receiveSample");
  try {
    final response = await http
        .post(Uri.parse("$url/ReceiveSamplePage_ReceiveSample"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        Navigator.pop(contextBG);
        /* alertSuccess("RECEIVE COMPLETE"); */
        yield 2;
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
        yield 0;
      }
    }
  } on TimeoutException catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
    yield 0;
  } on Error catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
    yield 0;
  }
}

String rejectSampleRemark = "";
Stream<int> rejectSample() async* {
  Map<String, String> qParams = {
    'sampleCode': sampleCode,
    'userName': userName,
    'rejectSampleRemark': rejectSampleRemark,
  };
  EasyLoading.show(status: 'loading...');
  try {
    print("in rejectSample");
    final response = await http
        .post(Uri.parse("$url/ReceiveSamplePage_RejectSample"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        Navigator.pop(contextBG);
        alertSuccess("REJECT COMPLETE");
        yield 2;
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
        yield 0;
      }
    }
  } on TimeoutException catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
    yield 0;
  } on Error catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
    yield 0;
  }
}

