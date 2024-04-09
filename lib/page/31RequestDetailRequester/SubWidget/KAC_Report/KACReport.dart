import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as IMG;
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/dataTime.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPicture/ShowPicture.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_Report/data/KACReportData.dart';

// ignore: non_constant_identifier_names
void KACReportDataPopUp(String _reqNo) {
  showDialog(
      barrierDismissible: true,
      context: contextBG,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 900,
                child: KACReportData(
                  reqNo: _reqNo,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CLOSE'),
            ),
          ],
        );
      });
}

createReport() {
  CoolAlert.show(
      width: 200,
      context: contextBG,
      type: CoolAlertType.confirm,
      text: (() {
        if (newCreate)
          return "CONFIRM CREATE REPORT";
        else
          return "RECREATE REPORT WILL CLEAR REPORT DATA";
      }()),
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        if (kACReportData[0].subLeader != '-') {
          kACReportData[0].nextApprover = kACReportData[0].subLeader;
        } else if (kACReportData[0].gl != '-') {
          kACReportData[0].nextApprover = kACReportData[0].gl;
        } else if (kACReportData[0].jp != '-') {
          kACReportData[0].nextApprover = kACReportData[0].jp;
        } else if (kACReportData[0].dgm != '-') {
          kACReportData[0].nextApprover = kACReportData[0].dgm;
        } else {
          kACReportData[0].nextApprover = "COMPLETE";
        }
        for (int i = 1; i < kACReportData.length; i++) {
          kACReportData[i].comment1 = kACReportData[0].comment1;
          kACReportData[i].comment2 = kACReportData[0].comment2;
          kACReportData[i].comment3 = kACReportData[0].comment3;
          kACReportData[i].comment4 = kACReportData[0].comment4;
          kACReportData[i].comment5 = kACReportData[0].comment5;
          kACReportData[i].comment6 = kACReportData[0].comment6;
          kACReportData[i].comment7 = kACReportData[0].comment7;
          kACReportData[i].comment8 = kACReportData[0].comment8;
          kACReportData[i].comment9 = kACReportData[0].comment9;
          kACReportData[i].comment10 = kACReportData[0].comment10;
          kACReportData[i].reportRemark = kACReportData[0].reportRemark;
          kACReportData[i].nextApprover = kACReportData[0].nextApprover;
        }
        //Navigator.pop(contextBG);
        createKACReport();
        //Navigator.pop(contextBG);
      });
}

reviseReport() {
  CoolAlert.show(
      width: 200,
      context: contextBG,
      type: CoolAlertType.confirm,
      text: (() {
        return "CONFIRM REVISE REPORT \n WILL CLEAR APPROVED DATA";
      }()),
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        print(kACReportData[0].reviseNo.toString());
        print(kACReportData[0].nextApprover.toString());
        if (kACReportData[0].reviseNo < 3 &&
            kACReportData[0].nextApprover == 'COMPLETE') {
          kACReportData[0].reviseNo = kACReportData[0].reviseNo + 1;
        }
        if (kACReportData[0].subLeader != '-') {
          kACReportData[0].nextApprover = kACReportData[0].subLeader;
        } else if (kACReportData[0].gl != '-') {
          kACReportData[0].nextApprover = kACReportData[0].gl;
        } else if (kACReportData[0].subLeader != '-') {
          kACReportData[0].nextApprover = kACReportData[0].jp;
        } else {
          kACReportData[0].nextApprover = kACReportData[0].dgm;
        }
        for (int i = 1; i < kACReportData.length; i++) {
          kACReportData[i].comment1 = kACReportData[0].comment1;
          kACReportData[i].comment2 = kACReportData[0].comment2;
          kACReportData[i].comment3 = kACReportData[0].comment3;
          kACReportData[i].comment4 = kACReportData[0].comment4;
          kACReportData[i].comment5 = kACReportData[0].comment5;
          kACReportData[i].comment6 = kACReportData[0].comment6;
          kACReportData[i].comment7 = kACReportData[0].comment7;
          kACReportData[i].comment8 = kACReportData[0].comment8;
          kACReportData[i].comment9 = kACReportData[0].comment9;
          kACReportData[i].comment10 = kACReportData[0].comment10;
          kACReportData[i].reportRemark = kACReportData[0].reportRemark;
          kACReportData[i].nextApprover = kACReportData[0].nextApprover;
          kACReportData[i].reviseNo = kACReportData[0].reviseNo;
        }
        //Navigator.pop(contextBG);

        print("===================================");
        reviseKACReport();
        //Navigator.pop(contextBG);
      });
}

// ignore: must_be_immutable
class KACReportData extends StatefulWidget {
  String reqNo = "";
  KACReportData({
    required this.reqNo,
  });

  @override
  State<StatefulWidget> createState() => KACReportDataState();
}

class KACReportDataState extends State<KACReportData> {
  @override
  void initState() {
    super.initState();
  }

  void showImage(indexItem) {
    var outputAsUint8List;
    outputAsUint8List = base64.decode(kACReportData[indexItem].resultIn);
    /* if (result == 1) {
      outputAsUint8List =
          new Uint8List.fromList(itemData[indexSample][indexItem].result1.codeUnits);
      
    }
    if (result == 2) {
      outputAsUint8List =
          new Uint8List.fromList(dataSEMInput[index].result_2.codeUnits);
      outputAsUint8List = base64.decode(dataSEMInput[index].result_2);
    } */

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 600,
                  child: outputAsUint8List != null
                      ? Image.memory(outputAsUint8List!,
                          //width: 250, height: 250,
                          fit: BoxFit.cover)
                      : Container(),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  final _formKey = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;

  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');
  var evaluationOption = [
    '-',
    'PASS',
    'LOW',
    'HIGH',
    'NOT PASS',
    'NG',
    '1 TIME/MONTH'
  ];

  MaterialColor checkColorData() {
    return Colors.red;
  }

  TextStyle styleHeaderTable() {
    return TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  }

  TextStyle stylesection() {
    return TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  }

  TextStyle styledata(String condition) {
    Color colorSelect = Colors.black;
    if (condition != '') {
      colorSelect = Colors.blue;
    }

    return TextStyle(fontSize: 12, fontFamily: 'Mitr', color: colorSelect);
  }

  TextStyle styleDataReport(String condition) {
    Color colorSelect = Colors.black;
    if (condition != '') {
      colorSelect = Colors.blue;
    }

    return TextStyle(fontSize: 12, fontFamily: 'Mitr', color: colorSelect);
  }

  TextStyle styleEvaluate(String dataIn) {
    Color colorSelect = Colors.black;
    if (dataIn == 'LOW' || dataIn == 'HIGH') {
      colorSelect = Colors.red;
    }
    return TextStyle(fontSize: 12, fontFamily: 'Mitr', color: colorSelect);
  }

  void evaluate(int index) {
    try {
      if (kACReportData[index].resultReport.toString() != null ||
          kACReportData[index].resultReport.toString() != '') {
        /* print(
                  "Result:${kACReportData[i].result.toString()},Max:${kACReportData[i].buffMax.toString()},Min:${kACReportData[i].buffMin.toString()}");
               */
        if (double.parse(kACReportData[index].resultReport.toString()) >
            kACReportData[index].buffMax) {
          kACReportData[index].evaluation = 'HIGH';
        } else if (double.parse(kACReportData[index].resultReport.toString()) <
            kACReportData[index].buffMin) {
          kACReportData[index].evaluation = 'LOW';
        } else {
          kACReportData[index].evaluation = 'PASS';
        }
      } else {
        //print("else$i");
        kACReportData[index].evaluation = '-';
      }
    } on Exception catch (e) {
      print("error$index $e");
      kACReportData[index].evaluation = '-';
    }
  }

  bool userCheck = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: FutureBuilder(
            future: searchKACReportData(
              widget.reqNo,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                //print(snapshot.data);
                if (userName == kACReportData[0].incharge) {
                  userCheck = true;
                }
                if (snapshot.data != 0) {
                  return Container(
                    height: 500,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Container(
                            height: heightBox1,
                            child: Text("REPORT ${kACReportData[0].custFull}",
                                style: stylesection())),
                        Container(
                            height: heightBox1,
                            child: Text(
                                "REVISION NO ${kACReportData[0].reviseNo}",
                                style: stylesection())),
                        Container(
                          height: heightBox1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  child: Text("Sampling Date",
                                      style: stylesection())),
                              Container(
                                  child: Text(
                                      toDateOnly(kACReportData[0].samplingDate),
                                      style: styledata(''))),
                              Container(
                                  child: Text("Report Making Date",
                                      style: stylesection())),
                              Container(
                                  child: Text(
                                      toDateOnly(
                                          kACReportData[0].createReportDate),
                                      style: styledata(''))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomTheme.colorWhite,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: CustomTheme.colorShadowBgStrong,
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                    spreadRadius: 0)
                              ],
                            ),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: CustomTheme.colorWhite,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: DataTable(
                                        columnSpacing: 5,
                                        horizontalMargin: 10,
                                        dataRowHeight: heightBox1,
                                        columns: [
                                          DataColumn(
                                            label: Container(
                                              width: 120,
                                              child: Text('PROCESS',
                                                  style: styleHeaderTable()),
                                            ),
                                            tooltip: "PROCESS",
                                          ),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Container(
                                              width: 120,
                                              child: Text('ITEM NAME',
                                                  style: styleHeaderTable()),
                                            ),
                                            tooltip: "ITEM NAME",
                                          ),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Container(
                                                width: 80,
                                                child: Text(
                                                  'CONTROL',
                                                  style: styleHeaderTable(),
                                                  textAlign: TextAlign.center,
                                                )),
                                            tooltip: "CONTROL RANGE",
                                          ),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Text('RESULT IN',
                                                style: styleHeaderTable()),
                                            tooltip: "RESULT IN",
                                          ),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Text('RESULT REPORT',
                                                style: styleHeaderTable()),
                                            tooltip: "RESULT REPORT",
                                          ),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Container(
                                              width: 80,
                                              child: Text('EVALUATION',
                                                  style: styleHeaderTable()),
                                            ),
                                            tooltip: "EVALUATION",
                                          ),
                                          DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Text('ORDER',
                                                style: styleHeaderTable()),
                                            tooltip: "REPORT ORDER",
                                          ),
                                        ],
                                        rows: List<DataRow>.generate(
                                            kACReportData.length,
                                            (index) => DataRow(cells: [
                                                  DataCell(
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                            kACReportData[index]
                                                                .processReportName
                                                                .toString(),
                                                            style: styledata(
                                                                kACReportData[
                                                                        index]
                                                                    .patternReport)),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(_verticalDivider),
                                                  DataCell(Container(
                                                    width: 100,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                        kACReportData[index]
                                                            .itemReportName
                                                            .toString(),
                                                        style: styledata(
                                                            kACReportData[index]
                                                                .patternReport),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  )),
                                                  DataCell(_verticalDivider),
                                                  DataCell(Container(
                                                    //width: 50,
                                                    child: Center(
                                                      child: Text(
                                                        kACReportData[index]
                                                            .controlRange
                                                            .toString(),
                                                        style: styledata(
                                                            kACReportData[index]
                                                                .patternReport),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  )),
                                                  DataCell(_verticalDivider),
                                                  DataCell((() {
                                                    if (kACReportData[index]
                                                        .resultIn
                                                        .contains('pic_')) {
                                                      return Center(
                                                        child: Container(
                                                          child: IconButton(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            icon: Icon(
                                                                Icons.image),
                                                            onPressed: () {
                                                              showPicture(
                                                                  kACReportData[
                                                                          index]
                                                                      .resultIn,
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Center(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          width: 100,
                                                          child: Text(
                                                              kACReportData[
                                                                      index]
                                                                  .resultIn
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: styledata(
                                                                  kACReportData[
                                                                          index]
                                                                      .patternReport) /* TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Mitr',
                                                                  color: (() {
                                                                    if (kACReportData[index].evaluation ==
                                                                            "LOW" ||
                                                                        kACReportData[index].evaluation ==
                                                                            "HIGH")
                                                                      return Colors
                                                                          .red;
                                                                    else {
                                                                      return Colors
                                                                          .black;
                                                                    }
                                                                  }())) */
                                                              ),
                                                        ),
                                                      );
                                                    }
                                                  })()),
                                                  DataCell(_verticalDivider),
                                                  DataCell(TextResultReport(
                                                          index: index)

                                                      /* (() {
                                                    if (kACReportData[index]
                                                        .itemReportName
                                                        .contains('Picture')) {
                                                      return Center(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              child: IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                icon: Icon(
                                                                  Icons.image,
                                                                  color: checkEditData(
                                                                      kACReportData[
                                                                              index]
                                                                          .resultIn,
                                                                      kACReportData[
                                                                              index]
                                                                          .resultReport),
                                                                ),
                                                                onPressed: () {
                                                                  showPicture(
                                                                      kACReportData[
                                                                              index]
                                                                          .resultReport,
                                                                      context);
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              child: IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                icon: Icon(
                                                                  Icons.upload,
                                                                  color: checkEditData(
                                                                      kACReportData[
                                                                              index]
                                                                          .resultIn,
                                                                      kACReportData[
                                                                              index]
                                                                          .resultReport),
                                                                ),
                                                                onPressed: () {
                                                                  chooseImage(
                                                                      index);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      return Center(
                                                        child: Container(
                                                          width: 80,
                                                          child:
                                                              FormBuilderTextField(
                                                            /* textInputAction:
                                                                TextInputAction
                                                                    .next, */
                                                            style: styleDataResult(
                                                                kACReportData[
                                                                        index]
                                                                    .resultIn,
                                                                kACReportData[
                                                                        index]
                                                                    .resultReport),
                                                            decoration: InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                border:
                                                                    OutlineInputBorder()),
                                                            name:
                                                                'result$index',
                                                            initialValue:
                                                                kACReportData[
                                                                        index]
                                                                    .resultReport,
                                                            onChanged: (value) {
                                                              kACReportData[
                                                                          index]
                                                                      .resultReport =
                                                                  value
                                                                      .toString();
                                                              /* evaluate(index); */
                                                              /* setState(() {}); */
                                                            },
                                                            onSubmitted: (val) {
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  })() */
                                                      ),
                                                  DataCell(_verticalDivider),
                                                  DataCell(
                                                    Container(
                                                      width: 80,
                                                      child:
                                                          FormBuilderDropdown(
                                                        // shouldRequestFocus:
                                                        //     false,
                                                        style: styleEvaluate(
                                                            kACReportData[index]
                                                                .evaluation),
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            border:
                                                                OutlineInputBorder()),
                                                        items: evaluationOption
                                                            .map((option) =>
                                                                DropdownMenuItem(
                                                                  value: option,
                                                                  child: Text(
                                                                      '$option'),
                                                                ))
                                                            .toList(),
                                                        name:
                                                            'evaluation$index',
                                                        key: Key(
                                                            kACReportData[index]
                                                                .evaluation
                                                                .toString()),
                                                        initialValue:
                                                            kACReportData[index]
                                                                .evaluation,
                                                        onChanged: (value) {
                                                          kACReportData[index]
                                                                  .evaluation =
                                                              value.toString();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(_verticalDivider),
                                                  DataCell(
                                                    Container(
                                                      //width: 150,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                          kACReportData[index]
                                                              .reportOrder
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]))),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    children: [
                                      rowData(
                                        "COMMENT1",
                                        Expanded(
                                          child: FormBuilderTextField(
                                            style: styledata(''),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                border: OutlineInputBorder()),
                                            name: 'comment1',
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            initialValue:
                                                kACReportData[0].comment1,
                                            enabled: true,
                                            onChanged: (value) {
                                              print(value);
                                              kACReportData[0].comment1 =
                                                  value.toString();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      rowData(
                                        "COMMENT2",
                                        Expanded(
                                          child: FormBuilderTextField(
                                            style: styledata(''),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                border: OutlineInputBorder()),
                                            name: 'comment2',
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            initialValue:
                                                kACReportData[0].comment2,
                                            enabled: true,
                                            onChanged: (value) {
                                              kACReportData[0].comment2 =
                                                  value.toString();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      rowData(
                                        "COMMENT3",
                                        Expanded(
                                          child: FormBuilderTextField(
                                            style: styledata(''),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                border: OutlineInputBorder()),
                                            name: 'comment3',
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            initialValue:
                                                kACReportData[0].comment3,
                                            enabled: true,
                                            onChanged: (value) {
                                              kACReportData[0].comment3 =
                                                  value.toString();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      rowData(
                                        "COMMENT4",
                                        Expanded(
                                          child: FormBuilderTextField(
                                            style: styledata(''),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                border: OutlineInputBorder()),
                                            name: 'comment4',
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            initialValue:
                                                kACReportData[0].comment4,
                                            enabled: true,
                                            onChanged: (value) {
                                              kACReportData[0].comment4 =
                                                  value.toString();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      rowData(
                                        "COMMENT5",
                                        Expanded(
                                          child: FormBuilderTextField(
                                            style: styledata(''),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                border: OutlineInputBorder()),
                                            name: 'comment5',
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            initialValue:
                                                kACReportData[0].comment5,
                                            enabled: true,
                                            onChanged: (value) {
                                              kACReportData[0].comment5 =
                                                  value.toString();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  /* 
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT3",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment3',
                                          initialValue:
                                              kACReportData[0].comment3,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment3 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT4",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment4',
                                          initialValue:
                                              kACReportData[0].comment4,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment4 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT5",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment5',
                                          initialValue:
                                              kACReportData[0].comment5,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment5 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT6",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment6',
                                          initialValue:
                                              kACReportData[0].comment6,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment6 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT7",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment7',
                                          initialValue:
                                              kACReportData[0].comment7,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment7 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT8",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment8',
                                          initialValue:
                                              kACReportData[0].comment8,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment8 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT9",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment9',
                                          initialValue:
                                              kACReportData[0].comment9,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment9 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "COMMENT10",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'comment10',
                                          initialValue:
                                              kACReportData[0].comment10,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].comment10 =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ), */
                                  Container(
                                    height: heightBox1,
                                    child: rowData(
                                      "REPORT REMARK",
                                      Expanded(
                                        child: FormBuilderTextField(
                                          style: styledata(''),
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder()),
                                          name: 'reportRemark',
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          initialValue:
                                              kACReportData[0].reportRemark,
                                          enabled: true,
                                          onChanged: (value) {
                                            kACReportData[0].reportRemark =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (kACReportData[0].reviseNo == 0 &&
                                      userCheck)
                                    Container(
                                      height: 50,
                                      child: Center(
                                        child: IconButton(
                                          tooltip: "CREATE NEW REPORT",
                                          icon: Icon(
                                            Icons.save,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            createReport();
                                          },
                                        ),
                                      ),
                                    ),
                                  if (userCheck &&
                                      (kACReportData[0].reviseNo >= 1 ||
                                          kACReportData[0].nextApprover ==
                                              'COMPLETE'))
                                    Container(
                                      height: 50,
                                      child: Center(
                                        child: IconButton(
                                          tooltip: "REVISE REPORT/OVER WRITE",
                                          icon: Icon(
                                            Icons.save,
                                            color: Colors.amber,
                                          ),
                                          onPressed: () {
                                            reviseReport();
                                          },
                                        ),
                                      ),
                                    ),
                                  if (userCheck &&
                                      kACReportData[0].reviseNo < 3 &&
                                      kACReportData[0].nextApprover ==
                                          'COMPLETE')
                                    Container(
                                      height: 50,
                                      child: Center(
                                        child: IconButton(
                                          tooltip: "REVISE NEW REPORT",
                                          icon: Icon(
                                            Icons.save,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            reviseReport();
                                          },
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text("NO DATA");
                }
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);

Container rowData(String sectionName, Widget data) {
  double heightBox1 = 25;
  double widthsection1 = 160;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

  return Container(
    //height: heightBox1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Container(
          width: widthsection1,
          child: Text(
            sectionName,
            style: stylesection,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        data,
      ],
    ),
  );
}

TextStyle styleDataResult(String dataIn1, String dataIn2) {
  Color colorSelect = Colors.black;
  if (dataIn1.toString() != dataIn2.toString()) {
    colorSelect = Colors.red;
  }
  return TextStyle(fontSize: 12, fontFamily: 'Mitr', color: colorSelect);
}

Color checkEditData(String dataIn1, String dataIn2) {
  Color colorResult = Colors.black;
  print(dataIn1 + '-' + dataIn2);
  if (dataIn1 != dataIn2) {
    colorResult = Colors.red;
  }
  return colorResult;
}

class TextResultReport extends StatefulWidget {
  int index = 0;
  TextResultReport({Key? key, required this.index}) : super(key: key);

  @override
  State<TextResultReport> createState() => _TextResultReportState();
}

class _TextResultReportState extends State<TextResultReport> {
  chooseImage(int index) async {
    try {
      kACReportPic.clear();
      kACReportPic.add(kACReportData[index]);
      final result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      Uint8List? imageByte;
      if (result?.files.first != null) {
        imageByte = result?.files.first.bytes;
      }
      Uint8List? resizedData;
      IMG.Image? img = IMG.decodeImage(imageByte!);
      /* IMG.Image resized = IMG.copyResize(img!, width: 250, height: 250);
      resizedData = IMG.encodeJpg(resized) as Uint8List?; */
      resizedData = IMG.encodeJpg(img!) as Uint8List?;
      var buffPath = '';
      buffPath = await saveKACReportPic(base64.encode(resizedData!));
      print(buffPath);
      if (buffPath != '') {
        kACReportData[index].resultReport = buffPath;
        print(kACReportData[index].resultReport);
      }
      //print(dataSEMInput[index].result_1);
      //var outputAsUint8List = new Uint8List.fromList(s.codeUnits);
      /* setState(() {}); */
    } on Error catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(child: Container(child: (() {
      if (kACReportData[widget.index].itemReportName.contains('Pic') ||
          kACReportData[widget.index].itemReportName.contains('SEM') ||
          kACReportData[widget.index].itemName.contains('SEM') ||
          kACReportData[widget.index].itemName.contains('Pic') ||
          kACReportData[widget.index].itemReportName.contains('Image') ||
          kACReportData[widget.index].itemName.contains('Image')) {
        return Center(
          child: Row(
            children: [
              Container(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.image,
                    color: checkEditData(kACReportData[widget.index].resultIn,
                        kACReportData[widget.index].resultReport),
                  ),
                  onPressed: () {
                    showPicture(
                        kACReportData[widget.index].resultReport, context);
                  },
                ),
              ),
              Container(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.upload,
                    color: checkEditData(kACReportData[widget.index].resultIn,
                        kACReportData[widget.index].resultReport),
                  ),
                  onPressed: () {
                    chooseImage(widget.index);
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
          child: Container(
            width: 80,
            child: FormBuilderTextField(
              /* textInputAction:
                                                                TextInputAction
                                                                    .next, */
              style: styleDataResult(kACReportData[widget.index].resultIn,
                  kACReportData[widget.index].resultReport),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder()),
              name: 'result$widget.index',
              initialValue: kACReportData[widget.index].resultReport,
              onChanged: (value) {
                kACReportData[widget.index].resultReport = value.toString();
                /* evaluate(index); */
                /* setState(() {}); */
              },
              onSubmitted: (val) {
                setState(() {});
              },
            ),
          ),
        );
      }
    })()));
  }
}
