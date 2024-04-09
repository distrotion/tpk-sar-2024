import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/17_SG_NoxRust/data/17_SG_NoxRustStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/17_SG_NoxRust/data/17_SG_NoxRust_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataSG_NoxRust extends Bloc<SG_NoxRustEvent, int> {
  ManageDataSG_NoxRust() : super(0);

  @override
  Stream<int> mapEventToState(SG_NoxRustEvent event) async* {
    if (event == SG_NoxRustEvent.searchSG_NoxRustForInput) {
      yield* searchSG_NoxRustForInput();
    } else if (event == SG_NoxRustEvent.saveSG_NoxRustData) {
      yield* saveSG_NoxRustData();
    } else if (event == SG_NoxRustEvent.tempSaveSG_NoxRustData) {
      yield* tempSaveSG_NoxRustData();
    } else if (event == SG_NoxRustEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelSG_NoxRust> dataSG_NoxRustInput = [];

Stream<int> searchSG_NoxRustForInput() async* {
  print("in searchSG_NoxRustForInput");
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
        .post(Uri.parse("$url/Instrument_searchSG_NoxRustForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataSG_NoxRustInput = modelSG_NoxRustFromJson(response.body);
        for (int i = 0; i < dataSG_NoxRustInput.length; i++) {
          if (dataSG_NoxRustInput[i].tempareture_1 == "") {
            dataSG_NoxRustInput[i].tempareture_1 = dataSG_NoxRustInput[i].temp;
          }
          if (dataSG_NoxRustInput[i].tempareture_2 == "") {
            dataSG_NoxRustInput[i].tempareture_2 = dataSG_NoxRustInput[i].temp;
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

List<ModelSG_NoxRust> dataTempSG_NoxRustsave = [];
Stream<int> tempSaveSG_NoxRustData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveSG_NoxRustData");
  Map<String, String> qParams = {
    'data': modelSG_NoxRustToJson(dataTempSG_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataSG_NoxRust"),
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

List<ModelSG_NoxRust> dataSG_NoxRustsave = [];
Stream<int> saveSG_NoxRustData() async* {
  print("in save SG_NoxRust");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelSG_NoxRustToJson(dataSG_NoxRustsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataSG_NoxRust"), body: qParams)
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
