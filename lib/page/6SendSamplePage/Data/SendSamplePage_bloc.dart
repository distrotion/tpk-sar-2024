import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/6SendSamplePage/Data/SendSamplePage_event.dart';
import 'package:tpk_login_arsa_01/page/6SendSamplePage/SendSamplePage.dart';
import 'SendSamplePageStructure.dart';
//----------------------------------------------------------------

class ManageDataSendSample extends Bloc<SendSamplePageEvent, int> {
  ManageDataSendSample() : super(0);

  @override
  Stream<int> mapEventToState(SendSamplePageEvent event) async* {
    if (event == SendSamplePageEvent.searchSampleData) {
      yield* searchSampleData();
    } else if (event == SendSamplePageEvent.sendSample) {
      yield* sendSample();
    } else if (event == SendSamplePageEvent.searchRequestData) {
      yield* searchRequestData();
    } else if (event == SendSamplePageEvent.clearState) {
      yield* clearState();
    }
  }
}

List<MasterAddItem> selectedItemAdd = [];
List<ModelFullRequestData> sampleData = [];

Stream<int> searchSampleData() async* {
  Map<String, String> qParams = {
    'sampleCode': sampleCode,
  };
  EasyLoading.show(status: 'loading...');
  print("in searchSampleData $sampleCode + 111111");
  try {
    final response = await http
        .post(Uri.parse("$url/SendSamplePage_SearchSampleData"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body != "error") {
        if (response.body != '[]') {
          sampleData = modelFullRequestDataFromJson(response.body);
          yield 1;
          contextSendSamplePage
              .read<ManageDataSendSample>()
              .add(SendSamplePageEvent.searchRequestData);
        } else {
          alertError("DATA NOT FOUND");
          yield 0;
        }
      } else {
        alertError("SYSTEM ERROR");
        yield 0;
      }
    } else {
      alertNetworkError();
      yield 0;
    }
  } on TimeoutException catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
  }
}

Stream<int> clearState() async* {
  //print("inclear");
  yield 0;
}

List<ModelTableRequestData> tableRequestData = [];
String sampleCode = "";
Stream<int> searchRequestData() async* {
  Map<String, String> qParams = {
    'ReqNo': sampleCode.substring(0, 15),
  };

  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$url/SendSamplePage_SearchRequestData"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        if (response.body != '[]') {
          print(response.body);
          tableRequestData = modelTableRequestDataFromJson(response.body);
          yield 2;
        } else {
          alertError("NOT FOUND SAMPLE DATA");
        }
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
      }
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

/* Future<int> searchRequestData() async {
  Map<String, String> qParams = {
    'ReqNo': sampleCode.substring(0, 14),
  };
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .get(Uri.parse("$url/SendSamplePage_SearchRequestData"),
            headers: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        if (response.body != '[]') {
          print(response.body);
          tableRequestData = modelTableRequestDataFromJson(response.body);
          return 1;
        } else {
          alertError("NOT FOUND SAMPLE DATA");
          return 0;
        }
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
        return 0;
      }
    } else {
      EasyLoading.dismiss();
      alertNetworkError();
      return 0;
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
  return 0;
} */

String selectedPrinter = "-";

Stream<int> sendSample() async* {
  Map<String, String> qParams = {
    'data': modelFullRequestDataToJson(sampleData),
    'printer': selectedPrinter,
  };
  EasyLoading.show(status: 'loading...');
  print("insendsample");
  try {
    final response = await http
        .post(Uri.parse("$url/SendSamplePage_SendSample"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        contextSendSamplePage
            .read<ManageDataSendSample>()
            .add(SendSamplePageEvent.clearState);
        contextSendSamplePage
            .read<ManageDataSendSample>()
            .add(SendSamplePageEvent.searchRequestData);
        /* alertSuccess("RECEIVE COMPLETE"); */
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
        yield 0;
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

List<MasterInstrument> itemtToAdd = [];
String sampleTypeName = "";
Future<int> searchItemAdd() async {
  Map<String, String> qParams = {
    'sampleTypeName': sampleTypeName,
  };
  print("in searchItemAdd");
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestPage_SearchItemAdd"), body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      itemtToAdd = masterInstrumentFromJson(response.body);
      //await searchTempAdd();
      //await searchPosAdd();
      return 1;
    } else {
      return 0;
    }
  } on TimeoutException catch (e) {
    print(e);
  } on Error catch (e) {
    print(e);
  }
  return 0;
}

List tempToAdd = [];
Future<void> searchTempAdd() async {
  print("in searchTempAdd");
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestPage_SearchTempAdd"))
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      tempToAdd = jsonDecode(response.body);
    } else {}
  } on TimeoutException catch (e) {
    print(e);
  } on Error catch (e) {
    print(e);
  }
}

List posToAdd = [];
Future<void> searchPosAdd() async {
  print("in searchPosAdd");
  try {
    final response = await http
        .post(Uri.parse("$url/RoutineRequestPage_SearchPosAdd"))
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      posToAdd = jsonDecode(response.body);
    } else {}
  } on TimeoutException catch (e) {
    print(e);
  } on Error catch (e) {
    print(e);
  }
}
