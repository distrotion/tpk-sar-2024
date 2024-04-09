import 'dart:convert';

List<SearchRequestModel> searchRequestModelFromJson(String str) =>
    List<SearchRequestModel>.from(
        json.decode(str).map((x) => SearchRequestModel.fromJson(x)));

String searchRequestModelToJson(List<SearchRequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchRequestModel {
  SearchRequestModel({
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

  factory SearchRequestModel.fromJson(Map<String, dynamic> json) =>
      SearchRequestModel(
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

List<ModelTableRequetJob> modelTableRequetJobFromJson(String str) =>
    List<ModelTableRequetJob>.from(
        json.decode(str).map((x) => ModelTableRequetJob.fromJson(x)));

String modelTableRequetJobToJson(List<ModelTableRequetJob> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTableRequetJob {
  ModelTableRequetJob({
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
    this.incharge,
    this.samplingDate,
    this.receiveDate,
    this.userReceive,
    this.analysisDueDate,
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
  dynamic incharge;
  dynamic samplingDate;
  dynamic receiveDate;
  dynamic userReceive;
  dynamic analysisDueDate;

  factory ModelTableRequetJob.fromJson(Map<String, dynamic> json) =>
      ModelTableRequetJob(
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
        incharge: json["incharge"] ?? "",
        samplingDate: json["samplingDate"] ?? "",
        receiveDate: json["receiveDate"] ?? "",
        userReceive: json["userReceive"] ?? "",
        analysisDueDate: json["analysisDueDate"] ?? "",
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
        "incharge": incharge,
        "samplingDate": samplingDate,
        "receiveDate": receiveDate,
        "userReceive": userReceive,
        "analysisDueDate": analysisDueDate,
      };
}


/* incharge
samplingDate
receiveDate
userReceive
analysisDueDate

data[j].incharge=dataIn[i].Incharge;
data[j].samplingDate=dataIn[i].SamplingDate;
data[j].receiveDate=dataIn[i].ReceiveDate;
data[j].userReceive=dataIn[i].UserReceive;
data[j].analysisDueDate=dataIn[i].AnalysisDueDate; */