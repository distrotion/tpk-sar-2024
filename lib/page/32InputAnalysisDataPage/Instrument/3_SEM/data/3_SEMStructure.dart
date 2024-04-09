import 'dart:convert';

List<ModelSEM> modelSEMFromJson(String str) =>
    List<ModelSEM>.from(json.decode(str).map((x) => ModelSEM.fromJson(x)));

String modelSEMToJson(List<ModelSEM> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSEM {
  ModelSEM(
      {this.requestSampleId,
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
      this.itemNo,
      this.itemName,
      this.remarkNo,
      this.itemStatus,
      this.userAnalysis,
      this.userAnalysisBranch,
      this.analysisDate,
      this.resultSymbol_1,
      this.result_1,
      this.resultUnit_1,
      this.resultRemark_1,
      this.resultSymbol_2,
      this.result_2,
      this.resultUnit_2,
      this.resultRemark_2,
      this.magnification_1,
      this.position_1,
      this.magnification_2,
      this.position_2,
      this.canEdit,
      this.fileName_1,
      this.fileName_2});

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
  dynamic itemNo;
  dynamic itemName;
  dynamic remarkNo;
  dynamic itemStatus;
  dynamic userAnalysis;
  dynamic userAnalysisBranch;
  dynamic analysisDate;
  dynamic resultSymbol_1;
  dynamic result_1;
  dynamic resultUnit_1;
  dynamic resultRemark_1;
  dynamic resultSymbol_2;
  dynamic result_2;
  dynamic resultUnit_2;
  dynamic resultRemark_2;
  dynamic magnification_1;
  dynamic position_1;
  dynamic magnification_2;
  dynamic position_2;
  dynamic canEdit;
  dynamic fileName_1;
  dynamic fileName_2;

  factory ModelSEM.fromJson(Map<String, dynamic> json) => ModelSEM(
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
        itemNo: json["ItemNo"] ?? "",
        itemName: json["ItemName"] ?? "",
        remarkNo: json["RemarkNo"] ?? "",
        itemStatus: json["ItemStatus"] ?? "",
        userAnalysis: json["UserAnalysis"] ?? "",
        userAnalysisBranch: json["UserAnalysisBranch"] ?? "",
        analysisDate: json["AnalysisDate"] ?? "",
        resultSymbol_1: json["ResultSymbol_1"] ?? "",
        result_1: json["Result_1"] ?? "",
        resultUnit_1: json["ResultUnit_1"] ?? "",
        resultRemark_1: json["ResultRemark_1"] ?? "",
        magnification_1: json["Magnification_1"] ?? "",
        position_1: json["Position_1"] ?? "",
        resultSymbol_2: json["ResultSymbol_2"] ?? "",
        result_2: json["Result_2"] ?? "",
        resultUnit_2: json["ResultUnit_2"] ?? "",
        resultRemark_2: json["ResultRemark_2"] ?? "",
        magnification_2: json["Magnification_2"] ?? "",
        position_2: json["Position_2"] ?? "",
        canEdit: false,
        fileName_1: json["FileName_1"] ?? "",
        fileName_2: json["FileName_2"] ?? "",
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
        "ItemNo": itemNo ?? "",
        "ItemName": itemName ?? "",
        "RemarkNo": remarkNo ?? "",
        "ItemStatus": itemStatus ?? "",
        "UserAnalysis": userAnalysis ?? "",
        "UserAnalysisBranch": userAnalysisBranch ?? "",
        "AnalysisDate": analysisDate ?? "",
        "ResultSymbol_1": resultSymbol_1 ?? "",
        "Result_1": result_1 ?? "",
        "ResultUnit_1": resultUnit_1 ?? "",
        "ResultRemark_1": resultRemark_1 ?? "",
        "Magnification_1": magnification_1 ?? "",
        "Position_1": position_1 ?? "",
        "ResultSymbol_2": resultSymbol_2 ?? "",
        "Result_2": result_2 ?? "",
        "ResultUnit_2": resultUnit_2 ?? "",
        "ResultRemark_2": resultRemark_2 ?? "",
        "Magnification_2": magnification_2 ?? "",
        "Position_2": position_2 ?? "",
        "FileName_1": fileName_1 ?? "",
        "FileName_2": fileName_2 ?? "",
      };
}
