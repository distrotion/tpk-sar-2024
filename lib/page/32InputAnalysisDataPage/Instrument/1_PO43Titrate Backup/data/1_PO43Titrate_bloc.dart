import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import '1_PO43TitrateStructure.dart';
import '1_PO43Titrate_event.dart';

//----------------------------------------------------------------

class ManageDataPO43Titrate extends Bloc<PO43TitrateEvent, int> {
  ManageDataPO43Titrate() : super(0);

  @override
  Stream<int> mapEventToState(PO43TitrateEvent event) async* {
    if (event == PO43TitrateEvent.searcPO43hOldData) {
      yield* searcPO43hOldData();
    } else if (event == PO43TitrateEvent.savePO43Data) {
      yield* savePO43Data();
    }
  }
}

List<ModelPo43Titrate> dataPO43 = [];

Stream<int> searcPO43hOldData() async* {
  print("in searcPO43hOldData");
  Map<String, String> qParams = {
    'itemId': "item_itemData[0].id.toString()",
  };
  final response = await http
      .get(Uri.parse("$url/Instrument_searchPO43OldData"), headers: qParams);
  if (response.statusCode == 200) {
    //print(response.body);
    dataPO43 = modelPo43TitrateFromJson(response.body);
    //print("dataPO43  $dataPO43");
    String itemStatus = "item_itemData[0].itemStatus"; 
    if (itemStatus == "LIST NORMAL" || itemStatus == "FINISH NORMAL") {
      if (dataPO43.isEmpty) {
        //length ==0
        print("isempty");
        initialAddPO43("NORMAL");
      }
    } else if (itemStatus == "LIST RECHECK" || itemStatus == "FINISH RECHECK") {
      if (dataPO43.length != 2) {
        initialAddPO43("RECHECK");
      }
    } else if (itemStatus == "LIST RECONFIRM" ||
        itemStatus == "FINISH RECONFIRM") {
      if (dataPO43.length != 3) {
        if (dataPO43[dataPO43.length - 1].itemStatus != "RECONFIRM") {
          initialAddPO43("RECONFIRM");
        }
      }
    } else {
      if (dataPO43.isEmpty) {
        //length ==0
        initialAddPO43("NORMAL");
      }
    }
    List<ModelPo43Titrate> buff = [];
    buff = dataPO43;
    //print("buff${buff.length}");
    dataPO43 = buff.reversed.toList();
    if ("item_itemData[0].userListAnalysis" == userName) {
      if (itemStatus == "LIST NORMAL" ||
          itemStatus == "FINISH NORMAL" ||
          itemStatus == "LIST RECHECK" ||
          itemStatus == "FINISH RECHECK" ||
          itemStatus == "LIST RECONFIRM" ||
          itemStatus == "FINISH RECONFIRM") dataPO43[0].canEdit = true;
    }

    yield 1;
  } else {
    yield 0;
  }
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

Stream<int> savePO43Data() async* {
  print("in save PO43");
  List<ModelPo43Titrate> dataPO43save = [];
  dataPO43save.add(dataPO43[0]);
  //print(modelPo43TitrateToJson(dataPO43save));
  Map<String, String> qParams = {
    'data': modelPo43TitrateToJson(dataPO43save),
  };
  final response =
      await http.post(Uri.parse("$url/Instrument_saveDataPO43"), body: qParams);
  if (response.statusCode == 200) {
    //print("Respone: ${response.body}");
    CoolAlert.show(
      width: 150,
      context: contextBG,
      type: CoolAlertType.success,
      //title: 'Oops...',
      text: 'SAVE RESULT COMPLETE',
      loopAnimation: false,
    );
    yield 1;
  } else {
    //throw Exception('Failed to load posts');
  }
  yield 1;
}
