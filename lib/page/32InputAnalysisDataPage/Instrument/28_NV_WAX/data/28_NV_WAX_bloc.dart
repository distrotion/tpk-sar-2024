import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/28_NV_WAX/data/28_NV_WAXStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/28_NV_WAX/data/28_NV_WAX_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataNV_WAX extends Bloc<NV_WAXEvent, int> {
  ManageDataNV_WAX() : super(0);

  @override
  Stream<int> mapEventToState(NV_WAXEvent event) async* {
    if (event == NV_WAXEvent.searchNV_WAXForInput) {
      yield* searchNV_WAXForInput();
    } else if (event == NV_WAXEvent.saveNV_WAXData) {
      yield* saveNV_WAXData();
    } else if (event == NV_WAXEvent.tempSaveNV_WAXData) {
      yield* tempSaveNV_WAXData();
    } else if (event == NV_WAXEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelNV_WAX> dataNV_WAXInput = [];

Stream<int> searchNV_WAXForInput() async* {
  print("in searchNV_WAXForInput");
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
        .post(Uri.parse("$url/Instrument_searchNV_WAXForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataNV_WAXInput = modelNV_WAXFromJson(response.body);
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

List<ModelNV_WAX> dataTempNV_WAXsave = [];
Stream<int> tempSaveNV_WAXData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveNV_WAXData");
  Map<String, String> qParams = {
    'data': modelNV_WAXToJson(dataTempNV_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataNV_WAX"),
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

List<ModelNV_WAX> dataNV_WAXsave = [];
Stream<int> saveNV_WAXData() async* {
  print("in save NV_WAX");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelNV_WAXToJson(dataNV_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataNV_WAX"), body: qParams)
        .timeout(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        alertSuccess("SAVE RESULT COMPLETE");
       /*  contextAnalysisDataPage
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
