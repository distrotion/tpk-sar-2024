import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/30RequestDetailTTC/RoutineRequestDetailTTCPage.dart';
import 'RoutineRequestDetailTTCPage_event.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ManageDataRoutineRequestDetailTTCPage
    extends Bloc<RoutineRequestDetailTTCPageEvent, int> {
  ManageDataRoutineRequestDetailTTCPage() : super(0);

  @override
  Stream<int> mapEventToState(RoutineRequestDetailTTCPageEvent event) async* {
    if (event == RoutineRequestDetailTTCPageEvent.clearState) {
      yield* clearState();
    } else if (event == RoutineRequestDetailTTCPageEvent.searchRequestData) {
      yield* searchRequestData();
    } else if (event == RoutineRequestDetailTTCPageEvent.selectResult) {
      yield* selectResult();
    } else if (event == RoutineRequestDetailTTCPageEvent.submitRecheckResult) {
      yield* submitRecheckResult();
    } else if (event == RoutineRequestDetailTTCPageEvent.submitApproveResult) {
      yield* submitApproveResult();
    } else if (event == RoutineRequestDetailTTCPageEvent.approveAllResult) {
      yield* approveAllResult();
    } else if (event == RoutineRequestDetailTTCPageEvent.acceptReconfirm) {
      yield* acceptReconfirm();
    } else if (event == RoutineRequestDetailTTCPageEvent.rejectReconfirm) {
      yield* rejectReconfirm();
    }

    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

class RoutineRequestDetailTTCPagePageEvent {}

Stream<int> clearState() async* {
  yield 0;
}

List<ModelFullRequestData> requestData = [];
List<ModelFullRequestData> sampleData = []; // index = sample
List<List<ModelFullRequestData>> itemData =
    []; // index1 = sampleNo, index2 = itemNO

Stream<int> searchRequestData() async* {
  EasyLoading.show(status: 'loading...');
  print("IN RoutineRequestDetailTTCPage_searchRequestData");
  final SharedPreferences prefs = await _prefs;
  String reqNo = prefs.getString('RoutineRequestDetailTTCPage_reqNo') ?? "";
  print("reqNO:$reqNo");
  Map<String, String> qParams = {
    'reqNo': reqNo,
  };
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestDetailTTCPage_searchRequestData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      sampleData.clear();
      requestData.clear();
      itemData.clear();
      requestData = modelFullRequestDataFromJson(response.body);
      int bufferSampleNo = 0;

      for (int i = 0; i < requestData.length; i++) {
        /* if (int.tryParse(requestData[i].sampleNo) != bufferSampleNo) {
          bufferSampleNo = int.tryParse(requestData[i].sampleNo) ?? 1;
          //print("bufferSampleNo : $bufferSampleNo");
          sampleData.add(requestData[i]);
          itemData.add([]);
        } */
        if (i == 0) {
          bufferSampleNo = 1;
          sampleData.add(requestData[i]);
          itemData.add([]);
        } else if (requestData[i].sampleNo != requestData[i - 1].sampleNo) {
          bufferSampleNo++;
          sampleData.add(requestData[i]);
          itemData.add([]);
        }
        //print(itemData.length);
        itemData[(bufferSampleNo) - 1].add(requestData[i]);
      }
      /*  print(itemData[0].length);
    print(itemData[0][1].itemName);
    print("itemData : ${itemData.length}");
    print("itemData[2] : ${itemData[2].length}");
    print("itemData[2] : ${itemData[2][2].itemName}"); */
      EasyLoading.dismiss();
      yield 1;
    } else {
      EasyLoading.dismiss();
      print("where is my server");
      yield 0;
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

Stream<int> selectResult() async* {
  print("1");
  yield 0;
  await Future.delayed(
    Duration(milliseconds: 500),
  );
  print("2");
  yield 1;
}

List<ModelFullRequestData> recheckResultData = [];
Stream<int> submitRecheckResult() async* {
  Map<String, String> qParams = {
    'recheckResultData': modelFullRequestDataToJson(recheckResultData),
  };
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestDetailTTCPage_submitRecheckResult"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        alertSuccess("REQUEST RECHECK COMPLETE");
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.clearState);
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.searchRequestData);
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
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

List<ModelFullRequestData> approveResultData = [];
Stream<int> submitApproveResult() async* {
  Map<String, String> qParams = {
    'approveResultData': modelFullRequestDataToJson(approveResultData),
  };
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestDetailTTCPage_submitApproveResult"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        alertSuccess("SUBMIT RESULT COMPLETE");
        /* contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.clearState);
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.searchRequestData); */
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
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

List<ModelFullRequestData> approveAllResultData = [];
Stream<int> approveAllResult() async* {
  Map<String, String> qParams = {
    'approveAllResultData': modelFullRequestDataToJson(approveAllResultData),
  };
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(
            Uri.parse("$url/RoutineRequestDetailTTCPage_approveAllResultData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        alertSuccess("SUBMIT RESULT COMPLETE");
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.clearState);
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.searchRequestData);
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
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

List<ModelFullRequestData> acceptReconfirmData = [];
Stream<int> acceptReconfirm() async* {
  Map<String, String> qParams = {
    'acceptReconfirmData': modelFullRequestDataToJson(acceptReconfirmData),
  };
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestDetailTTCPage_acceptReconfirm"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        alertSuccess("ACCEPT RECONFIRM COMPLETE");
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.clearState);
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.searchRequestData);
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
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

List<ModelFullRequestData> rejectReconfirmData = [];
Stream<int> rejectReconfirm() async* {
  Map<String, String> qParams = {
    'rejectReconfirmData': modelFullRequestDataToJson(rejectReconfirmData),
  };
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestDetailTTCPage_rejectReconfirm"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        alertSuccess("REJECT RECONFIRM COMPLETE");
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.clearState);
        contextRoutineRequestDetailTTCPage
            .read<ManageDataRoutineRequestDetailTTCPage>()
            .add(RoutineRequestDetailTTCPageEvent.searchRequestData);
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
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

String editItemStatus = "";
String editItemId = "";
Future<int> saveEditItemStatus() async {
  Map<String, String> qParams = {
    'id': editItemId,
    'itemStatus': editItemStatus,
  };
  print("in editItemStatus");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$url/RoutineRequestDetailRequesterPage_saveEditItemStatus"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    print(response.statusCode);
    if (response.statusCode == 200 && response.body != "error") {
      alertSuccess("EDIT ITEM STATUS COMPLETE");
      return 1;
    } else {
      alertNetworkError();
      return 0;
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
    return 0;
  } on Error catch (e) {
    print(e);
    alertNetworkError();
    return 0;
  }
}

String editDuedateDate = "";
String editDuedateId = "";
String editDuedateItemStatus = "";
String editDuedateRemark = "";
Future<int> saveEditDuedate() async {
  Map<String, String> qParams = {
    'user': userName,
    'id': editDuedateId,
    'editDuedateDate': editDuedateDate,
    'editDuedateItemStatus': editDuedateItemStatus,
    'editDuedateRemark': editDuedateRemark,
  };
  print("in saveEditDuedate");
  try {
    final response = await http
        .post(
            Uri.parse("$url/RoutineRequestDetailRequesterPage_saveEditDuedate"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    print(response.statusCode);
    if (response.statusCode == 200 && response.body != "error") {
      alertSuccess("EDIT Duedate COMPLETE");
      return 1;
    } else {
      alertNetworkError();
      return 0;
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
    return 0;
  } on Error catch (e) {
    print(e);
    alertNetworkError();
    return 0;
  }
}
