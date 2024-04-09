import 'dart:convert';

List<ItemToExcel> itemToExcelFromJson(String str) => List<ItemToExcel>.from(
    json.decode(str).map((x) => ItemToExcel.fromJson(x)));

String itemToExcelToJson(List<ItemToExcel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemToExcel {
  ItemToExcel({
    this.instrumentName = "",
    this.BP_R1M_MKT = 0,
    this.BP_R1M_CHE = 0,
    this.BP_R1M_PHO = 0,
    this.BP_R1M_KAN = 0,
    this.BP_R1M_GAS = 0,
    this.BP_R1M_SUM = 0,
    this.BP_R1S_MKT = 0,
    this.BP_R1S_PHO = 0,
    this.BP_R1S_ISN = 0,
    this.BP_R1S_GAS = 0,
    this.BP_R1S_GGW = 0,
    this.BP_R1S_ENV = 0,
    this.BP_R1S_SUM = 0,
    this.BP_R1_SUM = 0,
    this.BP_R2M_MKT = 0,
    this.BP_R2M_CHE = 0,
    this.BP_R2M_PHO = 0,
    this.BP_R2M_KAN = 0,
    this.BP_R2M_GAS = 0,
    this.BP_R2M_SUM = 0,
    this.BP_R2S_MKT = 0,
    this.BP_R2S_PHO = 0,
    this.BP_R2S_ISN = 0,
    this.BP_R2S_GAS = 0,
    this.BP_R2S_GGW = 0,
    this.BP_R2S_ENV = 0,
    this.BP_R2S_SUM = 0,
    this.BP_R2_SUM = 0,
    this.BP_R36M_MKT = 0,
    this.BP_R36M_CHE = 0,
    this.BP_R36M_PHO = 0,
    this.BP_R36M_KAN = 0,
    this.BP_R36M_GAS = 0,
    this.BP_R36M_SUM = 0,
    this.BP_R36S_MKT = 0,
    this.BP_R36S_PHO = 0,
    this.BP_R36S_ISN = 0,
    this.BP_R36S_GAS = 0,
    this.BP_R36S_GGW = 0,
    this.BP_R36S_ENV = 0,
    this.BP_R36S_SUM = 0,
    this.BP_R36_SUM = 0,
    this.BP_R26_SUM = 0,
    this.BP_ALL_SUM = 0,
    this.RY_R1S_MKT = 0,
    this.RY_R1S_CHE = 0,
    this.RY_R1S_PHO = 0,
    this.RY_R1S_KAN = 0,
    this.RY_R1S_GAS = 0,
    this.RY_R1S_SUM = 0,
    this.RY_R1M_MKT = 0,
    this.RY_R1M_PHO = 0,
    this.RY_R1M_ISN = 0,
    this.RY_R1M_GAS = 0,
    this.RY_R1M_GGW = 0,
    this.RY_R1M_ENV = 0,
    this.RY_R1M_SUM = 0,
    this.RY_R1_SUM = 0,
    this.RY_R2S_MKT = 0,
    this.RY_R2S_CHE = 0,
    this.RY_R2S_PHO = 0,
    this.RY_R2S_KAN = 0,
    this.RY_R2S_GAS = 0,
    this.RY_R2S_SUM = 0,
    this.RY_R2M_MKT = 0,
    this.RY_R2M_PHO = 0,
    this.RY_R2M_ISN = 0,
    this.RY_R2M_GAS = 0,
    this.RY_R2M_GGW = 0,
    this.RY_R2M_ENV = 0,
    this.RY_R2M_SUM = 0,
    this.RY_R2_SUM = 0,
    this.RY_R36S_MKT = 0,
    this.RY_R36S_CHE = 0,
    this.RY_R36S_PHO = 0,
    this.RY_R36S_KAN = 0,
    this.RY_R36S_GAS = 0,
    this.RY_R36S_SUM = 0,
    this.RY_R36M_MKT = 0,
    this.RY_R36M_PHO = 0,
    this.RY_R36M_ISN = 0,
    this.RY_R36M_GAS = 0,
    this.RY_R36M_GGW = 0,
    this.RY_R36M_ENV = 0,
    this.RY_R36M_SUM = 0,
    this.RY_R36_SUM = 0,
    this.RY_R26_SUM = 0,
    this.RY_ALL_SUM = 0,
    this.ALL_SUM = 0,
  });

  dynamic instrumentName;
  dynamic BP_R1M_MKT;
  dynamic BP_R1M_CHE;
  dynamic BP_R1M_PHO;
  dynamic BP_R1M_KAN;
  dynamic BP_R1M_GAS;
  dynamic BP_R1M_SUM;
  dynamic BP_R1S_MKT;
  dynamic BP_R1S_PHO;
  dynamic BP_R1S_ISN;
  dynamic BP_R1S_GAS;
  dynamic BP_R1S_GGW;
  dynamic BP_R1S_ENV;
  dynamic BP_R1S_SUM;
  dynamic BP_R1_SUM;
  dynamic BP_R2M_MKT;
  dynamic BP_R2M_CHE;
  dynamic BP_R2M_PHO;
  dynamic BP_R2M_KAN;
  dynamic BP_R2M_GAS;
  dynamic BP_R2M_SUM;
  dynamic BP_R2S_MKT;
  dynamic BP_R2S_PHO;
  dynamic BP_R2S_ISN;
  dynamic BP_R2S_GAS;
  dynamic BP_R2S_GGW;
  dynamic BP_R2S_ENV;
  dynamic BP_R2S_SUM;
  dynamic BP_R2_SUM;
  dynamic BP_R36M_MKT;
  dynamic BP_R36M_CHE;
  dynamic BP_R36M_PHO;
  dynamic BP_R36M_KAN;
  dynamic BP_R36M_GAS;
  dynamic BP_R36M_SUM;
  dynamic BP_R36S_MKT;
  dynamic BP_R36S_PHO;
  dynamic BP_R36S_ISN;
  dynamic BP_R36S_GAS;
  dynamic BP_R36S_GGW;
  dynamic BP_R36S_ENV;
  dynamic BP_R36S_SUM;
  dynamic BP_R36_SUM;
  dynamic BP_R26_SUM;
  dynamic BP_ALL_SUM;
  dynamic RY_R1S_MKT;
  dynamic RY_R1S_CHE;
  dynamic RY_R1S_PHO;
  dynamic RY_R1S_KAN;
  dynamic RY_R1S_GAS;
  dynamic RY_R1S_SUM;
  dynamic RY_R1M_MKT;
  dynamic RY_R1M_PHO;
  dynamic RY_R1M_ISN;
  dynamic RY_R1M_GAS;
  dynamic RY_R1M_GGW;
  dynamic RY_R1M_ENV;
  dynamic RY_R1M_SUM;
  dynamic RY_R1_SUM;
  dynamic RY_R2S_MKT;
  dynamic RY_R2S_CHE;
  dynamic RY_R2S_PHO;
  dynamic RY_R2S_KAN;
  dynamic RY_R2S_GAS;
  dynamic RY_R2S_SUM;
  dynamic RY_R2M_MKT;
  dynamic RY_R2M_PHO;
  dynamic RY_R2M_ISN;
  dynamic RY_R2M_GAS;
  dynamic RY_R2M_GGW;
  dynamic RY_R2M_ENV;
  dynamic RY_R2M_SUM;
  dynamic RY_R2_SUM;
  dynamic RY_R36S_MKT;
  dynamic RY_R36S_CHE;
  dynamic RY_R36S_PHO;
  dynamic RY_R36S_KAN;
  dynamic RY_R36S_GAS;
  dynamic RY_R36S_SUM;
  dynamic RY_R36M_MKT;
  dynamic RY_R36M_PHO;
  dynamic RY_R36M_ISN;
  dynamic RY_R36M_GAS;
  dynamic RY_R36M_GGW;
  dynamic RY_R36M_ENV;
  dynamic RY_R36M_SUM;
  dynamic RY_R36_SUM;
  dynamic RY_R26_SUM;
  dynamic RY_ALL_SUM;
  dynamic ALL_SUM;

  factory ItemToExcel.fromJson(Map<String, dynamic> json) => ItemToExcel(
        instrumentName: json["instrumentName"] ?? "",
        BP_R1M_MKT: json["BP_R1M_MKT"] ?? 0,
        BP_R1M_CHE: json["BP_R1M_CHE"] ?? 0,
        BP_R1M_PHO: json["BP_R1M_PHO"] ?? 0,
        BP_R1M_KAN: json["BP_R1M_KAN"] ?? 0,
        BP_R1M_GAS: json["BP_R1M_GAS"] ?? 0,
        BP_R1M_SUM: json["BP_R1M_SUM"] ?? 0,
        BP_R1S_MKT: json["BP_R1S_MKT"] ?? 0,
        BP_R1S_PHO: json["BP_R1S_PHO"] ?? 0,
        BP_R1S_ISN: json["BP_R1S_ISN"] ?? 0,
        BP_R1S_GAS: json["BP_R1S_GAS"] ?? 0,
        BP_R1S_GGW: json["BP_R1S_GGW"] ?? 0,
        BP_R1S_ENV: json["BP_R1S_ENV"] ?? 0,
        BP_R1S_SUM: json["BP_R1S_SUM"] ?? 0,
        BP_R1_SUM: json["BP_R1_SUM"] ?? 0,
        BP_R2M_MKT: json["BP_R2M_MKT"] ?? 0,
        BP_R2M_CHE: json["BP_R2M_CHE"] ?? 0,
        BP_R2M_PHO: json["BP_R2M_PHO"] ?? 0,
        BP_R2M_KAN: json["BP_R2M_KAN"] ?? 0,
        BP_R2M_GAS: json["BP_R2M_GAS"] ?? 0,
        BP_R2M_SUM: json["BP_R2M_SUM"] ?? 0,
        BP_R2S_MKT: json["BP_R2S_MKT"] ?? 0,
        BP_R2S_PHO: json["BP_R2S_PHO"] ?? 0,
        BP_R2S_ISN: json["BP_R2S_ISN"] ?? 0,
        BP_R2S_GAS: json["BP_R2S_GAS"] ?? 0,
        BP_R2S_GGW: json["BP_R2S_GGW"] ?? 0,
        BP_R2S_ENV: json["BP_R2S_ENV"] ?? 0,
        BP_R2S_SUM: json["BP_R2S_SUM"] ?? 0,
        BP_R2_SUM: json["BP_R2_SUM"] ?? 0,
        BP_R36M_MKT: json["BP_R36M_MKT"] ?? 0,
        BP_R36M_CHE: json["BP_R36M_CHE"] ?? 0,
        BP_R36M_PHO: json["BP_R36M_PHO"] ?? 0,
        BP_R36M_KAN: json["BP_R36M_KAN"] ?? 0,
        BP_R36M_GAS: json["BP_R36M_GAS"] ?? 0,
        BP_R36M_SUM: json["BP_R36M_SUM"] ?? 0,
        BP_R36S_MKT: json["BP_R36S_MKT"] ?? 0,
        BP_R36S_PHO: json["BP_R36S_PHO"] ?? 0,
        BP_R36S_ISN: json["BP_R36S_ISN"] ?? 0,
        BP_R36S_GAS: json["BP_R36S_GAS"] ?? 0,
        BP_R36S_GGW: json["BP_R36S_GGW"] ?? 0,
        BP_R36S_ENV: json["BP_R36S_ENV"] ?? 0,
        BP_R36S_SUM: json["BP_R36S_SUM"] ?? 0,
        BP_R36_SUM: json["BP_R36_SUM"] ?? 0,
        BP_R26_SUM: json["BP_R26_SUM"] ?? 0,
        BP_ALL_SUM: json["BP_ALL_SUM"] ?? 0,
        RY_R1S_MKT: json["RY_R1S_MKT"] ?? 0,
        RY_R1S_CHE: json["RY_R1S_CHE"] ?? 0,
        RY_R1S_PHO: json["RY_R1S_PHO"] ?? 0,
        RY_R1S_KAN: json["RY_R1S_KAN"] ?? 0,
        RY_R1S_GAS: json["RY_R1S_GAS"] ?? 0,
        RY_R1S_SUM: json["RY_R1S_SUM"] ?? 0,
        RY_R1M_MKT: json["RY_R1M_MKT"] ?? 0,
        RY_R1M_PHO: json["RY_R1M_PHO"] ?? 0,
        RY_R1M_ISN: json["RY_R1M_ISN"] ?? 0,
        RY_R1M_GAS: json["RY_R1M_GAS"] ?? 0,
        RY_R1M_GGW: json["RY_R1M_GGW"] ?? 0,
        RY_R1M_ENV: json["RY_R1M_ENV"] ?? 0,
        RY_R1M_SUM: json["RY_R1M_SUM"] ?? 0,
        RY_R1_SUM: json["RY_R1_SUM"] ?? 0,
        RY_R2S_MKT: json["RY_R2S_MKT"] ?? 0,
        RY_R2S_CHE: json["RY_R2S_CHE"] ?? 0,
        RY_R2S_PHO: json["RY_R2S_PHO"] ?? 0,
        RY_R2S_KAN: json["RY_R2S_KAN"] ?? 0,
        RY_R2S_GAS: json["RY_R2S_GAS"] ?? 0,
        RY_R2S_SUM: json["RY_R2S_SUM"] ?? 0,
        RY_R2M_MKT: json["RY_R2M_MKT"] ?? 0,
        RY_R2M_PHO: json["RY_R2M_PHO"] ?? 0,
        RY_R2M_ISN: json["RY_R2M_ISN"] ?? 0,
        RY_R2M_GAS: json["RY_R2M_GAS"] ?? 0,
        RY_R2M_GGW: json["RY_R2M_GGW"] ?? 0,
        RY_R2M_ENV: json["RY_R2M_ENV"] ?? 0,
        RY_R2M_SUM: json["RY_R2M_SUM"] ?? 0,
        RY_R2_SUM: json["RY_R2_SUM"] ?? 0,
        RY_R36S_MKT: json["RY_R36S_MKT"] ?? 0,
        RY_R36S_CHE: json["RY_R36S_CHE"] ?? 0,
        RY_R36S_PHO: json["RY_R36S_PHO"] ?? 0,
        RY_R36S_KAN: json["RY_R36S_KAN"] ?? 0,
        RY_R36S_GAS: json["RY_R36S_GAS"] ?? 0,
        RY_R36S_SUM: json["RY_R36S_SUM"] ?? 0,
        RY_R36M_MKT: json["RY_R36M_MKT"] ?? 0,
        RY_R36M_PHO: json["RY_R36M_PHO"] ?? 0,
        RY_R36M_ISN: json["RY_R36M_ISN"] ?? 0,
        RY_R36M_GAS: json["RY_R36M_GAS"] ?? 0,
        RY_R36M_GGW: json["RY_R36M_GGW"] ?? 0,
        RY_R36M_ENV: json["RY_R36M_ENV"] ?? 0,
        RY_R36M_SUM: json["RY_R36M_SUM"] ?? 0,
        RY_R36_SUM: json["RY_R36_SUM"] ?? 0,
        RY_R26_SUM: json["RY_R26_SUM"] ?? 0,
        RY_ALL_SUM: json["RY_ALL_SUM"] ?? 0,
        ALL_SUM: json["ALL_SUM"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "instrumentName": instrumentName ?? "",
        "BP_R1M_MKT": BP_R1M_MKT ?? "",
        "BP_R1M_CHE": BP_R1M_CHE ?? "",
        "BP_R1M_PHO": BP_R1M_PHO ?? "",
        "BP_R1M_KAN": BP_R1M_KAN ?? "",
        "BP_R1M_GAS": BP_R1M_GAS ?? "",
        "BP_R1M_SUM": BP_R1M_SUM ?? "",
        "BP_R1S_MKT": BP_R1S_MKT ?? "",
        "BP_R1S_PHO": BP_R1S_PHO ?? "",
        "BP_R1S_ISN": BP_R1S_ISN ?? "",
        "BP_R1S_GAS": BP_R1S_GAS ?? "",
        "BP_R1S_GGW": BP_R1S_GGW ?? "",
        "BP_R1S_ENV": BP_R1S_ENV ?? "",
        "BP_R1S_SUM": BP_R1S_SUM ?? "",
        "BP_R1_SUM": BP_R1_SUM ?? "",
        "BP_R2M_MKT": BP_R2M_MKT ?? "",
        "BP_R2M_CHE": BP_R2M_CHE ?? "",
        "BP_R2M_PHO": BP_R2M_PHO ?? "",
        "BP_R2M_KAN": BP_R2M_KAN ?? "",
        "BP_R2M_GAS": BP_R2M_GAS ?? "",
        "BP_R2M_SUM": BP_R2M_SUM ?? "",
        "BP_R2S_MKT": BP_R2S_MKT ?? "",
        "BP_R2S_PHO": BP_R2S_PHO ?? "",
        "BP_R2S_ISN": BP_R2S_ISN ?? "",
        "BP_R2S_GAS": BP_R2S_GAS ?? "",
        "BP_R2S_GGW": BP_R2S_GGW ?? "",
        "BP_R2S_ENV": BP_R2S_ENV ?? "",
        "BP_R2S_SUM": BP_R2S_SUM ?? "",
        "BP_R2_SUM": BP_R2_SUM ?? "",
        "BP_R36M_MKT": BP_R36M_MKT ?? "",
        "BP_R36M_CHE": BP_R36M_CHE ?? "",
        "BP_R36M_PHO": BP_R36M_PHO ?? "",
        "BP_R36M_KAN": BP_R36M_KAN ?? "",
        "BP_R36M_GAS": BP_R36M_GAS ?? "",
        "BP_R36M_SUM": BP_R36M_SUM ?? "",
        "BP_R36S_MKT": BP_R36S_MKT ?? "",
        "BP_R36S_PHO": BP_R36S_PHO ?? "",
        "BP_R36S_ISN": BP_R36S_ISN ?? "",
        "BP_R36S_GAS": BP_R36S_GAS ?? "",
        "BP_R36S_GGW": BP_R36S_GGW ?? "",
        "BP_R36S_ENV": BP_R36S_ENV ?? "",
        "BP_R36S_SUM": BP_R36S_SUM ?? "",
        "BP_R36_SUM": BP_R36_SUM ?? "",
        "BP_R26_SUM": BP_R26_SUM ?? "",
        "BP_ALL_SUM": BP_ALL_SUM ?? "",
        "RY_R1S_MKT": RY_R1S_MKT ?? "",
        "RY_R1S_CHE": RY_R1S_CHE ?? "",
        "RY_R1S_PHO": RY_R1S_PHO ?? "",
        "RY_R1S_KAN": RY_R1S_KAN ?? "",
        "RY_R1S_GAS": RY_R1S_GAS ?? "",
        "RY_R1S_SUM": RY_R1S_SUM ?? "",
        "RY_R1M_MKT": RY_R1M_MKT ?? "",
        "RY_R1M_PHO": RY_R1M_PHO ?? "",
        "RY_R1M_ISN": RY_R1M_ISN ?? "",
        "RY_R1M_GAS": RY_R1M_GAS ?? "",
        "RY_R1M_GGW": RY_R1M_GGW ?? "",
        "RY_R1M_ENV": RY_R1M_ENV ?? "",
        "RY_R1M_SUM": RY_R1M_SUM ?? "",
        "RY_R1_SUM": RY_R1_SUM ?? "",
        "RY_R2S_MKT": RY_R2S_MKT ?? "",
        "RY_R2S_CHE": RY_R2S_CHE ?? "",
        "RY_R2S_PHO": RY_R2S_PHO ?? "",
        "RY_R2S_KAN": RY_R2S_KAN ?? "",
        "RY_R2S_GAS": RY_R2S_GAS ?? "",
        "RY_R2S_SUM": RY_R2S_SUM ?? "",
        "RY_R2M_MKT": RY_R2M_MKT ?? "",
        "RY_R2M_PHO": RY_R2M_PHO ?? "",
        "RY_R2M_ISN": RY_R2M_ISN ?? "",
        "RY_R2M_GAS": RY_R2M_GAS ?? "",
        "RY_R2M_GGW": RY_R2M_GGW ?? "",
        "RY_R2M_ENV": RY_R2M_ENV ?? "",
        "RY_R2M_SUM": RY_R2M_SUM ?? "",
        "RY_R2_SUM": RY_R2_SUM ?? "",
        "RY_R36S_MKT": RY_R36S_MKT ?? "",
        "RY_R36S_CHE": RY_R36S_CHE ?? "",
        "RY_R36S_PHO": RY_R36S_PHO ?? "",
        "RY_R36S_KAN": RY_R36S_KAN ?? "",
        "RY_R36S_GAS": RY_R36S_GAS ?? "",
        "RY_R36S_SUM": RY_R36S_SUM ?? "",
        "RY_R36M_MKT": RY_R36M_MKT ?? "",
        "RY_R36M_PHO": RY_R36M_PHO ?? "",
        "RY_R36M_ISN": RY_R36M_ISN ?? "",
        "RY_R36M_GAS": RY_R36M_GAS ?? "",
        "RY_R36M_GGW": RY_R36M_GGW ?? "",
        "RY_R36M_ENV": RY_R36M_ENV ?? "",
        "RY_R36M_SUM": RY_R36M_SUM ?? "",
        "RY_R36_SUM": RY_R36_SUM ?? "",
        "RY_R26_SUM": RY_R26_SUM ?? "",
        "RY_ALL_SUM": RY_ALL_SUM ?? "",
        "ALL_SUM": ALL_SUM ?? "",
      };
}
