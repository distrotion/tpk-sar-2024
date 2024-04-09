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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/19_FlashPoint_NoxRust/data/19_FlashPoint_NoxRustStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/19_FlashPoint_NoxRust/data/19_FlashPoint_NoxRust_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataFlashPoint_NoxRust extends Bloc<FlashPoint_NoxRustEvent, int> {
  ManageDataFlashPoint_NoxRust() : super(0);

  @override
  Stream<int> mapEventToState(FlashPoint_NoxRustEvent event) async* {
    if (event == FlashPoint_NoxRustEvent.searchFlashPoint_NoxRustForInput) {
      yield* searchFlashPoint_NoxRustForInput();
    } else if (event == FlashPoint_NoxRustEvent.saveFlashPoint_NoxRustData) {
      yield* saveFlashPoint_NoxRustData();
    } else if (event == FlashPoint_NoxRustEvent.tempSaveFlashPoint_NoxRustData) {
      yield* tempSaveFlashPoint_NoxRustData();
    } else if (event == FlashPoint_NoxRustEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelFlashPoint_NoxRust> dataFlashPoint_NoxRustInput = [];

Stream<int> searchFlashPoint_NoxRustForInput() async* {
  print("in searchFlashPoint_NoxRustForInput");
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
        .post(Uri.parse("$url/Instrument_searchFlashPoint_NoxRustForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataFlashPoint_NoxRustInput = modelFlashPoint_NoxRustFromJson(response.body);
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

List<ModelFlashPoint_NoxRust> dataTempFlashPoint_NoxRustsave = [];
Stream<int> tempSaveFlashPoint_NoxRustData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveFlashPoint_NoxRustData");
  Map<String, String> qParams = {
    'data': modelFlashPoint_NoxRustToJson(dataTempFlashPoint_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataFlashPoint_NoxRust"), body: qParams)
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

List<ModelFlashPoint_NoxRust> dataFlashPoint_NoxRustsave = [];
Stream<int> saveFlashPoint_NoxRustData() async* {
  print("in save FlashPoint_NoxRust");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelFlashPoint_NoxRustToJson(dataFlashPoint_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataFlashPoint_NoxRust"), body: qParams)
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
