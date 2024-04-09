import 'dart:convert';

List<ModelPo43Titrate> modelPo43TitrateFromJson(String str) =>
    List<ModelPo43Titrate>.from(
        json.decode(str).map((x) => ModelPo43Titrate.fromJson(x)));

String modelPo43TitrateToJson(List<ModelPo43Titrate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPo43Titrate {
  ModelPo43Titrate({
    this.id,
    this.requestSampleId,
    this.reqNo,
    this.jobType,
    this.incharge,
    this.branch,
    this.requestSection,
    this.reqDate,
    this.custFull,
    this.sampleCode,
    this.sampleGroup,
    this.sampleType,
    this.sampleTank,
    this.sampleName,
    this.processReportName,
    this.samplingDate,
    this.analysisDueDate,
    this.sampleRemark,
    this.sampleAttachFile,
    this.position,
    this.mag,
    this.temp,
    this.stdFactor,
    this.stdMax,
    this.stdMin,
    this.controlRange,
    this.itemNo,
    this.itemName,
    this.itemReportName,
    this.remarkNo,
    this.itemStatus,
    this.userAnalysis,
    this.userAnalysisBranch,
    this.analysisDate,
    this.titrantFactor_1,
    this.endPt1_1,
    this.endPt2_1,
    this.resultSymbol_1,
    this.result_1,
    this.resultUnit_1,
    this.resultRemark_1,
    this.resultFile_1,
    this.titrantFactor_2,
    this.endPt1_2,
    this.endPt2_2,
    this.resultSymbol_2,
    this.result_2,
    this.resultUnit_2,
    this.resultRemark_2,
    this.resultFile_2,
    this.canEdit,
  });

  dynamic id;
  dynamic requestSampleId;
  dynamic reqNo;
  dynamic jobType;
  dynamic incharge;
  dynamic branch;
  dynamic requestSection;
  dynamic reqDate;
  dynamic custFull;
  dynamic sampleCode;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic processReportName;
  dynamic samplingDate;
  dynamic analysisDueDate;
  dynamic sampleRemark;
  dynamic sampleAttachFile;
  dynamic position;
  dynamic mag;
  dynamic temp;
  dynamic stdFactor;
  dynamic stdMax;
  dynamic stdMin;
  dynamic controlRange;
  dynamic itemNo;
  dynamic itemName;
  dynamic itemReportName;
  dynamic remarkNo;
  dynamic itemStatus;
  dynamic userAnalysis;
  dynamic userAnalysisBranch;
  dynamic analysisDate;
  dynamic titrantFactor_1;
  dynamic endPt1_1;
  dynamic endPt2_1;
  dynamic resultSymbol_1;
  dynamic result_1;
  dynamic resultUnit_1;
  dynamic resultRemark_1;
  dynamic resultFile_1;
  dynamic titrantFactor_2;
  dynamic endPt1_2;
  dynamic endPt2_2;
  dynamic resultSymbol_2;
  dynamic result_2;
  dynamic resultUnit_2;
  dynamic resultRemark_2;
  dynamic resultFile_2;
  dynamic canEdit;

  factory ModelPo43Titrate.fromJson(Map<String, dynamic> json) =>
      ModelPo43Titrate(
        requestSampleId: json["RequestSample_ID"] ?? "",
        reqNo: json["ReqNo"] ?? "",
        jobType: json["JobType"] ?? "",
        incharge: json["Incharge"] ?? "",
        branch: json["Branch"] ?? "",
        requestSection: json["RequestSection"] ?? "",
        reqDate: json["ReqDate"] ?? "",
        custFull: json["CustFull"] ?? "",
        sampleCode: json["SampleCode"] ?? "",
        sampleGroup: json["SampleGroup"] ?? "",
        sampleType: json["SampleType"] ?? "",
        sampleTank: json["SampleTank"] ?? "",
        sampleName: json["SampleName"] ?? "",
        processReportName: json["ProcessReportName"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        analysisDueDate: json["AnalysisDueDate"] ?? "",
        sampleRemark: json["SampleRemark"] ?? "",
        sampleAttachFile: json["SampleAttachFile"] ?? "",
        position: json["Position"] ?? "",
        mag: json["Mag"] ?? "",
        temp: json["Temp"] ?? "",
        stdFactor: json["StdFactor"] ?? "",
        stdMax: json["StdMax"] ?? "",
        stdMin: json["StdMin"] ?? "",
        controlRange: json["ControlRange"] ?? "",
        itemNo: json["ItemNo"] ?? "",
        itemName: json["ItemName"] ?? "",
        itemReportName: json["ItemReportName"] ?? "",
        remarkNo: json["RemarkNo"] ?? "",
        itemStatus: json["ItemStatus"] ?? "",
        userAnalysis: json["UserAnalysis"] ?? "",
        userAnalysisBranch: json["UserAnalysisBranch"] ?? "",
        analysisDate: json["AnalysisDate"] ?? "",
        titrantFactor_1: json["TitrantFactor_1"] ?? "",
        endPt1_1: json["EndPt1_1"] ?? "",
        endPt2_1: json["EndPt2_1"] ?? "",
        resultSymbol_1: json["ResultSymbol_1"] ?? "",
        result_1: json["Result_1"] ?? "",
        resultUnit_1: json["ResultUnit_1"] ?? "",
        resultRemark_1: json["ResultRemark_1"] ?? "",
        resultFile_1: json["ResultFile_1"] ?? "",
        titrantFactor_2: json["TitrantFactor_2"] ?? "",
        endPt1_2: json["EndPt1_2"] ?? "",
        endPt2_2: json["EndPt2_2"] ?? "",
        resultSymbol_2: json["ResultSymbol_2"] ?? "",
        result_2: json["Result_2"] ?? "",
        resultUnit_2: json["ResultUnit_2"] ?? "",
        resultRemark_2: json["ResultRemark_2"] ?? "",
        resultFile_2: json["ResultFile_2"] ?? "",
        canEdit: false,
      );

  Map<String, dynamic> toJson() => {
        "RequestSample_ID": requestSampleId ?? "",
        "ReqNo": reqNo ?? "",
        "JobType": jobType ?? "",
        "Incharge": incharge ?? "",
        "Branch": branch ?? "",
        "RequestSection": requestSection ?? "",
        "ReqDate": reqDate ?? "",
        "CustFull": custFull ?? "",
        "SampleCode": sampleCode ?? "",
        "SampleGroup": sampleGroup ?? "",
        "SampleType": sampleType ?? "",
        "SampleTank": sampleTank ?? "",
        "SampleName": sampleName ?? "",
        "ProcessReportName": processReportName ?? "",
        "SamplingDate": samplingDate ?? "",
        "AnalysisDueDate": analysisDueDate ?? "",
        "SampleRemark": sampleRemark ?? "",
        "SampleAttachFile": sampleAttachFile ?? "",
        "Position": position ?? "",
        "Mag": mag ?? "",
        "Temp": temp ?? "",
        "StdFactor": stdFactor ?? "",
        "StdMax": stdMax ?? "",
        "StdMin": stdMin ?? "",
        "ControlRange": controlRange ?? "",
        "ItemNo": itemNo ?? "",
        "ItemName": itemName ?? "",
        "ItemReportName": itemReportName ?? "",
        "RemarkNo": remarkNo ?? "",
        "ItemStatus": itemStatus ?? "",
        "UserAnalysis": userAnalysis ?? "",
        "UserAnalysisBranch": userAnalysisBranch ?? "",
        "AnalysisDate": analysisDate ?? "",
        "TitrantFactor_1": titrantFactor_1 ?? "",
        "EndPt1_1": endPt1_1 ?? "",
        "EndPt2_1": endPt2_1 ?? "",
        "ResultSymbol_1": resultSymbol_1 ?? "",
        "Result_1": result_1 ?? "",
        "ResultUnit_1": resultUnit_1 ?? "",
        "ResultRemark_1": resultRemark_1 ?? "",
        "ResultFile_1": resultFile_1 ?? "",
        "TitrantFactor_2": titrantFactor_2 ?? "",
        "EndPt1_2": endPt1_2 ?? "",
        "EndPt2_2": endPt2_2 ?? "",
        "ResultSymbol_2": resultSymbol_2 ?? "",
        "Result_2": result_2 ?? "",
        "ResultUnit_2": resultUnit_2 ?? "",
        "ResultRemark_2": resultRemark_2 ?? "",
        "ResultFile_2": resultFile_2 ?? "",
      };
}
