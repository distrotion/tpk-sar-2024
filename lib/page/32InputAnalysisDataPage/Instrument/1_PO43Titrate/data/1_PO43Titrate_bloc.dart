import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/InputAnalysisDataPage.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import '1_PO43TitrateStructure.dart';
import '1_PO43Titrate_event.dart';

//----------------------------------------------------------------

class ManageDataPO43Titrate extends Bloc<PO43TitrateEvent, int> {
  ManageDataPO43Titrate() : super(0);

  @override
  Stream<int> mapEventToState(PO43TitrateEvent event) async* {
    if (event == PO43TitrateEvent.searchPO43ForInput) {
      yield* searchPO43ForInput();
    } else if (event == PO43TitrateEvent.savePO43Data) {
      yield* savePO43Data();
    } else if (event == PO43TitrateEvent.tempSavePO43Data) {
      yield* tempSavePO43Data();
    } else if (event == PO43TitrateEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelPo43Titrate> dataPO43Input = [];
List<ModelPo43Titrate> dataPO43 = [];

Stream<int> searchPO43ForInput() async* {
  print("in searchPO43ForInput");
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
        .post(Uri.parse("$url/Instrument_searchPO43ForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      if (response.body != "error") {
        dataPO43Input = modelPo43TitrateFromJson(response.body);
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

void initialAddPO43(String status) {
  dataPO43.add(ModelPo43Titrate(
    /* requestSampleId: item_itemData[0].id,
    reqNo: item_itemData[0].reqNo,
    jobType: item_itemData[0].jobType,
    incharge: item_itemData[0].incharge,
    branch: item_itemData[0].branch,
    requestSection: item_itemData[0].requestSection,
    reqDate: item_itemData[0].reqDate,
    custFull: item_itemData[0].custFull,
    sampleCode: item_itemData[0].sampleCode,
    sampleGroup: item_itemData[0].sampleGroup,
    sampleType: item_itemData[0].sampleType,
    sampleTank: item_itemData[0].sampleTank,
    sampleName: item_itemData[0].sampleName,
    samplingDate: item_itemData[0].samplingDate,
    analysisDueDate: item_itemData[0].analysisDueDate,
    sampleRemark: item_itemData[0].sampleRemark,
    sampleAttachFile: item_itemData[0].sampleAttachFile,
    position: item_itemData[0].position,
    mag: item_itemData[0].mag,
    temp: item_itemData[0].temp,
    stdFactor: item_itemData[0].stdFactor,
    stdMax: item_itemData[0].stdMax,
    stdMin: item_itemData[0].stdMin,
    itemNo: item_itemData[0].itemNo,
    itemName: item_itemData[0].itemName,
    remarkNo: item_itemData[0].remarkNo, */
    itemStatus: status,
    userAnalysis: userName,
    userAnalysisBranch: userBranch,
    analysisDate: "",
    titrantFactor_1: "",
    endPt1_1: "",
    endPt2_1: "",
    resultSymbol_1: "",
    result_1: "",
    resultUnit_1: "",
    resultRemark_1: "",
    titrantFactor_2: "",
    endPt1_2: "",
    endPt2_2: "",
    resultSymbol_2: "",
    result_2: "",
    resultUnit_2: "",
    resultRemark_2: "",
    canEdit: false,
  ));
}

List<ModelPo43Titrate> dataTempPO43save = [];
Stream<int> tempSavePO43Data() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSavePO43Data");
  Map<String, String> qParams = {
    'data': modelPo43TitrateToJson(dataTempPO43save),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataPO43"), body: qParams)
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

List<ModelPo43Titrate> dataPO43save = [];
Stream<int> savePO43Data() async* {
  print("in save PO43");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelPo43TitrateToJson(dataPO43save),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataPO43"), body: qParams)
        .timeout(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        alertSuccess("SAVE RESULT COMPLETE");
        /* contextAnalysisDataPage
            .read<ManageDataInputAnalysisDataPage>()
            .add(InputAnalysisDataPageEvent.reloadData); */
        contextAnalysisDataPage
            .read<ManageDataInputAnalysisDataPage>()
            .add(InputAnalysisDataPageEvent.updateOffline);
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
