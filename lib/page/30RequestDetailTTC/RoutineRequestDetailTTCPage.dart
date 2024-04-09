import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/Global/dataTime.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryDataExcel/HistoryDataExcel.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPicture/ShowPicture.dart';
import 'SubWidget/TableApproveResultDetail.dart';
import 'data/RoutineRequestDetailTTCPage_bloc.dart';
import 'data/RoutineRequestDetailTTCPage_event.dart';

late BuildContext contextRoutineRequestDetailTTCPage;

class RoutineRequestDetailTTCPage extends StatelessWidget {
  const RoutineRequestDetailTTCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataRoutineRequestDetailTTCPage>(
          create: (BuildContext context) =>
              ManageDataRoutineRequestDetailTTCPage(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20),
          child: Column(
            children: [
              ApproveResult(),
              //HistoryData(),
            ],
          ),
        ),
      ),
    );
  }
}

class ApproveResult extends StatefulWidget {
  const ApproveResult({Key? key}) : super(key: key);

  @override
  _ApproveResultState createState() => _ApproveResultState();
}

class _ApproveResultState extends State<ApproveResult> {
  void initState() {
    print("InINITIAL");
    super.initState();
    context
        .read<ManageDataRoutineRequestDetailTTCPage>()
        .add(RoutineRequestDetailTTCPageEvent.searchRequestData);
  }

  final _formKey2 = GlobalKey<FormBuilderState>();

  void showImage(int indexSample, int indexItem, int result) {
    var outputAsUint8List;
    switch (result) {
      case 1:
        {
          outputAsUint8List =
              base64.decode(itemData[indexSample][indexItem].result1);
        }
        break;
      case 2:
        {
          outputAsUint8List =
              base64.decode(itemData[indexSample][indexItem].result2);
        }
        break;
      case 3:
        {
          outputAsUint8List =
              base64.decode(itemData[indexSample][indexItem].result3);
        }
        break;
      case 4:
        {
          outputAsUint8List =
              base64.decode(itemData[indexSample][indexItem].result4);
        }
        break;
      case 5:
        {
          outputAsUint8List =
              base64.decode(itemData[indexSample][indexItem].result5);
        }
        break;
      case 6:
        {
          outputAsUint8List =
              base64.decode(itemData[indexSample][indexItem].result6);
        }
        break;
      case 7:
        {
          outputAsUint8List =
              base64.decode(itemData[indexSample][indexItem].resultApprove);
        }
        break;
      default:
        {}
    }
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

  void selectResult(int indexSample, int indexItem) {
    String dataselect = '0';
    CoolAlert.show(
      barrierDismissible: true,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'SELECT RESULT',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Form(
        key: _formKey2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: FormBuilderCheckboxGroup(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                name: 'selectedResult',
                onChanged: (valve) {
                  dataselect = valve![0].toString();
                  print(dataselect.toString());
                },
                options: [
                  if (itemData[indexSample][indexItem].result1 != "")
                    FormBuilderFieldOption(
                      value: 1,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        width: 200,
                        child: Container(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.image),
                            onPressed: () {
                              showPicture(
                                  itemData[indexSample][indexItem]
                                      .result1
                                      .toString(),
                                  context);
                            },
                          ),
                        ),
                        /* (() {
                          if (itemData[indexSample][indexItem].result1.length <
                              1000) {
                            return Text(itemData[indexSample][indexItem]
                                    .resultSymbol1
                                    .toString() +
                                " " +
                                itemData[indexSample][indexItem]
                                    .result1
                                    .toString() +
                                " " +
                                itemData[indexSample][indexItem]
                                    .resultUnit1
                                    .toString());
                          } else {
                            var outputAsUint8List;
                            outputAsUint8List = base64.decode(
                                itemData[indexSample][indexItem].result1);
                            return Container(
                              width: 400,
                              child: outputAsUint8List != null
                                  ? Image.memory(outputAsUint8List!,
                                      //width: 250, height: 250,
                                      fit: BoxFit.cover)
                                  : Container(),
                            );
                          }
                        }()), */
                      ),
                    ),
                  if (itemData[indexSample][indexItem].result2 != "")
                    FormBuilderFieldOption(
                        value: 2,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          width: 200,
                          child: Container(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.image),
                              onPressed: () {
                                showPicture(
                                    itemData[indexSample][indexItem]
                                        .result2
                                        .toString(),
                                    context);
                              },
                            ),
                          ), /* (() {
                            if (itemData[indexSample][indexItem]
                                    .result2
                                    .length <
                                1000) {
                              return Text(itemData[indexSample][indexItem]
                                      .resultSymbol2
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .result2
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .resultUnit2
                                      .toString());
                            } else {
                              var outputAsUint8List;
                              outputAsUint8List = base64.decode(
                                  itemData[indexSample][indexItem].result2);
                              return Container(
                                width: 400,
                                child: outputAsUint8List != null
                                    ? Image.memory(outputAsUint8List!,
                                        //width: 250, height: 250,
                                        fit: BoxFit.cover)
                                    : Container(),
                              );
                            }
                          }()), */
                        )),
                  if (itemData[indexSample][indexItem].result3 != "")
                    FormBuilderFieldOption(
                        value: 3,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          width: 200,
                          child: Container(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.image),
                              onPressed: () {
                                showPicture(
                                    itemData[indexSample][indexItem]
                                        .result3
                                        .toString(),
                                    context);
                              },
                            ),
                          ), /* (() {
                            if (itemData[indexSample][indexItem]
                                    .result3
                                    .length <
                                1000) {
                              return Text(itemData[indexSample][indexItem]
                                      .resultSymbol3
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .result3
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .resultUnit3
                                      .toString());
                            } else {
                              var outputAsUint8List;
                              outputAsUint8List = base64.decode(
                                  itemData[indexSample][indexItem].result3);
                              return Container(
                                width: 400,
                                child: outputAsUint8List != null
                                    ? Image.memory(outputAsUint8List!,
                                        //width: 250, height: 250,
                                        fit: BoxFit.cover)
                                    : Container(),
                              );
                            }
                          }()), */
                        )),
                  if (itemData[indexSample][indexItem].result4 != "")
                    FormBuilderFieldOption(
                        value: 4,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          width: 200,
                          child: Container(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.image),
                              onPressed: () {
                                showPicture(
                                    itemData[indexSample][indexItem]
                                        .result4
                                        .toString(),
                                    context);
                              },
                            ),
                          ), /* (() {
                            if (itemData[indexSample][indexItem]
                                    .result4
                                    .length <
                                1000) {
                              return Text(itemData[indexSample][indexItem]
                                      .resultSymbol4
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .result4
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .resultUnit4
                                      .toString());
                            } else {
                              var outputAsUint8List;
                              outputAsUint8List = base64.decode(
                                  itemData[indexSample][indexItem].result4);
                              return Container(
                                width: 400,
                                child: outputAsUint8List != null
                                    ? Image.memory(outputAsUint8List!,
                                        //width: 250, height: 250,
                                        fit: BoxFit.cover)
                                    : Container(),
                              );
                            }
                          }()), */
                        )),
                  if (itemData[indexSample][indexItem].result5 != "")
                    FormBuilderFieldOption(
                        value: 5,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          width: 200,
                          child: Container(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.image),
                              onPressed: () {
                                showPicture(
                                    itemData[indexSample][indexItem]
                                        .result5
                                        .toString(),
                                    context);
                              },
                            ),
                          ), /* (() {
                            if (itemData[indexSample][indexItem]
                                    .result5
                                    .length <
                                1000) {
                              return Text(itemData[indexSample][indexItem]
                                      .resultSymbol5
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .result5
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .resultUnit5
                                      .toString());
                            } else {
                              var outputAsUint8List;
                              outputAsUint8List = base64.decode(
                                  itemData[indexSample][indexItem].result5);
                              return Container(
                                width: 400,
                                child: outputAsUint8List != null
                                    ? Image.memory(outputAsUint8List!,
                                        //width: 250, height: 250,
                                        fit: BoxFit.cover)
                                    : Container(),
                              );
                            }
                          }()), */
                        )),
                  if (itemData[indexSample][indexItem].result6 != "")
                    FormBuilderFieldOption(
                        value: 6,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          width: 200,
                          child: Container(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.image),
                              onPressed: () {
                                showPicture(
                                    itemData[indexSample][indexItem]
                                        .result6
                                        .toString(),
                                    context);
                              },
                            ),
                          ), /* (() {
                            if (itemData[indexSample][indexItem]
                                    .result6
                                    .length <
                                1000) {
                              return Text(itemData[indexSample][indexItem]
                                      .resultSymbol6
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .result6
                                      .toString() +
                                  " " +
                                  itemData[indexSample][indexItem]
                                      .resultUnit6
                                      .toString());
                            } else {
                              var outputAsUint8List;
                              outputAsUint8List = base64.decode(
                                  itemData[indexSample][indexItem].result6);
                              return Container(
                                width: 400,
                                child: outputAsUint8List != null
                                    ? Image.memory(outputAsUint8List!,
                                        //width: 250, height: 250,
                                        fit: BoxFit.cover)
                                    : Container(),
                              );
                            }
                          }()), */
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
      onConfirmBtnTap: () {
        //_formKey2.currentState?.save();
        //final formData = _formKey2.currentState!.value;
        //print(formData);
        try {
          /* if (formData['selectedResult'].length == 0) {
            Navigator.pop(context);
          } else if (formData['selectedResult'].length == 1) {
            if (formData['selectedResult'][0] == 1) {
              itemData[indexSample][indexItem].resultApproveSymbol =
                  itemData[indexSample][indexItem].resultSymbol1;
              itemData[indexSample][indexItem].resultApprove =
                  itemData[indexSample][indexItem].result1;
              itemData[indexSample][indexItem].resultApproveUnit =
                  itemData[indexSample][indexItem].resultUnit1;
              itemData[indexSample][indexItem].resultApproveFile =
                  itemData[indexSample][indexItem].resultFile1;
            } else if (formData['selectedResult'][0] == 2) {
              itemData[indexSample][indexItem].resultApproveSymbol =
                  itemData[indexSample][indexItem].resultSymbol2;
              itemData[indexSample][indexItem].resultApprove =
                  itemData[indexSample][indexItem].result2;
              itemData[indexSample][indexItem].resultApproveUnit =
                  itemData[indexSample][indexItem].resultUnit2;
              itemData[indexSample][indexItem].resultApproveFile =
                  itemData[indexSample][indexItem].resultFile2;
            } else if (formData['selectedResult'][0] == 3) {
              itemData[indexSample][indexItem].resultApproveSymbol =
                  itemData[indexSample][indexItem].resultSymbol3;
              itemData[indexSample][indexItem].resultApprove =
                  itemData[indexSample][indexItem].result3;
              itemData[indexSample][indexItem].resultApproveUnit =
                  itemData[indexSample][indexItem].resultUnit3;
              itemData[indexSample][indexItem].resultApproveFile =
                  itemData[indexSample][indexItem].resultFile3;
            } else if (formData['selectedResult'][0] == 4) {
              itemData[indexSample][indexItem].resultApproveSymbol =
                  itemData[indexSample][indexItem].resultSymbol4;
              itemData[indexSample][indexItem].resultApprove =
                  itemData[indexSample][indexItem].result4;
              itemData[indexSample][indexItem].resultApproveUnit =
                  itemData[indexSample][indexItem].resultUnit4;
              itemData[indexSample][indexItem].resultApproveFile =
                  itemData[indexSample][indexItem].resultFile4;
            } else if (formData['selectedResult'][0] == 5) {
              itemData[indexSample][indexItem].resultApproveSymbol =
                  itemData[indexSample][indexItem].resultSymbol5;
              itemData[indexSample][indexItem].resultApprove =
                  itemData[indexSample][indexItem].result5;
              itemData[indexSample][indexItem].resultApproveUnit =
                  itemData[indexSample][indexItem].resultUnit5;
              itemData[indexSample][indexItem].resultApproveFile =
                  itemData[indexSample][indexItem].resultFile5;
            } else if (formData['selectedResult'][0] == 6) {
              itemData[indexSample][indexItem].resultApproveSymbol =
                  itemData[indexSample][indexItem].resultSymbol6;
              itemData[indexSample][indexItem].resultApprove =
                  itemData[indexSample][indexItem].result6;
              itemData[indexSample][indexItem].resultApproveUnit =
                  itemData[indexSample][indexItem].resultUnit6;
              itemData[indexSample][indexItem].resultApproveFile =
                  itemData[indexSample][indexItem].resultFile6;
            }
            setState(() {});
          } else {
            var count = formData['selectedResult'].length;
            var sum = 0.0;
            print('ekseee $count');
            for (var i = 0; i < count; i++) {
              if (formData['selectedResult'][i] == 1) {
                sum = sum +
                    double.parse(itemData[indexSample][indexItem].result1);
              } else if (formData['selectedResult'][i] == 2) {
                sum = sum +
                    double.parse(itemData[indexSample][indexItem].result2);
              } else if (formData['selectedResult'][i] == 3) {
                sum = sum +
                    double.parse(itemData[indexSample][indexItem].result3);
              } else if (formData['selectedResult'][i] == 4) {
                sum = sum +
                    double.parse(itemData[indexSample][indexItem].result4);
              } else if (formData['selectedResult'][i] == 5) {
                sum = sum +
                    double.parse(itemData[indexSample][indexItem].result5);
              } else if (formData['selectedResult'][i] == 6) {
                sum = sum +
                    double.parse(itemData[indexSample][indexItem].result6);
              }
            }
            itemData[indexSample][indexItem].resultApproveSymbol = "";
            itemData[indexSample][indexItem].resultApprove = sum / count;
            itemData[indexSample][indexItem].resultApproveUnit =
                itemData[indexSample][indexItem].resultUnit1;
            itemData[indexSample][indexItem].resultApproveFile =
                itemData[indexSample][indexItem].resultFile1; */

          if (dataselect == '1') {
            itemData[indexSample][indexItem].resultApproveSymbol = "";
            itemData[indexSample][indexItem].resultApprove =
                itemData[indexSample][indexItem].result1;
            itemData[indexSample][indexItem].resultApproveUnit =
                itemData[indexSample][indexItem].resultUnit1;
            itemData[indexSample][indexItem].resultApproveFile =
                itemData[indexSample][indexItem].resultFile1;
          } else if (dataselect == '2') {
            itemData[indexSample][indexItem].resultApproveSymbol = "";
            itemData[indexSample][indexItem].resultApprove =
                itemData[indexSample][indexItem].result2;
            itemData[indexSample][indexItem].resultApproveUnit =
                itemData[indexSample][indexItem].resultUnit2;
            itemData[indexSample][indexItem].resultApproveFile =
                itemData[indexSample][indexItem].resultFile2;
          } else if (dataselect == '3') {
            itemData[indexSample][indexItem].resultApproveSymbol = "";
            itemData[indexSample][indexItem].resultApprove =
                itemData[indexSample][indexItem].result3;
            itemData[indexSample][indexItem].resultApproveUnit =
                itemData[indexSample][indexItem].resultUnit3;
            itemData[indexSample][indexItem].resultApproveFile =
                itemData[indexSample][indexItem].resultFile3;
          } else if (dataselect == '4') {
            itemData[indexSample][indexItem].resultApproveSymbol = "";
            itemData[indexSample][indexItem].resultApprove =
                itemData[indexSample][indexItem].result4;
            itemData[indexSample][indexItem].resultApproveUnit =
                itemData[indexSample][indexItem].resultUnit4;
            itemData[indexSample][indexItem].resultApproveFile =
                itemData[indexSample][indexItem].resultFile4;
          } else if (dataselect == '5') {
            itemData[indexSample][indexItem].resultApproveSymbol = "";
            itemData[indexSample][indexItem].resultApprove =
                itemData[indexSample][indexItem].result5;
            itemData[indexSample][indexItem].resultApproveUnit =
                itemData[indexSample][indexItem].resultUnit5;
            itemData[indexSample][indexItem].resultApproveFile =
                itemData[indexSample][indexItem].resultFile5;
          } else if (dataselect == '6') {
            itemData[indexSample][indexItem].resultApproveSymbol = "";
            itemData[indexSample][indexItem].resultApprove =
                itemData[indexSample][indexItem].result6;
            itemData[indexSample][indexItem].resultApproveUnit =
                itemData[indexSample][indexItem].resultUnit6;
            itemData[indexSample][indexItem].resultApproveFile =
                itemData[indexSample][indexItem].resultFile6;
          }
          setState(() {});
        } on Error catch (e) {
          //print(e);
        }
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void recheckResult(int indexSample, int indexItem) {
    CoolAlert.show(
      barrierDismissible: true,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'CONFIRM RECHECK RESULT',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Column(
        children: [
          Text("ITEM ${itemData[indexSample][indexItem].itemName.toString()}"),
          Container(
            width: 350,
            child: FormBuilderTextField(
              style: styleDataInTable,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder()),
              name: 'recheckRemark',
              onChanged: (value) {
                itemData[indexSample][indexItem].requestRecheckRemark =
                    value.toString();
              },
            ),
          ),
        ],
      ),
      onConfirmBtnTap: () {
        recheckResultData.clear();
        recheckResultData.add(itemData[indexSample][indexItem]);
        recheckResultData[0].userRequestRecheck = userName;
        //var now = DateTime.now();
        /* recheckResultData[0].analysisDueDate = (DateFormat("yyyy-MM-dd")
                .format(new DateTime(now.year, now.month, now.day + 1)))
            .toString(); */
        context.read<ManageDataRoutineRequestDetailTTCPage>().add(
              RoutineRequestDetailTTCPageEvent.submitRecheckResult,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void approveResult(int indexSample, int indexItem) {
    CoolAlert.show(
      barrierDismissible: true,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'CONFIRM APPROVE RESULT',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget:
          Text("ITEM ${itemData[indexSample][indexItem].itemName.toString()}"),
      onConfirmBtnTap: () {
        approveResultData.clear();
        approveResultData.add(itemData[indexSample][indexItem]);
        approveResultData[0].userApprove = userName;
        context.read<ManageDataRoutineRequestDetailTTCPage>().add(
              RoutineRequestDetailTTCPageEvent.submitApproveResult,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void approveAllResult() {
    int countItem = 0;
    approveAllResultData.clear();
    for (int i = 0; i < itemData.length; i++) {
      for (int j = 0; j < itemData[i].length; j++) {
        if (itemData[i][j].selected == true) {
          approveAllResultData.add(itemData[i][j]);
          approveAllResultData[countItem].userApprove = userName;
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
        text: 'CONFIRM APPROVE RESULT',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        loopAnimation: true,
        widget: Text("$countItem ITEM"),
            /* Text(
                "ITEM $countItem {itemData[indexSample][indexItem].itemName.toString()}"), */
        onConfirmBtnTap: () {
          context.read<ManageDataRoutineRequestDetailTTCPage>().add(
                RoutineRequestDetailTTCPageEvent.approveAllResult,
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
          // Navigator.pop(context);
        },
        onCancelBtnTap: () {
          //Navigator.pop(context);
        },
      );
    }
  }

  void acceptReconfirm(int indexSample, int indexItem) {
    CoolAlert.show(
      barrierDismissible: true,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'ACCEPT RECONFIRM REQUEST',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget:
          Text("ITEM ${itemData[indexSample][indexItem].itemName.toString()}"),
      onConfirmBtnTap: () {
        acceptReconfirmData.clear();
        acceptReconfirmData.add(itemData[indexSample][indexItem]);
        acceptReconfirmData[0].userAcceptReconfirm = userName;
        context.read<ManageDataRoutineRequestDetailTTCPage>().add(
              RoutineRequestDetailTTCPageEvent.acceptReconfirm,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void rejectReconfirm(int indexSample, int indexItem) {
    CoolAlert.show(
      barrierDismissible: true,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'REJECT RECONFIRM REQUEST',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget:
          Text("ITEM ${itemData[indexSample][indexItem].itemName.toString()}"),
      onConfirmBtnTap: () {
        rejectReconfirmData.clear();
        rejectReconfirmData.add(itemData[indexSample][indexItem]);
        rejectReconfirmData[0].userApprove = userName;
        context.read<ManageDataRoutineRequestDetailTTCPage>().add(
              RoutineRequestDetailTTCPageEvent.rejectReconfirm,
            );
        //Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

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
                Container(
                  width: 600,
                  child: HistoryChart(
                    itemID: _itemID,
                    itemName: _itemName,
                    section: "TTC",
                    max: _max,
                    min: _min,
                  ),
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

  void _EditItemStatus(int id) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: EditItemStatus(
              idInSql: id,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    _dismissDialog();
                    await saveEditItemStatus();
                  },
                  child: Text('SAVE')),
              TextButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('EXIT'),
              )
            ],
          );
        });
  }

  void _EditDuedate(int id, String itemStatus) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: EditItemDueDate(
              idInSql: id,
              itemStatus: itemStatus,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    _dismissDialog();
                    await saveEditDuedate();
                  },
                  child: Text('SAVE')),
              TextButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('EXIT'),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

//
  final _formKey = GlobalKey<FormBuilderState>();
  final _formKey3 = GlobalKey<FormBuilderState>();
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
    contextRoutineRequestDetailTTCPage = context;
    return Form(
      key: _formKey,
      child: BlocBuilder<ManageDataRoutineRequestDetailTTCPage, int>(
          builder: (context, state) {
        print("rebuild state :$state");

        if (state == 1) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  //width: 1500,
                  //height: 200,
                  padding: EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                    left: 25,
                    right: 25,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        "CUSTOMER NAME",
                        Container(
                          child: Text(
                            requestData[0].custFull.toString() +
                                ' | ' +
                                requestData[0].custShort.toString(),
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
                        "INCHARGE",
                        Container(
                          child: Text(
                            requestData[0].incharge.toString(),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "HISTORY",
                        Container(
                            child: ButtonSaveHistoryExcel(
                          custFull: requestData[0].custFull.toString(),
                        )),
                      ),

                      /* 
                      rowData(
                        "RECEIVE DATE",
                        Container(
                          child: Text(
                            toDateOnly(requestData[0].receiveDate.toString()),
                            style: styledata,
                          ),
                        ),
                      ),
                      rowData(
                        "ANALYSIS DUE DATE",
                        Container(
                          child: Text(
                            toDateOnly(
                                requestData[0].analysisDueDate.toString()),
                            style: styledata,
                          ),
                        ),
                      ), */
                    ],
                  ),
                ),
              ),
              Container(
                height: 600,
                margin: EdgeInsets.only(top: 25, bottom: 25),
                child: SingleChildScrollView(
                  child: Container(
                      //width: 1500,
                      /* margin: EdgeInsets.only(
                        top: 25,
                      ), */
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
                        width: 1500,
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
                                  children: [
                                    rowData(
                                      "SAMPLE CODE",
                                      Container(
                                        child: Text(
                                          sampleData[indexSample]
                                              .sampleCode
                                              .toString(),
                                          style: styledata,
                                        ),
                                      ),
                                    ),
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
                                      "SAMPLING DATE",
                                      Container(
                                        child: Text(
                                          toDateOnly(sampleData[indexSample]
                                                  .samplingDate
                                                  .toString()) +
                                              '    ( Send : ' +
                                              toDateTime(sampleData[indexSample]
                                                  .sendDate
                                                  .toString()) +
                                              " )",
                                          style: styledata,
                                        ),
                                      ),
                                    ),
                                    rowData(
                                      "SAMPLE RECEVICE DATE",
                                      Container(
                                        child: Text(
                                          sampleData[indexSample].userReceive +
                                              ' ' +
                                              toDateOnly(sampleData[indexSample]
                                                  .receiveDate
                                                  .toString()),
                                          style: styledata,
                                        ),
                                      ),
                                    ),
                                    rowData(
                                      "SAMPLE STATUS",
                                      Container(
                                        child: statusSample(
                                            sampleData[indexSample]
                                                .sampleStatus),
                                      ),
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
                                        label: Text('ITEM',
                                            style: styleHeaderTable),
                                        tooltip: "ITEM NAME",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('POS',
                                            style: styleHeaderTable),
                                        tooltip: "POSITION",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('MAG/DILU',
                                            style: styleHeaderTable),
                                        tooltip: "MAGNIFICATION/DILUTION TIME",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('STATUS',
                                            style: styleHeaderTable),
                                        tooltip: "STATUS ITEM",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('DUE',
                                            style: styleHeaderTable),
                                        tooltip: "ANALYSIS DUEDATE",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('LIST BY',
                                            style: styleHeaderTable),
                                        tooltip: "LIST JOB BY",
                                      ),
                                      /* DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Text('MAG',
                                                style: styleHeaderTable),
                                            tooltip: "MAGNIFICATION",
                                          ), */

                                      /* DataColumn(label: _verticalDivider),
                                          DataColumn(
                                            label: Text('TEMP',
                                                style: styleHeaderTable),
                                          ), */
                                      /* DataColumn(label: _verticalDivider),
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
                                          ), */
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('HIS',
                                            style: styleHeaderTable),
                                        tooltip: "HISTORY",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label:
                                            Text('R1', style: styleHeaderTable),
                                        tooltip: "RESULT 1",
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R1 RM',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 1 REMARK"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R2',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT2"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R2 RM',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 2 REMARK"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R3',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 3"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R3 RM',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 3 REMARK"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R4',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 4"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R4 RM',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 4 REMARK"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R5',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 5"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R5 RM',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 5 REMARK"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R6',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 6"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R6 RM',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT 6 REMARK"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('PATH',
                                              style: styleHeaderTable),
                                          tooltip: "SEM"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R APPOV',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT APPROVE"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('R COMMENT',
                                              style: styleHeaderTable),
                                          tooltip: "RESULT COMMENT"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('RECHECK',
                                            style: styleHeaderTable),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                        label: Text('SAVE',
                                            style: styleHeaderTable),
                                      ),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('RCF RM',
                                              style: styleHeaderTable),
                                          tooltip: "RECONFIRM REMARK"),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Text('REONFIRM',
                                              style: styleHeaderTable),
                                          tooltip: "REONFIRM"),
                                    ],
                                    rows: List<DataRow>.generate(
                                        itemData[indexSample].length,
                                        (indexItem) => DataRow(cells: [
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                      itemData[indexSample]
                                                              [indexItem]
                                                          .itemName
                                                          .toString(),
                                                      style: styleDataInTable),
                                                ),
                                              ),
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
                                                      .mag
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Row(
                                                children: [
                                                  statusItem(
                                                      itemData[indexSample]
                                                              [indexItem]
                                                          .itemStatus
                                                          .toString(),
                                                      12),
                                                  if (userRoleId >= 9)
                                                    Container(
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: Icon(
                                                          Icons.settings,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          _EditItemStatus(
                                                              itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .id);
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell(Row(
                                                children: [
                                                  Text(
                                                      toDateOnly(
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .analysisDueDate
                                                              .toString()),
                                                      style: styleDataInTable),
                                                  if (userRoleId >= 9)
                                                    Container(
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: Icon(
                                                          Icons.settings,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          _EditDuedate(
                                                              itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .id,
                                                              itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .itemStatus);
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .userListAnalysis
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(
                                                //History Data
                                                IconButton(
                                                  icon: Icon(Icons.insights),
                                                  onPressed: () {
                                                    setState(() {
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
                                                            .stdMaxL
                                                            .toString(),
                                                        itemData[indexSample]
                                                                [indexItem]
                                                            .stdMinL
                                                            .toString(),
                                                      );
                                                    });
                                                  },
                                                ),
                                              ),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if (itemData[indexSample]
                                                        [indexItem]
                                                    .result1
                                                    .contains('pic_')) {
                                                  return Container(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(Icons.image),
                                                      onPressed: () {
                                                        showPicture(
                                                            itemData[indexSample]
                                                                    [indexItem]
                                                                .result1,
                                                            context);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .resultSymbol1
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .result1
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .resultUnit1
                                                              .toString(),
                                                      style: styleDataInTable);
                                                }
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .resultRemark1
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if (itemData[indexSample]
                                                        [indexItem]
                                                    .result2
                                                    .contains('pic_')) {
                                                  return Container(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(Icons.image),
                                                      onPressed: () {
                                                        showPicture(
                                                            itemData[indexSample]
                                                                    [indexItem]
                                                                .result2,
                                                            context);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .resultSymbol2
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .result2
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .resultUnit2
                                                              .toString(),
                                                      style: styleDataInTable);
                                                }
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .resultRemark2
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if (itemData[indexSample]
                                                        [indexItem]
                                                    .result3
                                                    .contains('pic_')) {
                                                  return Container(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(Icons.image),
                                                      onPressed: () {
                                                        showPicture(
                                                            itemData[indexSample]
                                                                    [indexItem]
                                                                .result3,
                                                            context);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .resultSymbol3
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .result3
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .resultUnit3
                                                              .toString(),
                                                      style: styleDataInTable);
                                                }
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .resultRemark3
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if (itemData[indexSample]
                                                        [indexItem]
                                                    .result4
                                                    .contains('pic_')) {
                                                  return Container(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(Icons.image),
                                                      onPressed: () {
                                                        showPicture(
                                                            itemData[indexSample]
                                                                    [indexItem]
                                                                .result4,
                                                            context);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .resultSymbol4
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .result4
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .resultUnit4
                                                              .toString(),
                                                      style: styleDataInTable);
                                                }
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .resultRemark4
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if (itemData[indexSample]
                                                        [indexItem]
                                                    .result5
                                                    .contains('pic_')) {
                                                  return Container(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(Icons.image),
                                                      onPressed: () {
                                                        showPicture(
                                                            itemData[indexSample]
                                                                    [indexItem]
                                                                .result5,
                                                            context);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .resultSymbol5
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .result5
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .resultUnit5
                                                              .toString(),
                                                      style: styleDataInTable);
                                                }
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .resultRemark5
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if (itemData[indexSample]
                                                        [indexItem]
                                                    .result6
                                                    .contains('pic_')) {
                                                  return Container(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(Icons.image),
                                                      onPressed: () {
                                                        showPicture(
                                                            itemData[indexSample]
                                                                    [indexItem]
                                                                .result6,
                                                            context);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Text(
                                                      itemData[indexSample]
                                                                  [indexItem]
                                                              .resultSymbol6
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .result6
                                                              .toString() +
                                                          " " +
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .resultUnit6
                                                              .toString(),
                                                      style: styleDataInTable);
                                                }
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .resultRemark6
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Text("PATH",
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell(Row(
                                                children: [
                                                  (() {
                                                    if (itemData[indexSample]
                                                            [indexItem]
                                                        .resultApprove
                                                        .toString()
                                                        .contains('pic_')) {
                                                      return Container(
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
                                                                    .resultApprove,
                                                                context);
                                                          },
                                                        ),
                                                      );
                                                    } else {
                                                      return Text(
                                                          itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .resultApproveSymbol
                                                                  .toString() +
                                                              itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .resultApprove
                                                                  .toString() +
                                                              ' ' +
                                                              itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .resultApproveUnit
                                                                  .toString(),
                                                          style:
                                                              styleDataInTable);
                                                    }
                                                  }()),
                                                  if ((itemData[indexSample][
                                                                      indexItem]
                                                                  .itemStatus ==
                                                              "FINISH NORMAL" ||
                                                          itemData[indexSample][
                                                                      indexItem]
                                                                  .itemStatus ==
                                                              "FINISH RECHECK" ||
                                                          itemData[indexSample][
                                                                      indexItem]
                                                                  .itemStatus ==
                                                              "FINISH RECONFIRM" ||
                                                          itemData[indexSample][
                                                                      indexItem]
                                                                  .itemStatus ==
                                                              "APPROVE") &&
                                                      userRoleId >= 5) ...[
                                                    if (itemData[indexSample]
                                                            [indexItem]
                                                        .resultApprove
                                                        .toString()
                                                        .contains('pic_'))
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .assignment_returned),
                                                        onPressed: () {
                                                          selectResult(
                                                              indexSample,
                                                              indexItem);
                                                        },
                                                      ),
                                                    Checkbox(
                                                      value:
                                                          itemData[indexSample]
                                                                  [indexItem]
                                                              .selected,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          itemData[indexSample][
                                                                      indexItem]
                                                                  .selected =
                                                              !itemData[indexSample]
                                                                      [
                                                                      indexItem]
                                                                  .selected;
                                                        });
                                                      },
                                                    ),
                                                  ]
                                                ],
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if ((itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH NORMAL" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH RECHECK" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH RECONFIRM" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "APPROVE") &&
                                                    userRoleId >= 5) {
                                                  return Container(
                                                    width: 100,
                                                    child: FormBuilderTextField(
                                                      style: styleDataInTable,
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          border:
                                                              OutlineInputBorder()),
                                                      name:
                                                          'remark$indexSample$indexItem',
                                                      onChanged: (value) {
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .requestRecheckRemark =
                                                            value.toString();
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .resultApproveRemark =
                                                            value.toString();
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if ((itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH NORMAL" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH RECHECK" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH RECONFIRM" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "APPROVE") &&
                                                    userRoleId >= 5) {
                                                  return IconButton(
                                                    icon: Icon(
                                                      Icons.cancel,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      recheckResult(indexSample,
                                                          indexItem);
                                                    },
                                                  );
                                                } else
                                                  return Container();
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if ((itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH NORMAL" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH RECHECK" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "FINISH RECONFIRM" ||
                                                        itemData[indexSample]
                                                                    [indexItem]
                                                                .itemStatus ==
                                                            "APPROVE") &&
                                                    userRoleId >= 5) {
                                                  return IconButton(
                                                    icon: Icon(
                                                      Icons.save,
                                                      color: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      approveResult(indexSample,
                                                          indexItem);
                                                    },
                                                  );
                                                } else
                                                  return Container();
                                              }())),
                                              DataCell(_verticalDivider),
                                              DataCell(Text(
                                                  itemData[indexSample]
                                                          [indexItem]
                                                      .requestReconfirmRemark
                                                      .toString(),
                                                  style: styleDataInTable)),
                                              DataCell(_verticalDivider),
                                              DataCell((() {
                                                if (itemData[indexSample]
                                                                [indexItem]
                                                            .itemStatus ==
                                                        'REQUEST RECONFIRM' &&
                                                    userRoleId >= 5) {
                                                  return Row(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .task_alt_rounded,
                                                            color: Colors.green,
                                                          ),
                                                          onPressed: () {
                                                            acceptReconfirm(
                                                                indexSample,
                                                                indexItem);
                                                          }),
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            rejectReconfirm(
                                                                indexSample,
                                                                indexItem);
                                                          }),
                                                    ],
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }())),
                                            ]))),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                ),
              ),
              if ((userSection == 'TTC' && userRoleId >= 5) ||
                  userRoleId == 99) ...[
                SizedBox(
                  height: 5,
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
                        approveAllResult();
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
      child: TableResultApprove(),
    );
  }
}

class EditItemStatus extends StatefulWidget {
  int idInSql = 0;
  EditItemStatus({
    Key? key,
    required this.idInSql,
  }) : super(key: key);

  @override
  _EditItemStatusState createState() => _EditItemStatusState();
}

class _EditItemStatusState extends State<EditItemStatus> {
  void initState() {
    super.initState();
  }

  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  TextStyle styleHeaderTable =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 400,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 100,
                      child: Text("STATUS ITEM", style: stylesection)),
                  Container(
                    child: Expanded(
                      child: CustomSearchableDropDown(
                        primaryColor: Colors.black,
                        menuMode: true,
                        menuHeight: 100,
                        labelStyle: styledata,
                        items: listStatusItem,
                        label: 'STATUS ITEM',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(Icons.search),
                        ),
                        dropDownMenuItems: listStatusItem.map((item) {
                          return item;
                        }).toList(),
                        onChanged: (value) {
                          print(value);
                          if (value != null) {
                            editItemId = widget.idInSql.toString();
                            editItemStatus = value.toString();
                          }
                        },
                      ),
                    ),
                  ),
                ]),
          ),
        ]));
  }
}

class EditItemDueDate extends StatefulWidget {
  int idInSql = 0;
  String itemStatus = "";
  EditItemDueDate({
    Key? key,
    required this.idInSql,
    required this.itemStatus,
  }) : super(key: key);

  @override
  _EditItemDueDateState createState() => _EditItemDueDateState();
}

class _EditItemDueDateState extends State<EditItemDueDate> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.itemStatus);
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      "NEW DUE DATE",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mitr'),
                    ),
                  ),
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      format: DateFormat("dd-MM-yyyy"),
                      style: TextStyle(fontSize: 13, fontFamily: 'Mitr'),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                          border: OutlineInputBorder()),
                      //initialValue: samplingDate,
                      inputType: InputType.date,
                      name: 'editDuedateDate',
                      onChanged: (value) {
                        editDuedateId = widget.idInSql.toString();
                        editDuedateItemStatus = widget.itemStatus.toString();
                        editDuedateDate = value.toString();
                      },
                    ),
                  ),
                ],
              )),
          Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      "REMARK CHANGE DUE DATE",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mitr'),
                    ),
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      style: TextStyle(fontSize: 13, fontFamily: 'Mitr'),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                          border: OutlineInputBorder()),
                      //initialValue: samplingDate,
                      name: 'remark',
                      onChanged: (value) {
                        editDuedateId = widget.idInSql.toString();
                        editDuedateItemStatus = widget.itemStatus.toString();
                        editDuedateRemark = value.toString();
                      },
                    ),
                  ),
                ],
              )),
        ]));
  }
}
