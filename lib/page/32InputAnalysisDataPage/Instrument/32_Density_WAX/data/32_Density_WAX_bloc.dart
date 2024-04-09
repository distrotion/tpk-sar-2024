import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/32_Density_WAX/data/32_Density_WAXStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/32_Density_WAX/data/32_Density_WAX_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataDensity_WAX extends Bloc<Density_WAXEvent, int> {
  ManageDataDensity_WAX() : super(0);

  @override
  Stream<int> mapEventToState(Density_WAXEvent event) async* {
    if (event == Density_WAXEvent.searchDensity_WAXForInput) {
      yield* searchDensity_WAXForInput();
    } else if (event == Density_WAXEvent.saveDensity_WAXData) {
      yield* saveDensity_WAXData();
    } else if (event == Density_WAXEvent.tempSaveDensity_WAXData) {
      yield* tempSaveDensity_WAXData();
    } else if (event == Density_WAXEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelDensity_WAX> dataDensity_WAXInput = [];

Stream<int> searchDensity_WAXForInput() async* {
  print("in searchDensity_WAXForInput");
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
        .post(Uri.parse("$url/Instrument_searchDensity_WAXForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataDensity_WAXInput = modelDensity_WAXFromJson(response.body);
        for (int i = 0; i < dataDensity_WAXInput.length; i++) {
          if (dataDensity_WAXInput[i].tempareture_1 == "") {
            dataDensity_WAXInput[i].tempareture_1 = "30";
          }
          if (dataDensity_WAXInput[i].tempareture_2 == "") {
            dataDensity_WAXInput[i].tempareture_2 = "30";
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

List<ModelDensity_WAX> dataTempDensity_WAXsave = [];
Stream<int> tempSaveDensity_WAXData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveDensity_WAXData");
  Map<String, String> qParams = {
    'data': modelDensity_WAXToJson(dataTempDensity_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataDensity_WAX"),
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

List<ModelDensity_WAX> dataDensity_WAXsave = [];
Stream<int> saveDensity_WAXData() async* {
  print("in save Density_WAX");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelDensity_WAXToJson(dataDensity_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataDensity_WAX"), body: qParams)
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
