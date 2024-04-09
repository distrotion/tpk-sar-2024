import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/37_ContactAngle/data/37_ContactAngleStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/37_ContactAngle/data/37_ContactAngle_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataContactAngle extends Bloc<ContactAngleEvent, int> {
  ManageDataContactAngle() : super(0);

  @override
  Stream<int> mapEventToState(ContactAngleEvent event) async* {
    if (event == ContactAngleEvent.searchContactAngleForInput) {
      yield* searchContactAngleForInput();
    } else if (event == ContactAngleEvent.saveContactAngleData) {
      yield* saveContactAngleData();
    } else if (event == ContactAngleEvent.tempSaveContactAngleData) {
      yield* tempSaveContactAngleData();
    } else if (event == ContactAngleEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelContactAngle> dataContactAngleInput = [];

Stream<int> searchContactAngleForInput() async* {
  print("in searchContactAngleForInput");
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
        .post(Uri.parse("$url/Instrument_searchContactAngleForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      //print(response.body);
      if (response.body != "error") {
        dataContactAngleInput = modelContactAngleFromJson(response.body);
        for (int i = 0; i < dataContactAngleInput.length; i++) {
          if (dataContactAngleInput[i].pos_1 == '') {
            dataContactAngleInput[i].pos_1 = dataContactAngleInput[i].position;
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

List<ModelContactAngle> dataTempContactAnglesave = [];
Stream<int> tempSaveContactAngleData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveContactAngleData");
  Map<String, String> qParams = {
    'data': modelContactAngleToJson(dataTempContactAnglesave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataContactAngle"),
            body: qParams)
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

List<ModelContactAngle> dataContactAnglesave = [];
Stream<int> saveContactAngleData() async* {
  print("in save ContactAngle");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelContactAngleToJson(dataContactAnglesave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataContactAngle"), body: qParams)
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
