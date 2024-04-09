import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/51_Filter/data/51_FilterStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/51_Filter/data/51_Filter_event.dart';
//----------------------------------------------------------------

class ManageDataFilter extends Bloc<FilterEvent, int> {
  ManageDataFilter() : super(0);

  @override
  Stream<int> mapEventToState(FilterEvent event) async* {
    if (event == FilterEvent.searchFilterForInput) {
      yield* searchFilterForInput();
    } else if (event == FilterEvent.saveFilterData) {
      yield* saveFilterData();
    } else if (event == FilterEvent.tempSaveFilterData) {
      yield* tempSaveFilterData();
    } else if (event == FilterEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelFilter> dataFilterInput = [];

Stream<int> searchFilterForInput() async* {
  print("in searchFilterForInput");
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
        .post(Uri.parse("$url/Instrument_searchFilterForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      //print(response.body);
      if (response.body != "error") {
        dataFilterInput = modelFilterFromJson(response.body);
        for (int i = 0; i < dataFilterInput.length; i++) {
          if (dataFilterInput[i].magnification_1 == "") {
            dataFilterInput[i].magnification_1 = dataFilterInput[i].mag;
          }
          if (dataFilterInput[i].position_1 == "") {
            dataFilterInput[i].position_1 = dataFilterInput[i].position;
          }
          if (dataFilterInput[i].magnification_2 == "") {
            dataFilterInput[i].magnification_2 = dataFilterInput[i].mag;
          }
          if (dataFilterInput[i].position_2 == "") {
            dataFilterInput[i].position_2 = dataFilterInput[i].position;
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

List<ModelFilter> dataTempFiltersave = [];
Stream<int> tempSaveFilterData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveFilterData");
  Map<String, String> qParams = {
    'data': modelFilterToJson(dataTempFiltersave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataFilter"), body: qParams)
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

List<ModelFilter> dataFiltersave = [];
Stream<int> saveFilterData() async* {
  print("in save Filter");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelFilterToJson(dataFiltersave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataFilter"), body: qParams)
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

