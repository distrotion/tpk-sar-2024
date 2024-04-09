import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/31_FlashPoint_WAX/data/31_FlashPoint_WAXStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/31_FlashPoint_WAX/data/31_FlashPoint_WAX_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataFlashPoint_WAX extends Bloc<FlashPoint_WAXEvent, int> {
  ManageDataFlashPoint_WAX() : super(0);

  @override
  Stream<int> mapEventToState(FlashPoint_WAXEvent event) async* {
    if (event == FlashPoint_WAXEvent.searchFlashPoint_WAXForInput) {
      yield* searchFlashPoint_WAXForInput();
    } else if (event == FlashPoint_WAXEvent.saveFlashPoint_WAXData) {
      yield* saveFlashPoint_WAXData();
    } else if (event == FlashPoint_WAXEvent.tempSaveFlashPoint_WAXData) {
      yield* tempSaveFlashPoint_WAXData();
    } else if (event == FlashPoint_WAXEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelFlashPoint_WAX> dataFlashPoint_WAXInput = [];

Stream<int> searchFlashPoint_WAXForInput() async* {
  print("in searchFlashPoint_WAXForInput");
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
        .post(Uri.parse("$url/Instrument_searchFlashPoint_WAXForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataFlashPoint_WAXInput = modelFlashPoint_WAXFromJson(response.body);
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

List<ModelFlashPoint_WAX> dataTempFlashPoint_WAXsave = [];
Stream<int> tempSaveFlashPoint_WAXData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveFlashPoint_WAXData");
  Map<String, String> qParams = {
    'data': modelFlashPoint_WAXToJson(dataTempFlashPoint_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataFlashPoint_WAX"), body: qParams)
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

List<ModelFlashPoint_WAX> dataFlashPoint_WAXsave = [];
Stream<int> saveFlashPoint_WAXData() async* {
  print("in save FlashPoint_WAX");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelFlashPoint_WAXToJson(dataFlashPoint_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataFlashPoint_WAX"), body: qParams)
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
