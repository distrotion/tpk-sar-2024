import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/data/KPIItemDataStructure.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';

import '../../2KPIItemCount/SubWidget/KPIItemCountTable/data/KPIItemCountTable_bloc.dart';

//----------------------------------------------------------------

class rowInstrument {
  rowInstrument({
    this.row = 0,
    this.instrumentName = "",
  });
  int row;
  String instrumentName;
}

List<rowInstrument> instrumentOrder = [
  rowInstrument(row: 7, instrumentName: 'XRF'),
  rowInstrument(row: 9, instrumentName: 'XRD'),
  rowInstrument(row: 11, instrumentName: 'SEM'),
  rowInstrument(row: 12, instrumentName: 'Crystal size'),
  rowInstrument(row: 15, instrumentName: 'ICP'),
  rowInstrument(row: 19, instrumentName: 'IC'),
  rowInstrument(row: 24, instrumentName: 'Ti(UV)'),
  rowInstrument(row: 25, instrumentName: 'OCA'),
  rowInstrument(row: 27, instrumentName: 'TOC'),
  rowInstrument(row: 28, instrumentName: 'SSM'),
  rowInstrument(row: 30, instrumentName: 'LECO'),
  rowInstrument(row: 32, instrumentName: 'Cl(AUTO)'),
  rowInstrument(row: 34, instrumentName: 'Cwt'),
  rowInstrument(row: 35, instrumentName: 'Cwt.3 layers'),
  rowInstrument(row: 37, instrumentName: 'S.G(Nox Rust)'),
  rowInstrument(row: 38, instrumentName: 'Flash Point (NOX-RUST)'),
  rowInstrument(row: 39, instrumentName: 'Viscosity(NOX-RUST)'),
  rowInstrument(row: 40, instrumentName: 'Acid Number(Nox Rust)'),
  rowInstrument(row: 41, instrumentName: 'Solid Content(Nox Rust)'),
  rowInstrument(row: 42, instrumentName: 'Moisture(Nox Rust)'),
  rowInstrument(row: 43, instrumentName: 'Density(WAX)'),
  rowInstrument(row: 44, instrumentName: 'Flash Point(WAX)'),
  rowInstrument(row: 45, instrumentName: 'Viscosity(WAX)'),
  rowInstrument(row: 46, instrumentName: '%NV(WAX)'),
  rowInstrument(row: 47, instrumentName: '%NV'),
  rowInstrument(row: 56, instrumentName: 'Surfactant'),
  rowInstrument(row: 57, instrumentName: 'PO43-(Titration)'),
  rowInstrument(row: 69, instrumentName: 'CN-'),
  //rowInstrument(row : ,instrumentName: 'Filter Image'),
  rowInstrument(row: 82, instrumentName: 'Contact angle'),
  rowInstrument(row: 83, instrumentName: '%Brix'),
  rowInstrument(row: 84, instrumentName: 'D-smut'),
  rowInstrument(row: 85, instrumentName: 'L-Value'),
  rowInstrument(row: 86, instrumentName: 'pH'),
  rowInstrument(row: 87, instrumentName: 'EC'),
  rowInstrument(row: 88, instrumentName: 'Sludge'),
  rowInstrument(row: 89, instrumentName: 'F-F'),
  rowInstrument(row: 90, instrumentName: 'Cwt. PULS'),
  //rowInstrument(row : ,instrumentName: '%NV(Nox Rust)'),
  //rowInstrument(row : ,instrumentName: 'CO32-)}
];

List<dynamic> itemCost = [
  "",
  "326",
  "51",
  "",
  "102",
  "",
  "79",
  "46",
  "",
  "",
  "81",
  "",
  "",
  "",
  "154",
  "",
  "",
  "",
  "",
  "141",
  "96",
  "",
  "126",
  "298",
  "",
  "161",
  "",
  "175",
  "",
  "74",
  "218",
  "",
  "71",
  "161",
  "86",
  "141",
  "308",
  "145",
  "230",
  "289",
  "273",
  "149",
  "149",
  "",
  "60",
  "61",
  "",
  "",
  "",
  "",
  "",
  "165",
  "71",
  "",
  "",
  "",
  "",
  "",
  "28",
  "56",
  "370",
  "209",
  "165",
  "130",
  "558",
  "435",
  "203",
  "203",
  "203",
  "203",
  "203",
  "203",
  "203",
  "197",
  "154",
  "",
  "",
  "200",
  "57",
  "85",
  "57",
  "56",
  "78",
  "137",
  "113",
  "74",
  "558",
  "773",
  "137",
  "",
  "187",
  "175",
  "99",
  "99",
  "",
  "",
  "",
  "",
  "",
];
List<String> itemName = [
  "Analyze (XRF)",
  "Qualitative analysis (SoC)",
  "Quantitative analysis (cwt)      ",
  "Analyze (XRD)",
  "Quantitative analysis (P ratio, 020ratio)",
  "Analyze (SEM)",
  "SEM",
  "Crystal size",
  "Analyze (ICP)",
  "Qualitative analysis             ",
  "Quantitative analysis  ",
  "Quantitative analysis in D/G (Digest)",
  "Quantitative analysis in LUBE",
  "Analyze (IC)",
  "Analysis (Total F,Cl, NO3,SO4,PO4,P2O7) ",
  "Analysis (F,Cl, NO3,SO4,PO4) in LUBE",
  "Analyze (CE)",
  "Quantitative analysis NO3-, Br-",
  "Analyze (UV-VIS)",
  "Ti",
  "OCA",
  "Analyze (TOC)",
  "TOC ; Oil content",
  "TC ; SSM",
  "Analyze (LECO)",
  "Carbon content in part",
  "Analyze (AUTO TITRATOR)",
  "Cl Titrate ",
  "Analyze (Cwt.remove)",
  "CWT (Hot,Room)",
  "CWT 3 layer",
  "Nox Rust & Wax",
  "Nox Rust : SG",
  "Nox Rust : Flash point",
  "Nox Rust : Viscosity",
  "Nox Rust : acid number",
  "Nox Rust : Solid Content",
  "Nox Rust : Moisture : Karl Fischer",
  "WAX : SG",
  "WAX : Flash point",
  "WAX : Viscosity",
  "WAX : %NV",
  "%NV : Oven,Nox",
  "Titration",
  "FA",
  "TA",
  "FC",
  "TC",
  "F Al",
  "T Al",
  "Cr6+",
  "Surfactant",
  "Phosphate",
  "Titrate Zr",
  "Titrate Acid",
  "ClO3-",
  "AC",
  "Analyze (WWT)",
  "Temperature",
  "pH (WWT)",
  "BOD",
  "COD",
  "TDS",
  "TSS",
  "Cyanide : UV",
  "Oil & Grease (extraction)",
  "Heavy Metal (Zn)",
  "Heavy Metal (Ni)",
  "Heavy Metal (Mn)",
  "Heavy Metal (Cu)",
  "Heavy Metal (Cr)",
  "Heavy Metal (Pb)",
  "Heavy Metal (Cd)",
  "Total Fluoride (Ion Meter)",
  "Chloride (WWT)",
  "Others",
  "Extraction (Oil from work pieces)",
  "Contact angle",
  "Brix analysis",
  "Color meter De-smut",
  "Color meter L-value",
  "pH check",
  "EC check",
  "Sludge",
  "Free F- : Ion",
  "Cwt. PULS",
  "Cyanide : UV in water rinse",
  "CN in water cooling (ISN Distill&Titrate)",
  "Sludge CO32-",
  "Sample preparation",
  "CUTTING - Discotom",
  "CUTTING - Bandsaw",
  "PAINT REMOVE - Skeleton",
  "PAINT REMOVE - NMP",
  "Test panel",
  "Report",
  "SoC",
  "Overseas (OVS)",
];
List<int> indexItemnameColor = [
  5,
  8,
  10,
  13,
  14,
  18,
  21,
  23,
  26,
  29,
  31,
  33,
  36,
  48,
  62,
  80,
  94,
  99,
  100
];

List<String> plantBP = ["MKT", "CHE", "PHO-BP", "KAN", "GAS-BP"];
List<String> plantESIE1 = [
  "MKT",
  "PHO-RY",
  "ISN-RY",
  "GAS-RY",
  "GAS-GW",
  "ENV-RY"
];

List<String> instrumentName = [
  "",
  "SoC",
  "XRF",
  "",
  "XRD",
  "",
  "SEM",
  "Crystal size",
  "",
  "",
  "ICP",
  "",
  "",
  "",
  "IC",
  "",
  "",
  "",
  "",
  "Ti(UV)",
  "OCA",
  "",
  "TOC",
  "SSM",
  "",
  "LECO",
  "",
  "Cl(AUTO)",
  "",
  "Cwt",
  "Cwt.3 layers",
  "",
  "S.G(Nox Rust)",
  "Flash Point (NOX-RUST)",
  "Viscosity(NOX-RUST)",
  "Acid Number(Nox Rust)",
  "Solid Content(Nox Rust)",
  "Moisture(Nox Rust)",
  "Density(WAX)",
  "Flash Point(WAX)",
  "Viscosity(WAX)",
  "%NV(WAX)",
  "%NV",
  "",
  "F.A.",
  "T.A.",
  "",
  "",
  "",
  "",
  "",
  "Surfactant",
  "PO43-(Titration)",
  "",
  "",
  "",
  "",
  "",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "WWT",
  "",
  "",
  "Contact angle",
  "%Brix",
  "D-smut",
  "L-Value",
  "pH",
  "EC",
  "Sludge",
  "F-F",
  "Cwt. PULS",
  "Cyanide : UV in water rinse",
  "Cyanide : UV in water rinse",
  "Sludge CO32-",
  "",
  "CUTTING - Discotom",
  "CUTTING - Bandsaw",
  "PAINT REMOVE - Skeleton",
  "PAINT REMOVE - NMP",
  "",
  "",
  "Report SoC",
  "Report OVS",
  "Total",
];

List<String> indexColumnStr = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "AA",
  "AB",
  "AC",
  "AD",
  "AE",
  "AF",
  "AG",
  "AH",
  "AI",
  "AJ",
  "AK",
  "AL",
  "AM",
  "AN",
  "AO",
  "AP",
  "AQ",
  "AR",
  "AS",
  "AT",
  "AU",
  "AV",
  "AW",
  "AX",
  "AY",
  "AZ",
  "BA",
  "BB",
  "BC",
  "BD",
  "BE",
  "BF",
  "BG",
  "BH",
  "BI",
  "BJ",
  "BK",
  "BL",
  "BM",
  "BN",
  "BO",
  "BP",
  "BQ",
  "BR",
  "BS",
  "BT",
  "BU",
  "BV",
  "BW",
  "BX",
  "BY",
  "BZ",
  "CA",
  "CB",
  "CC",
  "CD",
  "CE",
  "CF",
  "CG",
  "CH",
  "CI",
  "CJ",
  "CK",
  "CL",
  "CM",
  "CN",
  "CO",
  "CP",
  "CQ",
  "CR",
  "CS",
  "CT",
  "CU",
  "CV",
  "CW",
  "CX",
  "CY",
  "CZ",
];

List rowWOData = [
  5,
  8,
  10,
  13,
  14,
  18,
  21,
  23,
  26,
  29,
  31,
  33,
  36,
  48,
  62,
  80,
  81,
  94,
  99,
  100
];

List<List<dynamic>> dataItemToExcel = [[]];
Future getDataCreateExcel() async {
  Map<String, String> qParams = {
    'SearchOption': jsonEncode(searchOption),
  };
  print('in getDataCreateExcel');
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(
            Uri.parse("$urlE/SummaryDataPage/KPIItemCount_getDataCreateExcel"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      List<ItemToExcel> buffData = [];
      buffData = itemToExcelFromJson(response.body);
      for (var i = 0; i < 50; i++) {
        dataItemToExcel.add([]);
        for (var j = 0; j < 90; j++) {
          dataItemToExcel[i].add([]);
        }
      }
      //SUM DATA
      for (int i = 0; i < buffData.length; i++) {
        //BP
        //R1
        buffData[i].BP_R1M_SUM = buffData[i].BP_R1M_MKT +
            buffData[i].BP_R1M_CHE +
            buffData[i].BP_R1M_PHO +
            buffData[i].BP_R1M_KAN +
            buffData[i].BP_R1M_GAS;
        buffData[i].BP_R1S_SUM = buffData[i].BP_R1S_MKT +
            buffData[i].BP_R1S_PHO +
            buffData[i].BP_R1S_ISN +
            buffData[i].BP_R1S_GAS +
            buffData[i].BP_R1S_GGW +
            buffData[i].BP_R1S_ENV;
        buffData[i].BP_R1_SUM = buffData[i].BP_R1M_SUM + buffData[i].BP_R1S_SUM;
        //R2
        buffData[i].BP_R2M_SUM = buffData[i].BP_R2M_MKT +
            buffData[i].BP_R2M_CHE +
            buffData[i].BP_R2M_PHO +
            buffData[i].BP_R2M_KAN +
            buffData[i].BP_R2M_GAS;
        buffData[i].BP_R2S_SUM = buffData[i].BP_R2S_MKT +
            buffData[i].BP_R2S_PHO +
            buffData[i].BP_R2S_ISN +
            buffData[i].BP_R2S_GAS +
            buffData[i].BP_R2S_GGW +
            buffData[i].BP_R2S_ENV;
        buffData[i].BP_R2_SUM = buffData[i].BP_R2M_SUM + buffData[i].BP_R2S_SUM;
        //R36
        buffData[i].BP_R36M_SUM = buffData[i].BP_R36M_MKT +
            buffData[i].BP_R36M_CHE +
            buffData[i].BP_R36M_PHO +
            buffData[i].BP_R36M_KAN +
            buffData[i].BP_R36M_GAS;
        buffData[i].BP_R36S_SUM = buffData[i].BP_R36S_MKT +
            buffData[i].BP_R36S_PHO +
            buffData[i].BP_R36S_ISN +
            buffData[i].BP_R36S_GAS +
            buffData[i].BP_R36S_GGW +
            buffData[i].BP_R36S_ENV;
        buffData[i].BP_R36_SUM =
            buffData[i].BP_R36M_SUM + buffData[i].BP_R36S_SUM;
        buffData[i].BP_R26_SUM = buffData[i].BP_R2_SUM + buffData[i].BP_R36_SUM;
        buffData[i].BP_ALL_SUM = buffData[i].BP_R26_SUM + buffData[i].BP_R1_SUM;
        //ESIE
        buffData[i].RY_R1S_SUM = buffData[i].RY_R1S_MKT +
            buffData[i].RY_R1S_CHE +
            buffData[i].RY_R1S_PHO +
            buffData[i].RY_R1S_KAN +
            buffData[i].RY_R1S_GAS;
        buffData[i].RY_R1M_SUM = buffData[i].RY_R1M_MKT +
            buffData[i].RY_R1M_PHO +
            buffData[i].RY_R1M_ISN +
            buffData[i].RY_R1M_GAS +
            buffData[i].RY_R1M_GGW +
            buffData[i].RY_R1M_ENV;
        buffData[i].RY_R1_SUM = buffData[i].RY_R1S_SUM + buffData[i].RY_R1M_SUM;
        //R2
        buffData[i].RY_R2S_SUM = buffData[i].RY_R2S_MKT +
            buffData[i].RY_R2S_CHE +
            buffData[i].RY_R2S_PHO +
            buffData[i].RY_R2S_KAN +
            buffData[i].RY_R2S_GAS;
        buffData[i].RY_R2M_SUM = buffData[i].RY_R2M_MKT +
            buffData[i].RY_R2M_PHO +
            buffData[i].RY_R2M_ISN +
            buffData[i].RY_R2M_GAS +
            buffData[i].RY_R2M_GGW +
            buffData[i].RY_R2M_ENV;
        buffData[i].RY_R2_SUM = buffData[i].RY_R2S_SUM + buffData[i].RY_R2M_SUM;
        //R36
        buffData[i].RY_R36S_SUM = buffData[i].RY_R36S_MKT +
            buffData[i].RY_R36S_CHE +
            buffData[i].RY_R36S_PHO +
            buffData[i].RY_R36S_KAN +
            buffData[i].RY_R36S_GAS;
        buffData[i].RY_R36M_SUM = buffData[i].RY_R36M_MKT +
            buffData[i].RY_R36M_PHO +
            buffData[i].RY_R36M_ISN +
            buffData[i].RY_R36M_GAS +
            buffData[i].RY_R36M_GGW +
            buffData[i].RY_R36M_ENV;
        buffData[i].RY_R36_SUM =
            buffData[i].RY_R36S_SUM + buffData[i].RY_R36M_SUM;
        buffData[i].RY_R26_SUM = buffData[i].RY_R2_SUM + buffData[i].RY_R36_SUM;
        buffData[i].RY_ALL_SUM = buffData[i].RY_R26_SUM + buffData[i].RY_R1_SUM;
        buffData[i].ALL_SUM = buffData[i].BP_ALL_SUM + buffData[i].RY_ALL_SUM;

        if (buffData[i].instrumentName == "XRD 020 Ratio" ||
            buffData[i].instrumentName == "XRD P Ratio(%)") {
          dataItemToExcel[9][0] = "XRD";
          dataItemToExcel[9][1] =
              dataItemToExcel[9][1] + buffData[i].BP_R1M_MKT;
          dataItemToExcel[9][2] =
              dataItemToExcel[9][2] + buffData[i].BP_R1M_CHE;
          dataItemToExcel[9][3] =
              dataItemToExcel[9][3] + buffData[i].BP_R1M_PHO;
          dataItemToExcel[9][4] =
              dataItemToExcel[9][4] + buffData[i].BP_R1M_KAN;
          dataItemToExcel[9][5] =
              dataItemToExcel[9][5] + buffData[i].BP_R1M_GAS;
          dataItemToExcel[9][6] =
              dataItemToExcel[9][6] + buffData[i].BP_R1M_SUM;
          dataItemToExcel[9][7] =
              dataItemToExcel[9][7] + buffData[i].BP_R1S_MKT;
          dataItemToExcel[9][8] =
              dataItemToExcel[9][8] + buffData[i].BP_R1S_PHO;
          dataItemToExcel[9][9] =
              dataItemToExcel[9][9] + buffData[i].BP_R1S_ISN;
          dataItemToExcel[9][10] =
              dataItemToExcel[9][10] + buffData[i].BP_R1S_GAS;
          dataItemToExcel[9][11] =
              dataItemToExcel[9][11] + buffData[i].BP_R1S_GGW;
          dataItemToExcel[9][12] =
              dataItemToExcel[9][12] + buffData[i].BP_R1S_ENV;
          dataItemToExcel[9][13] =
              dataItemToExcel[9][13] + buffData[i].BP_R1S_SUM;
          dataItemToExcel[9][14] =
              dataItemToExcel[9][14] + buffData[i].BP_R1_SUM;
          dataItemToExcel[9][15] =
              dataItemToExcel[9][15] + buffData[i].BP_R2M_MKT;
          dataItemToExcel[9][16] =
              dataItemToExcel[9][16] + buffData[i].BP_R2M_CHE;
          dataItemToExcel[9][17] =
              dataItemToExcel[9][17] + buffData[i].BP_R2M_PHO;
          dataItemToExcel[9][18] =
              dataItemToExcel[9][18] + buffData[i].BP_R2M_KAN;
          dataItemToExcel[9][19] =
              dataItemToExcel[9][19] + buffData[i].BP_R2M_GAS;
          dataItemToExcel[9][20] =
              dataItemToExcel[9][20] + buffData[i].BP_R2M_SUM;
          dataItemToExcel[9][21] =
              dataItemToExcel[9][21] + buffData[i].BP_R2S_MKT;
          dataItemToExcel[9][22] =
              dataItemToExcel[9][22] + buffData[i].BP_R2S_PHO;
          dataItemToExcel[9][23] =
              dataItemToExcel[9][23] + buffData[i].BP_R2S_ISN;
          dataItemToExcel[9][24] =
              dataItemToExcel[9][24] + buffData[i].BP_R2S_GAS;
          dataItemToExcel[9][25] =
              dataItemToExcel[9][25] + buffData[i].BP_R2S_GGW;
          dataItemToExcel[9][26] =
              dataItemToExcel[9][26] + buffData[i].BP_R2S_ENV;
          dataItemToExcel[9][27] =
              dataItemToExcel[9][27] + buffData[i].BP_R2S_SUM;
          dataItemToExcel[9][28] =
              dataItemToExcel[9][28] + buffData[i].BP_R2_SUM;
          dataItemToExcel[9][29] =
              dataItemToExcel[9][29] + buffData[i].BP_R36M_MKT;
          dataItemToExcel[9][30] =
              dataItemToExcel[9][30] + buffData[i].BP_R36M_CHE;
          dataItemToExcel[9][31] =
              dataItemToExcel[9][31] + buffData[i].BP_R36M_PHO;
          dataItemToExcel[9][32] =
              dataItemToExcel[9][32] + buffData[i].BP_R36M_KAN;
          dataItemToExcel[9][33] =
              dataItemToExcel[9][33] + buffData[i].BP_R36M_GAS;
          dataItemToExcel[9][34] =
              dataItemToExcel[9][34] + buffData[i].BP_R36M_SUM;
          dataItemToExcel[9][35] =
              dataItemToExcel[9][35] + buffData[i].BP_R36S_MKT;
          dataItemToExcel[9][36] =
              dataItemToExcel[9][36] + buffData[i].BP_R36S_PHO;
          dataItemToExcel[9][37] =
              dataItemToExcel[9][37] + buffData[i].BP_R36S_ISN;
          dataItemToExcel[9][38] =
              dataItemToExcel[9][38] + buffData[i].BP_R36S_GAS;
          dataItemToExcel[9][39] =
              dataItemToExcel[9][39] + buffData[i].BP_R36S_GGW;
          dataItemToExcel[9][40] =
              dataItemToExcel[9][40] + buffData[i].BP_R36S_ENV;
          dataItemToExcel[9][41] =
              dataItemToExcel[9][41] + buffData[i].BP_R36S_SUM;
          dataItemToExcel[9][42] =
              dataItemToExcel[9][42] + buffData[i].BP_R36_SUM;
          dataItemToExcel[9][43] =
              dataItemToExcel[9][43] + buffData[i].BP_R26_SUM;
          dataItemToExcel[9][44] =
              dataItemToExcel[9][44] + buffData[i].BP_ALL_SUM;
          dataItemToExcel[9][45] =
              dataItemToExcel[9][45] + buffData[i].RY_R1S_MKT;
          dataItemToExcel[9][46] =
              dataItemToExcel[9][46] + buffData[i].RY_R1S_CHE;
          dataItemToExcel[9][47] =
              dataItemToExcel[9][47] + buffData[i].RY_R1S_PHO;
          dataItemToExcel[9][48] =
              dataItemToExcel[9][48] + buffData[i].RY_R1S_KAN;
          dataItemToExcel[9][49] =
              dataItemToExcel[9][49] + buffData[i].RY_R1S_GAS;
          dataItemToExcel[9][50] =
              dataItemToExcel[9][50] + buffData[i].RY_R1S_SUM;
          dataItemToExcel[9][51] =
              dataItemToExcel[9][51] + buffData[i].RY_R1M_MKT;
          dataItemToExcel[9][52] =
              dataItemToExcel[9][52] + buffData[i].RY_R1M_PHO;
          dataItemToExcel[9][53] =
              dataItemToExcel[9][53] + buffData[i].RY_R1M_ISN;
          dataItemToExcel[9][54] =
              dataItemToExcel[9][54] + buffData[i].RY_R1M_GAS;
          dataItemToExcel[9][55] =
              dataItemToExcel[9][55] + buffData[i].RY_R1M_GGW;
          dataItemToExcel[9][56] =
              dataItemToExcel[9][56] + buffData[i].RY_R1M_ENV;
          dataItemToExcel[9][57] =
              dataItemToExcel[9][57] + buffData[i].RY_R1M_SUM;
          dataItemToExcel[9][58] =
              dataItemToExcel[9][58] + buffData[i].RY_R1_SUM;
          dataItemToExcel[9][59] =
              dataItemToExcel[9][59] + buffData[i].RY_R2S_MKT;
          dataItemToExcel[9][60] =
              dataItemToExcel[9][60] + buffData[i].RY_R2S_CHE;
          dataItemToExcel[9][61] =
              dataItemToExcel[9][61] + buffData[i].RY_R2S_PHO;
          dataItemToExcel[9][62] =
              dataItemToExcel[9][62] + buffData[i].RY_R2S_KAN;
          dataItemToExcel[9][63] =
              dataItemToExcel[9][63] + buffData[i].RY_R2S_GAS;
          dataItemToExcel[9][64] =
              dataItemToExcel[9][64] + buffData[i].RY_R2S_SUM;
          dataItemToExcel[9][65] =
              dataItemToExcel[9][65] + buffData[i].RY_R2M_MKT;
          dataItemToExcel[9][66] =
              dataItemToExcel[9][66] + buffData[i].RY_R2M_PHO;
          dataItemToExcel[9][67] =
              dataItemToExcel[9][67] + buffData[i].RY_R2M_ISN;
          dataItemToExcel[9][68] =
              dataItemToExcel[9][68] + buffData[i].RY_R2M_GAS;
          dataItemToExcel[9][69] =
              dataItemToExcel[9][69] + buffData[i].RY_R2M_GGW;
          dataItemToExcel[9][70] =
              dataItemToExcel[9][70] + buffData[i].RY_R2M_ENV;
          dataItemToExcel[9][71] =
              dataItemToExcel[9][71] + buffData[i].RY_R2M_SUM;
          dataItemToExcel[9][72] =
              dataItemToExcel[9][72] + buffData[i].RY_R2_SUM;
          dataItemToExcel[9][73] =
              dataItemToExcel[9][73] + buffData[i].RY_R36S_MKT;
          dataItemToExcel[9][74] =
              dataItemToExcel[9][74] + buffData[i].RY_R36S_CHE;
          dataItemToExcel[9][75] =
              dataItemToExcel[9][75] + buffData[i].RY_R36S_PHO;
          dataItemToExcel[9][76] =
              dataItemToExcel[9][76] + buffData[i].RY_R36S_KAN;
          dataItemToExcel[9][77] =
              dataItemToExcel[9][77] + buffData[i].RY_R36S_GAS;
          dataItemToExcel[9][78] =
              dataItemToExcel[9][78] + buffData[i].RY_R36S_SUM;
          dataItemToExcel[9][79] =
              dataItemToExcel[9][79] + buffData[i].RY_R36M_MKT;
          dataItemToExcel[9][80] =
              dataItemToExcel[9][80] + buffData[i].RY_R36M_PHO;
          dataItemToExcel[9][81] =
              dataItemToExcel[9][81] + buffData[i].RY_R36M_ISN;
          dataItemToExcel[9][82] =
              dataItemToExcel[9][82] + buffData[i].RY_R36M_GAS;
          dataItemToExcel[9][83] =
              dataItemToExcel[9][83] + buffData[i].RY_R36M_GGW;
          dataItemToExcel[9][84] =
              dataItemToExcel[9][84] + buffData[i].RY_R36M_ENV;
          dataItemToExcel[9][85] =
              dataItemToExcel[9][85] + buffData[i].RY_R36M_SUM;
          dataItemToExcel[9][86] =
              dataItemToExcel[9][86] + buffData[i].RY_R36_SUM;
          dataItemToExcel[9][87] =
              dataItemToExcel[9][87] + buffData[i].RY_R26_SUM;
          dataItemToExcel[9][88] =
              dataItemToExcel[9][88] + buffData[i].RY_ALL_SUM;
          dataItemToExcel[9][89] = dataItemToExcel[9][89] + buffData[i].ALL_SUM;
        } else {
          var index = instrumentOrder.indexWhere(((instrumentOrder) =>
              instrumentOrder.instrumentName == buffData[i].instrumentName));
          if (index != -1) {
            dataItemToExcel[index][0] = buffData[i].instrumentName;
            dataItemToExcel[index][1] = buffData[i].BP_R1M_MKT;
            dataItemToExcel[index][2] = buffData[i].BP_R1M_CHE;
            dataItemToExcel[index][3] = buffData[i].BP_R1M_PHO;
            dataItemToExcel[index][4] = buffData[i].BP_R1M_KAN;
            dataItemToExcel[index][5] = buffData[i].BP_R1M_GAS;
            dataItemToExcel[index][6] = buffData[i].BP_R1M_SUM;
            dataItemToExcel[index][7] = buffData[i].BP_R1S_MKT;
            dataItemToExcel[index][8] = buffData[i].BP_R1S_PHO;
            dataItemToExcel[index][9] = buffData[i].BP_R1S_ISN;
            dataItemToExcel[index][10] = buffData[i].BP_R1S_GAS;
            dataItemToExcel[index][11] = buffData[i].BP_R1S_GGW;
            dataItemToExcel[index][12] = buffData[i].BP_R1S_ENV;
            dataItemToExcel[index][13] = buffData[i].BP_R1S_SUM;
            dataItemToExcel[index][14] = buffData[i].BP_R1_SUM;
            dataItemToExcel[index][15] = buffData[i].BP_R2M_MKT;
            dataItemToExcel[index][16] = buffData[i].BP_R2M_CHE;
            dataItemToExcel[index][17] = buffData[i].BP_R2M_PHO;
            dataItemToExcel[index][18] = buffData[i].BP_R2M_KAN;
            dataItemToExcel[index][19] = buffData[i].BP_R2M_GAS;
            dataItemToExcel[index][20] = buffData[i].BP_R2M_SUM;
            dataItemToExcel[index][21] = buffData[i].BP_R2S_MKT;
            dataItemToExcel[index][22] = buffData[i].BP_R2S_PHO;
            dataItemToExcel[index][23] = buffData[i].BP_R2S_ISN;
            dataItemToExcel[index][24] = buffData[i].BP_R2S_GAS;
            dataItemToExcel[index][25] = buffData[i].BP_R2S_GGW;
            dataItemToExcel[index][26] = buffData[i].BP_R2S_ENV;
            dataItemToExcel[index][27] = buffData[i].BP_R2S_SUM;
            dataItemToExcel[index][28] = buffData[i].BP_R2_SUM;
            dataItemToExcel[index][29] = buffData[i].BP_R36M_MKT;
            dataItemToExcel[index][30] = buffData[i].BP_R36M_CHE;
            dataItemToExcel[index][31] = buffData[i].BP_R36M_PHO;
            dataItemToExcel[index][32] = buffData[i].BP_R36M_KAN;
            dataItemToExcel[index][33] = buffData[i].BP_R36M_GAS;
            dataItemToExcel[index][34] = buffData[i].BP_R36M_SUM;
            dataItemToExcel[index][35] = buffData[i].BP_R36S_MKT;
            dataItemToExcel[index][36] = buffData[i].BP_R36S_PHO;
            dataItemToExcel[index][37] = buffData[i].BP_R36S_ISN;
            dataItemToExcel[index][38] = buffData[i].BP_R36S_GAS;
            dataItemToExcel[index][39] = buffData[i].BP_R36S_GGW;
            dataItemToExcel[index][40] = buffData[i].BP_R36S_ENV;
            dataItemToExcel[index][41] = buffData[i].BP_R36S_SUM;
            dataItemToExcel[index][42] = buffData[i].BP_R36_SUM;
            dataItemToExcel[index][43] = buffData[i].BP_R26_SUM;
            dataItemToExcel[index][44] = buffData[i].BP_ALL_SUM;
            ////////////////////////////////////////////////////
            dataItemToExcel[index][45] = buffData[i].RY_R1M_MKT;
            dataItemToExcel[index][46] = buffData[i].RY_R1M_PHO;
            dataItemToExcel[index][47] = buffData[i].RY_R1M_ISN;
            dataItemToExcel[index][48] = buffData[i].RY_R1M_GAS;
            dataItemToExcel[index][49] = buffData[i].RY_R1M_GGW;
            dataItemToExcel[index][50] = buffData[i].RY_R1M_ENV;
            dataItemToExcel[index][51] = buffData[i].RY_R1M_SUM;
            dataItemToExcel[index][52] = buffData[i].RY_R1S_MKT;
            dataItemToExcel[index][53] = buffData[i].RY_R1S_CHE;
            dataItemToExcel[index][54] = buffData[i].RY_R1S_PHO;
            dataItemToExcel[index][55] = buffData[i].RY_R1S_KAN;
            dataItemToExcel[index][56] = buffData[i].RY_R1S_GAS;
            dataItemToExcel[index][57] = buffData[i].RY_R1S_SUM;
            dataItemToExcel[index][58] = buffData[i].RY_R1_SUM;
            dataItemToExcel[index][59] = buffData[i].RY_R2M_MKT;
            dataItemToExcel[index][60] = buffData[i].RY_R2M_PHO;
            dataItemToExcel[index][61] = buffData[i].RY_R2M_ISN;
            dataItemToExcel[index][62] = buffData[i].RY_R2M_GAS;
            dataItemToExcel[index][63] = buffData[i].RY_R2M_GGW;
            dataItemToExcel[index][64] = buffData[i].RY_R2M_ENV;
            dataItemToExcel[index][65] = buffData[i].RY_R2M_SUM;
            dataItemToExcel[index][66] = buffData[i].RY_R2S_MKT;
            dataItemToExcel[index][67] = buffData[i].RY_R2S_CHE;
            dataItemToExcel[index][68] = buffData[i].RY_R2S_PHO;
            dataItemToExcel[index][69] = buffData[i].RY_R2S_KAN;
            dataItemToExcel[index][70] = buffData[i].RY_R2S_GAS;
            dataItemToExcel[index][71] = buffData[i].RY_R2S_SUM;
            dataItemToExcel[index][72] = buffData[i].RY_R2_SUM;
            dataItemToExcel[index][73] = buffData[i].RY_R36M_MKT;
            dataItemToExcel[index][74] = buffData[i].RY_R36M_PHO;
            dataItemToExcel[index][75] = buffData[i].RY_R36M_ISN;
            dataItemToExcel[index][76] = buffData[i].RY_R36M_GAS;
            dataItemToExcel[index][77] = buffData[i].RY_R36M_GGW;
            dataItemToExcel[index][78] = buffData[i].RY_R36M_ENV;
            dataItemToExcel[index][79] = buffData[i].RY_R36M_SUM;
            dataItemToExcel[index][80] = buffData[i].RY_R36S_MKT;
            dataItemToExcel[index][81] = buffData[i].RY_R36S_CHE;
            dataItemToExcel[index][82] = buffData[i].RY_R36S_PHO;
            dataItemToExcel[index][83] = buffData[i].RY_R36S_KAN;
            dataItemToExcel[index][84] = buffData[i].RY_R36S_GAS;
            dataItemToExcel[index][85] = buffData[i].RY_R36S_SUM;
            dataItemToExcel[index][86] = buffData[i].RY_R36_SUM;
            dataItemToExcel[index][87] = buffData[i].RY_R26_SUM;
            dataItemToExcel[index][88] = buffData[i].RY_ALL_SUM;
            dataItemToExcel[index][89] = buffData[i].ALL_SUM;
          }
        }
      }
      //print(itemToExcelToJson(dataItemToExcel));
      // for (var i = 0; i < dataItemToExcel.length; i++) {
      // if (dataItemToExcel[i].length == 0)
      dataItemToExcel.removeWhere((item) => item.length == 0);
      //}

      return 1;
    } else {
      EasyLoading.dismiss();
      alertError("System Error");
      return 1;
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 0;
  } on Error catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 0;
  }
}

/* List<rowInstrument> instrumentOrder = [
  rowInstrument(row: 7, instrumentName: 'XRF'),
  rowInstrument(row: 9, instrumentName: 'XRD'),
  rowInstrument(row: 11, instrumentName: 'SEM'),
  rowInstrument(row: 12, instrumentName: 'Crystal size'),
  rowInstrument(row: 15, instrumentName: 'ICP'),
  rowInstrument(row: 19, instrumentName: 'IC'),
  rowInstrument(row: 24, instrumentName: 'Ti(UV)'),
  rowInstrument(row: 25, instrumentName: 'OCA'),
  rowInstrument(row: 27, instrumentName: 'TOC'),
  rowInstrument(row: 28, instrumentName: 'SSM'),
  rowInstrument(row: 30, instrumentName: 'LECO'),
  rowInstrument(row: 32, instrumentName: 'Cl(AUTO)'),
  rowInstrument(row: 34, instrumentName: 'Cwt'),
  rowInstrument(row: 35, instrumentName: 'Cwt.3 layers'),
  rowInstrument(row: 37, instrumentName: 'S.G(Nox Rust)'),
  rowInstrument(row: 38, instrumentName: 'Flash Point (NOX-RUST)'),
  rowInstrument(row: 39, instrumentName: 'Viscosity(NOX-RUST)'),
  rowInstrument(row: 40, instrumentName: 'Acid Number(Nox Rust)'),
  rowInstrument(row: 41, instrumentName: 'Solid Content(Nox Rust)'),
  rowInstrument(row: 42, instrumentName: 'Moisture(Nox Rust)'),
  rowInstrument(row: 43, instrumentName: 'Density(WAX)'),
  rowInstrument(row: 44, instrumentName: 'Flash Point(WAX)'),
  rowInstrument(row: 45, instrumentName: 'Viscosity(WAX)'),
  rowInstrument(row: 46, instrumentName: '%NV(WAX)'),
  rowInstrument(row: 47, instrumentName: '%NV'),
  rowInstrument(row: 56, instrumentName: 'Surfactant'),
  rowInstrument(row: 57, instrumentName: 'PO43-(Titration)'),
  rowInstrument(row: 69, instrumentName: 'CN-'),
  //rowInstrument(row : ,instrumentName: 'Filter Image'),
  rowInstrument(row: 82, instrumentName: 'Contact angle'),
  rowInstrument(row: 83, instrumentName: '%Brix'),
  rowInstrument(row: 84, instrumentName: 'D-smut'),
  rowInstrument(row: 85, instrumentName: 'L-Value'),
  rowInstrument(row: 86, instrumentName: 'pH'),
  rowInstrument(row: 87, instrumentName: 'EC'),
  rowInstrument(row: 88, instrumentName: 'Sludge'),
  rowInstrument(row: 89, instrumentName: 'F-F'),
  rowInstrument(row: 90, instrumentName: 'Cwt. PULS'),
  //rowInstrument(row : ,instrumentName: '%NV(Nox Rust)'),
  //rowInstrument(row : ,instrumentName: 'CO32-)}
];

List<ItemToExcel> dataItemToExcel = [];
Future getDataCreateExcel() async {
  Map<String, String> qParams = {
    'SearchOption': jsonEncode(searchOption),
  };
  print('in getDataCreateExcel');
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(
            Uri.parse("$urlE/SummaryDataPage/KPIItemCount_getDataCreateExcel"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      List<ItemToExcel> dataItemToExcel = [];
      List<ItemToExcel> buffData = [];
      buffData = itemToExcelFromJson(response.body);
      for (var i = 0; i < 40; i++) {
        dataItemToExcel.add(ItemToExcel());
      }
      //SUM DATA
      for (int i = 0; i < buffData.length; i++) {
        //BP
        //R1
        buffData[i].BP_R1M_SUM = buffData[i].BP_R1M_MKT +
            buffData[i].BP_R1M_CHE +
            buffData[i].BP_R1M_PHO +
            buffData[i].BP_R1M_KAN +
            buffData[i].BP_R1M_GAS;
        buffData[i].BP_R1S_SUM = buffData[i].BP_R1S_MKT +
            buffData[i].BP_R1S_PHO +
            buffData[i].BP_R1S_ISN +
            buffData[i].BP_R1S_GAS +
            buffData[i].BP_R1S_GGW +
            buffData[i].BP_R1S_ENV;
        buffData[i].BP_R1_SUM = buffData[i].BP_R1M_SUM + buffData[i].BP_R1S_SUM;
        //R2
        buffData[i].BP_R2M_SUM = buffData[i].BP_R2M_MKT +
            buffData[i].BP_R2M_CHE +
            buffData[i].BP_R2M_PHO +
            buffData[i].BP_R2M_KAN +
            buffData[i].BP_R2M_GAS;
        buffData[i].BP_R2S_SUM = buffData[i].BP_R2S_MKT +
            buffData[i].BP_R2S_PHO +
            buffData[i].BP_R2S_ISN +
            buffData[i].BP_R2S_GAS +
            buffData[i].BP_R2S_GGW +
            buffData[i].BP_R2S_ENV;
        buffData[i].BP_R2_SUM = buffData[i].BP_R2M_SUM + buffData[i].BP_R2S_SUM;
        //R36
        buffData[i].BP_R36M_SUM = buffData[i].BP_R36M_MKT +
            buffData[i].BP_R36M_CHE +
            buffData[i].BP_R36M_PHO +
            buffData[i].BP_R36M_KAN +
            buffData[i].BP_R36M_GAS;
        buffData[i].BP_R36S_SUM = buffData[i].BP_R36S_MKT +
            buffData[i].BP_R36S_PHO +
            buffData[i].BP_R36S_ISN +
            buffData[i].BP_R36S_GAS +
            buffData[i].BP_R36S_GGW +
            buffData[i].BP_R36S_ENV;
        buffData[i].BP_R36_SUM =
            buffData[i].BP_R36M_SUM + buffData[i].BP_R36S_SUM;
        buffData[i].BP_R26_SUM = buffData[i].BP_R2_SUM + buffData[i].BP_R36_SUM;
        buffData[i].BP_ALL_SUM = buffData[i].BP_R26_SUM + buffData[i].BP_R1_SUM;
        //ESIE
        buffData[i].RY_R1S_SUM = buffData[i].RY_R1S_MKT +
            buffData[i].RY_R1S_CHE +
            buffData[i].RY_R1S_PHO +
            buffData[i].RY_R1S_KAN +
            buffData[i].RY_R1S_GAS;
        buffData[i].RY_R1M_SUM = buffData[i].RY_R1M_MKT +
            buffData[i].RY_R1M_PHO +
            buffData[i].RY_R1M_ISN +
            buffData[i].RY_R1M_GAS +
            buffData[i].RY_R1M_GGW +
            buffData[i].RY_R1M_ENV;
        buffData[i].RY_R1_SUM = buffData[i].RY_R1S_SUM + buffData[i].RY_R1M_SUM;
        //R2
        buffData[i].RY_R2S_SUM = buffData[i].RY_R2S_MKT +
            buffData[i].RY_R2S_CHE +
            buffData[i].RY_R2S_PHO +
            buffData[i].RY_R2S_KAN +
            buffData[i].RY_R2S_GAS;
        buffData[i].RY_R2M_SUM = buffData[i].RY_R2M_MKT +
            buffData[i].RY_R2M_PHO +
            buffData[i].RY_R2M_ISN +
            buffData[i].RY_R2M_GAS +
            buffData[i].RY_R2M_GGW +
            buffData[i].RY_R2M_ENV;
        buffData[i].RY_R2_SUM = buffData[i].RY_R2S_SUM + buffData[i].RY_R2M_SUM;
        //R36
        buffData[i].RY_R36S_SUM = buffData[i].RY_R36S_MKT +
            buffData[i].RY_R36S_CHE +
            buffData[i].RY_R36S_PHO +
            buffData[i].RY_R36S_KAN +
            buffData[i].RY_R36S_GAS;
        buffData[i].RY_R36M_SUM = buffData[i].RY_R36M_MKT +
            buffData[i].RY_R36M_PHO +
            buffData[i].RY_R36M_ISN +
            buffData[i].RY_R36M_GAS +
            buffData[i].RY_R36M_GGW +
            buffData[i].RY_R36M_ENV;
        buffData[i].RY_R36_SUM =
            buffData[i].RY_R36S_SUM + buffData[i].RY_R36M_SUM;
        buffData[i].RY_R26_SUM = buffData[i].RY_R2_SUM + buffData[i].RY_R36_SUM;
        buffData[i].RY_ALL_SUM = buffData[i].RY_R26_SUM + buffData[i].RY_R1_SUM;

        if (buffData[i].instrumentName == "XRD 020 Ratio" ||
            buffData[i].instrumentName == "XRD P Ratio(%)") {
          dataItemToExcel[9].instrumentName = "XRD";
          dataItemToExcel[9].BP_R1M_MKT =
              dataItemToExcel[9].BP_R1M_MKT + buffData[i].BP_R1M_MKT;
          dataItemToExcel[9].BP_R1M_CHE =
              dataItemToExcel[9].BP_R1M_CHE + buffData[i].BP_R1M_CHE;
          dataItemToExcel[9].BP_R1M_PHO =
              dataItemToExcel[9].BP_R1M_PHO + buffData[i].BP_R1M_PHO;
          dataItemToExcel[9].BP_R1M_KAN =
              dataItemToExcel[9].BP_R1M_KAN + buffData[i].BP_R1M_KAN;
          dataItemToExcel[9].BP_R1M_GAS =
              dataItemToExcel[9].BP_R1M_GAS + buffData[i].BP_R1M_GAS;
          dataItemToExcel[9].BP_R1M_SUM =
              dataItemToExcel[9].BP_R1M_SUM + buffData[i].BP_R1M_SUM;
          dataItemToExcel[9].BP_R1S_MKT =
              dataItemToExcel[9].BP_R1S_MKT + buffData[i].BP_R1S_MKT;
          dataItemToExcel[9].BP_R1S_PHO =
              dataItemToExcel[9].BP_R1S_PHO + buffData[i].BP_R1S_PHO;
          dataItemToExcel[9].BP_R1S_ISN =
              dataItemToExcel[9].BP_R1S_ISN + buffData[i].BP_R1S_ISN;
          dataItemToExcel[9].BP_R1S_GAS =
              dataItemToExcel[9].BP_R1S_GAS + buffData[i].BP_R1S_GAS;
          dataItemToExcel[9].BP_R1S_GGW =
              dataItemToExcel[9].BP_R1S_GGW + buffData[i].BP_R1S_GGW;
          dataItemToExcel[9].BP_R1S_ENV =
              dataItemToExcel[9].BP_R1S_ENV + buffData[i].BP_R1S_ENV;
          dataItemToExcel[9].BP_R1S_SUM =
              dataItemToExcel[9].BP_R1S_SUM + buffData[i].BP_R1S_SUM;
          dataItemToExcel[9].BP_R1_SUM =
              dataItemToExcel[9].BP_R1_SUM + buffData[i].BP_R1_SUM;
          dataItemToExcel[9].BP_R2M_MKT =
              dataItemToExcel[9].BP_R2M_MKT + buffData[i].BP_R2M_MKT;
          dataItemToExcel[9].BP_R2M_CHE =
              dataItemToExcel[9].BP_R2M_CHE + buffData[i].BP_R2M_CHE;
          dataItemToExcel[9].BP_R2M_PHO =
              dataItemToExcel[9].BP_R2M_PHO + buffData[i].BP_R2M_PHO;
          dataItemToExcel[9].BP_R2M_KAN =
              dataItemToExcel[9].BP_R2M_KAN + buffData[i].BP_R2M_KAN;
          dataItemToExcel[9].BP_R2M_GAS =
              dataItemToExcel[9].BP_R2M_GAS + buffData[i].BP_R2M_GAS;
          dataItemToExcel[9].BP_R2M_SUM =
              dataItemToExcel[9].BP_R2M_SUM + buffData[i].BP_R2M_SUM;
          dataItemToExcel[9].BP_R2S_MKT =
              dataItemToExcel[9].BP_R2S_MKT + buffData[i].BP_R2S_MKT;
          dataItemToExcel[9].BP_R2S_PHO =
              dataItemToExcel[9].BP_R2S_PHO + buffData[i].BP_R2S_PHO;
          dataItemToExcel[9].BP_R2S_ISN =
              dataItemToExcel[9].BP_R2S_ISN + buffData[i].BP_R2S_ISN;
          dataItemToExcel[9].BP_R2S_GAS =
              dataItemToExcel[9].BP_R2S_GAS + buffData[i].BP_R2S_GAS;
          dataItemToExcel[9].BP_R2S_GGW =
              dataItemToExcel[9].BP_R2S_GGW + buffData[i].BP_R2S_GGW;
          dataItemToExcel[9].BP_R2S_ENV =
              dataItemToExcel[9].BP_R2S_ENV + buffData[i].BP_R2S_ENV;
          dataItemToExcel[9].BP_R2S_SUM =
              dataItemToExcel[9].BP_R2S_SUM + buffData[i].BP_R2S_SUM;
          dataItemToExcel[9].BP_R2_SUM =
              dataItemToExcel[9].BP_R2_SUM + buffData[i].BP_R2_SUM;
          dataItemToExcel[9].BP_R36M_MKT =
              dataItemToExcel[9].BP_R36M_MKT + buffData[i].BP_R36M_MKT;
          dataItemToExcel[9].BP_R36M_CHE =
              dataItemToExcel[9].BP_R36M_CHE + buffData[i].BP_R36M_CHE;
          dataItemToExcel[9].BP_R36M_PHO =
              dataItemToExcel[9].BP_R36M_PHO + buffData[i].BP_R36M_PHO;
          dataItemToExcel[9].BP_R36M_KAN =
              dataItemToExcel[9].BP_R36M_KAN + buffData[i].BP_R36M_KAN;
          dataItemToExcel[9].BP_R36M_GAS =
              dataItemToExcel[9].BP_R36M_GAS + buffData[i].BP_R36M_GAS;
          dataItemToExcel[9].BP_R36M_SUM =
              dataItemToExcel[9].BP_R36M_SUM + buffData[i].BP_R36M_SUM;
          dataItemToExcel[9].BP_R36S_MKT =
              dataItemToExcel[9].BP_R36S_MKT + buffData[i].BP_R36S_MKT;
          dataItemToExcel[9].BP_R36S_PHO =
              dataItemToExcel[9].BP_R36S_PHO + buffData[i].BP_R36S_PHO;
          dataItemToExcel[9].BP_R36S_ISN =
              dataItemToExcel[9].BP_R36S_ISN + buffData[i].BP_R36S_ISN;
          dataItemToExcel[9].BP_R36S_GAS =
              dataItemToExcel[9].BP_R36S_GAS + buffData[i].BP_R36S_GAS;
          dataItemToExcel[9].BP_R36S_GGW =
              dataItemToExcel[9].BP_R36S_GGW + buffData[i].BP_R36S_GGW;
          dataItemToExcel[9].BP_R36S_ENV =
              dataItemToExcel[9].BP_R36S_ENV + buffData[i].BP_R36S_ENV;
          dataItemToExcel[9].BP_R36S_SUM =
              dataItemToExcel[9].BP_R36S_SUM + buffData[i].BP_R36S_SUM;
          dataItemToExcel[9].BP_R36_SUM =
              dataItemToExcel[9].BP_R36_SUM + buffData[i].BP_R36_SUM;
          dataItemToExcel[9].BP_R26_SUM =
              dataItemToExcel[9].BP_R26_SUM + buffData[i].BP_R26_SUM;
          dataItemToExcel[9].BP_ALL_SUM =
              dataItemToExcel[9].BP_ALL_SUM + buffData[i].BP_ALL_SUM;
          dataItemToExcel[9].RY_R1S_MKT =
              dataItemToExcel[9].RY_R1S_MKT + buffData[i].RY_R1S_MKT;
          dataItemToExcel[9].RY_R1S_CHE =
              dataItemToExcel[9].RY_R1S_CHE + buffData[i].RY_R1S_CHE;
          dataItemToExcel[9].RY_R1S_PHO =
              dataItemToExcel[9].RY_R1S_PHO + buffData[i].RY_R1S_PHO;
          dataItemToExcel[9].RY_R1S_KAN =
              dataItemToExcel[9].RY_R1S_KAN + buffData[i].RY_R1S_KAN;
          dataItemToExcel[9].RY_R1S_GAS =
              dataItemToExcel[9].RY_R1S_GAS + buffData[i].RY_R1S_GAS;
          dataItemToExcel[9].RY_R1S_SUM =
              dataItemToExcel[9].RY_R1S_SUM + buffData[i].RY_R1S_SUM;
          dataItemToExcel[9].RY_R1M_MKT =
              dataItemToExcel[9].RY_R1M_MKT + buffData[i].RY_R1M_MKT;
          dataItemToExcel[9].RY_R1M_PHO =
              dataItemToExcel[9].RY_R1M_PHO + buffData[i].RY_R1M_PHO;
          dataItemToExcel[9].RY_R1M_ISN =
              dataItemToExcel[9].RY_R1M_ISN + buffData[i].RY_R1M_ISN;
          dataItemToExcel[9].RY_R1M_GAS =
              dataItemToExcel[9].RY_R1M_GAS + buffData[i].RY_R1M_GAS;
          dataItemToExcel[9].RY_R1M_GGW =
              dataItemToExcel[9].RY_R1M_GGW + buffData[i].RY_R1M_GGW;
          dataItemToExcel[9].RY_R1M_ENV =
              dataItemToExcel[9].RY_R1M_ENV + buffData[i].RY_R1M_ENV;
          dataItemToExcel[9].RY_R1M_SUM =
              dataItemToExcel[9].RY_R1M_SUM + buffData[i].RY_R1M_SUM;
          dataItemToExcel[9].RY_R1_SUM =
              dataItemToExcel[9].RY_R1_SUM + buffData[i].RY_R1_SUM;
          dataItemToExcel[9].RY_R2S_MKT =
              dataItemToExcel[9].RY_R2S_MKT + buffData[i].RY_R2S_MKT;
          dataItemToExcel[9].RY_R2S_CHE =
              dataItemToExcel[9].RY_R2S_CHE + buffData[i].RY_R2S_CHE;
          dataItemToExcel[9].RY_R2S_PHO =
              dataItemToExcel[9].RY_R2S_PHO + buffData[i].RY_R2S_PHO;
          dataItemToExcel[9].RY_R2S_KAN =
              dataItemToExcel[9].RY_R2S_KAN + buffData[i].RY_R2S_KAN;
          dataItemToExcel[9].RY_R2S_GAS =
              dataItemToExcel[9].RY_R2S_GAS + buffData[i].RY_R2S_GAS;
          dataItemToExcel[9].RY_R2S_SUM =
              dataItemToExcel[9].RY_R2S_SUM + buffData[i].RY_R2S_SUM;
          dataItemToExcel[9].RY_R2M_MKT =
              dataItemToExcel[9].RY_R2M_MKT + buffData[i].RY_R2M_MKT;
          dataItemToExcel[9].RY_R2M_PHO =
              dataItemToExcel[9].RY_R2M_PHO + buffData[i].RY_R2M_PHO;
          dataItemToExcel[9].RY_R2M_ISN =
              dataItemToExcel[9].RY_R2M_ISN + buffData[i].RY_R2M_ISN;
          dataItemToExcel[9].RY_R2M_GAS =
              dataItemToExcel[9].RY_R2M_GAS + buffData[i].RY_R2M_GAS;
          dataItemToExcel[9].RY_R2M_GGW =
              dataItemToExcel[9].RY_R2M_GGW + buffData[i].RY_R2M_GGW;
          dataItemToExcel[9].RY_R2M_ENV =
              dataItemToExcel[9].RY_R2M_ENV + buffData[i].RY_R2M_ENV;
          dataItemToExcel[9].RY_R2M_SUM =
              dataItemToExcel[9].RY_R2M_SUM + buffData[i].RY_R2M_SUM;
          dataItemToExcel[9].RY_R2_SUM =
              dataItemToExcel[9].RY_R2_SUM + buffData[i].RY_R2_SUM;
          dataItemToExcel[9].RY_R36S_MKT =
              dataItemToExcel[9].RY_R36S_MKT + buffData[i].RY_R36S_MKT;
          dataItemToExcel[9].RY_R36S_CHE =
              dataItemToExcel[9].RY_R36S_CHE + buffData[i].RY_R36S_CHE;
          dataItemToExcel[9].RY_R36S_PHO =
              dataItemToExcel[9].RY_R36S_PHO + buffData[i].RY_R36S_PHO;
          dataItemToExcel[9].RY_R36S_KAN =
              dataItemToExcel[9].RY_R36S_KAN + buffData[i].RY_R36S_KAN;
          dataItemToExcel[9].RY_R36S_GAS =
              dataItemToExcel[9].RY_R36S_GAS + buffData[i].RY_R36S_GAS;
          dataItemToExcel[9].RY_R36S_SUM =
              dataItemToExcel[9].RY_R36S_SUM + buffData[i].RY_R36S_SUM;
          dataItemToExcel[9].RY_R36M_MKT =
              dataItemToExcel[9].RY_R36M_MKT + buffData[i].RY_R36M_MKT;
          dataItemToExcel[9].RY_R36M_PHO =
              dataItemToExcel[9].RY_R36M_PHO + buffData[i].RY_R36M_PHO;
          dataItemToExcel[9].RY_R36M_ISN =
              dataItemToExcel[9].RY_R36M_ISN + buffData[i].RY_R36M_ISN;
          dataItemToExcel[9].RY_R36M_GAS =
              dataItemToExcel[9].RY_R36M_GAS + buffData[i].RY_R36M_GAS;
          dataItemToExcel[9].RY_R36M_GGW =
              dataItemToExcel[9].RY_R36M_GGW + buffData[i].RY_R36M_GGW;
          dataItemToExcel[9].RY_R36M_ENV =
              dataItemToExcel[9].RY_R36M_ENV + buffData[i].RY_R36M_ENV;
          dataItemToExcel[9].RY_R36M_SUM =
              dataItemToExcel[9].RY_R36M_SUM + buffData[i].RY_R36M_SUM;
          dataItemToExcel[9].RY_R36_SUM =
              dataItemToExcel[9].RY_R36_SUM + buffData[i].RY_R36_SUM;
          dataItemToExcel[9].RY_R26_SUM =
              dataItemToExcel[9].RY_R26_SUM + buffData[i].RY_R26_SUM;
          dataItemToExcel[9].RY_ALL_SUM =
              dataItemToExcel[9].RY_ALL_SUM + buffData[i].RY_ALL_SUM;
          dataItemToExcel[9].ALL_SUM =
              dataItemToExcel[9].ALL_SUM + buffData[i].ALL_SUM;
        } else {
          var index = instrumentOrder.indexWhere(((instrumentOrder) =>
              instrumentOrder.instrumentName == buffData[i].instrumentName));
          if (index != -1) {
            dataItemToExcel[index].instrumentName = buffData[i].instrumentName;
            dataItemToExcel[index].BP_R1M_MKT = buffData[i].BP_R1M_MKT;
            dataItemToExcel[index].BP_R1M_CHE = buffData[i].BP_R1M_CHE;
            dataItemToExcel[index].BP_R1M_PHO = buffData[i].BP_R1M_PHO;
            dataItemToExcel[index].BP_R1M_KAN = buffData[i].BP_R1M_KAN;
            dataItemToExcel[index].BP_R1M_GAS = buffData[i].BP_R1M_GAS;
            dataItemToExcel[index].BP_R1M_SUM = buffData[i].BP_R1M_SUM;
            dataItemToExcel[index].BP_R1S_MKT = buffData[i].BP_R1S_MKT;
            dataItemToExcel[index].BP_R1S_PHO = buffData[i].BP_R1S_PHO;
            dataItemToExcel[index].BP_R1S_ISN = buffData[i].BP_R1S_ISN;
            dataItemToExcel[index].BP_R1S_GAS = buffData[i].BP_R1S_GAS;
            dataItemToExcel[index].BP_R1S_GGW = buffData[i].BP_R1S_GGW;
            dataItemToExcel[index].BP_R1S_ENV = buffData[i].BP_R1S_ENV;
            dataItemToExcel[index].BP_R1S_SUM = buffData[i].BP_R1S_SUM;
            dataItemToExcel[index].BP_R1_SUM = buffData[i].BP_R1_SUM;
            dataItemToExcel[index].BP_R2M_MKT = buffData[i].BP_R2M_MKT;
            dataItemToExcel[index].BP_R2M_CHE = buffData[i].BP_R2M_CHE;
            dataItemToExcel[index].BP_R2M_PHO = buffData[i].BP_R2M_PHO;
            dataItemToExcel[index].BP_R2M_KAN = buffData[i].BP_R2M_KAN;
            dataItemToExcel[index].BP_R2M_GAS = buffData[i].BP_R2M_GAS;
            dataItemToExcel[index].BP_R2M_SUM = buffData[i].BP_R2M_SUM;
            dataItemToExcel[index].BP_R2S_MKT = buffData[i].BP_R2S_MKT;
            dataItemToExcel[index].BP_R2S_PHO = buffData[i].BP_R2S_PHO;
            dataItemToExcel[index].BP_R2S_ISN = buffData[i].BP_R2S_ISN;
            dataItemToExcel[index].BP_R2S_GAS = buffData[i].BP_R2S_GAS;
            dataItemToExcel[index].BP_R2S_GGW = buffData[i].BP_R2S_GGW;
            dataItemToExcel[index].BP_R2S_ENV = buffData[i].BP_R2S_ENV;
            dataItemToExcel[index].BP_R2S_SUM = buffData[i].BP_R2S_SUM;
            dataItemToExcel[index].BP_R2_SUM = buffData[i].BP_R2_SUM;
            dataItemToExcel[index].BP_R36M_MKT = buffData[i].BP_R36M_MKT;
            dataItemToExcel[index].BP_R36M_CHE = buffData[i].BP_R36M_CHE;
            dataItemToExcel[index].BP_R36M_PHO = buffData[i].BP_R36M_PHO;
            dataItemToExcel[index].BP_R36M_KAN = buffData[i].BP_R36M_KAN;
            dataItemToExcel[index].BP_R36M_GAS = buffData[i].BP_R36M_GAS;
            dataItemToExcel[index].BP_R36M_SUM = buffData[i].BP_R36M_SUM;
            dataItemToExcel[index].BP_R36S_MKT = buffData[i].BP_R36S_MKT;
            dataItemToExcel[index].BP_R36S_PHO = buffData[i].BP_R36S_PHO;
            dataItemToExcel[index].BP_R36S_ISN = buffData[i].BP_R36S_ISN;
            dataItemToExcel[index].BP_R36S_GAS = buffData[i].BP_R36S_GAS;
            dataItemToExcel[index].BP_R36S_GGW = buffData[i].BP_R36S_GGW;
            dataItemToExcel[index].BP_R36S_ENV = buffData[i].BP_R36S_ENV;
            dataItemToExcel[index].BP_R36S_SUM = buffData[i].BP_R36S_SUM;
            dataItemToExcel[index].BP_R36_SUM = buffData[i].BP_R36_SUM;
            dataItemToExcel[index].BP_R26_SUM = buffData[i].BP_R26_SUM;
            dataItemToExcel[index].BP_ALL_SUM = buffData[i].BP_ALL_SUM;
            dataItemToExcel[index].RY_R1S_MKT = buffData[i].RY_R1S_MKT;
            dataItemToExcel[index].RY_R1S_CHE = buffData[i].RY_R1S_CHE;
            dataItemToExcel[index].RY_R1S_PHO = buffData[i].RY_R1S_PHO;
            dataItemToExcel[index].RY_R1S_KAN = buffData[i].RY_R1S_KAN;
            dataItemToExcel[index].RY_R1S_GAS = buffData[i].RY_R1S_GAS;
            dataItemToExcel[index].RY_R1S_SUM = buffData[i].RY_R1S_SUM;
            dataItemToExcel[index].RY_R1M_MKT = buffData[i].RY_R1M_MKT;
            dataItemToExcel[index].RY_R1M_PHO = buffData[i].RY_R1M_PHO;
            dataItemToExcel[index].RY_R1M_ISN = buffData[i].RY_R1M_ISN;
            dataItemToExcel[index].RY_R1M_GAS = buffData[i].RY_R1M_GAS;
            dataItemToExcel[index].RY_R1M_GGW = buffData[i].RY_R1M_GGW;
            dataItemToExcel[index].RY_R1M_ENV = buffData[i].RY_R1M_ENV;
            dataItemToExcel[index].RY_R1M_SUM = buffData[i].RY_R1M_SUM;
            dataItemToExcel[index].RY_R1_SUM = buffData[i].RY_R1_SUM;
            dataItemToExcel[index].RY_R2S_MKT = buffData[i].RY_R2S_MKT;
            dataItemToExcel[index].RY_R2S_CHE = buffData[i].RY_R2S_CHE;
            dataItemToExcel[index].RY_R2S_PHO = buffData[i].RY_R2S_PHO;
            dataItemToExcel[index].RY_R2S_KAN = buffData[i].RY_R2S_KAN;
            dataItemToExcel[index].RY_R2S_GAS = buffData[i].RY_R2S_GAS;
            dataItemToExcel[index].RY_R2S_SUM = buffData[i].RY_R2S_SUM;
            dataItemToExcel[index].RY_R2M_MKT = buffData[i].RY_R2M_MKT;
            dataItemToExcel[index].RY_R2M_PHO = buffData[i].RY_R2M_PHO;
            dataItemToExcel[index].RY_R2M_ISN = buffData[i].RY_R2M_ISN;
            dataItemToExcel[index].RY_R2M_GAS = buffData[i].RY_R2M_GAS;
            dataItemToExcel[index].RY_R2M_GGW = buffData[i].RY_R2M_GGW;
            dataItemToExcel[index].RY_R2M_ENV = buffData[i].RY_R2M_ENV;
            dataItemToExcel[index].RY_R2M_SUM = buffData[i].RY_R2M_SUM;
            dataItemToExcel[index].RY_R2_SUM = buffData[i].RY_R2_SUM;
            dataItemToExcel[index].RY_R36S_MKT = buffData[i].RY_R36S_MKT;
            dataItemToExcel[index].RY_R36S_CHE = buffData[i].RY_R36S_CHE;
            dataItemToExcel[index].RY_R36S_PHO = buffData[i].RY_R36S_PHO;
            dataItemToExcel[index].RY_R36S_KAN = buffData[i].RY_R36S_KAN;
            dataItemToExcel[index].RY_R36S_GAS = buffData[i].RY_R36S_GAS;
            dataItemToExcel[index].RY_R36S_SUM = buffData[i].RY_R36S_SUM;
            dataItemToExcel[index].RY_R36M_MKT = buffData[i].RY_R36M_MKT;
            dataItemToExcel[index].RY_R36M_PHO = buffData[i].RY_R36M_PHO;
            dataItemToExcel[index].RY_R36M_ISN = buffData[i].RY_R36M_ISN;
            dataItemToExcel[index].RY_R36M_GAS = buffData[i].RY_R36M_GAS;
            dataItemToExcel[index].RY_R36M_GGW = buffData[i].RY_R36M_GGW;
            dataItemToExcel[index].RY_R36M_ENV = buffData[i].RY_R36M_ENV;
            dataItemToExcel[index].RY_R36M_SUM = buffData[i].RY_R36M_SUM;
            dataItemToExcel[index].RY_R36_SUM = buffData[i].RY_R36_SUM;
            dataItemToExcel[index].RY_R26_SUM = buffData[i].RY_R26_SUM;
            dataItemToExcel[index].RY_ALL_SUM = buffData[i].RY_ALL_SUM;
            dataItemToExcel[index].ALL_SUM = buffData[i].ALL_SUM;
          }
        }
      }
      //print(itemToExcelToJson(dataItemToExcel));

      print(dataItemToExcel[0]);

      return 1;
    } else {
      EasyLoading.dismiss();
      alertError("System Error");
      return 1;
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 0;
  } on Error catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 0;
  }
}
 */

/* import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/page/12ItemAnalysisDue/SubTAB/ItemAnalysisDue/SammaryItemData/data/SummaryItemDataStructure.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';

List<ModelSummaryItemData> summaryItemDataBuffBP = [];
List<ModelSummaryItemData> summaryItemDataBuffRY = [];

Future<int> fetchSummaryItemData(String branch) async {
  print('fetchSummaryItemData');
  Map<String, String> qParams = {
    'Branch': branch,
  };
  EasyLoading.show(status: 'loading...');
  print("in fetchSummaryItemData");
  try {
    final response = await http
        .post(Uri.parse("$url/ItemAnalysisDue_fetchSummaryItemData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      if (response.body != "error") {
        List<ModelSummaryItemData> buffer =
            modelSummaryItemDataFromJson(response.body);

        //remove date 0 data
        for (int i = 0; i < buffer.length; i++) {
          if (buffer[i].countReceive == 0 &&
              buffer[i].countWaitAnalysis == 0 &&
              buffer[i].countWaitRecheck == 0 &&
              buffer[i].countWaitReconfirm == 0 &&
              buffer[i].countWaitApprove == 0) {
            buffer.removeAt(i);
            i--;
          }
        }

        if (buffer.length > 10) {
          buffer.removeRange(0, buffer.length - 10);
        }
        if (branch == "BANGPOO") {
          print("IN BP");
          summaryItemDataBuffBP = buffer;
        } else {
          print("IN RAYONG");
          summaryItemDataBuffRY = buffer;
        }
      }
    } else {
      alertError("System Error");
    }
    return 2;
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 2;
  } on Error catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 2;
  }
}





/* 
Future<int> fetchSummaryRequestData() async {
  Map<String, String> qParams = {
    'user': userName,
    //'apprvoeReportData': modelFullRequestDataToJson(apprvoeReportData),
  };
  print("in fetchSummaryRequestData");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$url/RoutineRequestDetailRequesterPage_saveApproveReport"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("APPROVE REPORT COMPLETE");
    } else {
      print("nodata");
      alertNetworkError();
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    alertNetworkError();
  }
  return 0;
}
 */ */