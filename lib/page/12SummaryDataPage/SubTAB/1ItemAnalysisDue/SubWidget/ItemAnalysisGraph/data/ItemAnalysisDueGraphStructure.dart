import 'dart:convert';

List<ModelItemAnalysisDueGrpah> modelItemAnalysisDueGrpahFromJson(String str) =>
    List<ModelItemAnalysisDueGrpah>.from(
        json.decode(str).map((x) => ModelItemAnalysisDueGrpah.fromJson(x)));

String modelItemAnalysisDueGrpahToJson(List<ModelItemAnalysisDueGrpah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelItemAnalysisDueGrpah {
  ModelItemAnalysisDueGrpah({
    this.analysisDuedate = "",
    this.countReceive = "",
    this.countWaitAnalysis = "",
    this.countWaitRecheck = "",
    this.countWaitReconfirm = "",
    this.countWaitApprove = "",
    this.countApprove = "",
  });

  dynamic analysisDuedate;
  dynamic countReceive;
  dynamic countWaitAnalysis;
  dynamic countWaitRecheck;
  dynamic countWaitReconfirm;
  dynamic countWaitApprove;
  dynamic countApprove;

  factory ModelItemAnalysisDueGrpah.fromJson(Map<String, dynamic> json) =>
      ModelItemAnalysisDueGrpah(
        analysisDuedate: json["AnalysisDuedate"] ?? "",
        countReceive: json["CountReceive"] ?? "",
        countWaitAnalysis: json["CountWaitAnalysis"] ?? "",
        countWaitApprove: json["CountWaitApprove"] ?? "",
        countApprove: json["CountApprove"] ?? "",
        countWaitRecheck: json["CountWaitRecheck"] ?? "",
        countWaitReconfirm: json["CountWaitReconfirm"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "AnalysisDuedate": analysisDuedate ?? "",
        "CountReceive": countReceive ?? "",
        "CountWaitAnalysis": countWaitAnalysis ?? "",
        "CountWaitApprove": countWaitApprove ?? "",
        "CountApprove": countApprove ?? "",
        "CountWaitRecheck": countWaitRecheck ?? "",
        "CountWaitReconfirm": countWaitReconfirm ?? "",
      };
}
