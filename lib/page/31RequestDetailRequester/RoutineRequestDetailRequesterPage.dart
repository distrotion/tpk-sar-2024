import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cool_alert/cool_alert.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:tpk_login_arsa_01/Global/dataTime.dart';
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPDF/ShowPDF.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPicture/ShowPicture.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_ActualLineInput/ActaulLineInput.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_Report/KACReport.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/data/RoutineRequestDetailRequesterPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/data/RoutineRequestDetailRequesterPage_event.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as dart_ui;
import 'dart:html' as html; //ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js; // ignore: avoid_web_libraries_in_flutter

//----------------
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import '../20SubPage/HistoryChart/Data/ManageChartDataStructure.dart';
//----------------

late BuildContext contextRoutineRequestDetail;
final GlobalKey _globalKey = GlobalKey();

class RoutineRequestDetailRequesterPage extends StatelessWidget {
  const RoutineRequestDetailRequesterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataRoutineRequestDetailRequesterPage>(
          create: (BuildContext context) =>
              ManageDataRoutineRequestDetailRequesterPage(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 10),
          child: Column(
            children: [
              SampleDetail(),
              //HistoryData(),
            ],
          ),
        ),
      ),
    );
  }
}

class SampleDetail extends StatefulWidget {
  const SampleDetail({Key? key}) : super(key: key);

  @override
  _SampleDetailState createState() => _SampleDetailState();
}

class _SampleDetailState extends State<SampleDetail> {
  void initState() {
    print("InINITIAL");
    super.initState();
    context
        .read<ManageDataRoutineRequestDetailRequesterPage>()
        .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
  }

  void cancelRequest(int indexSample) {
    CoolAlert.show(
      barrierDismissible: false,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'CANCEL REQUEST',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Text(sampleData[indexSample].custFull),
      onConfirmBtnTap: () {
        cancelRequestData.clear();
        cancelRequestData.add(sampleData[indexSample]);
        context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.cancelRequest,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void cancelSample(int indexSample) {
    CoolAlert.show(
      barrierDismissible: false,
      width: 200,
      context: context,
      type: CoolAlertType.confirm,
      text: 'CANCEL SAMPLE',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Text(sampleData[indexSample].sampleName.toString()),
      onConfirmBtnTap: () {
        cancelSampleData.clear();
        cancelSampleData.add(sampleData[indexSample]);
        context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.cancelSample,
            );
        // Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void cancelItem(int indexSample, int indexItem) {
    CoolAlert.show(
      barrierDismissible: false,
      width: 200,
      context: context,
      type: CoolAlertType.confirm,
      text: 'CANCEL ITEM',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Text(itemData[indexSample][indexItem].itemName.toString()),
      onConfirmBtnTap: () {
        cancelItemData.clear();
        cancelItemData.add(itemData[indexSample][indexItem]);
        context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.cancelItem,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  void reconfirmResult(int indexSample, int indexItem) {
    CoolAlert.show(
      barrierDismissible: false,
      width: 200,
      context: context,
      type: CoolAlertType.confirm,
      text: 'RECONFIRM',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Text(itemData[indexSample][indexItem].itemName.toString()),
      onConfirmBtnTap: () {
        reconfirmResultData.clear();
        reconfirmResultData.add(itemData[indexSample][indexItem]);
        context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.submitReconfirmResult,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void completeResult(int indexSample, int indexItem) {
    CoolAlert.show(
      barrierDismissible: false,
      width: 200,
      context: context,
      type: CoolAlertType.confirm,
      text: 'CONFIRM RESULT',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Text(itemData[indexSample][indexItem].itemName.toString()),
      onConfirmBtnTap: () {
/*         itemData[indexSample][indexItem].resultCompleteSymbol =
            itemData[indexSample][indexItem].resultApproveSymbol;
        itemData[indexSample][indexItem].resultComplete =
            itemData[indexSample][indexItem].resultApprove;
        itemData[indexSample][indexItem].resultCompleteUnit =
            itemData[indexSample][indexItem].resultApproveUnit;
        itemData[indexSample][indexItem].resultCompleteFile =
            itemData[indexSample][indexItem].resultApproveFile; */
        completeResultData.clear();
        completeResultData.add(itemData[indexSample][indexItem]);
        context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.submitCompleteResult,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void completeAllResult() {
    int countItem = 0;
    completeAllResultData.clear();
    for (int i = 0; i < itemData.length; i++) {
      for (int j = 0; j < itemData[i].length; j++) {
        if (itemData[i][j].selected == true) {
/*           itemData[i][j].resultCompleteSymbol =
              itemData[i][j].resultApproveSymbol;
          itemData[i][j].resultComplete = itemData[i][j].resultApprove;
          itemData[i][j].resultCompleteUnit = itemData[i][j].resultApproveUnit;
          itemData[i][j].resultCompleteFile = itemData[i][j].resultApproveFile; */
          completeAllResultData.add(itemData[i][j]);
          countItem++;
        }
      }
    }
    if (countItem > 0) {
      CoolAlert.show(
        barrierDismissible: true,
        width: 400,
        context: context,
        type: CoolAlertType.confirm,
        text: 'CONFIRM COMPLETE RESULT',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        loopAnimation: true,
        widget: Text("$countItem ITEM"),
        //       Text("ITEM ${itemData[indexSample][indexItem].itemName.toString()}"),
        onConfirmBtnTap: () {
          context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
                RoutineRequestDetailRequesterPageEvent.submitCompleteAllResult,
              );
          //Navigator.pop(context);
        },
        onCancelBtnTap: () {
          //Navigator.pop(context);
        },
      );
    } else {
      CoolAlert.show(
        barrierDismissible: false,
        width: 400,
        context: context,
        type: CoolAlertType.error,
        text: 'NO RESULT SELECTED',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        loopAnimation: true,
        onConfirmBtnTap: () {
          //Navigator.pop(context);
        },
        onCancelBtnTap: () {
          //Navigator.pop(context);
        },
      );
    }
  }

  void selectPrint(int indexSample) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          String initialPrint = "";
          if (userSection == "MKT") {
            if (userBranch == "BANGPOO") {
              initialPrint = "BPMKT";
            } else {
              initialPrint = "RYMKT";
            }
          } else {
            if (userBranch == "BANGPOO") {
              initialPrint = "BPTTC";
            } else {
              initialPrint = "RYTTC";
            }
          }
          dataReprint.clear();
          for (int i = 0; i < itemData[indexSample].length; i++) {
            dataReprint.add(itemData[indexSample][i]);
          }

          //print('11111' + '${itemData[indexSample].length}');
          //print(modelFullRequestDataToJson(sampleData[indexSample][]));
          selectedPrinter = initialPrint;
          return AlertDialog(
            title: Text('SELECT PRINTER'),
            content: Container(
              width: 600,
              child: FormBuilderSegmentedControl(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                name: 'printer',
                initialValue: initialPrint,
                options: [
                  FormBuilderFieldOption(
                      value: 'BPMKT',
                      child: Text(
                        'MARKETING BANGPOO',
                        style: styleHeaderTable,
                      )),
                  FormBuilderFieldOption(
                      value: 'RYMKT',
                      child: Text(
                        'MARKETING RAYONG',
                        style: styleHeaderTable,
                      )),
                  FormBuilderFieldOption(
                      value: 'BPTTC',
                      child: Text(
                        'TTC BANGPOO',
                        style: styleHeaderTable,
                      )),
                  FormBuilderFieldOption(
                      value: 'RYTTC',
                      child: Text(
                        'TTC RAYONG',
                        style: styleHeaderTable,
                      )),
                ],
                onChanged: (value) {
                  selectedPrinter = value.toString();
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    await reprintTag();
                    Navigator.pop(context);
                  },
                  child: Text('YES')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('NO'),
              )
            ],
          );
        });
  }

  void approveReport() {
    var buffComment = "";
    CoolAlert.show(
      barrierDismissible: false,
      width: 200,
      showCancelBtn: true,
      context: context,
      type: CoolAlertType.custom,
      text: 'APPROVE REPORT',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: false,
      widget: TextField(
        style: styleDataInTable,
        decoration: InputDecoration(
            hintText: 'COMMENT',
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder()),
        onChanged: (value) {
          buffComment = value.toString();
        },
      ),
      onConfirmBtnTap: () {
        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);

        apprvoeReportData.clear();
        apprvoeReportData.add(sampleData[0]);
        apprvoeReportData[0].reportRemark = requestData[0].reportRemark +
            '\n' +
            userName +
            "  " +
            toDateOnly(date.toString()) +
            ' : ' +
            buffComment;
        /* context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.cancelSample,
            ); */
        //Navigator.pop(context);
        saveApproveReport();
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void rejectReport() {
    rejectReportData.clear();
    rejectReportData.add(sampleData[0]);
    CoolAlert.show(
      barrierDismissible: true,
      width: 200,
      context: context,
      type: CoolAlertType.custom,
      text: 'REJECT REPORT',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      showCancelBtn: true,
      confirmBtnColor: Colors.amber,
      widget: TextField(
        style: styleDataInTable,
        decoration: InputDecoration(
            hintText: 'REJECT COMMENT',
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder()),
        onChanged: (value) {
          rejectReportData[0].reportRejectRemark = value.toString();
        },
      ),
      onConfirmBtnTap: () {
        /* context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.cancelSample,
            ); */
        //Navigator.pop(context);
        saveRejectReport();
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void deleteActualLine(String reqNo) {
    CoolAlert.show(
      barrierDismissible: true,
      width: 200,
      context: context,
      type: CoolAlertType.warning,
      text: 'DELETE ACTUAL LINE DATA && REPORT ',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      onConfirmBtnTap: () {
        reqNoDeleteActual = reqNo;
        /* context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.cancelSample,
            ); */
        //Navigator.pop(context);
        submitDeleteAcutal();
      },
      onCancelBtnTap: () {
        // Navigator.pop(context);
      },
    );
  }

  void deleteReport(String reqNo) {
    CoolAlert.show(
      barrierDismissible: true,
      width: 200,
      context: context,
      type: CoolAlertType.warning,
      text: 'DELETE REPORT',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      onConfirmBtnTap: () {
        reqNoDelete = reqNo;
        /* context.read<ManageDataRoutineRequestDetailRequesterPage>().add(
              RoutineRequestDetailRequesterPageEvent.cancelSample,
            ); */
        // Navigator.pop(context);
        submitDeleteReport();
      },
      onCancelBtnTap: () {
        // Navigator.pop(context);
      },
    );
  }

  void showImage(int indexSample, int indexItem) {
    var outputAsUint8List;
    outputAsUint8List =
        base64.decode(itemData[indexSample][indexItem].resultApprove);
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

/*   void showHistory(String _itemID, String _itemName, String _max, String _min) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: Text('HISTORY DATA'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 600,
                child: HistoryChart(
                  itemID: _itemID,
                  itemName: _itemName,
                  section: "OTHER",
                  max: _max,
                  min: _min,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Call a function to download data to CSV file
                downloadDataToCSV(_itemID, _itemName, _max, _min);
                Navigator.pop(context);
              },
              child: Text('Download data to CSV File'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
 */
  void showHistory(String _itemID, String _itemName, String _max, String _min) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: Text('HISTORY DATA'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  width: 600,
                  child: HistoryChart(
                    itemID: _itemID,
                    itemName: _itemName,
                    section: "OTHER",
                    max: _max,
                    min: _min,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                captureToback(_globalKey).then((value) {
                  print(value);

                  // Navigator.pop(context);
                });
              },
              child: Text('Download Chart'),
            ),
            ElevatedButton(
              onPressed: () 
              {
                
                downloadDataToExcel(_itemID, _itemName, _max, _min );
                Navigator.pop(context);
              },
              child: Text('Download Excel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  //mark

  void approveHistory(String reqNo) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('APPROVE HISTORY DATA'),
            content: FutureBuilder(
                future: searchHistoryApproveReport(reqNo),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != 0) {
                    return Container(
                        //width: 1500,
                        /* padding: EdgeInsets.only(
                          top: 25,
                          left: 25,
                          right: 25,
                          bottom: 25,
                        ), */
                        decoration: BoxDecoration(
                          color: CustomTheme.colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          boxShadow: [
                            BoxShadow(
                                color: CustomTheme.colorShadowBgStrong,
                                offset: Offset(0, 0),
                                //blurRadius: 10,
                                spreadRadius: 0)
                          ],
                        ),
                        child: DataTable(
                            columnSpacing: 5,
                            horizontalMargin: 10,
                            dataRowHeight: 60,
                            columns: [
                              DataColumn(
                                label: Container(
                                  //width: 120,
                                  child: Text('USER', style: styleHeaderTable),
                                ),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Container(
                                  //width: 120,
                                  child: Text('TIME', style: styleHeaderTable),
                                ),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Container(
                                  //width: 120,
                                  child:
                                      Text('REMARK', style: styleHeaderTable),
                                ),
                              ),
                              if (historyReportData[0].reviseNo >= 1) ...[
                                DataColumn(label: _verticalDivider),
                                DataColumn(
                                  label: Container(
                                    //width: 120,
                                    child: Text('TIME Rev1',
                                        style: styleHeaderTable),
                                  ),
                                ),
                                DataColumn(label: _verticalDivider),
                                DataColumn(
                                  label: Container(
                                    //width: 120,
                                    child: Text('REMARK Rev1',
                                        style: styleHeaderTable),
                                  ),
                                ),
                              ],
                              if (historyReportData[0].reviseNo >= 2) ...[
                                DataColumn(label: _verticalDivider),
                                DataColumn(
                                  label: Container(
                                    //width: 120,
                                    child: Text('TIME Rev2',
                                        style: styleHeaderTable),
                                  ),
                                ),
                                DataColumn(label: _verticalDivider),
                                DataColumn(
                                  label: Container(
                                    //width: 120,
                                    child: Text('REMARK Rev2',
                                        style: styleHeaderTable),
                                  ),
                                ),
                              ],
                              if (historyReportData[0].reviseNo >= 3) ...[
                                DataColumn(label: _verticalDivider),
                                DataColumn(
                                  label: Container(
                                    //width: 120,
                                    child: Text('TIME Rev3',
                                        style: styleHeaderTable),
                                  ),
                                ),
                                DataColumn(label: _verticalDivider),
                                DataColumn(
                                  label: Container(
                                    //width: 120,
                                    child: Text('REMARK Rev3',
                                        style: styleHeaderTable),
                                  ),
                                ),
                              ],

                              /* DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Container(
                                  width: 120,
                                  child:
                                      Text('TIME Rev5', style: styleHeaderTable),
                                ),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Container(
                                  width: 120,
                                  child:
                                      Text('REMARK Rev5', style: styleHeaderTable),
                                ),
                              ), */
                            ],
                            rows: List<DataRow>.generate(
                                historyReportData.length,
                                (index) => DataRow(cells: [
                                      DataCell(
                                        Container(
                                          child: Text(
                                              historyReportData[index]
                                                  .name
                                                  .toString(),
                                              style: styleDataInTable),
                                        ),
                                      ),
                                      DataCell(_verticalDivider),
                                      DataCell(
                                        Container(
                                          child: Text(
                                              toDateTime(
                                                  historyReportData[index]
                                                      .time0
                                                      .toString()),
                                              style: styleDataInTable),
                                        ),
                                      ),
                                      DataCell(_verticalDivider),
                                      DataCell(
                                        Container(
                                          child: Text(
                                              historyReportData[index]
                                                  .remark0
                                                  .toString(),
                                              style: styleDataInTable),
                                        ),
                                      ),
                                      if (historyReportData[0].reviseNo >=
                                          1) ...[
                                        DataCell(_verticalDivider),
                                        DataCell(
                                          Container(
                                            child: Text(
                                                toDateTime(
                                                    historyReportData[index]
                                                        .time1
                                                        .toString()),
                                                style: styleDataInTable),
                                          ),
                                        ),
                                        DataCell(_verticalDivider),
                                        DataCell(
                                          Container(
                                            child: Text(
                                                historyReportData[index]
                                                    .remark1
                                                    .toString(),
                                                style: styleDataInTable),
                                          ),
                                        ),
                                      ],
                                      if (historyReportData[0].reviseNo >=
                                          2) ...[
                                        DataCell(_verticalDivider),
                                        DataCell(
                                          Container(
                                            child: Text(
                                                toDateTime(
                                                    historyReportData[index]
                                                        .time2
                                                        .toString()),
                                                style: styleDataInTable),
                                          ),
                                        ),
                                        DataCell(_verticalDivider),
                                        DataCell(
                                          Container(
                                            child: Text(
                                                historyReportData[index]
                                                    .remark2
                                                    .toString(),
                                                style: styleDataInTable),
                                          ),
                                        ),
                                      ],
                                      if (historyReportData[0].reviseNo >=
                                          3) ...[
                                        DataCell(_verticalDivider),
                                        DataCell(
                                          Container(
                                            child: Text(
                                                toDateTime(
                                                    historyReportData[index]
                                                        .time3
                                                        .toString()),
                                                style: styleDataInTable),
                                          ),
                                        ),
                                        DataCell(_verticalDivider),
                                        DataCell(
                                          Container(
                                            child: Text(
                                                historyReportData[index]
                                                    .remark3
                                                    .toString(),
                                                style: styleDataInTable),
                                          ),
                                        ),
                                      ]
                                      /* DataCell(_verticalDivider),
                                      DataCell(
                                        Container(
                                          child: Text(
                                              toDateTime(
                                                  historyReportData[index]
                                                      .time5
                                                      .toString()),
                                              style: styleDataInTable),
                                        ),
                                      ),
                                      DataCell(_verticalDivider),
                                      DataCell(
                                        Container(
                                          child: Text(
                                              historyReportData[index]
                                                  .remark5
                                                  .toString(),
                                              style: styleDataInTable),
                                        ),
                                      ), */
                                    ]))));
                  } else {
                    return Container();
                  }
                }),
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

  void editStd(int indexSample, int indexItem) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('FACTOR EDIT'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 500,
                    child: EditStdFactor(
                      indexSample: indexSample,
                      indexItem: indexItem,
                    )),
                Container(
                  //height: 50,
                  child: Center(
                    child: IconButton(
                      tooltip: "SAVE DATA",
                      icon: Icon(
                        Icons.save,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        dataEditFactor.clear();
                        dataEditFactor.add(itemData[indexSample][indexItem]);
                        await submitEditStd();
                      },
                    ),
                  ),
                )
              ],
            ),
            /* actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ], */
          );
        });
  }

  void editReportName(int indexSample, int indexItem) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('EDIT REPORT NAME'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 500,
                    child: EditReportName(
                      indexSample: indexSample,
                      indexItem: indexItem,
                    )),
                Container(
                  //height: 50,
                  child: Center(
                    child: IconButton(
                      tooltip: "SAVE DATA",
                      icon: Icon(
                        Icons.save,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        dataEditReportName.clear();
                        dataEditReportName
                            .add(itemData[indexSample][indexItem]);
                        await submitEditReportName();
                      },
                    ),
                  ),
                )
              ],
            ),
            /* actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ], */
          );
        });
  }

  final _formKey = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  TextStyle styleHeaderTable =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');
  bool userCheck = false;
  bool settingView = false;

  @override
  Widget build(BuildContext context) {
    contextRoutineRequestDetail = context;
    return Form(
      key: _formKey,
      child: BlocBuilder<ManageDataRoutineRequestDetailRequesterPage, int>(
          builder: (context, state) {
        print("rebuild state :$state");
        if (state == 1) {
          if (userName == requestData[0].incharge ||
              userName == requestData[0].reqUser ||
              userSection == requestData[0].incharge ||
              userRoleId == 99) {
            userCheck = true;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  //width: 1500,
                  //height: 450,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 25,
                    right: 25,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: CustomTheme.colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    boxShadow: [
                      BoxShadow(
                          color: CustomTheme.colorShadowBgStrong,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //mainAxisSize: MainAxisSize.max,
                    children: [
                      rowData(
                        "REQUEST NO",
                        Container(
                          child: Text(
                            requestData[0].reqNo.toString(),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "JOB TYPE",
                        Container(
                          child: Text(
                            requestData[0].jobType.toString(),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "CUSTOMER NAME",
                        Container(
                          child: Text(
                            requestData[0].custFull.toString(),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "SAMPLING DATE",
                        Container(
                          child: Text(
                            toDateOnly(requestData[0].samplingDate.toString()),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "REQUEST REMARK",
                        Container(
                          child: Text(
                            requestData[0].requestRemark.toString(),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "REQUEST ATTACH FILE",
                        Container(
                          child: Text(
                            requestData[0].requestAttachFile.toString(),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "INCHARGE",
                        Container(
                          child: Text(
                            requestData[0].incharge,
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "REQUEST BY",
                        Container(
                          child: Text(
                            requestData[0].reqUser.toString() +
                                "    " +
                                toDateTime(requestData[0].reqDate.toString()),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "REQUEST STATUS",
                        Container(
                          child: statusRequest(
                            requestData[0].requestStatus.toString(),
                          ),
                        ),
                      ),
                      rowData(
                        "ACTUAL LINE DATA",
                        Row(
                          children: [
                            Container(
                                child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.article),
                              onPressed: () {
                                ActualLineDataPopUp(
                                    requestData[0].reqNo.toString(),
                                    requestData[0].custFull.toString(),
                                    requestData[0].samplingDate.toString());
                              },
                            )),
                            if (userCheck)
                              Container(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteActualLine(
                                        requestData[0].reqNo.toString());
                                  },
                                ),
                              ),
                            Text(
                              toDateTime(
                                  requestData[0].inputDataDate.toString()),
                            )
                          ],
                        ),
                      ),
                      rowData(
                        "RAW REPORT DATA",
                        Row(
                          children: [
                            Container(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.article),
                                onPressed: () {
                                  //alertLoading();
                                  KACReportDataPopUp(
                                      requestData[0].reqNo.toString());
                                },
                              ),
                            ),
                            if (userCheck)
                              Container(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteReport(
                                        requestData[0].reqNo.toString());
                                  },
                                ),
                              ),
                            Text(
                              toDateTime(
                                  requestData[0].createReportDate.toString()),
                            ),
                            /* Container(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  loadReport(requestData[0].reqNo.toString());
                                },
                              ),
                            ), */
                          ],
                        ),
                      ),
                      if (requestData[0].reportRejectRemark.toString() != "" &&
                          requestData[0].reportRejectRemark.toString() !=
                              "-") ...[
                        rowData(
                            "REJECT REMARK",
                            Text(
                              requestData[0].reportRejectRemark,
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                      if (requestData[0].subLeader.toString() != "") ...[
                        rowData(
                          "REPORT",
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 22,
                                  icon: Icon(Icons.article),
                                  onPressed: () {
                                    loadReport(requestData[0].reqNo.toString());
                                    /* KACReportDataPopUp(
                                        requestData[0].reqNo.toString()); */
                                    /*  _launchURL(
                                        'http://172.23.10.51/ReportServer?%2fReport+Project1%2fSAR_KAC&rs:Format=PDF&rs:ClearSession=true&rs:Command=Render&ReqNo=${requestData[0].reqNo}');
                                    */ //http://172.23.10.51/ReportServer/Pages/ReportViewer.aspx?%2fReport+Project1%2fSAR_KAC_TestOp2&rs:Command=Render
                                    /* _launchURL(
                                        'http://172.20.30.46/ReportServer/Pages/ReportViewer.aspx?%2fReport+Project4%2fTPK-SAR-${requestData[0].patternReport}&:Command=Render&T1=${requestData[0].reqNo}'); */
                                  },
                                ),
                              ),
                              if (requestData[0].nextApprover == userName) ...[
                                Container(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 22,
                                    icon: Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      approveReport();
                                    },
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 22,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      rejectReport();
                                    },
                                  ),
                                ),
                              ],
                              if (requestData[0].nextApprover == 'COMPLETE')
                                Text(
                                  '            ' +
                                      toDateTime(requestData[0]
                                          .reportCompleteDate
                                          .toString()),
                                ),
                            ],
                          ),
                        ),
                        if (requestData[0].reportRemark != '' &&
                            requestData[0].reportRemark != '-') ...[
                          SizedBox(
                            height: 5,
                          ),
                          rowData3(
                            "REPORT REAMRK :",
                            Text(
                              requestData[0].reportRemark,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                        rowData(
                          "NEXT APPROVER",
                          Container(
                            child: Text(requestData[0].nextApprover.toString()),
                          ),
                        ),
                        rowData(
                          "APPROVE HISTORY",
                          Container(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 22,
                              icon: Icon(
                                Icons.history,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                approveHistory(requestData[0].reqNo);
                              },
                            ),
                          ),
                        ),
                      ],
                      /*  rowData(
                          "CANCEL REQUEST",
                          (() {
                            if (userCheck)
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  cancelRequest(0);
                                },
                              );
                            else
                              return Container();
                          }())), */
                      rowData(
                        "SETTING VIEW",
                        Container(
                            child: Switch(
                          value: settingView,
                          onChanged: (bool value) {
                            setState(() {
                              settingView = value;
                            });
                          },
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  //width: 1500,
                  margin: EdgeInsets.only(
                    top: 25,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    shrinkWrap: true,
                    //padding: const EdgeInsets.all(8),
                    itemCount: sampleData.length,
                    itemBuilder: (BuildContext context, int indexSample) {
                      return Container(
                        //width: 1500,
                        padding: EdgeInsets.only(
                          top: 25,
                          left: 25,
                          right: 25,
                          bottom: 25,
                        ),
                        decoration: BoxDecoration(
                          color: CustomTheme.colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          boxShadow: [
                            BoxShadow(
                                color: CustomTheme.colorShadowBgStrong,
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 0)
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'SAMPLE CODE  : ${sampleData[indexSample].sampleCode.toString()}',
                                        style: stylesection,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            rowData(
                                              "SAMPLE GROUP",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .sampleGroup
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLE TYPE",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .sampleType
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLE TANK",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .sampleTank
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLE NAME",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .sampleName
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLE AMOUNT",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .sampleAmount
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLE STATUS",
                                              Container(
                                                child: statusSample(
                                                  sampleData[indexSample]
                                                      .sampleStatus
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLING DATE",
                                              Container(
                                                child: Text(
                                                  toDateOnly(sampleData[
                                                              indexSample]
                                                          .samplingDate
                                                          .toString()) +
                                                      '    ( Send : ' +
                                                      toDateTime(sampleData[
                                                              indexSample]
                                                          .sendDate
                                                          .toString()) +
                                                      " )",
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            rowData(
                                              "RECEIVE BY",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                          .userReceive
                                                          .toString() +
                                                      "   " +
                                                      toDateOnly(sampleData[
                                                              indexSample]
                                                          .receiveDate
                                                          .toString()),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "REJECT BY",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                          .userReject
                                                          .toString() +
                                                      "   " +
                                                      toDateOnly(sampleData[
                                                              indexSample]
                                                          .rejectDate
                                                          .toString()),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "REJECT REMARK",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .remarkReject
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLE ATTACH FILE",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .sampleAmount
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "SAMPLE REMARK",
                                              Container(
                                                child: Text(
                                                  sampleData[indexSample]
                                                      .sampleRemark
                                                      .toString(),
                                                  style: styledata,
                                                ),
                                              ),
                                            ),
                                            rowData(
                                              "REPRINT SAMPLE TAG",
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.print,
                                                ),
                                                onPressed: () {
                                                  selectPrint(indexSample);
                                                },
                                              ),
                                            ),
                                            rowData(
                                                "CANCEL SAMPLE",
                                                (() {
                                                  if (userCheck)
                                                    return IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        cancelSample(
                                                            indexSample);
                                                      },
                                                    );
                                                  else
                                                    return Container();
                                                }())),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomTheme.colorWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomTheme.colorShadowBgStrong,
                                      offset: Offset(0, 0),
                                      blurRadius: 0,
                                      spreadRadius: 0)
                                ],
                              ),
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    columnSpacing: 5,
                                    horizontalMargin: 10,
                                    dataRowHeight: 60,
                                    columns: [
                                      DataColumn(
                                        label: Container(
                                          width: 120,
                                          child: Text('PROCESS',
                                              style: styleHeaderTable),
                                        ),
                                        tooltip: "PROCESS REPORT NAME",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Container(
                                          width: 120,
                                          child: Text('ITEM',
                                              style: styleHeaderTable),
                                        ),
                                        tooltip: "ITEM NAME",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Container(
                                          width: 120,
                                          child: Text('ITEM STATUS',
                                              style: styleHeaderTable),
                                        ),
                                        tooltip: "STATUS ITEM",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('MAG',
                                            style: styleHeaderTable),
                                        tooltip: "MAGNIFICATION",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('POS',
                                            style: styleHeaderTable),
                                        tooltip: "POSITION",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('TEMP',
                                            style: styleHeaderTable),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('MAX',
                                            style: styleHeaderTable),
                                        tooltip: "CONTROL RANGE MAX",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('MIN',
                                            style: styleHeaderTable),
                                        tooltip: "CONTROL RANGE MIN",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('HISTORY',
                                            style: styleHeaderTable),
                                        tooltip: "HISTORY",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('RAW LAB RESULT',
                                            style: styleHeaderTable),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('STD FACTOR',
                                            style: styleHeaderTable),
                                      ),
                                      if (settingView) ...[
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD1(+)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD2(-)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD3(x)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD4(/)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD5(+)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD6(-)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD7(x)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('STD8(/)',
                                              style: styleHeaderTable),
                                        ),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                          label: Text('REPORT ORDER',
                                              style: styleHeaderTable),
                                        ),
                                      ],
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('RESULT',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT ACTUAL"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Container(
                                            width: 150,
                                            child: Text('RESULT COMMENT',
                                                style: styleHeaderTable),
                                          ),
                                          tooltip: "RESULT COMMENT"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('APPROVER',
                                              style: styleHeaderTable),
                                          tooltip: "APPROVE BY"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('PATH',
                                              style: styleHeaderTable),
                                          tooltip: "SEM"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('RECONFIRM REMARK',
                                            style: styleHeaderTable),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('RECONFIRM',
                                            style: styleHeaderTable),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('ACCEPT',
                                            style: styleHeaderTable),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('CANCEL ITEM',
                                            style: styleHeaderTable),
                                      ),
                                    ],
                                    rows: List<DataRow>.generate(
                                        itemData[indexSample].length,
                                        (indexItem) => DataRow(cells: [
                                              DataCell(
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .processReportName
                                                              .toString(),
                                                          style:
                                                              styleDataInTable),
                                                    ),
                                                    if (settingView)
                                                      Container(
                                                        child: IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          icon: Icon(
                                                            Icons.settings,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            editReportName(
                                                                indexSample,
                                                                indexItem);
                                                          },
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              DataCell(_verticalDivider),
                                              DataCell(
                                                Container(
                                                  child: Text(
                                                      itemData[indexSample]
                                                              [indexItem]
                                                          .itemReportName
                                                          .toString(),
                                                      style: styleDataInTable),
                                                ),
                                              ),
                                              DataCell(_verticalDivider),
                                              /* DataCell((() {
                                                if (itemData.length > 0) {
                                                  return Text("aaa");
                                                } else {
                                                  return Text("bbbb");
                                                }
                                              }())), */
                                              DataCell(Center(
                                                child: statusItem(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .itemStatus
                                                        .toString(),
                                                    12),
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .mag
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .position
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .temp
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .stdMax
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .stdMin
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(
                                                //History Data
                                                Center(
                                                  child: IconButton(
                                                    icon: Icon(Icons.insights),
                                                    onPressed: () {
                                                      setState(() {
                                                        /* showHistory(
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .custFull
                                                              .toString(),
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .itemName
                                                              .toString(),
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .stdMax
                                                              .toString(),
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .stdMin
                                                              .toString(),
                                                        ); */
                                                        showHistory(
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .id
                                                              .toString(),
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .itemName
                                                              .toString(),
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .stdMax
                                                              .toString(),
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .stdMin
                                                              .toString(),
                                                        );
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  // raw data from lab
                                                  itemData[indexSample]
                                                              [indexItem]
                                                          .resultApprove
                                                          .toString() +
                                                      " " +
                                                      itemData[indexSample]
                                                              [indexItem]
                                                          .resultApproveUnit
                                                          .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Row(
                                                children: [
                                                  Text(
                                                      itemData[indexSample]
                                                              [indexItem]
                                                          .stdFactor
                                                          .toString(),
                                                      style: styleDataInTable),
                                                  if (settingView)
                                                    Container(
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: Icon(
                                                          Icons.settings,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          editStd(indexSample,
                                                              indexItem);
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              )),
                                              if (settingView) ...[
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std1
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std2
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std3
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std4
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std5
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std6
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std7
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .std8
                                                        .toString(),
                                                    style: styleDataInTable)),
                                                DataCell(_verticalDivider),
                                                DataCell(Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .reportOrder
                                                        .toString(),
                                                    style: styleDataInTable)),
                                              ],
                                              DataCell(_verticalDivider),
                                              DataCell(Row(
                                                children: [
                                                  if (itemData[indexSample]
                                                                  [indexItem]
                                                              .itemStatus ==
                                                          'APPROVE' ||
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .itemStatus ==
                                                          'COMPLETE')
                                                    if (itemData[indexSample]
                                                            [indexItem]
                                                        .resultComplete
                                                        .contains('pic_'))
                                                      Container(
                                                        child: IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          icon:
                                                              Icon(Icons.image),
                                                          onPressed: () {
                                                            showPicture(
                                                                itemData[indexSample]
                                                                        [
                                                                        indexItem]
                                                                    .resultComplete,
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                  if (itemData[indexSample]
                                                                  [indexItem]
                                                              .itemStatus ==
                                                          'APPROVE' ||
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .itemStatus ==
                                                          'COMPLETE')
                                                    if (itemData[indexSample]
                                                                [indexItem]
                                                            .resultComplete
                                                            .contains('pic_') ==
                                                        false)
                                                      Text(
                                                          itemData[indexSample][
                                                                      indexItem]
                                                                  .resultCompleteSymbol
                                                                  .toString() +
                                                              itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .resultComplete
                                                                  .toString(),
                                                          style: styleDataInTable),
                                                  if (itemData[indexSample]
                                                                  [indexItem]
                                                              .itemStatus ==
                                                          'APPROVE' ||
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .itemStatus ==
                                                          'COMPLETE')
                                                    if (itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "APPROVE" &&
                                                        (userCheck))
                                                      Checkbox(
                                                        value: itemData[
                                                                    indexSample]
                                                                [indexItem]
                                                            .selected,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            itemData[indexSample]
                                                                    [indexItem]
                                                                .selected = !itemData[
                                                                        indexSample]
                                                                    [indexItem]
                                                                .selected;
                                                          });
                                                        },
                                                      ),
                                                ],
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell(
                                                Text(
                                                    itemData[indexSample]
                                                            [indexItem]
                                                        .resultApproveRemark,
                                                    style: styleDataInTable),
                                              ),
                                              DataCell(_verticalDivider),
                                              DataCell(
                                                Text(
                                                    itemData[indexSample]
                                                                [indexItem]
                                                            .userApprove +
                                                        "  " +
                                                        toDateTime(itemData[
                                                                    indexSample]
                                                                [indexItem]
                                                            .resultApproveDate
                                                            .toString()),
                                                    style: styleDataInTable),
                                              ),
                                              DataCell(_verticalDivider),
                                              DataCell(Text("PATH",
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(
                                                Column(children: [
                                                  /* if (itemData[indexSample]
                                                                  [indexItem]
                                                              .itemStatus ==
                                                          "APPROVE" &&
                                                      (userCheck)) */
                                                  if ((userCheck))
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          FormBuilderTextField(
                                                        style: styleDataInTable,
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            border:
                                                                OutlineInputBorder()),
                                                        name:
                                                            'remark$indexSample$indexItem',
                                                        initialValue: itemData[
                                                                    indexSample]
                                                                [indexItem]
                                                            .requestReconfirmRemark,
                                                        onChanged: (value) {
                                                          itemData[indexSample][
                                                                      indexItem]
                                                                  .requestReconfirmRemark =
                                                              value.toString();
                                                        },
                                                      ),
                                                    ),
                                                ]),
                                              ),
                                              DataCell(_verticalDivider),
                                              DataCell(Column(children: [
                                                /* if (itemData[indexSample]
                                                                [indexItem]
                                                            .itemStatus ==
                                                        "APPROVE" &&
                                                    (userCheck)) */
                                                if ((userCheck))
                                                  Center(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        reconfirmResult(
                                                            indexSample,
                                                            indexItem);
                                                      },
                                                    ),
                                                  ),
                                              ])),
                                              DataCell(_verticalDivider),
                                              DataCell(Column(children: [
                                                if (itemData[indexSample]
                                                                [indexItem]
                                                            .itemStatus ==
                                                        "APPROVE" &&
                                                    (userCheck))
                                                  Center(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.done,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        completeResult(
                                                            indexSample,
                                                            indexItem);
                                                      },
                                                    ),
                                                  ),
                                              ])),
                                              DataCell(_verticalDivider),
                                              DataCell(Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    if (itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus !=
                                                            "COMPLETE" &&
                                                        (userCheck))
                                                      Center(
                                                        child: IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            cancelItem(
                                                                indexSample,
                                                                indexItem);
                                                          },
                                                        ),
                                                      ),
                                                  ])),
                                            ]))),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
              if (((userCheck) && itemData[0][0].requestStatus != "COMPLETE") ||
                  userRoleId == 99) ...[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  /* child: IconButton(
                    icon: Icon(
                      Icons.task_alt_rounded,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      //acceptReconfirm(indexSample, indexItem);
                    }), */
                  child: TextButton.icon(
                      onPressed: () {
                        completeAllResult();
                      },
                      icon: Icon(
                        Icons.save,
                        color: Colors.green,
                      ),
                      label: Text('APPROVE ALL')),
                ),
                SizedBox(
                  height: 20,
                )
              ]
            ],
          );
        } else
          return CircularProgressIndicator();
      }),
    );
  }
}

Container rowData(String sectionName, Widget data) {
  double heightBox1 = 25;
  double widthsection1 = 160;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

  return Container(
    height: heightBox1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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

Container rowData2(String sectionName, Widget data) {
  double heightBox1 = 25;
  double widthsection1 = 160;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

  return Container(
    height: heightBox1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);

class HistoryData extends StatefulWidget {
  const HistoryData({Key? key}) : super(key: key);

  @override
  _HistoryDataState createState() => _HistoryDataState();
}

class _HistoryDataState extends State<HistoryData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: CustomTheme.colorWhite,
        borderRadius: BorderRadius.all(Radius.circular(0)),
        boxShadow: [
          BoxShadow(
              color: CustomTheme.colorShadowBgStrong,
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
      child: Container(), //TableResultApprove(),
    );
  }
}

class EditStdFactor extends StatefulWidget {
  int indexSample = 0;
  int indexItem = 0;
  EditStdFactor({required this.indexSample, required this.indexItem, Key? key})
      : super(key: key);

  @override
  State<EditStdFactor> createState() => _EditStdFactorState();
}

class _EditStdFactorState extends State<EditStdFactor> {
  final _formKey2 = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  TextStyle styleHeaderTable =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');

  void calculate() {
    try {
      double buff = 0;
      buff = (double.parse(itemData[widget.indexSample][widget.indexItem]
                  .resultApprove) +
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std1) -
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std2)) *
          double.parse(itemData[widget.indexSample][widget.indexItem].std3) /
          double.parse(itemData[widget.indexSample][widget.indexItem].std4);
      buff = ((buff +
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std5) -
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std6)) *
          double.parse(itemData[widget.indexSample][widget.indexItem].std7) /
          double.parse(itemData[widget.indexSample][widget.indexItem].std8));
      itemData[widget.indexSample][widget.indexItem].resultComplete =
          buff.toStringAsFixed(2);
      calculateMin();
      calculateMax();
      setState(() {
        print(itemData[widget.indexSample][widget.indexItem].resultComplete);
      });
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void calculateMin() {
    try {
      double buff = 0;
      /*  buff = (double.parse(
                  itemData[widget.indexSample][widget.indexItem].stdMin) *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std4) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std3)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std2) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std1);
      buff = ((buff *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std8) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std7)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std6) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std5));

      itemData[widget.indexSample][widget.indexItem].stdMinL =
          buff.toStringAsFixed(2);
      print(itemData[widget.indexSample][widget.indexItem].stdMinL); */
      buff = (double.parse(
                  itemData[widget.indexSample][widget.indexItem].stdMin) *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std8) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std7)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std6) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std5);
      buff = ((buff *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std4) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std3)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std2) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std1));

      itemData[widget.indexSample][widget.indexItem].stdMinL =
          buff.toStringAsFixed(2);
      print(itemData[widget.indexSample][widget.indexItem].stdMinL);
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void calculateMax() {
    try {
      double buff = 0;
      /*  buff = (double.parse(
                  itemData[widget.indexSample][widget.indexItem].stdMax) *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std4) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std3)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std2) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std1);
      buff = ((buff *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std8) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std7)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std6) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std5));

      itemData[widget.indexSample][widget.indexItem].stdMaxL =
          buff.toStringAsFixed(2); */
      buff = (double.parse(
                  itemData[widget.indexSample][widget.indexItem].stdMax) *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std8) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std7)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std6) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std5);
      buff = ((buff *
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std4) /
              double.parse(
                  itemData[widget.indexSample][widget.indexItem].std3)) +
          double.parse(itemData[widget.indexSample][widget.indexItem].std2) -
          double.parse(itemData[widget.indexSample][widget.indexItem].std1));

      itemData[widget.indexSample][widget.indexItem].stdMaxL =
          buff.toStringAsFixed(2);
      print(itemData[widget.indexSample][widget.indexItem].stdMaxL);
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    int indexSample = widget.indexSample;
    int indexItem = widget.indexItem;
    calculate();
    return Form(
        key: _formKey2,
        child: Container(
          child: Column(
            children: [
              rowData(
                "RAW DATA FROM LAB",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'resultBuff',
                      initialValue: itemData[indexSample][indexItem]
                              .resultApprove
                              .toString() +
                          itemData[indexSample][indexItem]
                              .resultApproveUnit
                              .toString(),
                      enabled: false,
                    ),
                  ),
                ),
              ),
              rowData(
                "MAG",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'mag',
                      initialValue:
                          itemData[indexSample][indexItem].mag.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].mag = value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "POSITION",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'pos',
                      initialValue:
                          itemData[indexSample][indexItem].position.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].position =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "TEMP",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'TEMP',
                      initialValue:
                          itemData[indexSample][indexItem].temp.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].temp =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD FACTOR",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'STDFACTOR',
                      initialValue:
                          itemData[indexSample][indexItem].stdFactor.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].stdFactor =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD1(+)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std1',
                      initialValue:
                          itemData[indexSample][indexItem].std1.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std1 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD2(-)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std2',
                      initialValue:
                          itemData[indexSample][indexItem].std2.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std2 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD3(X)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std3',
                      initialValue:
                          itemData[indexSample][indexItem].std3.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std3 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD4(/)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std4',
                      initialValue:
                          itemData[indexSample][indexItem].std4.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std4 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD5(+)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std5',
                      initialValue:
                          itemData[indexSample][indexItem].std5.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std5 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD6(-)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std6',
                      initialValue:
                          itemData[indexSample][indexItem].std6.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std6 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD7(X)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std7',
                      initialValue:
                          itemData[indexSample][indexItem].std7.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std7 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD8(/)",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'std8',
                      initialValue:
                          itemData[indexSample][indexItem].std8.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].std8 =
                            value.toString();
                        calculate();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "RESULT SHOW",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      name: 'resultcomplete',
                      key: Key(itemData[indexSample][indexItem]
                          .resultComplete
                          .toString()),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      //name: 'resultApprove',
                      initialValue: itemData[indexSample][indexItem]
                          .resultComplete
                          .toString(),
                      enabled: false,
                    ),
                  ),
                ),
              ),
              rowData(
                "STD MIN",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'stdMin',
                      initialValue:
                          itemData[indexSample][indexItem].stdMin.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].stdMin =
                            value.toString();
                        calculateMin();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD MAX",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'stdMax',
                      initialValue:
                          itemData[indexSample][indexItem].stdMax.toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].stdMax =
                            value.toString();
                        calculateMax();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "CONTROL RANGE",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: styleDataInTable,
                      /* decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()), */
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'ctrl',
                      initialValue: itemData[indexSample][indexItem]
                          .controlRange
                          .toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].controlRange =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class EditReportName extends StatefulWidget {
  int indexSample = 0;
  int indexItem = 0;
  EditReportName({required this.indexSample, required this.indexItem, Key? key})
      : super(key: key);

  @override
  State<EditReportName> createState() => _EditReportNameState();
}

class _EditReportNameState extends State<EditReportName> {
  final _formKey2 = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  TextStyle styleHeaderTable =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');

  @override
  Widget build(BuildContext context) {
    int indexSample = widget.indexSample;
    int indexItem = widget.indexItem;
    return Form(
        key: _formKey2,
        child: Container(
          child: Column(
            children: [
              rowData3(
                "PROCESS REPORT NAME",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      name: 'reportname',
                      initialValue:
                          itemData[indexSample][indexItem].processReportName,
                      enabled: true,
                      onChanged: (val) {
                        itemData[indexSample][indexItem].processReportName =
                            val.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData3(
                "ITEM REPORT NAME",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      name: 'item',
                      initialValue:
                          itemData[indexSample][indexItem].itemReportName,
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].itemReportName =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "REPORT ORDER",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'order',
                      initialValue: itemData[indexSample][indexItem]
                          .reportOrder
                          .toString(),
                      enabled: true,
                      onChanged: (value) {
                        itemData[indexSample][indexItem].reportOrder =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Container rowData3(String sectionName, Widget data) {
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

Future<String> captureToback(GlobalKey<State<StatefulWidget>> globalKey) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image = await boundary!.toImage(pixelRatio: 2);

    final ByteData? bytes =
        await image.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    // final imageEncoded = base64.encode(dataImage);

    await WebImageDownloader.downloadImageFromUInt8List(uInt8List: dataImage);
  

    // print(imageEncoded);

    // print(imageEncoded);

    return 'ok';
  } catch (e) {
    rethrow;
  }
}
