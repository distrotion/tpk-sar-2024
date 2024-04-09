import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/3_SEM/data/3_SEMStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/3_SEM/data/3_SEM_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataSEM extends Bloc<SEMEvent, int> {
  ManageDataSEM() : super(0);

  @override
  Stream<int> mapEventToState(SEMEvent event) async* {
    if (event == SEMEvent.searchSEMForInput) {
      yield* searchSEMForInput();
    } else if (event == SEMEvent.saveSEMData) {
      yield* saveSEMData();
    } else if (event == SEMEvent.tempSaveSEMData) {
      yield* tempSaveSEMData();
    } else if (event == SEMEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelSEM> dataSEMInput = [];

Stream<int> searchSEMForInput() async* {
  print("in searchSEMForInput");
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
        .post(Uri.parse("$url/Instrument_searchSEMForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataSEMInput = modelSEMFromJson(response.body);
        for (int i = 0; i < dataSEMInput.length; i++) {
          if (dataSEMInput[i].magnification_1 == "") {
            dataSEMInput[i].magnification_1 = dataSEMInput[i].mag;
          }
          if (dataSEMInput[i].position_1 == "") {
            dataSEMInput[i].position_1 = dataSEMInput[i].position;
          }
          if (dataSEMInput[i].magnification_2 == "") {
            dataSEMInput[i].magnification_2 = dataSEMInput[i].mag;
          }
          if (dataSEMInput[i].position_2 == "") {
            dataSEMInput[i].position_2 = dataSEMInput[i].position;
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

List<ModelSEM> dataTempSEMsave = [];
Stream<int> tempSaveSEMData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveSEMData");
  Map<String, String> qParams = {
    'data': modelSEMToJson(dataTempSEMsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataSEM"), body: qParams)
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

List<ModelSEM> dataSEMsave = [];
Stream<int> saveSEMData() async* {
  print("in save SEM");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelSEMToJson(dataSEMsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataSEM"), body: qParams)
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
