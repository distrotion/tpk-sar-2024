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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/52_CnUV/data/52_CnUVStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/52_CnUV/data/52_CnUV_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataCnUV extends Bloc<CnUVEvent, int> {
  ManageDataCnUV() : super(0);

  @override
  Stream<int> mapEventToState(CnUVEvent event) async* {
    if (event == CnUVEvent.searchCnUVForInput) {
      yield* searchCnUVForInput();
    } else if (event == CnUVEvent.saveCnUVData) {
      yield* saveCnUVData();
    } else if (event == CnUVEvent.tempSaveCnUVData) {
      yield* tempSaveCnUVData();
    } else if (event == CnUVEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelCnUV> dataCnUVInput = [];

Stream<int> searchCnUVForInput() async* {
  print("in searchCnUVForInput");
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
        .post(Uri.parse("$url/Instrument_searchCnUVForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      //print(response.body);
      if (response.body != "error") {
        dataCnUVInput = modelCnUVFromJson(response.body);
        for (int i = 0; i < dataCnUVInput.length; i++) {
          if (dataCnUVInput[i].dilutionTime_1 == "") {
            dataCnUVInput[i].dilutionTime_1 = dataCnUVInput[i].mag;
          }
          if (dataCnUVInput[i].dilutionTime_2 == "") {
            dataCnUVInput[i].dilutionTime_2 = dataCnUVInput[i].mag;
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

List<ModelCnUV> dataTempCnUVsave = [];
Stream<int> tempSaveCnUVData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveCnUVData");
  Map<String, String> qParams = {
    'data': modelCnUVToJson(dataTempCnUVsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataCnUV"), body: qParams)
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

List<ModelCnUV> dataCnUVsave = [];
Stream<int> saveCnUVData() async* {
  print("in save CnUV");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelCnUVToJson(dataCnUVsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataCnUV"), body: qParams)
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
