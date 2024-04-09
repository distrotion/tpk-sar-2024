import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/15_Viscosity_NoxRust/data/15_Viscosity_NoxRustStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/15_Viscosity_NoxRust/data/15_Viscosity_NoxRust_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataViscosity_NoxRust extends Bloc<Viscosity_NoxRustEvent, int> {
  ManageDataViscosity_NoxRust() : super(0);

  @override
  Stream<int> mapEventToState(Viscosity_NoxRustEvent event) async* {
    if (event == Viscosity_NoxRustEvent.searchViscosity_NoxRustForInput) {
      yield* searchViscosity_NoxRustForInput();
    } else if (event == Viscosity_NoxRustEvent.saveViscosity_NoxRustData) {
      yield* saveViscosity_NoxRustData();
    } else if (event == Viscosity_NoxRustEvent.tempSaveViscosity_NoxRustData) {
      yield* tempSaveViscosity_NoxRustData();
    } else if (event == Viscosity_NoxRustEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelViscosity_NoxRust> dataViscosity_NoxRustInput = [];

Stream<int> searchViscosity_NoxRustForInput() async* {
  print("in searchViscosity_NoxRustForInput");
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
        .post(Uri.parse("$url/Instrument_searchViscosity_NoxRustForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataViscosity_NoxRustInput =
            modelViscosity_NoxRustFromJson(response.body);

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

List<ModelViscosity_NoxRust> dataTempViscosity_NoxRustsave = [];
Stream<int> tempSaveViscosity_NoxRustData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveViscosity_NoxRustData");
  Map<String, String> qParams = {
    'data': modelViscosity_NoxRustToJson(dataTempViscosity_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataViscosity_NoxRust"),
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

List<ModelViscosity_NoxRust> dataViscosity_NoxRustsave = [];
Stream<int> saveViscosity_NoxRustData() async* {
  print("in save Viscosity_NoxRust");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelViscosity_NoxRustToJson(dataViscosity_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataViscosity_NoxRust"),
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
