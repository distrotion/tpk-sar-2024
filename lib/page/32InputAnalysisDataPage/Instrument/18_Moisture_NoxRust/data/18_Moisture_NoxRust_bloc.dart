import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/InputAnalysisDataPage.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/18_Moisture_NoxRust/data/18_Moisture_NoxRustStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/18_Moisture_NoxRust/data/18_Moisture_NoxRust_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataMoisture_NoxRust extends Bloc<Moisture_NoxRustEvent, int> {
  ManageDataMoisture_NoxRust() : super(0);

  @override
  Stream<int> mapEventToState(Moisture_NoxRustEvent event) async* {
    if (event == Moisture_NoxRustEvent.searchMoisture_NoxRustForInput) {
      yield* searchMoisture_NoxRustForInput();
    } else if (event == Moisture_NoxRustEvent.saveMoisture_NoxRustData) {
      yield* saveMoisture_NoxRustData();
    } else if (event == Moisture_NoxRustEvent.tempSaveMoisture_NoxRustData) {
      yield* tempSaveMoisture_NoxRustData();
    } else if (event == Moisture_NoxRustEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelMoisture_NoxRust> dataMoisture_NoxRustInput = [];

Stream<int> searchMoisture_NoxRustForInput() async* {
  print("in searchMoisture_NoxRustForInput");
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
        .post(Uri.parse("$url/Instrument_searchMoisture_NoxRustForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataMoisture_NoxRustInput =
            modelMoisture_NoxRustFromJson(response.body);
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

List<ModelMoisture_NoxRust> dataTempMoisture_NoxRustsave = [];
Stream<int> tempSaveMoisture_NoxRustData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveMoisture_NoxRustData");
  Map<String, String> qParams = {
    'data': modelMoisture_NoxRustToJson(dataTempMoisture_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataMoisture_NoxRust"),
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

List<ModelMoisture_NoxRust> dataMoisture_NoxRustsave = [];
Stream<int> saveMoisture_NoxRustData() async* {
  print("in save Moisture_NoxRust");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelMoisture_NoxRustToJson(dataMoisture_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataMoisture_NoxRust"),
            body: qParams)
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
