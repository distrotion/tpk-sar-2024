// To parse this JSON data, do
//
//     final sampleData = sampleDataFromMap(jsonString);

import 'dart:convert';

List<ModelSampleData> modelSampleDataFromMap(String str) =>
    List<ModelSampleData>.from(
        json.decode(str).map((x) => ModelSampleData.fromMap(x)));

String modelSampleDataToMap(List<ModelSampleData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ModelSampleData {
  ModelSampleData({
    this.reqNo,
    this.jobType,
    this.custFull,
    this.reqDate,
    this.sampleGroup,
    this.sampleType,
    this.sampleTank,
    this.sampleName,
    this.sampleAmount,
    this.samplingDate,
    this.itemName,
  });

  dynamic reqNo;
  dynamic jobType;
  dynamic custFull;
  dynamic reqDate;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic sampleAmount;
  dynamic samplingDate;
  dynamic itemName;

  factory ModelSampleData.fromMap(Map<String, dynamic> json) => ModelSampleData(
        reqNo: json["ReqNo"] == null ? null : json["ReqNo"],
        jobType: json["JobType"] == null ? null : json["JobType"],
        custFull: json["CustFull"] == null ? null : json["CustFull"],
        reqDate: json["ReqDate"] == null ? null : json["ReqDate"],
        sampleGroup: json["SampleGroup"] == null ? null : json["SampleGroup"],
        sampleType: json["SampleType"] == null ? null : json["SampleType"],
        sampleTank: json["SampleTank"] == null ? null : json["SampleTank"],
        sampleName: json["SampleName"] == null ? null : json["SampleName"],
        sampleAmount:
            json["SampleAmount"] == null ? null : json["SampleAmount"],
        samplingDate: json["SamplingDate"] == null
            ? null
            : DateTime.parse(json["SamplingDate"]),
        itemName: json["ItemName"] == null ? null : json["ItemName"],
      );

  Map<String, dynamic> toMap() => {
        "ReqNo": reqNo == null ? null : reqNo,
        "JobType": jobType == null ? null : jobType,
        "CustFull": custFull == null ? null : custFull,
        "ReqDate": reqDate == null ? null : reqDate,
        "SampleGroup": sampleGroup == null ? null : sampleGroup,
        "SampleType": sampleType == null ? null : sampleType,
        "SampleTank": sampleTank == null ? null : sampleTank,
        "SampleName": sampleName == null ? null : sampleName,
        "SampleAmount": sampleAmount == null ? null : sampleAmount,
        "SamplingDate":
            samplingDate == null ? null : samplingDate.toIso8601String(),
        "ItemName": itemName == null ? null : itemName,
      };
}

List<ModelTableRequestData> modelTableRequestDataFromJson(String str) =>
    List<ModelTableRequestData>.from(
        json.decode(str).map((x) => ModelTableRequestData.fromJson(x)));

String modelTableRequestDataToJson(List<ModelTableRequestData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTableRequestData {
  ModelTableRequestData({
    this.reqNo,
    this.jobType,
    this.custFull,
    this.reqDate,
    this.sampleCode,
    this.sampleName,
    this.sampleStatus,
    this.userReceive,
    this.receiveDate,
    this.analysisDueDate,
  });

  dynamic reqNo;
  dynamic jobType;
  dynamic custFull;
  dynamic reqDate;
  dynamic sampleCode;
  dynamic sampleName;
  dynamic sampleStatus;
  dynamic userReceive;
  dynamic receiveDate;
  dynamic analysisDueDate;
  dynamic selected;

  factory ModelTableRequestData.fromJson(Map<String, dynamic> json) =>
      ModelTableRequestData(
        reqNo: json["ReqNo"] ?? "",
        jobType: json["JobType"] ?? "",
        custFull: json["CustFull"] ?? "",
        reqDate: json["ReqDate"] ?? "",
        sampleCode: json["SampleCode"] ?? "",
        sampleName: json["SampleName"] ?? "",
        sampleStatus: json["SampleStatus"] ?? "",
        userReceive: json["UserReceive"] ?? "",
        receiveDate: json["ReceiveDate"] ?? "",
        analysisDueDate: json["AnalysisDueDate"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ReqNo": reqNo == null ? null : reqNo,
        "JobType": jobType == null ? null : jobType,
        "CustFull": custFull == null ? null : custFull,
        "ReqDate": reqDate == null ? null : reqDate.toIso8601String(),
        "SampleCode": sampleCode == null ? null : sampleCode,
        "SampleName": sampleName == null ? null : sampleName,
        "SampleStatus": sampleStatus == null ? null : sampleStatus,
        "UserReceive": userReceive == null ? null : userReceive,
        "ReceiveDate": receiveDate == null ? null : receiveDate,
        "AnalysisDueDate": analysisDueDate == null ? null : analysisDueDate,
      };
}

class MasterAddItem {
  MasterAddItem({
    this.instrumentName,
    this.itemName,
    this.temp,
    this.pos,
    this.mag,
  });

  dynamic instrumentName;
  dynamic itemName;
  dynamic temp;
  dynamic pos;
  dynamic mag;
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
