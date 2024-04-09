import 'dart:convert';

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

  factory MasterInstrument.fromJson(Map<String, dynamic> json) =>
      MasterInstrument(
        no: json["No"] == null ? "" : json["No"],
        groupId: json["GroupId"] == null ? "" : json["GroupId"],
        groupName: json["GroupName"] == null ? "" : json["GroupName"],
        sampleTypeId: json["SampleTypeId"] == null ? "" : json["SampleTypeId"],
        sampleTypeName:
            json["SampleTypeName"] == null ? "" : json["SampleTypeName"],
        instrumentId: json["InstrumentId"] == null ? "" : json["InstrumentId"],
        instrumentName:
            json["InstrumentName"] == null ? "" : json["InstrumentName"],
        itemId: json["ItemId"] == null ? "" : json["ItemId"],
        itemName: json["ItemName"] == null ? "" : json["ItemName"],
      );

  Map<String, dynamic> toJson() => {
        "No": no == null ? "" : no,
        "GroupId": groupId == null ? "" : groupId,
        "GroupName": groupName == null ? "" : groupName,
        "SampleTypeId": sampleTypeId == null ? "" : sampleTypeId,
        "SampleTypeName": sampleTypeName == null ? "" : sampleTypeName,
        "InstrumentId": instrumentId == null ? "" : instrumentId,
        "InstrumentName": instrumentName == null ? "" : instrumentName,
        "ItemId": itemId == null ? "" : itemId,
        "ItemName": itemName == null ? "" : itemName,
      };
}

List<ModelTableWaitList> modelTableWaitListFromJson(String str) =>
    List<ModelTableWaitList>.from(
        json.decode(str).map((x) => ModelTableWaitList.fromJson(x)));

String modelTableWaitListToJson(List<ModelTableWaitList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTableWaitList {
  ModelTableWaitList(
      {this.sampleCode,
      this.jobType,
      this.branch,
      this.instrumentName,
      this.itemNo,
      this.itemName,
      this.sampleType,
      this.sampleName,
      this.sampleAmount,
      this.receiveDate,
      this.analysisDueDate,
      this.itemStatus,
      this.errorName,
      this.samplingDate,
      this.custShort});

  dynamic sampleCode;
  dynamic jobType;
  dynamic branch;
  dynamic instrumentName;
  dynamic itemNo;
  dynamic itemName;
  dynamic sampleType;
  dynamic sampleName;
  dynamic sampleAmount;
  dynamic receiveDate;
  dynamic analysisDueDate;
  dynamic selected;
  dynamic itemStatus;
  dynamic errorName;
  dynamic samplingDate;
  dynamic custShort;

  factory ModelTableWaitList.fromJson(Map<String, dynamic> json) =>
      ModelTableWaitList(
        sampleCode: json["SampleCode"] ?? "",
        jobType: json["JobType"] ?? "",
        branch: json["Branch"] ?? "",
        instrumentName: json["InstrumentName"] ?? "",
        itemNo: json["ItemNo"] ?? "",
        itemName: json["ItemName"] ?? "",
        sampleType: json["SampleType"] ?? "",
        sampleName: json["SampleName"] ?? "",
        sampleAmount: json["SampleAmount"] ?? "",
        receiveDate: json["ReceiveDate"] ?? "",
        analysisDueDate: json["AnalysisDueDate"] ?? "",
        itemStatus: json["ItemStatus"] ?? "",
        errorName: json["ErrorName"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        custShort: json["CustShort"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "SampleCode": sampleCode == null ? "" : sampleCode,
        "JobType": jobType == null ? "" : jobType,
        "Branch": branch == null ? "" : branch,
        "InstrumentName": instrumentName == null ? "" : instrumentName,
        "ItemNo": itemNo == null ? "" : itemNo,
        "ItemName": itemName == null ? "" : itemName,
        "SampleType": sampleType == null ? "" : sampleType,
        "SampleName": sampleName == null ? "" : sampleName,
        "SampleAmount": sampleAmount == null ? "" : sampleAmount,
        "ReceiveDate": receiveDate == null ? "" : receiveDate,
        "AnalysisDueDate": analysisDueDate == null ? "" : analysisDueDate,
        "ItemStatus": itemStatus ?? "",
        "ErrorName": errorName ?? "",
        "SamplingDate": samplingDate == null ? "" : samplingDate,
        "custShort": custShort == null ? "" : custShort,
      };
}

List<ModelTableListJob> modelTableListJobFromJson(String str) =>
    List<ModelTableListJob>.from(
        json.decode(str).map((x) => ModelTableListJob.fromJson(x)));

String modelTableListJobToJson(List<ModelTableListJob> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTableListJob {
  ModelTableListJob({
    this.itemId,
    this.itemNo,
    this.itemName,
    this.itemStatus,
    this.sampleCode,
    this.jobType,
    this.custFull,
    this.samplingDate,
    this.sampleGroup,
    this.sampleType,
    this.sampleTank,
    this.sampleName,
    this.position,
    this.mag,
    this.temp,
    this.stdFactor,
    this.stdMax,
    this.stdMin,
    this.receiveDate,
    this.analysisDueDate,
    this.sampleRemark,
    this.selected,
    this.sampleAmount,
    this.errorName,
    this.errorStatus,
    this.custShort,
  });

  dynamic itemId;
  dynamic itemNo;
  dynamic itemName;
  dynamic itemStatus;
  dynamic sampleCode;
  dynamic jobType;
  dynamic custFull;
  dynamic samplingDate;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic position;
  dynamic mag;
  dynamic temp;
  dynamic stdFactor;
  dynamic stdMax;
  dynamic stdMin;
  dynamic receiveDate;
  dynamic analysisDueDate;
  dynamic sampleRemark;
  dynamic selected;
  dynamic sampleAmount;
  dynamic errorName;
  dynamic errorStatus;
  dynamic custShort;

  factory ModelTableListJob.fromJson(Map<String, dynamic> json) =>
      ModelTableListJob(
        itemId: json["Item_ID"] ?? "",
        itemNo: json["ItemNo"] ?? "",
        itemName: json["ItemName"] ?? "",
        itemStatus: json["ItemStatus"] ?? "",
        sampleCode: json["SampleCode"] ?? "",
        jobType: json["JobType"] ?? "",
        custFull: json["CustFull"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        sampleGroup: json["SampleGroup"] ?? "",
        sampleType: json["SampleType"] ?? "",
        sampleTank: json["SampleTank"] ?? "",
        sampleName: json["SampleName"] ?? "",
        position: json["Position"] ?? "",
        mag: json["Mag"] ?? "",
        temp: json["Temp"] ?? "",
        stdFactor: json["StdFactor"] ?? "",
        stdMax: json["StdMax"] ?? "",
        stdMin: json["StdMin"] ?? "",
        receiveDate: json["ReceiveDate"] ?? "",
        analysisDueDate: json["AnalysisDueDate"] ?? "",
        sampleRemark: json["SampleRemark"] ?? "",
        selected: json["Selected"] ?? "",
        sampleAmount: json["SampleAmount"] ?? "",
        errorName: json["ErrorName"] ?? "",
        errorStatus: json["ErrorStatus"] ?? "",
        custShort: json["CustShort"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Item_ID": itemId == null ? "" : itemId,
        "ItemNo": itemNo == null ? "" : itemNo,
        "ItemName": itemName == null ? "" : itemName,
        "ItemStatus": itemStatus == null ? "" : itemStatus,
        "SampleCode": sampleCode == null ? "" : sampleCode,
        "JobType": jobType == null ? "" : jobType,
        "CustFull": custFull == null ? "" : custFull,
        "SamplingDate": samplingDate == null ? "" : samplingDate,
        "SampleGroup": sampleGroup == null ? "" : sampleGroup,
        "SampleType": sampleType == null ? "" : sampleType,
        "SampleTank": sampleTank == null ? "" : sampleTank,
        "SampleName": sampleName == null ? "" : sampleName,
        "Position": position == null ? "" : position,
        "Mag": mag == null ? "" : mag,
        "Temp": temp == null ? "" : temp,
        "StdFactor": stdFactor == null ? "" : stdFactor,
        "StdMax": stdMax == null ? "" : stdMax,
        "StdMin": stdMin == null ? "" : stdMin,
        "ReceiveDate": receiveDate == null ? "" : receiveDate,
        "AnalysisDueDate": analysisDueDate == null ? "" : analysisDueDate,
        "SampleRemark": sampleRemark == null ? "" : sampleRemark,
        "Selected": selected == null ? "" : selected,
        "SampleAmount": sampleAmount ?? "",
        "ErrorName": errorName ?? "",
        "ErrorStatus": errorStatus ?? "",
        "CustShort": custShort ?? "",
      };
}

List<SearchItemModel> searchItemModelFromJson(String str) =>
    List<SearchItemModel>.from(
        json.decode(str).map((x) => SearchItemModel.fromJson(x)));

String searchItemModelToJson(List<SearchItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchItemModel {
  SearchItemModel({
    this.instrumentName = "",
    this.bangpoo = true,
    this.rayong = true,
  });

  dynamic instrumentName;
  dynamic bangpoo;
  dynamic rayong;

  factory SearchItemModel.fromJson(Map<String, dynamic> json) =>
      SearchItemModel(
        instrumentName: json["InstrumentName"] ?? "",
        bangpoo: json["Bangpoo"] ?? "",
        rayong: json["Rayong"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "InstrumentName": instrumentName ?? "",
        "Bangpoo": bangpoo ?? "",
        "Rayong": rayong ?? "",
      };
}
