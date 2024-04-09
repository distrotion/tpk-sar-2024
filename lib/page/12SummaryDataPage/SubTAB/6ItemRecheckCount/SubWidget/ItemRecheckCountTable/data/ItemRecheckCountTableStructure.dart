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

List<SearchItemRecheckModel> SearchItemRecheckModelFromJson(String str) =>
    List<SearchItemRecheckModel>.from(
        json.decode(str).map((x) => SearchItemRecheckModel.fromJson(x)));

String SearchItemRecheckModelToJson(List<SearchItemRecheckModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchItemRecheckModel {
  SearchItemRecheckModel({
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

  factory SearchItemRecheckModel.fromJson(Map<String, dynamic> json) =>
      SearchItemRecheckModel(
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

List<ItemRecheckCountModel> ItemRecheckCountModelFromJson(String str) =>
    List<ItemRecheckCountModel>.from(
        json.decode(str).map((x) => ItemRecheckCountModel.fromJson(x)));

String ItemRecheckCountModelToJson(List<MasterCustomerRoutine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemRecheckCountModel {
  ItemRecheckCountModel({
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
    this.mKTCount,
    this.mKTOverDueCount,
    this.cHECount,
    this.cHEOverDueCount,
    this.eNVCount,
    this.eNVOverDueCount,
    this.pHOCount,
    this.pHOOverDueCount,
    this.branch,
    this.gASCount,
    this.gASOverDueCount,
    this.iSNCount,
    this.iSNOverDueCount,
    this.kANCount,
    this.kANOverDueCount,
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
  dynamic mKTCount;
  dynamic mKTOverDueCount;
  dynamic cHECount;
  dynamic cHEOverDueCount;
  dynamic eNVCount;
  dynamic eNVOverDueCount;
  dynamic pHOCount;
  dynamic pHOOverDueCount;
  dynamic branch;
  dynamic gASCount;
  dynamic gASOverDueCount;
  dynamic iSNCount;
  dynamic iSNOverDueCount;
  dynamic kANCount;
  dynamic kANOverDueCount;

  factory ItemRecheckCountModel.fromJson(Map<String, dynamic> json) =>
      ItemRecheckCountModel(
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
        mKTCount: json["mKTCount"] ?? "",
        mKTOverDueCount: json["mKTOverDueCount"] ?? "",
        cHECount: json["cHECount"] ?? "",
        cHEOverDueCount: json["cHEOverDueCount"] ?? "",
        eNVCount: json["eNVCount"] ?? "",
        eNVOverDueCount: json["eNVOverDueCount"] ?? "",
        pHOCount: json["pHOCount"] ?? "",
        pHOOverDueCount: json["pHOOverDueCount"] ?? "",
        branch: json["branch"] ?? "",
        gASCount: json["gASCount"] ?? "",
        gASOverDueCount: json["gASOverDueCount"] ?? "",
        iSNCount: json["iSNCount"] ?? "",
        iSNOverDueCount: json["iSNOverDueCount"] ?? "",
        kANCount: json["kANCount"] ?? "",
        kANOverDueCount: json["kANOverDueCount"] ?? "",
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
        "mKTCount": mKTCount ?? "",
        "mKTOverDueCount": mKTOverDueCount ?? "",
        "cHECount": cHECount ?? "",
        "cHEOverDueCount": cHEOverDueCount ?? "",
        "eNVCount": eNVCount ?? "",
        "eNVOverDueCount": eNVOverDueCount ?? "",
        "pHOCount": pHOCount ?? "",
        "pHOOverDueCount": pHOOverDueCount ?? "",
        "branch": branch ?? "",
        "gASCount": gASCount ?? "",
        "gASOverDueCount": gASOverDueCount ?? "",
        "iSNCount": iSNCount ?? "",
        "iSNOverDueCount": iSNOverDueCount ?? "",
        "kANCount": kANCount ?? "",
        "kANOverDueCount": kANOverDueCount ?? "",
      };
}
