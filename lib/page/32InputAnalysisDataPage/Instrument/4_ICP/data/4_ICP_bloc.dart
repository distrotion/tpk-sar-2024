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
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/4_ICP/data/4_ICPStructure.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/4_ICP/data/4_ICP_event.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
//----------------------------------------------------------------

class ManageDataICP extends Bloc<ICPEvent, int> {
  ManageDataICP() : super(0);

  @override
  Stream<int> mapEventToState(ICPEvent event) async* {
    if (event == ICPEvent.searchICPForInput) {
      yield* searchICPForInput();
    } else if (event == ICPEvent.saveICPData) {
      yield* saveICPData();
    } else if (event == ICPEvent.tempSaveICPData) {
      yield* tempSaveICPData();
    } else if (event == ICPEvent.dummyHead) {
      yield* dummyHead();
    }
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<ModelICP> dataICPInput = [];

Stream<int> searchICPForInput() async* {
  print("in searchICPForInput");
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
        .post(Uri.parse("$url/Instrument_searchICPForInput"), body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.body);
      if (response.body != "error") {
        dataICPInput = modelICPFromJson(response.body);
        for (int i = 0; i < dataICPInput.length; i++) {
          if (dataICPInput[i].tW_1.toString() == "") {
            if (dataICPInput[i].sampleName == "AB-300R" &&
                (dataICPInput[i].itemName == "Zr" ||
                    dataICPInput[i].itemName == "V")) {
              dataICPInput[i].tW_1 = "1";
              dataICPInput[i].volume_1 = "100";
            } else if (dataICPInput[i].sampleName == "AB-300R" &&
                (dataICPInput[i].itemName == "Ti")) {
              dataICPInput[i].tW_1 = "0.5";
              dataICPInput[i].volume_1 = "100";
            } else if (dataICPInput[i].sampleName == "AB-300M" &&
                (dataICPInput[i].itemName == "Al")) {
              dataICPInput[i].tW_1 = "1";
              dataICPInput[i].volume_1 = "100";
            } else if (dataICPInput[i].sampleName == "AB-300M" &&
                (dataICPInput[i].itemName == "V" ||
                    dataICPInput[i].itemName == "Zr" ||
                    dataICPInput[i].itemName == "Ti")) {
              dataICPInput[i].tW_1 = "10";
              dataICPInput[i].volume_1 = "100";
            } else if (dataICPInput[i].sampleName == "AB-200M" &&
                (dataICPInput[i].itemName == "Al")) {
              dataICPInput[i].tW_1 = "1";
              dataICPInput[i].volume_1 = "100";
            }

            if (dataICPInput[i].dilutionTime_1 == "") {
              dataICPInput[i].dilutionTime_1 = dataICPInput[i].mag;
            }
            if (dataICPInput[i].dilutionTime_2 == "") {
              dataICPInput[i].dilutionTime_2 = dataICPInput[i].mag;
            }
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

/* void initialAddICP(String status) {
  dataICP.add(ModelICP(
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
/*     titrantFactor_1: "",
    endPt1_1: "",
    endPt2_1: "",
    resultSymbol_1: "",
    result_1: "",
    resultUnit_1: "",
    resultRemark_1: "",
    titrantFactor_2: "",
    endPt1_2: "",
    endPt2_2: "", */
    resultSymbol_2: "",
    result_2: "",
    resultUnit_2: "",
    resultRemark_2: "",
    canEdit: false,
  ));
} */

List<ModelICP> dataTempICPsave = [];
Stream<int> tempSaveICPData() async* {
  EasyLoading.show(status: 'loading...');
  print("in tempSaveICPData");
  Map<String, String> qParams = {
    'data': modelICPToJson(dataTempICPsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_tempSaveDataICP"), body: qParams)
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

List<ModelICP> dataICPsave = [];
Stream<int> saveICPData() async* {
  print("in save ICP");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'data': modelICPToJson(dataICPsave),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/Instrument_saveDataICP"), body: qParams)
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
