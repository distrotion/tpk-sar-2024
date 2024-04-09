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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/13_TiUV/data/13_TiUVStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/13_TiUV/data/13_TiUV_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataTiUV extends Bloc<TiUVEvent, int> {
  ManageDataTiUV() : super(0);

  @override
  Stream<int> mapEventToState(TiUVEvent event) async* {
    if (event == TiUVEvent.searchTiUVForInput) {
      yield* searchTiUVForInput();
    } else if (event == TiUVEvent.saveTiUVData) {
      yield* saveTiUVData();
    } else if (event == TiUVEvent.tempSaveTiUVData) {
      yield* tempSaveTiUVData();
    } else if (event == TiUVEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelTiUV> dataTiUVInput = [];

Stream<int> searchTiUVForInput() async* {
  print("in searchTiUVForInput");
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
        .post(Uri.parse("$url/Instrument_searchTiUVForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      //print(response.body);
      if (response.body != "error") {
        dataTiUVInput = modelTiUVFromJson(response.body);
        for (int i = 0; i < dataTiUVInput.length; i++) {
          if (dataTiUVInput[i].dilutionTime_1 == "") {
            dataTiUVInput[i].dilutionTime_1 = dataTiUVInput[i].mag;
          }
          if (dataTiUVInput[i].dilutionTime_2 == "") {
            dataTiUVInput[i].dilutionTime_2 = dataTiUVInput[i].mag;
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

List<ModelTiUV> dataTempTiUVsave = [];
Stream<int> tempSaveTiUVData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveTiUVData");
  Map<String, String> qParams = {
    'data': modelTiUVToJson(dataTempTiUVsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataTiUV"), body: qParams)
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

List<ModelTiUV> dataTiUVsave = [];
Stream<int> saveTiUVData() async* {
  print("in save TiUV");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelTiUVToJson(dataTiUVsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataTiUV"), body: qParams)
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
