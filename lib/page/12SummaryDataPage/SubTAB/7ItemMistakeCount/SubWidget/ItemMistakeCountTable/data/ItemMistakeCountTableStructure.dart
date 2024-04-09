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
        no: json["No"] ?? "",
        groupId: json["GroupId"] ?? "",
        groupName: json["GroupName"] ?? "",
        sampleTypeId: json["SampleTypeId"] ?? "",
        sampleTypeName: json["SampleTypeName"] ?? "",
        instrumentId: json["InstrumentId"] ?? "",
        instrumentName: json["InstrumentName"] ?? "",
        itemId: json["ItemId"] ?? "",
        itemName: json["ItemName"] ?? "",
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
      };
}

List<SearchItemMistakeModel> SearchItemMistakeModelFromJson(String str) =>
    List<SearchItemMistakeModel>.from(
        json.decode(str).map((x) => SearchItemMistakeModel.fromJson(x)));

String SearchItemMistakeModelToJson(List<SearchItemMistakeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchItemMistakeModel {
  SearchItemMistakeModel({
    this.requestNo = "",
    this.customerName = "",
    this.incharge = "",
    this.enableReceiveDate = false,
    this.receiveDateS = "",
    this.receiveDateE = "",
    this.enableDueDate = false,
    this.dueDateS = "",
    this.dueDateE = "",
    this.bangpoo = true,
    this.rayong = true,
    this.requestStatus = "",
    this.instrumentName = "",
    this.month = "",
    this.year = "",
  });

  dynamic requestNo;
  dynamic customerName;
  dynamic incharge;
  dynamic enableReceiveDate;
  dynamic receiveDateS;
  dynamic receiveDateE;
  dynamic enableDueDate;
  dynamic dueDateS;
  dynamic dueDateE;
  dynamic bangpoo;
  dynamic rayong;
  dynamic requestStatus;
  dynamic instrumentName;
  dynamic month;
  dynamic year;

  factory SearchItemMistakeModel.fromJson(Map<String, dynamic> json) =>
      SearchItemMistakeModel(
        requestNo: json["RequestNo"] ?? "",
        customerName: json["CustomerName"] ?? "",
        incharge: json["Incharge"] ?? "",
        enableReceiveDate: json["EnableReceiveDate"] ?? "",
        receiveDateS: json["ReceiveDateS"] ?? "",
        receiveDateE: json["ReceiveDateE"] ?? "",
        enableDueDate: json["EnableDueDate"] ?? "",
        dueDateS: json["DueDateS"] ?? "",
        dueDateE: json["DueDateE"] ?? "",
        bangpoo: json["Bangpoo"] ?? "",
        rayong: json["Rayong"] ?? "",
        requestStatus: json["RequestStatus"] ?? "",
        instrumentName: json["InstrumentName"] ?? "",
        month: json["Month"] ?? "",
        year: json["Year"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "RequestNo": requestNo ?? "",
        "CustomerName": customerName ?? "",
        "Incharge": incharge ?? "",
        "EnableReceiveDate": enableReceiveDate ?? "",
        "ReceiveDateS": receiveDateS ?? "",
        "ReceiveDateE": receiveDateE ?? "",
        "EnableDueDate": enableDueDate ?? "",
        "DueDateS": dueDateS ?? "",
        "DueDateE": dueDateE ?? "",
        "Bangpoo": bangpoo ?? "",
        "Rayong": rayong ?? "",
        "RequestStatus": requestStatus ?? "",
        "InstrumentName": instrumentName ?? "",
        "Month": month ?? "",
        "Year": year ?? "",
      };
}

List<MasterCustomerRoutine> masterCustomerRoutineFromJson(String str) =>
    List<MasterCustomerRoutine>.from(
        json.decode(str).map((x) => MasterCustomerRoutine.fromJson(x)));

String masterCustomerRoutineToJson(List<MasterCustomerRoutine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MasterCustomerRoutine {
  MasterCustomerRoutine({
    this.custFull,
    this.custShort,
    this.custSearch,
  });

  dynamic custFull;
  dynamic custShort;
  dynamic custSearch;

  factory MasterCustomerRoutine.fromJson(Map<String, dynamic> json) =>
      MasterCustomerRoutine(
        custFull: json["CustFull"] ?? "",
        custShort: json["CustShort"] ?? "",
        custSearch: json["CustSearch"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "CustFull": custFull ?? "",
        "CustShort": custShort ?? "",
        "CustSearch": custSearch ?? "",
      };
}

List<ItemMistakeCountModel> ItemMistakeCountModelFromJson(String str) =>
    List<ItemMistakeCountModel>.from(
        json.decode(str).map((x) => ItemMistakeCountModel.fromJson(x)));

String ItemMistakeCountModelToJson(List<MasterCustomerRoutine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemMistakeCountModel {
  ItemMistakeCountModel({
    this.instrumentName,
    this.custFull,
    this.allCount,
    this.overDueCount,
    this.bPCount,
    this.bPOverDueCount,
    this.rYCount,
    this.rYOverDueCount,
    this.instrumentBD,
    this.instrumentBDCount,
  });
  dynamic instrumentName;
  dynamic custFull;
  dynamic allCount;
  dynamic overDueCount;
  dynamic bPCount;
  dynamic bPOverDueCount;
  dynamic rYCount;
  dynamic rYOverDueCount;
  dynamic instrumentBD;
  dynamic instrumentBDCount;

  factory ItemMistakeCountModel.fromJson(Map<String, dynamic> json) =>
      ItemMistakeCountModel(
        instrumentName: json["instrumentName"] ?? "",
        custFull: json["custFull"] ?? "",
        allCount: json["allCount"] ?? "",
        overDueCount: json["overDueCount"] ?? "",
        bPCount: json["bPCount"] ?? "",
        bPOverDueCount: json["bPOverDueCount"] ?? "",
        rYCount: json["rYCount"] ?? "",
        rYOverDueCount: json["rYOverDueCount"] ?? "",
        instrumentBD: json["instrumentBD"] ?? "",
        instrumentBDCount: json["instrumentBDCount"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "instrumentName": instrumentName ?? "",
        "custFull": custFull ?? "",
        "allCount": allCount ?? "",
        "overDueCount": overDueCount ?? "",
        "bPCount": bPCount ?? "",
        "bPOverDueCount": bPOverDueCount ?? "",
        "rYCount": rYCount ?? "",
        "rYOverDueCount": rYOverDueCount ?? "",
        "instrumentBD": instrumentBD ?? "",
        "instrumentBDCount": instrumentBDCount ?? "",
      };
}
