import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/InputAnalysisDataPage.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/14_Cwt3Layer/data/14_Cwt3LayerStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/14_Cwt3Layer/data/14_Cwt3Layer_Event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataCwt3layers extends Bloc<Cwt3layersEvent, int> {
  ManageDataCwt3layers() : super(0);

  @override
  Stream<int> mapEventToState(Cwt3layersEvent event) async* {
    if (event == Cwt3layersEvent.searchCwt3layersForInput) {
      yield* searchCwt3layersForInput();
    } else if (event == Cwt3layersEvent.saveCwt3layersData) {
      yield* saveCwt3layersData();
    } else if (event == Cwt3layersEvent.tempSaveCwt3layersData) {
      yield* tempSaveCwt3layersData();
    } else if (event == Cwt3layersEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelCwt3layers> dataCwt3layersInput = [];

Stream<int> searchCwt3layersForInput() async* {
  print("in searchCwt3layersForInput");
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
        .post(Uri.parse("$url/Instrument_searchCwt3layersForInput"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataCwt3layersInput = modelCwt3layersFromJson(response.body);
        if (dataCwt3layersInput.length > 0) {
          int length = dataCwt3layersInput.length;
          for (int i = 0; i < length; i++) {
            dataCwt3layersInput[i].stdMax_Non = dataCwt3layersInput[i].stdMax;
            dataCwt3layersInput[i].stdMin_Non = dataCwt3layersInput[i].stdMin;
            dataCwt3layersInput[i].stdMax_Met =
                dataCwt3layersInput[i + 1].stdMax;
            dataCwt3layersInput[i].stdMin_Met =
                dataCwt3layersInput[i + 1].stdMin;
            dataCwt3layersInput.removeAt(i + 1);
            dataCwt3layersInput[i].stdMax_Zn =
                dataCwt3layersInput[i + 1].stdMax;
            dataCwt3layersInput[i].stdMin_Zn =
                dataCwt3layersInput[i + 1].stdMin;
            dataCwt3layersInput.removeAt(i + 1);
            length = length - 2;
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

List<ModelCwt3layers> dataTempCwt3layerssave = [];
Stream<int> tempSaveCwt3layersData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveCwt3layersData");
  Map<String, String> qParams = {
    'data': modelCwt3layersToJson(dataTempCwt3layerssave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataCwt3layers"),
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

List<ModelCwt3layers> dataCwt3layerssave = [];
Stream<int> saveCwt3layersData() async* {
  print("in save Cwt3layers");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelCwt3layersToJson(dataCwt3layerssave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataCwt3layers"), body: qParams)
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
