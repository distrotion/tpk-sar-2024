import 'dart:convert';

List<ModelTOC> modelTOCFromJson(String str) =>
    List<ModelTOC>.from(json.decode(str).map((x) => ModelTOC.fromJson(x)));

String modelTOCToJson(List<ModelTOC> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTOC {
  ModelTOC({
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
    this.tC_DilutionTime_1,
    this.tC_RawData_1,
    this.iC_DilutionTime_1,
    this.iC_RawData_1,
    this.tC_DilutionTime_2,
    this.tC_RawData_2,
    this.iC_DilutionTime_2,
    this.iC_RawData_2,
    this.tC_Vial_1,
    this.iC_Vial_1,
    this.tC_Vial_2,
    this.iC_Vial_2,
  });

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
  dynamic tC_DilutionTime_1;
  dynamic tC_RawData_1;
  dynamic iC_DilutionTime_1;
  dynamic iC_RawData_1;
  dynamic tC_DilutionTime_2;
  dynamic tC_RawData_2;
  dynamic iC_DilutionTime_2;
  dynamic iC_RawData_2;
  dynamic tC_Vial_1;
  dynamic iC_Vial_1;
  dynamic tC_Vial_2;
  dynamic iC_Vial_2;

  factory ModelTOC.fromJson(Map<String, dynamic> json) => ModelTOC(
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
        tC_DilutionTime_1: json["TC_DilutionTime_1"] ?? "",
        tC_RawData_1: json["TC_RawData_1"] ?? "",
        iC_DilutionTime_1: json["IC_DilutionTime_1"] ?? "",
        iC_RawData_1: json["IC_RawData_1"] ?? "",
        tC_DilutionTime_2: json["TC_DilutionTime_2"] ?? "",
        tC_RawData_2: json["TC_RawData_2"] ?? "",
        iC_DilutionTime_2: json["IC_DilutionTime_2"] ?? "",
        iC_RawData_2: json["IC_RawData_2"] ?? "",
        canEdit: false,
        tC_Vial_1:json ["TC_Vial_1"]??"",
        iC_Vial_1:json ["IC_Vial_1"]??"",
        tC_Vial_2:json ["TC_Vial_2"]??"",
        iC_Vial_2:json ["IC_Vial_2"]??"",
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
        "ResultFile_1": resultFile_1 ?? "",
        "ResultSymbol_2": resultSymbol_2 ?? "",
        "Result_2": result_2 ?? "",
        "ResultUnit_2": resultUnit_2 ?? "",
        "ResultRemark_2": resultRemark_2 ?? "",
        "ResultFile_2": resultFile_2 ?? "",
        "TC_DilutionTime_1": tC_DilutionTime_1 ?? "",
        "TC_RawData_1": tC_RawData_1 ?? "",
        "IC_DilutionTime_1": iC_DilutionTime_1 ?? "",
        "IC_RawData_1": iC_RawData_1 ?? "",
        "TC_DilutionTime_2": tC_DilutionTime_2 ?? "",
        "TC_RawData_2": tC_RawData_2 ?? "",
        "IC_DilutionTime_2": iC_DilutionTime_2 ?? "",
        "IC_RawData_2": iC_RawData_2 ?? "",
        "TC_Vial_1":tC_Vial_1 ?? "",
        "IC_Vial_1":iC_Vial_1 ?? "",
        "TC_Vial_2":tC_Vial_2 ?? "",
        "IC_Vial_2":iC_Vial_2 ?? "",
      };
}
