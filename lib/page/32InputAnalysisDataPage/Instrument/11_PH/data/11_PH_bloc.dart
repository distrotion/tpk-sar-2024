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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/11_PH/data/11_PHStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/11_PH/data/11_PH_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataPH extends Bloc<PHEvent, int> {
  ManageDataPH() : super(0);

  @override
  Stream<int> mapEventToState(PHEvent event) async* {
    if (event == PHEvent.searchPHForInput) {
      yield* searchPHForInput();
    } else if (event == PHEvent.savePHData) {
      yield* savePHData();
    } else if (event == PHEvent.tempSavePHData) {
      yield* tempSavePHData();
    } else if (event == PHEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelPH> dataPHInput = [];

Stream<int> searchPHForInput() async* {
  print("in searchPHForInput");
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
        .post(Uri.parse("$url/Instrument_searchPHForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataPHInput = modelPHFromJson(response.body);
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

List<ModelPH> dataTempPHsave = [];
Stream<int> tempSavePHData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSavePHData");
  Map<String, String> qParams = {
    'data': modelPHToJson(dataTempPHsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataPH"), body: qParams)
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

List<ModelPH> dataPHsave = [];
Stream<int> savePHData() async* {
  print("in save PH");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelPHToJson(dataPHsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataPH"), body: qParams)
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
