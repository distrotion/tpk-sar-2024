import 'dart:convert';

List<ModelTableSampleApprove> modelTableSampleApproveFromJson(String str) =>
    List<ModelTableSampleApprove>.from(
        json.decode(str).map((x) => ModelTableSampleApprove.fromJson(x)));

String modelTableSampleApproveToJson(List<ModelTableSampleApprove> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTableSampleApprove {
  ModelTableSampleApprove({
    this.id,
    this.reqNo,
    this.jobType,
    this.branch,
    this.custFull,
    this.incharge,
    this.sampleNo,
    this.sampleCode,
    this.samplingDate,
    this.sampleStatus,
    this.itemStatus,
    this.userReceive,
    this.receiveDate,
    this.analysisDueDate,
    this.position,
    this.mag,
    this.temp,
    this.stdFactor,
    this.stdMax,
    this.stdMin,
    this.userListAnalysis,
  });

  dynamic id;
  dynamic reqNo;
  dynamic jobType;
  dynamic branch;
  dynamic custFull;
  dynamic incharge;
  dynamic sampleNo;
  dynamic sampleCode;
  dynamic samplingDate;
  dynamic sampleStatus;
  dynamic itemStatus;
  dynamic userReceive;
  dynamic receiveDate;
  dynamic analysisDueDate;
  dynamic position;
  dynamic mag;
  dynamic temp;
  dynamic stdFactor;
  dynamic stdMax;
  dynamic stdMin;
  dynamic userListAnalysis;
  dynamic selected;

  factory ModelTableSampleApprove.fromJson(Map<String, dynamic> json) =>
      ModelTableSampleApprove(
        id: json["ID"] ?? "",
        reqNo: json["ReqNo"] ?? "",
        jobType: json["JobType"] ?? "",
        branch: json["Branch"] ?? "",
        custFull: json["CustFull"] ?? "",
        incharge: json["Incharge"] ?? "",
        sampleNo: json["SampleNo"] ?? "",
        sampleCode: json["SampleCode"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        sampleStatus: json["SampleStatus"] ?? "",
        itemStatus: json["ItemStatus"] ?? "",
        userReceive: json["UserReceive"] ?? "",
        receiveDate: json["ReceiveDate"] ?? "",
        analysisDueDate: json["AnalysisDueDate"] ?? "",
        position: json["Position"] ?? "",
        mag: json["Mag"] ?? "",
        temp: json["Temp"] ?? "",
        stdFactor: json["StdFactor"] ?? "",
        stdMax: json["StdMax"] ?? "",
        stdMin: json["StdMin"] ?? "",
        userListAnalysis: json["UserListAnalysis"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "ReqNo": reqNo == null ? null : reqNo,
        "JobType": jobType == null ? null : jobType,
        "Branch": branch == null ? null : branch,
        "CustFull": custFull == null ? null : custFull,
        "Incharge": incharge == null ? null : incharge,
        "SampleNo": sampleNo == null ? null : sampleNo,
        "SampleCode": sampleCode == null ? null : sampleCode,
        "SamplingDate": samplingDate == null ? null : samplingDate,
        "SampleStatus": sampleStatus == null ? null : sampleStatus,
        "ItemStatus": itemStatus == null ? null : itemStatus,
        "UserReceive": userReceive == null ? null : userReceive,
        "ReceiveDate": receiveDate == null ? null : receiveDate,
        "AnalysisDueDate": analysisDueDate == null ? null : analysisDueDate,
        "Position": position == null ? null : position,
        "Mag": mag == null ? null : mag,
        "Temp": temp == null ? null : temp,
        "StdFactor": stdFactor == null ? null : stdFactor,
        "StdMax": stdMax == null ? null : stdMax,
        "StdMin": stdMin == null ? null : stdMin,
        "UserListAnalysis": userListAnalysis == null ? null : userListAnalysis,
      };
}

List<SearchApproveModel> searchAnalysisModelFromJson(String str) =>
    List<SearchApproveModel>.from(
        json.decode(str).map((x) => SearchApproveModel.fromJson(x)));

String searchAnalysisModelToJson(List<SearchApproveModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchApproveModel {
  SearchApproveModel({
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
  });

  dynamic requestNo;
  dynamic customerName;
  dynamic incharge;

  dynamic type;
  dynamic enableReceiveDate;
  dynamic receiveDateS;
  dynamic receiveDateE;
  dynamic enableSamplingDate;
  dynamic samplingDateS;
  dynamic samplingDateE;
  dynamic enableDueDate;
  dynamic dueDateS;
  dynamic dueDateE;
  dynamic enableApproveDate;
  dynamic approveDateS;
  dynamic approveDateE;
  dynamic bangpoo;
  dynamic rayong;

  factory SearchApproveModel.fromJson(Map<String, dynamic> json) =>
      SearchApproveModel(
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
