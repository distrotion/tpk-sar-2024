import 'dart:convert';

List<ActualLineDataModel> ActualLineDataModelFromJson(String str) =>
    List<ActualLineDataModel>.from(
        json.decode(str).map((x) => ActualLineDataModel.fromJson(x)));

String ActualLineDataModelToJson(List<ActualLineDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActualLineDataModel {
  ActualLineDataModel({
    this.id,
    this.custFull,
    this.reqNo,
    this.sampleNo,
    this.groupNameTs,
    this.sampleGroup,
    this.sampleType,
    this.sampleTank,
    this.sampleName,
    this.samplingDate,
    this.itemNo,
    this.itemName,
    this.stdFactor,
    this.stdMax,
    this.stdSymbol,
    this.stdMin,
    this.result,
    this.inputDataDate,
    this.subLeader,
    this.gl,
    this.jp,
    this.dgm,
    this.patternReport,
    this.reportOrder,
    this.controlRange,
    this.itemReportName,
    this.processReportName,
  });

  dynamic id;
  dynamic custFull;
  dynamic reqNo;
  dynamic sampleNo;
  dynamic groupNameTs;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic samplingDate;
  dynamic itemNo;
  dynamic itemName;
  dynamic stdFactor;
  dynamic stdMax;
  dynamic stdSymbol;
  dynamic stdMin;
  dynamic result;
  dynamic inputDataDate;
  dynamic subLeader;
  dynamic gl;
  dynamic jp;
  dynamic dgm;
  dynamic patternReport;
  dynamic reportOrder;
  dynamic controlRange;
  dynamic itemReportName;
  dynamic processReportName;

  factory ActualLineDataModel.fromJson(Map<String, dynamic> json) =>
      ActualLineDataModel(
        id: json["ID"] ?? "",
        custFull: json["CustFull"] ?? "",
        reqNo: json["ReqNo"] ?? "",
        sampleNo: json["SampleNo"] ?? "",
        groupNameTs: json["GroupNameTS"] ?? "",
        sampleGroup: json["SampleGroup"] ?? "",
        sampleType: json["SampleType"] ?? "",
        sampleTank: json["SampleTank"] ?? "",
        sampleName: json["SampleName"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        itemNo: json["ItemNo"] ?? "",
        itemName: json["ItemName"] ?? "",
        stdFactor: json["StdFactor"] ?? "",
        stdMax: json["StdMax"] ?? "",
        stdSymbol: json["StdSymbol"] ?? "",
        stdMin: json["StdMin"] ?? "",
        result: json["Result"] ?? "",
        inputDataDate: json["InputDataDate"] ?? "",
        subLeader: json["SubLeader"] ?? "",
        gl: json["GL"] ?? "",
        jp: json["JP"] ?? "",
        dgm: json["DGM"] ?? "",
        patternReport: json["PatternReport"] ?? "",
        reportOrder: json["ReportOrder"] ?? "",
        processReportName: json["ProcessReportName"] ?? "",
        controlRange: json["ControlRange"] ?? "",
        itemReportName: json["ItemReportName"] ?? "",
        
      );

  Map<String, dynamic> toJson() => {
        "ID": id ?? "",
        "CustFull": custFull ?? "",
        "ReqNo": reqNo ?? "",
        "SampleNo": sampleNo ?? "",
        "GroupNameTS": groupNameTs ?? "",
        "SampleGroup": sampleGroup ?? "",
        "SampleType": sampleType ?? "",
        "SampleTank": sampleTank ?? "",
        "SampleName": sampleName ?? "",
        "SamplingDate": samplingDate ?? "",
        "ItemNo": itemNo ?? "",
        "ItemName": itemName ?? "",
        "StdFactor": stdFactor ?? "",
        "StdMax": stdMax ?? "",
        "StdSymbol": stdSymbol ?? "",
        "StdMin": stdMin ?? "",
        "Result": result ?? "",
        "InputDataDate": inputDataDate ?? "",
        "SubLeader": subLeader ?? "",
        "GL": gl ?? "",
        "JP": jp ?? "",
        "DGM": dgm ?? "",
        "PatternReport": patternReport ?? "",
        "ReportOrder": reportOrder ?? "",
        "ProcessReportName": processReportName ?? "",
        "ControlRange": controlRange ?? "",
        "ItemReportName": itemReportName ?? "",
        
      };
}
