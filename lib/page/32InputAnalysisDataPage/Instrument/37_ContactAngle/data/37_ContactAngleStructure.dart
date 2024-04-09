import 'dart:convert';

List<ModelContactAngle> modelContactAngleFromJson(String str) =>
    List<ModelContactAngle>.from(
        json.decode(str).map((x) => ModelContactAngle.fromJson(x)));

String modelContactAngleToJson(List<ModelContactAngle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelContactAngle {
  ModelContactAngle({
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
    this.pos_1,
    this.n1,
    this.n2,
    this.n3,
    this.n4,
    this.n5,
    this.n6,
    this.n7,
    this.n8,
    this.n9,
    this.n10,
    this.n11,
    this.n12,
    this.n13,
    this.n14,
    this.n15,
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
  dynamic pos_1;
  dynamic n1;
  dynamic n2;
  dynamic n3;
  dynamic n4;
  dynamic n5;
  dynamic n6;
  dynamic n7;
  dynamic n8;
  dynamic n9;
  dynamic n10;
  dynamic n11;
  dynamic n12;
  dynamic n13;
  dynamic n14;
  dynamic n15;

  factory ModelContactAngle.fromJson(Map<String, dynamic> json) =>
      ModelContactAngle(
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
        canEdit: false,
        pos_1: json["Pos_1"] ?? "",
        n1: json["N1"] ?? "",
        n2: json["N2"] ?? "",
        n3: json["N3"] ?? "",
        n4: json["N4"] ?? "",
        n5: json["N5"] ?? "",
        n6: json["N6"] ?? "",
        n7: json["N7"] ?? "",
        n8: json["N8"] ?? "",
        n9: json["N9"] ?? "",
        n10: json["N10"] ?? "",
        n11: json["N11"] ?? "",
        n12: json["N12"] ?? "",
        n13: json["N13"] ?? "",
        n14: json["N14"] ?? "",
        n15: json["N15"] ?? "",
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
        "Pos_1": pos_1 ?? "",
        "N1": n1 ?? "",
        "N2": n2 ?? "",
        "N3": n3 ?? "",
        "N4": n4 ?? "", 
        "N5": n5 ?? "",
        "N6": n6 ?? "",
        "N7": n7 ?? "",
        "N8": n8 ?? "",
        "N9": n9 ?? "",
        "N10": n10 ?? "",
        "N11": n11 ?? "",
        "N12": n12 ?? "",
        "N13": n13 ?? "",
        "N14": n14 ?? "",
        "N15": n15 ?? "",
      };
}
