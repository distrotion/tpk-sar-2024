import 'dart:convert';

List<KACReportDataModel> KACReportDataModelFromJson(String str) =>
    List<KACReportDataModel>.from(
        json.decode(str).map((x) => KACReportDataModel.fromJson(x)));

String KACReportDataModelToJson(List<KACReportDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KACReportDataModel {
  KACReportDataModel({
    this.id,
    this.custFull,
    this.reqNo,
    this.patternReport,
    this.reportOrder,
    this.sampleNo,
    this.groupNameTs,
    this.sampleGroup,
    this.sampleType,
    this.sampleTank,
    this.sampleName,
    this.samplingDate,
    this.createReportDate,
    this.itemNo,
    this.itemName,
    this.stdFactor,
    this.stdMax,
    this.stdSymbol,
    this.stdMin,
    this.resultReport,
    this.resultIn,
    this.evaluation,
    this.subLeader,
    this.subLeaderTime,
    this.gl,
    this.glTime,
    this.jp,
    this.jpTime,
    this.dgm,
    this.dgmTime,
    this.reportCompleteDate,
    this.nextApprover,
    this.comment1,
    this.comment2,
    this.comment3,
    this.comment4,
    this.comment5,
    this.comment6,
    this.comment7,
    this.comment8,
    this.comment9,
    this.comment10,
    this.controlRange,
    this.itemReportName,
    this.processReportName,
    this.incharge,
    this.std1,
    this.std2,
    this.std3,
    this.std4,
    this.std5,
    this.std6,
    this.std7,
    this.std8,
    this.std9,
    this.std10,
    this.reviseNo,
    this.inchargeTime_0,
    this.subLeaderRejectRemark_0,
    this.subLeaderTime_0,
    this.gLRejectRemark_0,
    this.gLTime_0,
    this.jPRejectRemark_0,
    this.jPTime_0,
    this.dGMRejectRemark_0,
    this.dGMTime_0,
    this.inchargeTime_1,
    this.subLeaderRejectRemark_1,
    this.subLeaderTime_1,
    this.gLRejectRemark_1,
    this.gLTime_1,
    this.jPRejectRemark_1,
    this.jPTime_1,
    this.dGMRejectRemark_1,
    this.dGMTime_1,
    this.inchargeTime_2,
    this.subLeaderRejectRemark_2,
    this.subLeaderTime_2,
    this.gLRejectRemark_2,
    this.gLTime_2,
    this.jPRejectRemark_2,
    this.jPTime_2,
    this.dGMRejectRemark_2,
    this.dGMTime_2,
    this.inchargeTime_3,
    this.subLeaderRejectRemark_3,
    this.subLeaderTime_3,
    this.gLRejectRemark_3,
    this.gLTime_3,
    this.jPRejectRemark_3,
    this.jPTime_3,
    this.dGMRejectRemark_3,
    this.dGMTime_3,
    this.reportRemark,
    this.reportRejectRemark,
    this.name = "",
    this.remark0 = "",
    this.remark1 = "",
    this.remark2 = "",
    this.remark3 = "",
    this.time0 = "",
    this.time1 = "",
    this.time2 = "",
    this.time3 = "",
  });

  dynamic id;
  dynamic custFull;
  dynamic reqNo;
  dynamic patternReport;
  dynamic reportOrder;
  dynamic sampleNo;
  dynamic groupNameTs;
  dynamic sampleGroup;
  dynamic sampleType;
  dynamic sampleTank;
  dynamic sampleName;
  dynamic samplingDate;
  dynamic createReportDate;
  dynamic itemNo;
  dynamic itemName;
  dynamic stdFactor;
  dynamic stdMax;
  dynamic stdSymbol;
  dynamic stdMin;
  dynamic resultReport;
  dynamic resultIn;
  dynamic evaluation;
  dynamic subLeader;
  dynamic subLeaderTime;
  dynamic gl;
  dynamic glTime;
  dynamic jp;
  dynamic jpTime;
  dynamic dgm;
  dynamic dgmTime;
  dynamic reportCompleteDate;
  dynamic nextApprover;
  dynamic comment1;
  dynamic comment2;
  dynamic comment3;
  dynamic comment4;
  dynamic comment5;
  dynamic comment6;
  dynamic comment7;
  dynamic comment8;
  dynamic comment9;
  dynamic comment10;
  dynamic controlRange;
  dynamic itemReportName;
  dynamic processReportName;
  dynamic incharge;
  double buffMax = 0;
  double buffMin = 0;
  dynamic std1;
  dynamic std2;
  dynamic std3;
  dynamic std4;
  dynamic std5;
  dynamic std6;
  dynamic std7;
  dynamic std8;
  dynamic std9;
  dynamic std10;
  dynamic enabled = false;
  dynamic reviseNo;
  dynamic inchargeTime_1;
  dynamic subLeaderRejectRemark_1;
  dynamic subLeaderTime_1;
  dynamic gLRejectRemark_1;
  dynamic gLTime_1;
  dynamic jPRejectRemark_1;
  dynamic jPTime_1;
  dynamic dGMRejectRemark_1;
  dynamic dGMTime_1;
  dynamic inchargeTime_2;
  dynamic subLeaderRejectRemark_2;
  dynamic subLeaderTime_2;
  dynamic gLRejectRemark_2;
  dynamic gLTime_2;
  dynamic jPRejectRemark_2;
  dynamic jPTime_2;
  dynamic dGMRejectRemark_2;
  dynamic dGMTime_2;
  dynamic inchargeTime_3;
  dynamic subLeaderRejectRemark_3;
  dynamic subLeaderTime_3;
  dynamic gLRejectRemark_3;
  dynamic gLTime_3;
  dynamic jPRejectRemark_3;
  dynamic jPTime_3;
  dynamic dGMRejectRemark_3;
  dynamic dGMTime_3;
  dynamic inchargeTime_0;
  dynamic subLeaderRejectRemark_0;
  dynamic subLeaderTime_0;
  dynamic gLRejectRemark_0;
  dynamic gLTime_0;
  dynamic jPRejectRemark_0;
  dynamic jPTime_0;
  dynamic dGMRejectRemark_0;
  dynamic dGMTime_0;
  dynamic reportRemark;
  dynamic reportRejectRemark;
  dynamic name;
  dynamic time1;
  dynamic time2;
  dynamic time3;
  dynamic time0;
  dynamic remark1;
  dynamic remark2;
  dynamic remark3;
  dynamic remark0;


  factory KACReportDataModel.fromJson(Map<String, dynamic> json) =>
      KACReportDataModel(
        id: json["ID"] ?? "",
        custFull: json["CustFull"] ?? "",
        reqNo: json["ReqNo"] ?? "",
        patternReport: json["PatternReport"] ?? "",
        reportOrder: json["ReportOrder"] ?? "",
        sampleNo: json["SampleNo"] ?? "",
        groupNameTs: json["GroupNameTS"] ?? "",
        sampleGroup: json["SampleGroup"] ?? "",
        sampleType: json["SampleType"] ?? "",
        sampleTank: json["SampleTank"] ?? "",
        sampleName: json["SampleName"] ?? "",
        samplingDate: json["SamplingDate"] ?? "",
        createReportDate: json["CreateReportDate"] ?? "",
        itemNo: json["ItemNo"] ?? "",
        itemName: json["ItemName"] ?? "",
        stdFactor: json["StdFactor"] ?? "",
        stdMax: json["StdMax"] ?? "",
        stdSymbol: json["StdSymbol"] ?? "",
        stdMin: json["StdMin"] ?? "",
        resultIn: json["ResultIn"] ?? "",
        resultReport: json["ResultReport"] ?? "",
        evaluation: json["Evaluation"] ?? "",
        subLeader: json["SubLeader"] ?? "",
        subLeaderTime: json["SubLeaderTime"] ?? "",
        gl: json["GL"] ?? "",
        glTime: json["GLTime"] ?? "",
        jp: json["JP"] ?? "",
        jpTime: json["JPTime"] ?? "",
        dgm: json["DGM"] ?? "",
        dgmTime: json["DGMTime"] ?? "",
        reportCompleteDate: json["ReportCompleteDate"] ?? "",
        nextApprover: json["NextApprover"] ?? "",
        comment1: json["Comment1"] ?? "",
        comment2: json["Comment2"] ?? "",
        comment3: json["Comment3"] ?? "",
        comment4: json["Comment4"] ?? "",
        comment5: json["Comment5"] ?? "",
        comment6: json["Comment6"] ?? "",
        comment7: json["Comment7"] ?? "",
        comment8: json["Comment8"] ?? "",
        comment9: json["Comment9"] ?? "",
        comment10: json["Comment10"] ?? "",
        processReportName: json["ProcessReportName"] ?? "",
        controlRange: json["ControlRange"] ?? "",
        itemReportName: json["ItemReportName"] ?? "",
        incharge: json["Incharge"] ?? "",
        std1: json["Std1"] ?? "",
        std2: json["Std2"] ?? "",
        std3: json["Std3"] ?? "",
        std4: json["Std4"] ?? "",
        std5: json["Std5"] ?? "",
        std6: json["Std6"] ?? "",
        std7: json["Std7"] ?? "",
        std8: json["Std8"] ?? "",
        std9: json["Std9"] ?? "",
        std10: json["Std10"] ?? "",
        reviseNo: json["ReviseNo"] ?? "",
        inchargeTime_1: json["InchargeTime_1"] ?? "",
        subLeaderRejectRemark_1: json["SubLeaderRejectRemark_1"] ?? "",
        subLeaderTime_1: json["SubLeaderTime_1"] ?? "",
        gLRejectRemark_1: json["GLRejectRemark_1"] ?? "",
        gLTime_1: json["GLTime_1"] ?? "",
        jPRejectRemark_1: json["JPRejectRemark_1"] ?? "",
        jPTime_1: json["JPTime_1"] ?? "",
        dGMRejectRemark_1: json["DGMRejectRemark_1"] ?? "",
        dGMTime_1: json["DGMTime_1"] ?? "",
        inchargeTime_2: json["InchargeTime_2"] ?? "",
        subLeaderRejectRemark_2: json["SubLeaderRejectRemark_2"] ?? "",
        subLeaderTime_2: json["SubLeaderTime_2"] ?? "",
        gLRejectRemark_2: json["GLRejectRemark_2"] ?? "",
        gLTime_2: json["GLTime_2"] ?? "",
        jPRejectRemark_2: json["JPRejectRemark_2"] ?? "",
        jPTime_2: json["JPTime_2"] ?? "",
        dGMRejectRemark_2: json["DGMRejectRemark_2"] ?? "",
        dGMTime_2: json["DGMTime_2"] ?? "",
        inchargeTime_3: json["InchargeTime_3"] ?? "",
        subLeaderRejectRemark_3: json["SubLeaderRejectRemark_3"] ?? "",
        subLeaderTime_3: json["SubLeaderTime_3"] ?? "",
        gLRejectRemark_3: json["GLRejectRemark_3"] ?? "",
        gLTime_3: json["GLTime_3"] ?? "",
        jPRejectRemark_3: json["JPRejectRemark_3"] ?? "",
        jPTime_3: json["JPTime_3"] ?? "",
        dGMRejectRemark_3: json["DGMRejectRemark_3"] ?? "",
        dGMTime_3: json["DGMTime_3"] ?? "",
        inchargeTime_0: json["InchargeTime_0"] ?? "",
        subLeaderRejectRemark_0: json["SubLeaderRejectRemark_0"] ?? "",
        subLeaderTime_0: json["SubLeaderTime_0"] ?? "",
        gLRejectRemark_0: json["GLRejectRemark_0"] ?? "",
        gLTime_0: json["GLTime_0"] ?? "",
        jPRejectRemark_0: json["JPRejectRemark_0"] ?? "",
        jPTime_0: json["JPTime_0"] ?? "",
        dGMRejectRemark_0: json["DGMRejectRemark_0"] ?? "",
        dGMTime_0: json["DGMTime_0"] ?? "",
        reportRemark: json["ReportRemark"] ?? "",
        reportRejectRemark: json["ReportRejectRemark"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ID": id ?? "",
        "CustFull": custFull ?? "",
        "ReqNo": reqNo ?? "",
        "PatternReport": patternReport ?? "",
        "ReportOrder": reportOrder ?? "",
        "SampleNo": sampleNo ?? "",
        "GroupNameTS": groupNameTs ?? "",
        "SampleGroup": sampleGroup ?? "",
        "SampleType": sampleType ?? "",
        "SampleTank": sampleTank ?? "",
        "SampleName": sampleName ?? "",
        "SamplingDate": samplingDate ?? "",
        "CreateReportDate": createReportDate ?? "",
        "ItemNo": itemNo ?? "",
        "ItemName": itemName ?? "",
        "StdFactor": stdFactor ?? "",
        "StdMax": stdMax ?? "",
        "StdSymbol": stdSymbol ?? "",
        "StdMin": stdMin ?? "",
        "ResultIn": resultIn ?? "",
        "ResultReport": resultReport ?? "",
        "Evaluation": evaluation ?? "",
        "SubLeader": subLeader ?? "",
        "SubLeaderTime": subLeaderTime ?? "",
        "GL": gl ?? "",
        "GLTime": glTime ?? "",
        "JP": jp ?? "",
        "JPTime": jpTime ?? "",
        "DGM": dgm ?? "",
        "DGMTime": dgmTime ?? "",
        "ReportCompleteDate": reportCompleteDate ?? "",
        "NextApprover": nextApprover ?? "",
        "Comment1": comment1 ?? "",
        "Comment2": comment2 ?? "",
        "Comment3": comment3 ?? "",
        "Comment4": comment4 ?? "",
        "Comment5": comment5 ?? "",
        "Comment6": comment6 ?? "",
        "Comment7": comment7 ?? "",
        "Comment8": comment8 ?? "",
        "Comment9": comment9 ?? "",
        "Comment10": comment10 ?? "",
        "ProcessReportName": processReportName ?? "",
        "ControlRange": controlRange ?? "",
        "ItemReportName": itemReportName ?? "",
        "Incharge": incharge ?? "",
        "Std1": std1 ?? "",
        "Std2": std2 ?? "",
        "Std3": std3 ?? "",
        "Std4": std4 ?? "",
        "Std5": std5 ?? "",
        "Std6": std6 ?? "",
        "Std7": std7 ?? "",
        "Std8": std8 ?? "",
        "Std9": std9 ?? "",
        "Std10": std10 ?? "",
        "ReviseNo": reviseNo ?? "",
        "InchargeTime_1": inchargeTime_1 ?? "",
        "SubLeaderRejectRemark_1": subLeaderRejectRemark_1 ?? "",
        "SubLeaderTime_1": subLeaderTime_1 ?? "",
        "GLRejectRemark_1": gLRejectRemark_1 ?? "",
        "GLTime_1": gLTime_1 ?? "",
        "JPRejectRemark_1": jPRejectRemark_1 ?? "",
        "JPTime_1": jPTime_1 ?? "",
        "DGMRejectRemark_1": dGMRejectRemark_1 ?? "",
        "DGMTime_1": dGMTime_1 ?? "",
        "InchargeTime_2": inchargeTime_2 ?? "",
        "SubLeaderRejectRemark_2": subLeaderRejectRemark_2 ?? "",
        "SubLeaderTime_2": subLeaderTime_2 ?? "",
        "GLRejectRemark_2": gLRejectRemark_2 ?? "",
        "GLTime_2": gLTime_2 ?? "",
        "JPRejectRemark_2": jPRejectRemark_2 ?? "",
        "JPTime_2": jPTime_2 ?? "",
        "DGMRejectRemark_2": dGMRejectRemark_2 ?? "",
        "DGMTime_2": dGMTime_2 ?? "",
        "InchargeTime_3": inchargeTime_3 ?? "",
        "SubLeaderRejectRemark_3": subLeaderRejectRemark_3 ?? "",
        "SubLeaderTime_3": subLeaderTime_3 ?? "",
        "GLRejectRemark_3": gLRejectRemark_3 ?? "",
        "GLTime_3": gLTime_3 ?? "",
        "JPRejectRemark_3": jPRejectRemark_3 ?? "",
        "JPTime_3": jPTime_3 ?? "",
        "DGMRejectRemark_3": dGMRejectRemark_3 ?? "",
        "DGMTime_3": dGMTime_3 ?? "",
        "InchargeTime_0": inchargeTime_0 ?? "",
        "SubLeaderRejectRemark_0": subLeaderRejectRemark_0 ?? "",
        "SubLeaderTime_0": subLeaderTime_0 ?? "",
        "GLRejectRemark_0": gLRejectRemark_0 ?? "",
        "GLTime_0": gLTime_0 ?? "",
        "JPRejectRemark_0": jPRejectRemark_0 ?? "",
        "JPTime_0": jPTime_0 ?? "",
        "DGMRejectRemark_0": dGMRejectRemark_0 ?? "",
        "DGMTime_0": dGMTime_0 ?? "",
        "ReportRemark": reportRemark ?? "",
        "ReportRejectRemark": reportRejectRemark ?? "",
      };
}
