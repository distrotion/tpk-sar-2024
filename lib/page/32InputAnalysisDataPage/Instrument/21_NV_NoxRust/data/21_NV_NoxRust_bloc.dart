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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/21_NV_NoxRust/data/21_NV_NoxRustStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/21_NV_NoxRust/data/21_NV_NoxRust_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataNV_NoxRust extends Bloc<NV_NoxRustEvent, int> {
  ManageDataNV_NoxRust() : super(0);

  @override
  Stream<int> mapEventToState(NV_NoxRustEvent event) async* {
    if (event == NV_NoxRustEvent.searchNV_NoxRustForInput) {
      yield* searchNV_NoxRustForInput();
    } else if (event == NV_NoxRustEvent.saveNV_NoxRustData) {
      yield* saveNV_NoxRustData();
    } else if (event == NV_NoxRustEvent.tempSaveNV_NoxRustData) {
      yield* tempSaveNV_NoxRustData();
    } else if (event == NV_NoxRustEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelNV_NoxRust> dataNV_NoxRustInput = [];

Stream<int> searchNV_NoxRustForInput() async* {
  print("in searchNV_NoxRustForInput");
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
        .post(Uri.parse("$url/Instrument_searchNV_NoxRustForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataNV_NoxRustInput = modelNV_NoxRustFromJson(response.body);
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

List<ModelNV_NoxRust> dataTempNV_NoxRustsave = [];
Stream<int> tempSaveNV_NoxRustData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveNV_NoxRustData");
  Map<String, String> qParams = {
    'data': modelNV_NoxRustToJson(dataTempNV_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataNV_NoxRust"),
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

List<ModelNV_NoxRust> dataNV_NoxRustsave = [];
Stream<int> saveNV_NoxRustData() async* {
  print("in save NV_NoxRust");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelNV_NoxRustToJson(dataNV_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataNV_NoxRust"), body: qParams)
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
