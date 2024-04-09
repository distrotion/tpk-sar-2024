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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/20_AcidNumber_NoxRust/data/20_AcidNumber_NoxRustStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/20_AcidNumber_NoxRust/data/20_AcidNumber_NoxRust_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataAcidNumber_NoxRust extends Bloc<AcidNumber_NoxRustEvent, int> {
  ManageDataAcidNumber_NoxRust() : super(0);

  @override
  Stream<int> mapEventToState(AcidNumber_NoxRustEvent event) async* {
    if (event == AcidNumber_NoxRustEvent.searchAcidNumber_NoxRustForInput) {
      yield* searchAcidNumber_NoxRustForInput();
    } else if (event == AcidNumber_NoxRustEvent.saveAcidNumber_NoxRustData) {
      yield* saveAcidNumber_NoxRustData();
    } else if (event == AcidNumber_NoxRustEvent.tempSaveAcidNumber_NoxRustData) {
      yield* tempSaveAcidNumber_NoxRustData();
    } else if (event == AcidNumber_NoxRustEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelAcidNumber_NoxRust> dataAcidNumber_NoxRustInput = [];

Stream<int> searchAcidNumber_NoxRustForInput() async* {
  print("in searchAcidNumber_NoxRustForInput");
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
        .post(Uri.parse("$url/Instrument_searchAcidNumber_NoxRustForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataAcidNumber_NoxRustInput = modelAcidNumber_NoxRustFromJson(response.body);
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

List<ModelAcidNumber_NoxRust> dataTempAcidNumber_NoxRustsave = [];
Stream<int> tempSaveAcidNumber_NoxRustData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveAcidNumber_NoxRustData");
  Map<String, String> qParams = {
    'data': modelAcidNumber_NoxRustToJson(dataTempAcidNumber_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataAcidNumber_NoxRust"), body: qParams)
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

List<ModelAcidNumber_NoxRust> dataAcidNumber_NoxRustsave = [];
Stream<int> saveAcidNumber_NoxRustData() async* {
  print("in save AcidNumber_NoxRust");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelAcidNumber_NoxRustToJson(dataAcidNumber_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataAcidNumber_NoxRust"), body: qParams)
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
