import 'dart:convert';

List<ModelSolidContent_NoxRust> modelSolidContent_NoxRustFromJson(String str) => List<ModelSolidContent_NoxRust>.from(
    json.decode(str).map((x) => ModelSolidContent_NoxRust.fromJson(x)));

String modelSolidContent_NoxRustToJson(List<ModelSolidContent_NoxRust> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSolidContent_NoxRust {
  ModelSolidContent_NoxRust(
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
      this.resultFile_1,
      this.resultSymbol_2,
      this.result_2,
      this.resultUnit_2,
      this.resultRemark_2,
      this.resultFile_2,
      this.canEdit,
      this.no_1,
      this.usedSample_1,
      this.w1_1,
      this.w2_1,
      this.w1W2_1,
      this.no_2,
      this.usedSample_2,
      this.w1_2,
      this.w2_2,
      this.w1W2_2});

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
  dynamic resultFile_1;
  dynamic resultSymbol_2;
  dynamic result_2;
  dynamic resultUnit_2;
  dynamic resultRemark_2;
  dynamic resultFile_2;
  dynamic canEdit;
  dynamic no_1;
  dynamic usedSample_1;
  dynamic w1_1;
  dynamic w2_1;
  dynamic w1W2_1;
  dynamic no_2;
  dynamic usedSample_2;
  dynamic w1_2;
  dynamic w2_2;
  dynamic w1W2_2;

  factory ModelSolidContent_NoxRust.fromJson(Map<String, dynamic> json) => ModelSolidContent_NoxRust(
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
        resultFile_1: json["ResultFile_1"] ?? "",
        resultSymbol_2: json["ResultSymbol_2"] ?? "",
        result_2: json["Result_2"] ?? "",
        resultUnit_2: json["ResultUnit_2"] ?? "",
        resultRemark_2: json["ResultRemark_2"] ?? "",
        resultFile_2: json["ResultFile_2"] ?? "",
        no_1: json["No_1"] ?? "",
        usedSample_1: json["UsedSample_1"] ?? "",
        w1_1: json["W1_1"] ?? "",
        w2_1: json["W2_1"] ?? "",
        w1W2_1: json["W1W2_1"] ?? "",
        no_2: json["No_2"] ?? "",
        usedSample_2: json["UsedSample_2"] ?? "",
        w1_2: json["W1_2"] ?? "",
        w2_2: json["W2_2"] ?? "",
        w1W2_2: json["W1W2_2"] ?? "",
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
        "ResultSymbol_1": resultSymbol_1 ?? "",
        "Result_1": result_1 ?? "",
        "ResultUnit_1": resultUnit_1 ?? "",
        "ResultRemark_1": resultRemark_1 ?? "",
        "ResultFile_1": resultFile_1 ?? "",
        "ResultSymbol_2": resultSymbol_2 ?? "",
        "Result_2": result_2 ?? "",
        "ResultUnit_2": resultUnit_2 ?? "",
        "ResultRemark_2": resultRemark_2 ?? "",
        "ResultFile_2": resultFile_2 ?? "",
        "No_1": no_1 ?? "",
        "UsedSample_1": usedSample_1 ?? "",
        "W1_1": w1_1 ?? "",
        "W2_1": w2_1 ?? "",
        "W1W2_1": w1W2_1 ?? "",
        "No_2": no_2 ?? "",
        "UsedSample_2": usedSample_2 ?? "",
        "W1_2": w1_2 ?? "",
        "W2_2": w2_2 ?? "",
        "W1W2_2": w1W2_2 ?? "",
      };
}
