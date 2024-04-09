/* import 'dart:convert';

List<ModelSummaryRequestData> modelSummaryRequestDataFromJson(String str) =>
    List<ModelSummaryRequestData>.from(
        json.decode(str).map((x) => ModelSummaryRequestData.fromJson(x)));

String modelSummaryRequestDataToJson(List<ModelSummaryRequestData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSummaryRequestData {
  ModelSummaryRequestData({
    this.analysisDuedate = "",
    this.countReceive = "",
    this.countWaitAnalysis = "",
    this.countWaitApprove = false,
    this.countApprove = "",
  });

  dynamic analysisDuedate;
  dynamic countReceive;
  dynamic countWaitAnalysis;
  dynamic countWaitApprove;
  dynamic countApprove;

  factory ModelSummaryRequestData.fromJson(Map<String, dynamic> json) =>
      ModelSummaryRequestData(
        analysisDuedate: json["AnalysisDuedate"] ?? "",
        countReceive: json["CountReceive"] ?? "",
        countWaitAnalysis: json["CountWaitAnalysis"] ?? "",
        countWaitApprove: json["CountWaitApprove"] ?? "",
        countApprove: json["CountApprove"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "AnalysisDuedate": analysisDuedate ?? "",
        "CountReceive": countReceive ?? "",
        "CountWaitAnalysis": countWaitAnalysis ?? "",
        "CountWaitApprove": countWaitApprove ?? "",
        "CountApprove": countApprove ?? "",
      };
}
 */