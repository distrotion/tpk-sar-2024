import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/7_FF/data/7_FFStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/7_FF/data/7_FF_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataFF extends Bloc<FFEvent, int> {
  ManageDataFF() : super(0);

  @override
  Stream<int> mapEventToState(FFEvent event) async* {
    if (event == FFEvent.searchFFForInput) {
      yield* searchFFForInput();
    } else if (event == FFEvent.saveFFData) {
      yield* saveFFData();
    } else if (event == FFEvent.tempSaveFFData) {
      yield* tempSaveFFData();
    } else if (event == FFEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelFF> dataFFInput = [];

Stream<int> searchFFForInput() async* {
  print("in searchFFForInput");
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
        .post(Uri.parse("$url/Instrument_searchFFForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      if (response.body != "error") {
        dataFFInput = modelFFFromJson(response.body);
        for (int i = 0; i < dataFFInput.length; i++) {
          if (dataFFInput[i].temp_1 == "") {
            dataFFInput[i].temp_1 = dataFFInput[i].temp;
          }
          if (dataFFInput[i].temp_2 == "") {
            dataFFInput[i].temp_2 = dataFFInput[i].temp;
          }
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

List<ModelFF> dataTempFFsave = [];
Stream<int> tempSaveFFData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveFFData");
  Map<String, String> qParams = {
    'data': modelFFToJson(dataTempFFsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataFF"), body: qParams)
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

List<ModelFF> dataFFsave = [];
Stream<int> saveFFData() async* {
  print("in save FF");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelFFToJson(dataFFsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataFF"), body: qParams)
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
