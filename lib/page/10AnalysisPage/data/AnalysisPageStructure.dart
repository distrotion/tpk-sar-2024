import 'dart:convert';

import 'package:intl/intl.dart';

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
    this.instrument,
    this.itemId,
    this.itemName,
  });

  dynamic no;
  dynamic groupId;
  dynamic groupName;
  dynamic sampleTypeId;
  dynamic sampleTypeName;
  dynamic instrumentId;
  dynamic instrument;
  dynamic itemId;
  dynamic itemName;

  factory MasterInstrument.fromJson(Map<String, dynamic> json) =>
      MasterInstrument(
        no: json["No"] == null ? null : json["No"],
        groupId: json["GroupId"] == null ? null : json["GroupId"],
        groupName: json["GroupName"] == null ? null : json["GroupName"],
        sampleTypeId:
            json["SampleTypeId"] == null ? null : json["SampleTypeId"],
        sampleTypeName:
            json["SampleTypeName"] == null ? null : json["SampleTypeName"],
        instrumentId:
            json["InstrumentId"] == null ? null : json["InstrumentId"],
        instrument: json["Instrument"] == null ? null : json["Instrument"],
        itemId: json["ItemId"] == null ? null : json["ItemId"],
        itemName: json["ItemName"] == null ? null : json["ItemName"],
      );

  Map<String, dynamic> toJson() => {
        "No": no == null ? null : no,
        "GroupId": groupId == null ? null : groupId,
        "GroupName": groupName == null ? null : groupName,
        "SampleTypeId": sampleTypeId == null ? null : sampleTypeId,
        "SampleTypeName": sampleTypeName == null ? null : sampleTypeName,
        "InstrumentId": instrumentId == null ? null : instrumentId,
        "Instrument": instrument == null ? null : instrument,
        "ItemId": itemId == null ? null : itemId,
        "ItemName": itemName == null ? null : itemName,
      };
}

List<SearchItemModel> searchItemModelFromJson(String str) =>
    List<SearchItemModel>.from(
        json.decode(str).map((x) => SearchItemModel.fromJson(x)));

String searchItemModelToJson(List<SearchItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchItemModel {
  SearchItemModel({
    this.sampleCode = "",
    this.remarkNo = "",
    this.instrumentName = "",
    this.list = true,
    this.finish = true,
  });

  dynamic sampleCode;
  dynamic remarkNo;
  dynamic instrumentName;
  dynamic list;
  dynamic finish;

  factory SearchItemModel.fromJson(Map<String, dynamic> json) =>
      SearchItemModel(
        sampleCode: json["SampleCode"] ?? "",
        remarkNo: json["RemarkNo"] ?? "",
        instrumentName: json["InstrumentName"] ?? "",
        list: json["List"] ?? "",
        finish: json["Finish"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "SampleCode": sampleCode ?? "",
        "RemarkNo": remarkNo ?? "",
        "InstrumentName": instrumentName ?? "",
        "List": list ?? "",
        "Finish": finish ?? "",
      };
}
