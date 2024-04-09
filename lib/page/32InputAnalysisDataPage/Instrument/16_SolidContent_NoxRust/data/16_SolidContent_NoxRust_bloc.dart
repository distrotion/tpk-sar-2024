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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/16_SolidContent_NoxRust/data/16_SolidContent_NoxRustStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/16_SolidContent_NoxRust/data/16_SolidContent_NoxRust_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataSolidContent_NoxRust
    extends Bloc<SolidContent_NoxRustEvent, int> {
  ManageDataSolidContent_NoxRust() : super(0);

  @override
  Stream<int> mapEventToState(SolidContent_NoxRustEvent event) async* {
    if (event == SolidContent_NoxRustEvent.searchSolidContent_NoxRustForInput) {
      yield* searchSolidContent_NoxRustForInput();
    } else if (event ==
        SolidContent_NoxRustEvent.saveSolidContent_NoxRustData) {
      yield* saveSolidContent_NoxRustData();
    } else if (event ==
        SolidContent_NoxRustEvent.tempSaveSolidContent_NoxRustData) {
      yield* tempSaveSolidContent_NoxRustData();
    } else if (event == SolidContent_NoxRustEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelSolidContent_NoxRust> dataSolidContent_NoxRustInput = [];

Stream<int> searchSolidContent_NoxRustForInput() async* {
  print("in searchSolidContent_NoxRustForInput");
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
        .post(Uri.parse("$url/Instrument_searchSolidContent_NoxRustForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataSolidContent_NoxRustInput =
            modelSolidContent_NoxRustFromJson(response.body);
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

List<ModelSolidContent_NoxRust> dataTempSolidContent_NoxRustsave = [];
Stream<int> tempSaveSolidContent_NoxRustData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveSolidContent_NoxRustData");
  Map<String, String> qParams = {
    'data': modelSolidContent_NoxRustToJson(dataTempSolidContent_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataSolidContent_NoxRust"),
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

List<ModelSolidContent_NoxRust> dataSolidContent_NoxRustsave = [];
Stream<int> saveSolidContent_NoxRustData() async* {
  print("in save SolidContent_NoxRust");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelSolidContent_NoxRustToJson(dataSolidContent_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataSolidContent_NoxRust"),
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
