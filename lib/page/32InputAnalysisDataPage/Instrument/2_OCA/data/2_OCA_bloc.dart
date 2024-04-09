import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/2_OCA/data/2_OCAStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/2_OCA/data/2_OCA_event.dart';

//----------------------------------------------------------------

class ManageDataOCA extends Bloc<OCAEvent, int> {
  ManageDataOCA() : super(0);

  @override
  Stream<int> mapEventToState(OCAEvent event) async* {
    if (event == OCAEvent.searchOCAForInput) {
      yield* searchOCAForInput();
    } else if (event == OCAEvent.saveOCAData) {
      yield* saveOCAData();
    } else if (event == OCAEvent.tempSaveOCAData) {
      yield* tempSaveOCAData();
    } else if (event == OCAEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelOCA> dataOCAInput = [];

Stream<int> searchOCAForInput() async* {
  print("in searchOCAForInput");
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
        .post(Uri.parse("$url/Instrument_searchOCAForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataOCAInput = modelOCAFromJson(response.body);
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

List<ModelOCA> dataTempOCAsave = [];
Stream<int> tempSaveOCAData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveOCAData");
  Map<String, String> qParams = {
    'data': modelOCAToJson(dataTempOCAsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataOCA"), body: qParams)
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

List<ModelOCA> dataOCAsave = [];
Stream<int> saveOCAData() async* {
  print("in save OCA");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelOCAToJson(dataOCAsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataOCA"), body: qParams)
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
