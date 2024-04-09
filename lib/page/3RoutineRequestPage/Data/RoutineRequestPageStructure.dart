import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:tpk_login_arsa_01/Global/global_var.dart';

List<ModelRountineDataSQL> routineDataSQLFromJson(String str) =>
    List<ModelRountineDataSQL>.from(
        json.decode(str).map((x) => ModelRountineDataSQL.fromJson(x)));
String routineDataSQLToJson(List<ModelRountineDataSQL> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelRountineDataSQL {
  ModelRountineDataSQL({
    this.reqNo,
    this.jobType,
    this.branch,
    this.requestSection,
    this.reqDate,
    this.reqUser,
    this.custId,
    this.custFull,
    this.custShort,
    this.code,
    this.requestRound,
    this.incharge,
    this.requestRemark,
    this.requestAttachFile,
    this.requestStatus,
    this.samplingDate,
    this.sampleNo,
    this.sampleStatus,
    this.groupNameTs,
    this.sampleGroup,
    this.sampleType,
    this.sampleTank,
    this.sampleName,
    this.subLeader,
    this.gl,
    this.jp,
    this.dmg,
  });
  dynamic reqNo;
  dynamic jobType;
  dynamic branch;
  dynamic requestSection;
  dynamic reqDate;
  dynamic reqUser;
  dynamic custId;
  dynamic custFull;
  dynamic custShort;
  dynamic code;
  dynamic requestRound;
  dynamic incharge;
  dynamic requestRemark;
  dynamic requestAttachFile;
  dynamic requestStatus;
  dynamic samplingDate;
  dynamic sampleNo;
  dynamic sampleStatus;
  dynamic groupNameTs;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic subLeader;
  dynamic gl;
  dynamic jp;
  dynamic dmg;
  factory ModelRountineDataSQL.fromJson(Map<String, dynamic> json) =>
      ModelRountineDataSQL(
        reqNo: json["ReqNo"] ?? "",
        jobType: json["JobType"] ?? "",
        branch: json["Branch"] ?? "",
        requestSection: json["RequestSection"] ?? "",
        reqDate: json["ReqDate"] ?? "",
        reqUser: json["ReqUser"] ?? "",
        custId: json["CustId"] ?? "",
        custFull: json["CustFull"] ?? "",
        custShort: json["CustShort"] ?? "",
        code: json["Code"] ?? "",
        requestRound: json["RequestRound"] ?? "",
        incharge: json["Incharge"] ?? "",
        requestRemark: json["RequestRemark"] ?? "",
        requestAttachFile: json["RequestAttachFile"] ?? "",
        requestStatus: json["RequestStatus"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        sampleNo: json["SampleNo"] ?? "",
        sampleStatus: json["SampleStatus"] ?? "",
        groupNameTs: json["GroupNameTS"] ?? "",
        sampleGroup: json["SampleGroup"] ?? "",
        sampleType: json["SampleType"] ?? "",
        sampleTank: json["SampleTank"] ?? "",
        sampleName: json["SampleName"] ?? "",
        subLeader: json["SubLeader"] ?? "",
        gl: json["GL"] ?? "",
        jp: json["JP"] ?? "",
        dmg: json["DMG"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ReqNo": reqNo ?? "",
        "JobType": jobType ?? "",
        "Branch": branch ?? "",
        "RequestSection": requestSection ?? "",
        "ReqDate": reqDate ?? "",
        "ReqUser": reqUser ?? "",
        "CustId": custId ?? "",
        "CustFull": custFull ?? "",
        "CustShort": custShort ?? "",
        "Code": code ?? "",
        "RequestRound": requestRound ?? "",
        "Incharge": incharge ?? "",
        "RequestRemark": requestRemark ?? "",
        "RequestAttachFile": requestAttachFile ?? "",
        "RequestStatus": requestStatus ?? "",
        "SamplingDate": samplingDate ?? "",
        "SampleNo": sampleNo ?? "",
        "SampleStatus": sampleStatus ?? "",
        "GroupNameTS": groupNameTs ?? "",
        "SampleGroup": sampleGroup ?? "",
        "SampleType": sampleType ?? "",
        "SampleTank": sampleTank ?? "",
        "SampleName": sampleName ?? "",
        "SubLeader": subLeader ?? "",
        "GL": gl ?? "",
        "JP": jp ?? "",
        "DMG": dmg ?? "",
      };
}

List<ModelSampleDataSQL> sampleDataSQLFromJson(String str) =>
    List<ModelSampleDataSQL>.from(
        json.decode(str).map((x) => ModelSampleDataSQL.fromJson(x)));
String sampleDataSQLToJson(List<ModelSampleDataSQL> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSampleDataSQL {
  ModelSampleDataSQL({
    this.id,
    this.reqNo,
    this.jobType,
    this.branch,
    this.requestSection,
    this.reqDate,
    this.reqUser,
    this.custId,
    this.custFull,
    this.custShort,
    this.code,
    this.incharge,
    this.requestRound,
    this.requestRemark,
    this.requestAttachFile,
    this.requestStatus,
    this.sampleNo,
    this.sampleCode,
    this.sampleStatus,
    this.groupNameTs,
    this.sampleGroup,
    this.sampleType,
    this.sampleTank,
    this.sampleName,
    this.sampleAmount,
    this.samplingDate,
    this.sampleRemark,
    this.sampleAttachFile,
    this.itemNo,
    this.instrumentName,
    this.itemName,
    this.itemStatus,
    this.userSend,
    this.sendDate,
    this.remarkSend,
    this.userReject,
    this.rejectDate,
    this.remarkReject,
    this.userCancel,
    this.cancelDate,
    this.cancelRemark,
    this.userReceive,
    this.receiveDate,
    this.analysisDueDate,
    this.position,
    this.mag,
    this.temp,
    this.stdFactor,
    this.stdMax,
    this.stdMin,
    this.userListAnalysis,
    this.listDate,
    this.remarkNo,
    this.resultSymbol1,
    this.result1,
    this.resultUnit1,
    this.resultRemark1,
    this.resultFile1,
    this.userAnalysis1,
    this.analysisDate1,
    this.resultSymbol2,
    this.result2,
    this.resultUnit2,
    this.resultRemark2,
    this.resultFile2,
    this.userAnalysis2,
    this.analysisDate2,
    this.resultSymbol3,
    this.result3,
    this.resultUnit3,
    this.resultRemark3,
    this.resultFile3,
    this.userAnalysis3,
    this.analysisDate3,
    this.resultSymbol4,
    this.result4,
    this.resultUnit4,
    this.resultRemark4,
    this.resultFile4,
    this.userAnalysis4,
    this.analysisDate4,
    this.resultSymbol5,
    this.result5,
    this.resultUnit5,
    this.resultRemark5,
    this.resultFile5,
    this.userAnalysis5,
    this.analysisDate5,
    this.resultSymbol6,
    this.result6,
    this.resultUnit6,
    this.resultRemark6,
    this.resultFile6,
    this.userAnalysis6,
    this.analysisDate6,
    this.userRequestRecheck,
    this.requestRecheckRemark,
    this.requestRecheckDate,
    this.userApprove,
    this.requestReconfirmRemark,
    this.requestReconfirmDate,
    this.resultApproveSymbol,
    this.resultApprove,
    this.resultApproveUnit,
    this.resultApproveRemark,
    this.resultApproveFile,
    this.resultAproveDate,
    this.finishCompleteDate,
  });
  dynamic id;
  dynamic reqNo = "0";
  dynamic jobType;
  dynamic branch;
  dynamic requestSection;
  dynamic reqDate;
  dynamic reqUser;
  dynamic custId;
  dynamic custFull;
  dynamic custShort;
  dynamic code;
  dynamic incharge;
  dynamic requestRound;
  dynamic requestRemark;
  dynamic requestAttachFile;
  dynamic requestStatus;
  dynamic sampleNo;
  dynamic sampleCode;
  dynamic sampleStatus;
  dynamic groupNameTs;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic sampleAmount;
  dynamic samplingDate;
  dynamic sampleRemark;
  dynamic sampleAttachFile;
  dynamic itemNo;
  dynamic instrumentName;
  dynamic itemName;
  dynamic itemStatus;
  dynamic userSend;
  dynamic sendDate;
  dynamic remarkSend;
  dynamic userReject;
  dynamic rejectDate;
  dynamic remarkReject;
  dynamic userCancel;
  dynamic cancelDate;
  dynamic cancelRemark;
  dynamic userReceive;
  dynamic receiveDate;
  dynamic analysisDueDate;
  dynamic position;
  dynamic mag;
  dynamic temp;
  dynamic stdFactor;
  dynamic stdMax;
  dynamic stdMin;
  dynamic userListAnalysis;
  dynamic listDate;
  dynamic remarkNo;
  dynamic resultSymbol1;
  dynamic result1;
  dynamic resultUnit1;
  dynamic resultRemark1;
  dynamic resultFile1;
  dynamic userAnalysis1;
  dynamic analysisDate1;
  dynamic resultSymbol2;
  dynamic result2;
  dynamic resultUnit2;
  dynamic resultRemark2;
  dynamic resultFile2;
  dynamic userAnalysis2;
  dynamic analysisDate2;
  dynamic resultSymbol3;
  dynamic result3;
  dynamic resultUnit3;
  dynamic resultRemark3;
  dynamic resultFile3;
  dynamic userAnalysis3;
  dynamic analysisDate3;
  dynamic resultSymbol4;
  dynamic result4;
  dynamic resultUnit4;
  dynamic resultRemark4;
  dynamic resultFile4;
  dynamic userAnalysis4;
  dynamic analysisDate4;
  dynamic resultSymbol5;
  dynamic result5;
  dynamic resultUnit5;
  dynamic resultRemark5;
  dynamic resultFile5;
  dynamic userAnalysis5;
  dynamic analysisDate5;
  dynamic resultSymbol6;
  dynamic result6;
  dynamic resultUnit6;
  dynamic resultRemark6;
  dynamic resultFile6;
  dynamic userAnalysis6;
  dynamic analysisDate6;
  dynamic userRequestRecheck;
  dynamic requestRecheckRemark;
  dynamic requestRecheckDate;
  dynamic requestReconfirmRemark;
  dynamic requestReconfirmDate;
  dynamic userApprove;
  dynamic resultApproveSymbol;
  dynamic resultApprove;
  dynamic resultApproveUnit;
  dynamic resultApproveRemark;
  dynamic resultApproveFile;
  dynamic resultAproveDate;
  dynamic finishCompleteDate;
  dynamic selected;

  factory ModelSampleDataSQL.fromJson(Map<String, dynamic> json) =>
      ModelSampleDataSQL(
        id: json["ID"] ?? "",
        reqNo: json["ReqNo"] ?? "",
        jobType: json["JobType"] ?? "",
        branch: json["Branch"] ?? "",
        requestSection: json["RequestSection"] ?? "",
        reqDate: json["ReqDate"] ?? "",
        reqUser: json["ReqUser"] ?? "",
        custId: json["CustId"] ?? "",
        custFull: json["CustFull"] ?? "",
        custShort: json["CustShort"] ?? "",
        code: json["Code"] ?? "",
        incharge: json["Incharge"] ?? "",
        requestRound: json["RequestRound"] ?? "",
        requestRemark: json["RequestRemark"] ?? "",
        requestAttachFile: json["RequestAttachFile"] ?? "",
        requestStatus: json["RequestStatus"] ?? "",
        sampleNo: json["SampleNo"] ?? "",
        sampleCode: json["SampleCode"] ?? "",
        sampleStatus: json["SampleStatus"] ?? "",
        groupNameTs: json["GroupNameTS"] ?? "",
        sampleGroup: json["SampleGroup"] ?? "",
        sampleType: json["SampleType"] ?? "",
        sampleTank: json["SampleTank"] ?? "",
        sampleName: json["SampleName"] ?? "",
        sampleAmount: json["SampleAmount"] ?? "",
        samplingDate: json["SamplingDate"] == null
            ? null
            : DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(json["SamplingDate"])),
        sampleRemark: json["SampleRemark"] ?? "",
        sampleAttachFile: json["SampleAttachFile"] ?? "",
        itemNo: json["ItemNo"] ?? "",
        instrumentName: json["InstrumentName"] ?? "",
        itemName: json["ItemName"] ?? "",
        itemStatus: json["ItemStatus"] ?? "",
        userSend: json["UserSend"] ?? "",
        sendDate: json["SendDate"] ?? "",
        remarkSend: json["RemarkSend"] ?? "",
        userReject: json["UserReject"] ?? "",
        rejectDate: json["RejectDate"] ?? "",
        remarkReject: json["RemarkReject"] ?? "",
        userCancel: json["UserCancel"] ?? "",
        cancelDate: json["CancelDate"] ?? "",
        cancelRemark: json["CancelRemark"] ?? "",
        userReceive: json["UserReceive"] ?? "",
        receiveDate: json["ReceiveDate"] ?? "",
        analysisDueDate: json["AnalysisDueDate"] == null
            ? null
            : DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(json["AnalysisDueDate"])),
        position: json["Position"] ?? "",
        mag: json["Mag"] ?? "",
        temp: json["Temp"] ?? "",
        stdFactor: json["StdFactor"] ?? "",
        stdMax: json["StdMax"] ?? "",
        stdMin: json["StdMin"] ?? "",
        userListAnalysis: json["UserListAnalysis"] ?? "",
        listDate: json["ListDate"] ?? "",
        remarkNo: json["RemarkNo"] ?? "",
        resultSymbol1: json["ResultSymbol1"] ?? "",
        result1: json["Result1"] ?? "",
        resultUnit1: json["ResultUnit1"] ?? "",
        resultRemark1: json["ResultRemark1"] ?? "",
        resultFile1: json["ResultFile1"] ?? "",
        userAnalysis1: json["UserAnalysis1"] ?? "",
        analysisDate1: json["AnalysisDate1"] ?? "",
        resultSymbol2: json["ResultSymbol2"] ?? "",
        result2: json["Result2"] ?? "",
        resultUnit2: json["ResultUnit2"] ?? "",
        resultRemark2: json["ResultRemark2"] ?? "",
        resultFile2: json["ResultFile2"] ?? "",
        userAnalysis2: json["UserAnalysis2"] ?? "",
        analysisDate2: json["AnalysisDate2"] ?? "",
        resultSymbol3: json["ResultSymbol3"] ?? "",
        result3: json["Result3"] ?? "",
        resultUnit3: json["ResultUnit3"] ?? "",
        resultRemark3: json["ResultRemark3"] ?? "",
        resultFile3: json["ResultFile3"] ?? "",
        userAnalysis3: json["UserAnalysis3"] ?? "",
        analysisDate3: json["AnalysisDate3"] ?? "",
        resultSymbol4: json["ResultSymbol4"] ?? "",
        result4: json["Result4"] ?? "",
        resultUnit4: json["ResultUnit4"] ?? "",
        resultRemark4: json["ResultRemark4"] ?? "",
        resultFile4: json["ResultFile4"] ?? "",
        userAnalysis4: json["UserAnalysis4"] ?? "",
        analysisDate4: json["AnalysisDate4"] ?? "",
        resultSymbol5: json["ResultSymbol5"] ?? "",
        result5: json["Result5"] ?? "",
        resultUnit5: json["ResultUnit5"] ?? "",
        resultRemark5: json["ResultRemark5"] ?? "",
        resultFile5: json["ResultFile5"] ?? "",
        userAnalysis5: json["UserAnalysis5"] ?? "",
        analysisDate5: json["AnalysisDate5"] ?? "",
        resultSymbol6: json["ResultSymbol6"] ?? "",
        result6: json["Result6"] ?? "",
        resultUnit6: json["ResultUnit6"] ?? "",
        resultRemark6: json["ResultRemark6"] ?? "",
        resultFile6: json["ResultFile6"] ?? "",
        userAnalysis6: json["UserAnalysis6"] ?? "",
        analysisDate6: json["AnalysisDate6"] ?? "",
        userRequestRecheck: json["UserRequestRecheck"] ?? "",
        requestRecheckRemark: json["RequestRecheckRemark"] ?? "",
        requestRecheckDate: json["RequestRecheckDate"] ?? "",
        userApprove: json["UserApprove"] ?? "",
        requestReconfirmRemark: json["RequestReconfirmRemark"] ?? "",
        requestReconfirmDate: json["RequestReconfirmDate"] ?? "",
        resultApproveSymbol: json["ResultApproveSymbol"] ?? "",
        resultApprove: json["ResultApprove"] ?? "",
        resultApproveUnit: json["ResultApproveUnit"] ?? "",
        resultApproveRemark: json["ResultApproveRemark"] ?? "",
        resultApproveFile: json["ResultApproveFile"] ?? "",
        resultAproveDate: json["ResultAproveDate"] ?? "",
        finishCompleteDate: json["FinishCompleteDate"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ID": id ?? "",
        "ReqNo": reqNo ?? "",
        "JobType": jobType ?? "",
        "Branch": branch ?? "",
        "RequestSection": requestSection ?? "",
        "ReqDate": reqDate ?? "",
        "ReqUser": reqUser ?? "",
        "CustId": custId ?? "",
        "CustFull": custFull ?? "",
        "CustShort": custShort ?? "",
        "Code": code ?? "",
        "Incharge": incharge ?? "",
        "RequestRound": requestRound ?? "",
        "RequestRemark": requestRemark ?? "",
        "RequestAttachFile": requestAttachFile ?? "",
        "RequestStatus": requestStatus ?? "",
        "SampleNo": sampleNo ?? "",
        "SampleCode": sampleCode ?? "",
        "SampleStatus": sampleStatus ?? "",
        "GroupNameTS": groupNameTs ?? "",
        "SampleGroup": sampleGroup ?? "",
        "SampleType": sampleType ?? "",
        "SampleTank": sampleTank ?? "",
        "SampleName": sampleName ?? "",
        "SampleAmount": sampleAmount ?? "",
        "SamplingDate": samplingDate ?? "",
        "SampleRemark": sampleRemark ?? "",
        "SampleAttachFile": sampleAttachFile ?? "",
        "ItemNo": itemNo ?? "",
        "InstrumentName": instrumentName ?? "",
        "ItemName": itemName ?? "",
        "ItemStatus": itemStatus ?? "",
        "UserSend": userSend ?? "",
        "SendDate": sendDate ?? "",
        "RemarkSend": remarkSend ?? "",
        "UserReject": userReject ?? "",
        "RejectDate": rejectDate ?? "",
        "RemarkReject": remarkReject ?? "",
        "UserCancel": userCancel ?? "",
        "CancelDate": cancelDate ?? "",
        "CancelRemark": cancelRemark ?? "",
        "UserReceive": userReceive ?? "",
        "ReceiveDate": receiveDate ?? "",
        "AnalysisDueDate": analysisDueDate ?? "",
        "Position": position ?? "",
        "Mag": mag ?? "",
        "Temp": temp ?? "",
        "StdFactor": stdFactor ?? "",
        "StdMax": stdMax ?? "",
        "StdMin": stdMin ?? "",
        "UserListAnalysis": userListAnalysis ?? "",
        "ListDate": listDate ?? "",
        "RemarkNo": remarkNo ?? "",
        "ResultSymbol1": resultSymbol1 ?? "",
        "Result1": result1 ?? "",
        "ResultUnit1": resultUnit1 ?? "",
        "ResultRemark1": resultRemark1 ?? "",
        "ResultFile1": resultFile1 ?? "",
        "UserAnalysis1": userAnalysis1 ?? "",
        "AnalysisDate1": analysisDate1 ?? "",
        "ResultSymbol2": resultSymbol2 ?? "",
        "Result2": result2 ?? "",
        "ResultUnit2": resultUnit2 ?? "",
        "ResultRemark2": resultRemark2 ?? "",
        "ResultFile2": resultFile2 ?? "",
        "UserAnalysis2": userAnalysis2 ?? "",
        "AnalysisDate2": analysisDate2 ?? "",
        "ResultSymbol3": resultSymbol3 ?? "",
        "Result3": result3 ?? "",
        "ResultUnit3": resultUnit3 ?? "",
        "ResultRemark3": resultRemark3 ?? "",
        "ResultFile3": resultFile3 ?? "",
        "UserAnalysis3": userAnalysis3 ?? "",
        "AnalysisDate3": analysisDate3 ?? "",
        "ResultSymbol4": resultSymbol4 ?? "",
        "Result4": result4 ?? "",
        "ResultUnit4": resultUnit4 ?? "",
        "ResultRemark4": resultRemark4 ?? "",
        "ResultFile4": resultFile4 ?? "",
        "UserAnalysis4": userAnalysis4 ?? "",
        "AnalysisDate4": analysisDate4 ?? "",
        "ResultSymbol5": resultSymbol5 ?? "",
        "Result5": result5 ?? "",
        "ResultUnit5": resultUnit5 ?? "",
        "ResultRemark5": resultRemark5 ?? "",
        "ResultFile5": resultFile5 ?? "",
        "UserAnalysis5": userAnalysis5 ?? "",
        "AnalysisDate5": analysisDate5 ?? "",
        "ResultSymbol6": resultSymbol6 ?? "",
        "Result6": result6 ?? "",
        "ResultUnit6": resultUnit6 ?? "",
        "ResultRemark6": resultRemark6 ?? "",
        "ResultFile6": resultFile6 ?? "",
        "UserAnalysis6": userAnalysis6 ?? "",
        "AnalysisDate6": analysisDate6 ?? "",
        "UserRequestRecheck": userRequestRecheck ?? "",
        "RequestRecheckRemark": requestRecheckRemark ?? "",
        "RequestRecheckDate": requestRecheckDate ?? "",
        "UserApprove": userApprove ?? "",
        "RequestReconfirmRemark": requestReconfirmRemark ?? "",
        "RequestReconfirmDate": requestReconfirmDate ?? "",
        "ResultApproveSymbol": resultApproveSymbol ?? "",
        "ResultApprove": resultApprove ?? "",
        "ResultApproveUnit": resultApproveUnit ?? "",
        "ResultApproveRemark": resultApproveRemark ?? "",
        "ResultApproveFile": resultApproveFile ?? "",
        "ResultAproveDate": resultAproveDate ?? "",
        "FinishCompleteDate": finishCompleteDate ?? "",
      };
}

List<MasterCustomerRoutine> masterCustomerRoutineFromJson(String str) =>
    List<MasterCustomerRoutine>.from(
        json.decode(str).map((x) => MasterCustomerRoutine.fromJson(x)));

String masterCustomerRoutineToJson(List<MasterCustomerRoutine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MasterCustomerRoutine {
  MasterCustomerRoutine({
    this.custFull,
    this.custShort,
    this.custSearch,
  });

  dynamic custFull;
  dynamic custShort;
  dynamic custSearch;

  factory MasterCustomerRoutine.fromJson(Map<String, dynamic> json) =>
      MasterCustomerRoutine(
        custFull: json["CustFull"] ?? "",
        custShort: json["CustShort"] ?? "",
        custSearch: json["CustSearch"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "CustFull": custFull ?? "",
        "CustShort": custShort ?? "",
        "CustSearch": custSearch ?? "",
      };
}

List<MasterInstrument> masterInstrumentFromJson(String str) =>
    List<MasterInstrument>.from(
        json.decode(str).map((x) => MasterInstrument.fromJson(x)));

String masterInstrumentToJson(List<MasterInstrument> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MasterInstrument {
  MasterInstrument({
    this.no,
    this.groupId,
    this.groupName,
    this.sampleTypeId,
    this.sampleTypeName,
    this.instrumentId,
    this.instrumentName,
    this.itemId,
    this.itemName,
    this.itemSearch,
  });

  dynamic no;
  dynamic groupId;
  dynamic groupName;
  dynamic sampleTypeId;
  dynamic sampleTypeName;
  dynamic instrumentId;
  dynamic instrumentName;
  dynamic itemId;
  dynamic itemName;
  dynamic itemSearch;

  factory MasterInstrument.fromJson(Map<String, dynamic> json) =>
      MasterInstrument(
        no: json["No"] ?? "",
        groupId: json["GroupId"] ?? "",
        groupName: json["GroupName"] ?? "",
        sampleTypeId: json["SampleTypeId"] ?? "",
        sampleTypeName: json["SampleTypeName"] ?? "",
        instrumentId: json["InstrumentId"] ?? "",
        instrumentName: json["InstrumentName"] ?? "",
        itemId: json["ItemId"] ?? "",
        itemName: json["ItemName"] ?? "",
        itemSearch: json["ItemSearch"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "No": no ?? "",
        "GroupId": groupId ?? "",
        "GroupName": groupName ?? "",
        "SampleTypeId": sampleTypeId ?? "",
        "SampleTypeName": sampleTypeName ?? "",
        "InstrumentId": instrumentId ?? "",
        "InstrumentName": instrumentName ?? "",
        "ItemId": itemId ?? "",
        "ItemName": itemName ?? "",
        "ItemSearch": itemSearch ?? "",
      };
}

List<AnalysisData> analysisDataFromJson(String str) => List<AnalysisData>.from(
    json.decode(str).map((x) => AnalysisData.fromJson(x)));

String analysisDataToJson(List<AnalysisData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnalysisData {
  AnalysisData({
    required this.no,
    required this.custId,
    required this.custFull,
    required this.custShort,
    required this.frequencyRequest,
    required this.sampleNo,
    required this.sampleGroup,
    required this.sampleType,
    required this.sampleTank,
    required this.sampleName,
    required this.frequency,
    required this.itemNo,
    required this.instrumentName,
    required this.itemName,
    required this.position,
    required this.mag,
    required this.temp,
    required this.stdFactor,
    required this.stdMax,
    required this.stdMin,
    required this.requestRound,
  });

  dynamic no;
  dynamic custId;
  dynamic custFull;
  dynamic custShort;
  dynamic frequencyRequest;
  dynamic sampleNo;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic frequency;
  dynamic itemNo;
  dynamic instrumentName;
  dynamic itemName;
  dynamic position;
  dynamic mag;
  dynamic temp;
  dynamic stdFactor;
  dynamic stdMax;
  dynamic stdMin;
  dynamic requestRound;

  factory AnalysisData.fromJson(Map<String, dynamic> json) => AnalysisData(
        no: json["No"] == null ? null : json["No"],
        custId: json["CustId"] == null ? null : json["CustId"],
        custFull: json["CustFull"] == null ? null : json["CustFull"],
        custShort: json["CustShort"] == null ? null : json["CustShort"],
        frequencyRequest:
            json["FrequencyRequest"] == null ? null : json["FrequencyRequest"],
        sampleNo: json["SampleNo"] == null ? null : json["SampleNo"],
        sampleGroup: json["SampleGroup"] == null ? null : json["SampleGroup"],
        sampleType: json["SampleType"] == null ? null : json["SampleType"],
        sampleTank: json["SampleTank"] == null ? null : json["SampleTank"],
        sampleName: json["SampleName"] == null ? null : json["SampleName"],
        frequency: json["Frequency"] == null ? null : json["Frequency"],
        itemNo: json["ItemNo"] == null ? null : json["ItemNo"],
        instrumentName: json["InstrumentName"],
        itemName: json["ItemName"] == null ? null : json["ItemName"],
        position: json["Position"],
        mag: json["Mag"],
        temp: json["Temp"],
        stdFactor: json["StdFactor"],
        stdMax: json["StdMax"] == null ? null : json["StdMax"],
        stdMin: json["StdMin"],
        requestRound:
            json["RequestRound"] == null ? null : json["RequestRound"],
      );

  Map<String, dynamic> toJson() => {
        "No": no == null ? null : no,
        "CustId": custId == null ? null : custId,
        "CustFull": custFull == null ? null : custFull,
        "CustShort": custShort == null ? null : custShort,
        "FrequencyRequest": frequencyRequest == null ? null : frequencyRequest,
        "SampleNo": sampleNo == null ? null : sampleNo,
        "SampleGroup": sampleGroup == null ? null : sampleGroup,
        "SampleType": sampleType == null ? null : sampleType,
        "SampleTank": sampleTank == null ? null : sampleTank,
        "sampleName": sampleName == null ? null : sampleName,
        "Frequency": frequency == null ? null : frequency,
        "ItemNo": itemNo == null ? null : itemNo,
        "InstrumentName": instrumentName,
        "ItemName": itemName == null ? null : itemName,
        "Position": position,
        "Mag": mag,
        "Temp": temp,
        "StdFactor": stdFactor,
        "StdMax": stdMax == null ? null : stdMax,
        "StdMin": stdMin,
        "RequestRound": requestRound == null ? null : requestRound,
      };
}

/* Future<List> findCustomerData(String customerName) async {
  Map<String, String> qParams = {
    'customerName': customerName,
  };
  //print("FindCustData: $customerName");
  final response =
      await http.get(Uri.parse("$url/FindCustomerData"), headers: qParams);
  if (response.statusCode == 200) {
    //print("In Future DataGet : ${response.body}");
    return analysisDataFromJson(response.body);
  } else {
    throw Exception('Failed to load posts');
  }
} */

class MasterAddItem {
  MasterAddItem({
    this.instrumentName,
    this.itemName,
    this.pos,
    this.mag,
    this.temp,
  });

  dynamic instrumentName;
  dynamic itemName;
  dynamic pos;
  dynamic mag;
  dynamic temp;
}

/* 
Future<String> createRequest(String requestData, String sampleData) async {
  Map<String, String> qParams = {
    'requestData': requestData,
    'sampleData': sampleData
  };
  print("increateRequest");
  final response =
      await http.post(Uri.parse("$url/createRequest"), body: qParams);
  //await http.post(Uri.parse("$url/createRequest"));
  if (response.statusCode == 200) {
    print("In Future DataGet : ${response.body}");
    return response.body;
  } else {
    throw Exception('Failed to load posts');
  }
} */
