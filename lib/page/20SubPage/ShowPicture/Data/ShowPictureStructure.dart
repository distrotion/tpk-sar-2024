// To parse this JSON data, do
//
//     final historyChartModel = historyChartModelFromJson(jsonString);

import 'dart:convert';

List<HistoryChartModel> historyChartModelFromJson(String str) => List<HistoryChartModel>.from(json.decode(str).map((x) => HistoryChartModel.fromJson(x)));

String historyChartModelToJson(List<HistoryChartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryChartModel {
    HistoryChartModel({
        this.id,
        this.samplingDate,
        this.stdMax,
        this.stdMin,
        this.resultApprove,
        this.resultApproveUnit,
    });

    dynamic id;
    dynamic samplingDate;
    dynamic stdMax;
    dynamic stdMin;
    dynamic resultApprove;
    dynamic resultApproveUnit;

    factory HistoryChartModel.fromJson(Map<String, dynamic> json) => HistoryChartModel(
        id: json["id"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        stdMax: json["StdMax"] ?? "0",
        stdMin: json["StdMin"] ?? "0",
        resultApprove: json["ResultApprove"] ?? "",
        resultApproveUnit: json["ResultApproveUnit"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "SamplingDate": samplingDate ?? "",
        "StdMax": stdMax ?? "",
        "StdMin": stdMin ?? "",        "ResultApprove": resultApprove ?? "",
        "ResultApproveUnit": resultApproveUnit ?? "",
    };
}
