import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/29_Viscosity_WAX/data/29_Viscosity_WAXStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/29_Viscosity_WAX/data/29_Viscosity_WAX_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataViscosity_WAX extends Bloc<Viscosity_WAXEvent, int> {
  ManageDataViscosity_WAX() : super(0);

  @override
  Stream<int> mapEventToState(Viscosity_WAXEvent event) async* {
    if (event == Viscosity_WAXEvent.searchViscosity_WAXForInput) {
      yield* searchViscosity_WAXForInput();
    } else if (event == Viscosity_WAXEvent.saveViscosity_WAXData) {
      yield* saveViscosity_WAXData();
    } else if (event == Viscosity_WAXEvent.tempSaveViscosity_WAXData) {
      yield* tempSaveViscosity_WAXData();
    } else if (event == Viscosity_WAXEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelViscosity_WAX> dataViscosity_WAXInput = [];

Stream<int> searchViscosity_WAXForInput() async* {
  print("in searchViscosity_WAXForInput");
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
        .post(Uri.parse("$url/Instrument_searchViscosity_WAXForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataViscosity_WAXInput = modelViscosity_WAXFromJson(response.body);
        for (int i = 0; i < dataViscosity_WAXInput.length; i++) {
          if (dataViscosity_WAXInput[i].tempareture_1 == "") {
            dataViscosity_WAXInput[i].tempareture_1 =
                dataViscosity_WAXInput[i].temp;
          }
          if (dataViscosity_WAXInput[i].tempareture_2 == "") {
            dataViscosity_WAXInput[i].tempareture_2 =
                dataViscosity_WAXInput[i].temp;
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

List<ModelViscosity_WAX> dataTempViscosity_WAXsave = [];
Stream<int> tempSaveViscosity_WAXData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveViscosity_WAXData");
  Map<String, String> qParams = {
    'data': modelViscosity_WAXToJson(dataTempViscosity_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataViscosity_WAX"),
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

List<ModelViscosity_WAX> dataViscosity_WAXsave = [];
Stream<int> saveViscosity_WAXData() async* {
  print("in save Viscosity_WAX");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelViscosity_WAXToJson(dataViscosity_WAXsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataViscosity_WAX"), body: qParams)
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
