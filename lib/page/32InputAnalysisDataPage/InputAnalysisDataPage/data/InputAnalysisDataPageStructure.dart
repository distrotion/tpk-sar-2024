import 'dart:convert';

List<SearchAnalysisModel> searchAnalysisModelFromJson(String str) =>
    List<SearchAnalysisModel>.from(
        json.decode(str).map((x) => SearchAnalysisModel.fromJson(x)));

String searchAnalysisModelToJson(List<SearchAnalysisModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchAnalysisModel {
  SearchAnalysisModel({
    this.sampleCode = "",
    this.remarkNo = "",
    this.list = true,
    this.finish = true,
  });

  dynamic sampleCode;
  dynamic remarkNo;
  dynamic list;
  dynamic finish;

  factory SearchAnalysisModel.fromJson(Map<String, dynamic> json) =>
      SearchAnalysisModel(
        sampleCode: json["SampleCode"] ?? "",
        remarkNo: json["RemarkNo"] ?? "",
        list: json["List"] ?? "",
        finish: json["Finish"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "SampleCode": sampleCode ?? "",
        "RemarkNo": remarkNo ?? "",
        "List": list ?? "",
        "Finish": finish ?? "",
      };
}
