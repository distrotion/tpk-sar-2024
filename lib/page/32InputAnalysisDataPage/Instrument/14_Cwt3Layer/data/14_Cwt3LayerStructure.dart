import 'dart:convert';

List<ModelCwt3layers> modelCwt3layersFromJson(String str) =>
    List<ModelCwt3layers>.from(
        json.decode(str).map((x) => ModelCwt3layers.fromJson(x)));

String modelCwt3layersToJson(List<ModelCwt3layers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCwt3layers {
  ModelCwt3layers({
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
    this.size,
    this.w1,
    this.w2,
    this.w1W2,
    this.result_Non,
    this.w3,
    this.w2W3,
    this.result_Met,
    this.w4,
    this.w3W4,
    this.result_Zn,
    this.resultUnit,
    this.resultRemark,
    this.stdMax_Non,
    this.stdMin_Non,
    this.stdMax_Met,
    this.stdMin_Met,
    this.stdMax_Zn,
    this.stdMin_Zn,
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
  dynamic size;
  dynamic w1;
  dynamic w2;
  dynamic w1W2;
  dynamic result_Non;
  dynamic w3;
  dynamic w2W3;
  dynamic result_Met;
  dynamic w4;
  dynamic w3W4;
  dynamic result_Zn;
  dynamic resultUnit;
  dynamic resultRemark;
  dynamic stdMax_Non;
  dynamic stdMin_Non;
  dynamic stdMax_Met;
  dynamic stdMin_Met;
  dynamic stdMax_Zn;
  dynamic stdMin_Zn;

  factory ModelCwt3layers.fromJson(Map<String, dynamic> json) =>
      ModelCwt3layers(
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
        size: json["Size"] ?? "",
        w1: json["W1"] ?? "",
        w2: json["W2"] ?? "",
        w1W2: json["W1W2"] ?? "",
        result_Non: json["Result_Non"] ?? "",
        w3: json["W3"] ?? "",
        w2W3: json["W2W3"] ?? "",
        result_Met: json["Result_Met"] ?? "",
        w4: json["W4"] ?? "",
        w3W4: json["W3W4"] ?? "",
        result_Zn: json["Result_Zn"] ?? "",
        resultUnit: json["ResultUnit"] ?? "",
        resultRemark: json["ResultRemark"] ?? "",
        stdMax_Non: json["StdMax_Non"] ?? "",
        stdMin_Non: json["StdMin_Non"] ?? "",
        stdMax_Met: json["StdMax_Met"] ?? "",
        stdMin_Met: json["StdMin_Met"] ?? "",
        stdMax_Zn: json["StdMax_Zn"] ?? "",
        stdMin_Zn: json["StdMin_Zn"] ?? "",
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
        "Size": size ?? "",
        "W1": w1 ?? "",
        "W2": w2 ?? "",
        "W1W2": w1W2 ?? "",
        "Result_Non": result_Non ?? "",
        "W3": w3 ?? "",
        "W2W3": w2W3 ?? "",
        "Result_Met": result_Met ?? "",
        "W4": w4 ?? "",
        "W3W4": w3W4 ?? "",
        "Result_Zn": result_Zn ?? "",
        "ResultUnit": resultUnit ?? "",
        "ResultRemark": resultRemark ?? "",
        "StdMax_Non":stdMax_Non ?? "",
        "StdMin_Non":stdMin_Non ?? "",
        "StdMax_Met":stdMax_Met ?? "",
        "StdMin_Met":stdMin_Met ?? "",
        "StdMax_Zn":stdMax_Zn ?? "",
        "StdMin_Zn":stdMin_Zn ?? "",
      };
}
