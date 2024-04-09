// To parse this JSON data, do
//
//     final historyChartModel = historyChartModelFromJson(jsonString);

import 'dart:convert';

List<HistoryChartModel> historyChartModelFromJson(String str) =>
    List<HistoryChartModel>.from(
        json.decode(str).map((x) => HistoryChartModel.fromJson(x)));

String historyChartModelToJson(List<HistoryChartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryChartModel {
  HistoryChartModel({
    this.id,
    this.custFull,
    this.sampleName,
    this.samplingDate,
    this.stdMax,
    this.stdMin,
    this.resultApprove,
    this.resultApproveUnit,
    this.position,
  });

  dynamic id;
  dynamic custFull;
  dynamic sampleName;
  dynamic samplingDate;
  dynamic stdMax;
  dynamic stdMin;
  dynamic resultApprove;
  dynamic resultApproveUnit;
  dynamic position;

  factory HistoryChartModel.fromJson(Map<String, dynamic> json) =>
      HistoryChartModel(
        id: json["id"] ?? "",
        custFull: json["CustFull"] ?? "",
        sampleName: json["SampleName"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        stdMax: json["StdMax"] ?? "0",
        stdMin: json["StdMin"] ?? "0",
        resultApprove: json["ResultApprove"] ?? "",
        resultApproveUnit: json["ResultApproveUnit"] ?? "",
        position: json["Position"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "CustFull": custFull ?? "",
        "SampleName": sampleName ?? "",
        "SamplingDate": samplingDate ?? "",
        "StdMax": stdMax ?? "",
        "StdMin": stdMin ?? "",
        "ResultApprove": resultApprove ?? "",
        "ResultApproveUnit": resultApproveUnit ?? "",
        "Position": position ?? "",
      };
}
