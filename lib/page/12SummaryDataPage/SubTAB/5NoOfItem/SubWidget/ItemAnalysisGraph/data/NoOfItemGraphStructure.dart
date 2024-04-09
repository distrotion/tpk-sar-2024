import 'dart:convert';


List<ModelNoOfItemGraph> ModelNoOfItemGraphFromJson(String str) =>
    List<ModelNoOfItemGraph>.from(
        json.decode(str).map((x) => ModelNoOfItemGraph.fromJson(x)));

String ModelNoOfItemGraphToJson(List<ModelNoOfItemGraph> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelNoOfItemGraph {
  ModelNoOfItemGraph({
    this.TAW = "",
    this.HONDA = "",
    this.IMCT = "",
    this.BCM = "",
    this.OTHER = "",
    this.countWaitApprove = "",
    this.countApprove = "",
  });

  dynamic TAW;
  dynamic HONDA;
  dynamic IMCT;
  dynamic BCM;
  dynamic OTHER;
  dynamic countWaitApprove;
  dynamic countApprove;

  factory ModelNoOfItemGraph.fromJson(Map<String, dynamic> json) =>
      ModelNoOfItemGraph(
        TAW: json["TAW"] ?? "",
        HONDA: json["HONDA"] ?? "",
        IMCT: json["IMCT"] ?? "",
        countWaitApprove: json["CountWaitApprove"] ?? "",
        countApprove: json["CountApprove"] ?? "",
        BCM: json["BCM"] ?? "",
        OTHER: json["OTHER"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "TAW": TAW ?? "",
        "HONDA": HONDA ?? "",
        "IMCT": IMCT ?? "",
        "CountWaitApprove": countWaitApprove ?? "",
        "CountApprove": countApprove ?? "",
        "BCM": BCM ?? "",
        "OTHER": OTHER ?? "",
      };
}
