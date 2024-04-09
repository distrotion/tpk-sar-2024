import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/36_Lvalue/data/36_LvalueStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/36_Lvalue/data/36_Lvalue_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataLvalue extends Bloc<LvalueEvent, int> {
  ManageDataLvalue() : super(0);

  @override
  Stream<int> mapEventToState(LvalueEvent event) async* {
    if (event == LvalueEvent.searchLvalueForInput) {
      yield* searchLvalueForInput();
    } else if (event == LvalueEvent.saveLvalueData) {
      yield* saveLvalueData();
    } else if (event == LvalueEvent.tempSaveLvalueData) {
      yield* tempSaveLvalueData();
    } else if (event == LvalueEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelLvalue> dataLvalueInput = [];

Stream<int> searchLvalueForInput() async* {
  print("in searchLvalueForInput");
  final SharedPreferences prefs = await _prefs;
  String instrumentName =
      prefs.getString('InputAnalysisDataPage_InstrumentName') ?? "";
  Map<String, String> qParams = {
    'UserName': userName,
    'InstrumentName': instrumentName,
    'SearchOption': jsonEncode(searchOption),
  };
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_searchLvalueForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataLvalueInput = modelLvalueFromJson(response.body);
        for (int i = 0; i < dataLvalueInput.length; i++) {
          dataLvalueInput[i].pos_1 = 'Wall-Out';
          dataLvalueInput[i].pos_2 = 'Wall-Out';
        }
        yield 1;
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
      }
    } else {
      EasyLoading.dismiss();
      alertError("SYSTEM ERROR");
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    alertNetworkError();
  } on Error catch (e) {
    EasyLoading.dismiss();
    alertNetworkError();
  }
}

Stream<int> dummyHead() async* {
  yield 1;
}

List<ModelLvalue> dataTempLvaluesave = [];
Stream<int> tempSaveLvalueData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveLvalueData");
  Map<String, String> qParams = {
    'data': modelLvalueToJson(dataTempLvaluesave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataLvalue"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        alertSuccess("SAVE RESULT COMPLETE");
        yield 1;
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
      }
    } else {
      EasyLoading.dismiss();
      alertError("SYSTEM ERROR");
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    alertNetworkError();
  } on Error catch (e) {
    EasyLoading.dismiss();
    alertNetworkError();
  }
  yield 1;
}

List<ModelLvalue> dataLvaluesave = [];
Stream<int> saveLvalueData() async* {
  print("in save Lvalue");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelLvalueToJson(dataLvaluesave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataLvalue"), body: qParams)
        .timeout(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        alertSuccess("SAVE RESULT COMPLETE");
        /* contextAnalysisDataPage
            .read<ManageDataInputAnalysisDataPage>()
            .add(InputAnalysisDataPageEvent.reloadData); */
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
      }
    } else {
      EasyLoading.dismiss();
      alertError("SYSTEM ERROR");
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    alertNetworkError();
  } on Error catch (e) {
    EasyLoading.dismiss();
    alertNetworkError();
  }
  yield 1;
}
