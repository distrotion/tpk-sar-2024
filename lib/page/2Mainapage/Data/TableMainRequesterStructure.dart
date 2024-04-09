import 'dart:convert';

List<ModelTableMainRequester> mainRequesterData = [];
// To parse this JSON data, do
//
//     final modelTableMainRequester = modelTableMainRequesterFromJson(jsonString);
List<ModelTableMainRequester> modelTableMainRequesterFromJson(String str) =>
    List<ModelTableMainRequester>.from(
        json.decode(str).map((x) => ModelTableMainRequester.fromJson(x)));

String modelTableMainRequesterToJson(List<ModelTableMainRequester> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTableMainRequester {
  ModelTableMainRequester({
    this.reqNo,
    this.jobType,
    this.reqDate,
    this.custFull,
    this.requestRound,
    this.requestStatus,
    this.sampleName1,
    this.sampleName2,
    this.sampleName3,
    this.sampleName4,
    this.sampleName5,
    this.sampleName6,
    this.sampleName7,
    this.sampleName8,
    this.sampleName9,
    this.sampleName10,
    this.sampleStatus1,
    this.sampleStatus2,
    this.sampleStatus3,
    this.sampleStatus4,
    this.sampleStatus5,
    this.sampleStatus6,
    this.sampleStatus7,
    this.sampleStatus8,
    this.sampleStatus9,
    this.sampleStatus10,
    this.manualDataStatus,
    this.reportStatus,
    this.reportDueDate,
    this.nextApprover,
    this.samplingDate,
  });

  dynamic reqNo;
  dynamic jobType;
  dynamic reqDate;
  dynamic custFull;
  dynamic requestRound;
  dynamic requestStatus;
  dynamic sampleName1;
  dynamic sampleName2;
  dynamic sampleName3;
  dynamic sampleName4;
  dynamic sampleName5;
  dynamic sampleName6;
  dynamic sampleName7;
  dynamic sampleName8;
  dynamic sampleName9;
  dynamic sampleName10;
  dynamic sampleStatus1;
  dynamic sampleStatus2;
  dynamic sampleStatus3;
  dynamic sampleStatus4;
  dynamic sampleStatus5;
  dynamic sampleStatus6;
  dynamic sampleStatus7;
  dynamic sampleStatus8;
  dynamic sampleStatus9;
  dynamic sampleStatus10;
  dynamic manualDataStatus;
  dynamic reportStatus;
  dynamic reportDueDate;
  dynamic nextApprover;
  dynamic selected;
  dynamic samplingDate;

  factory ModelTableMainRequester.fromJson(Map<String, dynamic> json) =>
      ModelTableMainRequester(
        reqNo: json["reqNo"] ?? "",
        jobType: json["jobType"] ?? "",
        reqDate: json["reqDate"] ?? "",
        custFull: json["custFull"] ?? "",
        requestRound: json["requestRound"] ?? "",
        requestStatus: json["requestStatus"] ?? "",
        sampleName1: json["sampleName1"] ?? "",
        sampleName2: json["sampleName2"] ?? "",
        sampleName3: json["sampleName3"] ?? "",
        sampleName4: json["sampleName4"] ?? "",
        sampleName5: json["sampleName5"] ?? "",
        sampleName6: json["sampleName6"] ?? "",
        sampleName7: json["sampleName7"] ?? "",
        sampleName8: json["sampleName8"] ?? "",
        sampleName9: json["sampleName9"] ?? "",
        sampleName10: json["sampleName10"] ?? "",
        sampleStatus1: json["sampleStatus1"] ?? "",
        sampleStatus2: json["sampleStatus2"] ?? "",
        sampleStatus3: json["sampleStatus3"] ?? "",
        sampleStatus4: json["sampleStatus4"] ?? "",
        sampleStatus5: json["sampleStatus5"] ?? "",
        sampleStatus6: json["sampleStatus6"] ?? "",
        sampleStatus7: json["sampleStatus7"] ?? "",
        sampleStatus8: json["sampleStatus8"] ?? "",
        sampleStatus9: json["sampleStatus9"] ?? "",
        sampleStatus10: json["sampleStatus10"] ?? "",
        manualDataStatus: json["manualDataStatus"] ?? "",
        reportStatus: json["reportStatus"] ?? "",
        reportDueDate: json["reportDueDate"] ?? "",
        nextApprover: json["nextApprover"] ?? "",
        samplingDate: json["samplingDate"] ??""
      );

  Map<String, dynamic> toJson() => {
        "reqNo": reqNo,
        "jobType": jobType,
        "reqDate": reqDate,
        "custFull": custFull,
        "requestRound": requestRound,
        "requestStatus": requestStatus,
        "sampleName1": sampleName1,
        "sampleName2": sampleName2,
        "sampleName3": sampleName3,
        "sampleName4": sampleName4,
        "sampleName5": sampleName5,
        "sampleName6": sampleName6,
        "sampleName7": sampleName7,
        "sampleName8": sampleName8,
        "sampleName9": sampleName9,
        "sampleName10": sampleName10,
        "sampleStatus1": sampleStatus1,
        "sampleStatus2": sampleStatus2,
        "sampleStatus3": sampleStatus3,
        "sampleStatus4": sampleStatus4,
        "sampleStatus5": sampleStatus5,
        "sampleStatus6": sampleStatus6,
        "sampleStatus7": sampleStatus7,
        "sampleStatus8": sampleStatus8,
        "sampleStatus9": sampleStatus9,
        "sampleStatus10": sampleStatus10,
        "manualDataStatus": manualDataStatus,
        "reportStatus": reportStatus,
        "reportDueDate": reportDueDate,
        "nextApprover": nextApprover,
        "samplingDate" : samplingDate,
      };
}
