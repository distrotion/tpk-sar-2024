import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/50_XRD_020Ratio/data/50_XRD_020RatioStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/50_XRD_020Ratio/data/50_XRD_020Ratio_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataXRD_020Ratio
    extends Bloc<XRD_020RatioEvent, int> {
  ManageDataXRD_020Ratio() : super(0);

  @override
  Stream<int> mapEventToState(XRD_020RatioEvent event) async* {
    if (event == XRD_020RatioEvent.searchXRD_020RatioForInput) {
      yield* searchXRD_020RatioForInput();
    } else if (event ==
        XRD_020RatioEvent.saveXRD_020RatioData) {
      yield* saveXRD_020RatioData();
    } else if (event ==
        XRD_020RatioEvent.tempSaveXRD_020RatioData) {
      yield* tempSaveXRD_020RatioData();
    } else if (event == XRD_020RatioEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelXRD_020Ratio> dataXRD_020RatioInput = [];

Stream<int> searchXRD_020RatioForInput() async* {
  print("in searchXRD_020RatioForInput");
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
        .post(Uri.parse("$url/Instrument_searchXRD_020RatioForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataXRD_020RatioInput =
            modelXRD_020RatioFromJson(response.body);
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

List<ModelXRD_020Ratio> dataTempXRD_020Ratiosave = [];
Stream<int> tempSaveXRD_020RatioData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveXRD_020RatioData");
  Map<String, String> qParams = {
    'data': modelXRD_020RatioToJson(dataTempXRD_020Ratiosave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataXRD_020Ratio"),
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

List<ModelXRD_020Ratio> dataXRD_020Ratiosave = [];
Stream<int> saveXRD_020RatioData() async* {
  print("in save XRD_020Ratio");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelXRD_020RatioToJson(dataXRD_020Ratiosave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataXRD_020Ratio"),
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
