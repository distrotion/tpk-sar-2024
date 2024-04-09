// ignore_for_file: unnecessary_statements

import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/InputAnalysisDataPage.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPageStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_Event.dart';

//----------------------------------------------------------------

class ManageDataInputAnalysisDataPage
    extends Bloc<InputAnalysisDataPageEvent, int> {
  ManageDataInputAnalysisDataPage() : super(0);

  @override
  Stream<int> mapEventToState(InputAnalysisDataPageEvent event) async* {
    if (event == InputAnalysisDataPageEvent.searchInstrumentListData) {
      yield* searchItemDetailData();
    }
    if (event == InputAnalysisDataPageEvent.reloadData) {
      yield* reloadData();
    }
    if (event == InputAnalysisDataPageEvent.updateOffline) {
      yield* updateOffline();
    }
  }
}

List<ModelFullRequestData> mainDataInput = [];
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//SearchAnalysisModel searchOption = SearchAnalysisModel();

Stream<int> searchItemDetailData() async* {
  final SharedPreferences prefs = await _prefs;
  //alertLoading();
  String instrumentName =
      prefs.getString('InputAnalysisDataPage_InstrumentName') ?? "";
  Map<String, String> qParams = {
    'UserName': userName,
    'InstrumentName': instrumentName,
    'SearchOption': jsonEncode(searchOption),
  };
  print("in SearchInstrumentListData");
  try {
    final response = await http
        .post(Uri.parse("$url/InputAnalysisDataPage_SearchInstrumentListData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      mainDataInput = modelFullRequestDataFromJson(response.body);
      if (mainDataInput.length > 0) {
        if (mainDataInput[0].instrumentName == 'Cwt.3 layers') {
          int length = mainDataInput.length;
          for (int i = 0; i < length; i++) {
            mainDataInput.removeAt(i + 1);
            mainDataInput.removeAt(i + 1);
            length = length - 2;
          }
        }
        yield 1;
      } else {
        alertError("Data Not Found");
        yield 0;
      }
    } else {
      alertNetworkError();
      yield 0;
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    alertNetworkError();
  }
}

Stream<int> reloadData() async* {
  yield 0;
  contextAnalysisDataPage
      .read<ManageDataInputAnalysisDataPage>()
      .add(InputAnalysisDataPageEvent.searchInstrumentListData);
}

Stream<int> updateOffline() async* {
  yield 0;
  print('yield 0');
  await Future.delayed(Duration(milliseconds: 10));
  //mainDataInput[0].itemStatus = 'FINISH RECHECK';
  print('yield 1');
  yield 1;
}
