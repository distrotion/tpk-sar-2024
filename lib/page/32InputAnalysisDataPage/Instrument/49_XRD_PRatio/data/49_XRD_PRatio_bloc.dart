import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/49_XRD_PRatio/data/49_XRD_PRatioStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/49_XRD_PRatio/data/49_XRD_PRatio_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataXRD_PRatio
    extends Bloc<XRD_PRatioEvent, int> {
  ManageDataXRD_PRatio() : super(0);

  @override
  Stream<int> mapEventToState(XRD_PRatioEvent event) async* {
    if (event == XRD_PRatioEvent.searchXRD_PRatioForInput) {
      yield* searchXRD_PRatioForInput();
    } else if (event ==
        XRD_PRatioEvent.saveXRD_PRatioData) {
      yield* saveXRD_PRatioData();
    } else if (event ==
        XRD_PRatioEvent.tempSaveXRD_PRatioData) {
      yield* tempSaveXRD_PRatioData();
    } else if (event == XRD_PRatioEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelXRD_PRatio> dataXRD_PRatioInput = [];

Stream<int> searchXRD_PRatioForInput() async* {
  print("in searchXRD_PRatioForInput");
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
        .post(Uri.parse("$url/Instrument_searchXRD_PRatioForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataXRD_PRatioInput =
            modelXRD_PRatioFromJson(response.body);
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

List<ModelXRD_PRatio> dataTempXRD_PRatiosave = [];
Stream<int> tempSaveXRD_PRatioData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveXRD_PRatioData");
  Map<String, String> qParams = {
    'data': modelXRD_PRatioToJson(dataTempXRD_PRatiosave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataXRD_PRatio"),
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

List<ModelXRD_PRatio> dataXRD_PRatiosave = [];
Stream<int> saveXRD_PRatioData() async* {
  print("in save XRD_PRatio");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelXRD_PRatioToJson(dataXRD_PRatiosave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataXRD_PRatio"),
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
