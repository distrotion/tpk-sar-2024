import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/35_Dsmut/data/35_DsmutStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/35_Dsmut/data/35_Dsmut_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataDsmut extends Bloc<DsmutEvent, int> {
  ManageDataDsmut() : super(0);

  @override
  Stream<int> mapEventToState(DsmutEvent event) async* {
    if (event == DsmutEvent.searchDsmutForInput) {
      yield* searchDsmutForInput();
    } else if (event == DsmutEvent.saveDsmutData) {
      yield* saveDsmutData();
    } else if (event == DsmutEvent.tempSaveDsmutData) {
      yield* tempSaveDsmutData();
    } else if (event == DsmutEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelDsmut> dataDsmutInput = [];

Stream<int> searchDsmutForInput() async* {
  print("in searchDsmutForInput");
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
        .post(Uri.parse("$url/Instrument_searchDsmutForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataDsmutInput = modelDsmutFromJson(response.body);
        for (int i = 0; i < dataDsmutInput.length; i++) {
          dataDsmutInput[i].pos_1 = 'Wall-In';
          dataDsmutInput[i].pos_2 = 'Wall-In';
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

List<ModelDsmut> dataTempDsmutsave = [];
Stream<int> tempSaveDsmutData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveDsmutData");
  Map<String, String> qParams = {
    'data': modelDsmutToJson(dataTempDsmutsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataDsmut"), body: qParams)
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

List<ModelDsmut> dataDsmutsave = [];
Stream<int> saveDsmutData() async* {
  print("in save Dsmut");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelDsmutToJson(dataDsmutsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataDsmut"), body: qParams)
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
