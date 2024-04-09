import 'dart:convert';

List<ModelTableReceiveiSample> ModelTableReceiveiSampleFromJson(String str) =>
    List<ModelTableReceiveiSample>.from(
        json.decode(str).map((x) => ModelTableReceiveiSample.fromJson(x)));

String ModelTableReceiveiSampleToJson(List<ModelTableReceiveiSample> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTableReceiveiSample {
  ModelTableReceiveiSample({
    this.reqNo,
    this.jobType,
    this.branch,
    this.samplecode,
    this.custFull,
    this.reqUser,
    this.sampleName,
    this.sampleStatus,
    this.userSend,
    this.sendDate,
    this.incharge,
  });

  dynamic reqNo;
  dynamic jobType;
  dynamic branch;
  dynamic samplecode;
  dynamic custFull;
  dynamic reqUser;
  dynamic sampleName;
  dynamic sampleStatus;
  dynamic userSend;
  dynamic sendDate;
  dynamic selected;
  dynamic incharge;

  factory ModelTableReceiveiSample.fromJson(Map<String, dynamic> json) =>
      ModelTableReceiveiSample(
        reqNo: json["ReqNo"] ?? "",
        jobType: json["JobType"] ?? "",
        branch: json["Branch"] ?? "",
        samplecode: json["Samplecode"] ?? "",
        custFull: json["CustFull"] ?? "",
        reqUser: json["ReqUser"] ?? "",
        sampleName: json["SampleName"] ?? "",
        sampleStatus: json["SampleStatus"] ?? "",
        userSend: json["UserSend"] ?? "",
        sendDate: json["SendDate"] ?? "",
        incharge: json["Incharge"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ReqNo": reqNo ?? "",
        "JobType": jobType ?? "",
        "Branch": branch ?? "",
        "Samplecode": samplecode ?? "",
        "CustFull": custFull ?? "",
        "ReqUser": reqUser ?? "",
        "SampleName": sampleName ?? "",
        "SampleStatus": sampleStatus ?? "",
        "UserSend": userSend ?? "",
        "SendDate": sendDate ?? "",
        "Incharge": incharge ?? "",
      };
}

String searchReceiveSampleToMap(List<SearchReceiveSample> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SearchReceiveSample {
  SearchReceiveSample({
    this.bangpoo = true,
    this.rayong = true,
  });
  dynamic bangpoo;
  dynamic rayong;

  Map<String, dynamic> toMap() => {
        "Bangpoo": bangpoo,
        "Rayong": rayong,
      };
}

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
    this.incharge,
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
  dynamic incharge;
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
        incharge: json["Incharge"] == null ? null : json["Incharge"],
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
        "Incharge": incharge == null ? null : incharge,
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
