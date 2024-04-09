import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/7_FF/data/7_FF_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/7_FF/data/7_FF_event.dart';

class Instrument_FF extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_FF({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataFF>(
          create: (BuildContext context) => ManageDataFF(),
        ),
      ],
      child: FF(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class FF extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  FF({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _FFState createState() => _FFState();
}

class _FFState extends State<FF> {
  int countData = 0;
  void initState() {
    print("InINITIAL FF");
    if (widget.headHeight == 0) {
      context.read<ManageDataFF>().add(FFEvent.searchFFForInput);
    } else {
      context.read<ManageDataFF>().add(FFEvent.dummyHead);
    }
    super.initState();
  }

/*   void calculate(int index) {
    print("incal");
    try {
      if (dataFFInput[index].custFull ==
          'BANGKOK CAN MANUFACTURING CO.,LTD. LINE 1') {
        if (double.parse(dataFFInput[index].result_1) < 1) {
          dataFFInput[index].result_1 = '< 1';
        }
      } else if (double.parse(dataFFInput[index].result_1) < 10) {
        dataFFInput[index].result_1 = '< 10';
        print("2");
        setState(() {
          print(dataFFInput[index].result_1);
        });
      } else {
        print("3");
      }
      dataFFInput[index].resultUnit_1 = "ppm";
      setState(() {
        print(dataFFInput[index].result_1);
      });
    } on Exception catch (e) {
      // TODO
      //print(e);
    }
  } */
  void calculate(int index) {
    print("incal");
    print(dataFFInput[index].result_1);
    try {
      if (dataFFInput[index].custFull ==
          'BANGKOK CAN MANUFACTURING CO.,LTD. LINE 1') {
        if (double.parse(dataFFInput[index].result_1) < 1) {
          dataFFInput[index].result_1 = '< 1';
        }
      } else if (userBranch == "BANGPOO") {
        if (double.parse(dataFFInput[index].result_1) < 1) {
          dataFFInput[index].result_1 = '< 1';
        }
      } else if (userBranch == "RAYONG") {
        if (double.parse(dataFFInput[index].result_1) < 10) {
          dataFFInput[index].result_1 = '< 10';
        }
      }
      dataFFInput[index].resultUnit_1 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
      setState(() {
        print(dataFFInput[index].result_1);
      });
      print(e);
    }
  }

  void calculate2(int index) {
    try {
      if (dataFFInput[index].custFull ==
          'BANGKOK CAN MANUFACTURING CO.,LTD. LINE 1') {
        if (double.parse(dataFFInput[index].result_2) < 1) {
          dataFFInput[index].result_2 = '< 1';
        }
      } else if (userBranch == "BANGPOO") {
        if (double.parse(dataFFInput[index].result_2) < 1) {
          dataFFInput[index].result_2 = '< 1';
        }
      } else if (userBranch == "RAYONG") {
        if (double.parse(dataFFInput[index].result_2) < 10) {
          dataFFInput[index].result_2 = '< 10';
        }
      }

      dataFFInput[index].resultUnit_2 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
      setState(() {
        print(dataFFInput[index].result_2);
      });
    }
  }

  void tempSave(int index) {
    dataTempFFsave.clear();
    dataTempFFsave.add(dataFFInput[index]);
    context.read<ManageDataFF>().add(FFEvent.tempSaveFFData);
  }

  void saveResult(int index) {
    if (dataFFInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataFFInput[index].stdMin.toString()}     STD MAX : ${dataFFInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataFFInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataFFInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataFFInput[index].result_1) >
                          double.parse(dataFFInput[index].stdMax) ||
                      double.parse(dataFFInput[index].result_1) <
                          double.parse(dataFFInput[index].stdMin) ||
                      double.parse(dataFFInput[index].result_2) >
                          double.parse(dataFFInput[index].stdMax) ||
                      double.parse(dataFFInput[index].result_2) <
                          double.parse(dataFFInput[index].stdMin)) {
                    return Text('RESULT OUT OF RANGE',
                        style: TextStyle(color: Colors.red));
                  } else
                    return Text('CONFIRM SAVE RESULT');
                } on Exception catch (e) {
                  return Text(
                    'CONFIRM SAVE RESULT',
                  );
                }
              } else {
                try {
                  if (double.parse(dataFFInput[index].result_1) >
                          double.parse(dataFFInput[index].stdMax) ||
                      double.parse(dataFFInput[index].result_1) <
                          double.parse(dataFFInput[index].stdMin)) {
                    return Text('RESULT OUT OF RANGE',
                        style: TextStyle(color: Colors.red));
                  } else
                    return Text('CONFIRM SAVE RESULT');
                } on Exception catch (e) {
                  return Text('CONFIRM SAVE RESULT');
                }
              }
            }()))
          ]),
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: () {
            dataFFsave.clear();
            dataFFInput[index].userAnalysis = userName;
            dataFFInput[index].userAnalysisBranch = userBranch;
            dataFFsave.add(dataFFInput[index]);
            context.read<ManageDataFF>().add(FFEvent.saveFFData);
          //  Navigator.pop(context);
          });
    } else {
      CoolAlert.show(
        width: 200,
        context: context,
        type: CoolAlertType.error,
        text: 'INPUT RESULT',
        confirmBtnText: 'OK',
        confirmBtnColor: Colors.green,
      );
    }
  }

  double widthC1 = 50;
  double widthC2 = 50;
  double widthC3 = 50;
  double widthC4 = 50;
  double widthC5 = 50;
  double widthC6 = 50;
  double widthC7 = 50;
  double widthC8 = 50;
  double widthC9 = 50;
  double widthC10 = 50;
  double widthC11 = 50;
  double widthC12 = 50;
  double widthC13 = 50;
  double widthC14 = 50;
  double widthC15 = 50;
  double widthC16 = 50;
  double widthC17 = 40;
  double fieldHeight = 30;

  TextStyle styleDataInTable =
      TextStyle(fontSize: 9, fontFamily: 'Mitr', color: Colors.black);
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);

  final _formKey2 = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageDataFF, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataFFInput.length;
        } else {
          countData = 0;
        }
        return Form(
            key: _formKey2,
            child: DataTable(
                headingRowHeight: widget.headHeight,
                headingTextStyle: styleHeaderTable,
                dataRowHeight: widget.dataHeight,
                dataTextStyle: styleDataInTable,
                columnSpacing: 5,
                horizontalMargin: 10,
                columns: [
                  DataColumn(
                    label: Container(
                        width: widthC1,
                        child: Text(
                          'REMARK',
                        )),
                    tooltip: "SAMPLE REMARK",
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'HISTORY',
                    'DATA/CHART',
                    widthC2,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn('TEMP\n(°C)', 'TEMP (°C)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(ppm)',
                    'RESULT (ppm)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'ERROR',
                    'ERROR RESULT',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn('TEMP\n(°C)(2)', 'TEMP (°C)', widthC7),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(ppm)(2)',
                    'RESULT (ppm)',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC11,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataFFInput[index].sampleRemark),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC2,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.insights),
                                  onPressed: () {
                                    setState(() {
                                      showHistory(
                                          dataFFInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataFFInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataFFInput[index].stdMax.toString(),
                                          dataFFInput[index].stdMin.toString(),
                                          context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider2),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue:
                                    dataFFInput[index].temp_1.toString(),
                                onChanged: (value) {
                                  dataFFInput[index].temp_1 = value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC4,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                textInputAction: TextInputAction.done,
                                decoration: formField(),
                                name: '${index}_4',
                                key:
                                    Key(dataFFInput[index].result_1.toString()),
                                initialValue:
                                    dataFFInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataFFInput[index].result_1 =
                                      value.toString();
                                  dataFFInput[index].resultUnit_1 = "ppm";
                                },
                                onSubmitted: (value) {
                                  dataFFInput[index].result_1 =
                                      value.toString();
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC5,
                              //height: fieldHeight,
                              child: FormBuilderDropdown(
                                items: errorData
                                    .map((error) => DropdownMenuItem(
                                          value: error,
                                          child: Text('$error'),
                                        ))
                                    .toList(),
                                style: styleDataInTable,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder()),
                                name: '${index}_5',
                                onChanged: (value) {
                                  dataFFInput[index].result_1 = value;
                                  dataFFInput[index].resultUnit_1 = "";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC6,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue: dataFFInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataFFInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.black12,
                                  ),
                                  onPressed: () {
                                    tempSave(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC11,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    saveResult(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider2),
                          DataCell(
                            Container(
                              width: widthC7,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue:
                                    dataFFInput[index].temp_2.toString(),
                                onChanged: (value) {
                                  dataFFInput[index].temp_2 = value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.done,
                                name: '${index}_8',
                                key:
                                    Key(dataFFInput[index].result_2.toString()),
                                initialValue:
                                    dataFFInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataFFInput[index].result_2 =
                                      value.toString();
                                  dataFFInput[index].resultUnit_2 = "ppm";
                                },
                                onSubmitted: (value) {
                                  dataFFInput[index].result_2 =
                                      value.toString();
                                  calculate2(index);
                                },
                              ),
                              //Text(dataFFInput[index].result_1),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue: dataFFInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataFFInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.black12,
                                  ),
                                  onPressed: () {
                                    tempSave(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC11,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    saveResult(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]))));
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);
Widget _verticalDivider2 = const VerticalDivider(
  color: Colors.black,
  thickness: 1,
);

InputDecoration formField() {
  return InputDecoration(
      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 3),
      border: OutlineInputBorder(gapPadding: 0));
}

headerColumn(
  String textIn,
  String tooltipIn,
  double widthData,
) {
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);
  return DataColumn(
    label: Container(
        width: widthData,
        child: Center(
            child: Text(textIn,
                style: styleHeaderTable, textAlign: TextAlign.center))),
    tooltip: tooltipIn,
  );
}
