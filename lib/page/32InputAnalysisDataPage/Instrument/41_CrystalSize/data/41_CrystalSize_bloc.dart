import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/41_CrystalSize/data/41_CrystalSizeStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/41_CrystalSize/data/41_CrystalSize_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataCrystalSize extends Bloc<CrystalSizeEvent, int> {
  ManageDataCrystalSize() : super(0);

  @override
  Stream<int> mapEventToState(CrystalSizeEvent event) async* {
    if (event == CrystalSizeEvent.searchCrystalSizeForInput) {
      yield* searchCrystalSizeForInput();
    } else if (event == CrystalSizeEvent.saveCrystalSizeData) {
      yield* saveCrystalSizeData();
    } else if (event == CrystalSizeEvent.tempSaveCrystalSizeData) {
      yield* tempSaveCrystalSizeData();
    } else if (event == CrystalSizeEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelCrystalSize> dataCrystalSizeInput = [];

Stream<int> searchCrystalSizeForInput() async* {
  print("in searchCrystalSizeForInput");
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
        .post(Uri.parse("$url/Instrument_searchCrystalSizeForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataCrystalSizeInput = modelCrystalSizeFromJson(response.body);
        for (int i = 0; i < dataCrystalSizeInput.length; i++) {
          if (dataCrystalSizeInput[i].magnification_1 == "") {
            dataCrystalSizeInput[i].magnification_1 =
                dataCrystalSizeInput[i].mag;
          }
          if (dataCrystalSizeInput[i].position_1 == "") {
            dataCrystalSizeInput[i].position_1 =
                dataCrystalSizeInput[i].position;
          }
          if (dataCrystalSizeInput[i].magnification_2 == "") {
            dataCrystalSizeInput[i].magnification_2 =
                dataCrystalSizeInput[i].mag;
          }
          if (dataCrystalSizeInput[i].position_2 == "") {
            dataCrystalSizeInput[i].position_2 =
                dataCrystalSizeInput[i].position;
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

List<ModelCrystalSize> dataTempCrystalSizesave = [];
Stream<int> tempSaveCrystalSizeData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveCrystalSizeData");
  Map<String, String> qParams = {
    'data': modelCrystalSizeToJson(dataTempCrystalSizesave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataCrystalSize"),
            body: qParams)
        .timeout(Duration(seconds: 15));
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

List<ModelCrystalSize> dataCrystalSizesave = [];
Stream<int> saveCrystalSizeData() async* {
  print("in save CrystalSize");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelCrystalSizeToJson(dataCrystalSizesave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataCrystalSize"), body: qParams)
        .timeout(const Duration(seconds: 15));
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
