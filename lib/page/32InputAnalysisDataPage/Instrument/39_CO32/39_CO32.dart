import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/39_CO32/data/39_CO32_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/39_CO32/data/39_CO32_event.dart';

class Instrument_CO32 extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_CO32(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataCO32>(
          create: (BuildContext context) => ManageDataCO32(),
        ),
      ],
      child: CO32(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class CO32 extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  CO32({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _CO32State createState() => _CO32State();
}

class _CO32State extends State<CO32> {
  int countData = 0;
  void initState() {
    print("InINITIAL CO32");
    if (widget.headHeight == 0) {
      context.read<ManageDataCO32>().add(CO32Event.searchCO32ForInput);
    } else {
      context.read<ManageDataCO32>().add(CO32Event.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataCO32Input[index].w1W2_1 = (double.parse(dataCO32Input[index].w2_1) -
              double.parse(dataCO32Input[index].w1_1))
          .toStringAsFixed(4);
      dataCO32Input[index].result_1 =
          (((double.parse(dataCO32Input[index].w1W2_1) * 60) /
                      (197 * double.parse(dataCO32Input[index].usedSample_1))) *
                  100)
              .toStringAsFixed(2);
      dataCO32Input[index].resultUnit_1 = "% w/w";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataCO32Input[index].w1W2_2 = (double.parse(dataCO32Input[index].w2_2) -
              double.parse(dataCO32Input[index].w1_2))
          .toStringAsFixed(4);
      dataCO32Input[index].result_2 =
          (((double.parse(dataCO32Input[index].w1W2_2) * 60) /
                      (197 * double.parse(dataCO32Input[index].usedSample_2))) *
                  100)
              .toStringAsFixed(2);
      dataCO32Input[index].resultUnit_2 = "% w/w";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempCO32save.clear();
    dataTempCO32save.add(dataCO32Input[index]);
    context.read<ManageDataCO32>().add(CO32Event.tempSaveCO32Data);
  }

  void saveResult(int index) {
    if (dataCO32Input[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataCO32Input[index].stdMin.toString()}     STD MAX : ${dataCO32Input[index].stdMax.toString()}'),
            Text('RESULT : ${dataCO32Input[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataCO32Input[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataCO32Input[index].result_1) >
                          double.parse(dataCO32Input[index].stdMax) ||
                      double.parse(dataCO32Input[index].result_1) <
                          double.parse(dataCO32Input[index].stdMin) ||
                      double.parse(dataCO32Input[index].result_2) >
                          double.parse(dataCO32Input[index].stdMax) ||
                      double.parse(dataCO32Input[index].result_2) <
                          double.parse(dataCO32Input[index].stdMin)) {
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
                  if (double.parse(dataCO32Input[index].result_1) >
                          double.parse(dataCO32Input[index].stdMax) ||
                      double.parse(dataCO32Input[index].result_1) <
                          double.parse(dataCO32Input[index].stdMin)) {
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
            dataCO32save.clear();
            dataCO32Input[index].userAnalysis = userName;
            dataCO32Input[index].userAnalysisBranch = userBranch;
            dataCO32save.add(dataCO32Input[index]);
            context.read<ManageDataCO32>().add(CO32Event.saveCO32Data);
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
  double widthC17 = 50;
  double widthC18 = 50;
  double widthC19 = 40;
  double fieldHeight = 30;

  TextStyle styleDataInTable =
      TextStyle(fontSize: 9, fontFamily: 'Mitr', color: Colors.black);
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageDataCO32, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataCO32Input.length;
        } else {
          countData = 0;
        }
        return Form(
            key: _formKey,
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
                  /* headerColumn('NO', 'NO', widthC3),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'SAMPLE WIGHT\n(g)',
                    'SAMPLE WIGHT(g)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 1\n(g)',
                    'WEIGHT 1 (g)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 2\n(g)',
                    'WEIGHT 2 (g)',
                    widthC6,
                  ),
                  /* DataColumn(label: _verticalDivider),
                  headerColumn(
                    'W2-W1\n(g)',
                    'WEIGHT1- WEIGHT2 (g)',
                    widthC7,
                  ), */
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(%w/w)',
                    'RESULT = (((W2-W1)*60)/(197*sample weight))*100',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC9),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC10,
                  ), DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC18,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC19,
                  ),
                  DataColumn(label: _verticalDivider2),
                  /* headerColumn('NO', 'NO', widthC11),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'USED\nSAMPLE(mL)(2)',
                    'USED SAMPLE(mL)',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 1\n(g)(2)',
                    'WEIGHT 1 (g)',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 2\n(g)(2)',
                    'WEIGHT 2 (g)',
                    widthC14,
                  ),
                  /* DataColumn(label: _verticalDivider),
                  headerColumn(
                    'W2-W1\n(g)(2)',
                    'WEIGHT1- WEIGHT2 (g)',
                    widthC15,
                  ), */
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(%w/w)(2)',
                    'RESULT = (((W2-W1)*60)/(197*sample weight))*100',
                    widthC16,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC17,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC18,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC19,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataCO32Input[index].sampleRemark),
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
                                          dataCO32Input[index]
                                              .requestSampleId
                                              .toString(),
                                          dataCO32Input[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataCO32Input[index]
                                              .stdMax
                                              .toString(),
                                          dataCO32Input[index]
                                              .stdMin
                                              .toString(),
                                          context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider2),
                          /* DataCell(
                            Container(
                              width: widthC3,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue:
                                    dataCO32Input[index].no_1.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].no_1 =
                                      value.toString();
                                  },onSubmitted: (value) {
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC4,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_4',
                                initialValue: dataCO32Input[index]
                                    .usedSample_1
                                    .toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].usedSample_1 =
                                      value.toString();
                                  },onSubmitted: (value) {
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC5,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue:
                                    dataCO32Input[index].w1_1.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].w1_1 = value.toString();
                                  },onSubmitted: (value) {
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC6,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue:
                                    dataCO32Input[index].w2_1.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].w2_1 = value.toString();
                                  },onSubmitted: (value) {
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          /* DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC7,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue:
                                    dataCO32Input[index].w1W2_1.toString(),
                                key: Key(
                                    dataCO32Input[index].w1W2_1.toString()),
                                enabled: false,
                                onChanged: (value) {
                                  dataCO32Input[index].w1W2_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ), */
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                // enabled: false,
                                name: '${index}_8',
                                key: Key(
                                    dataCO32Input[index].result_1.toString()),
                                initialValue:
                                    dataCO32Input[index].result_1.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].result_1 =
                                      value.toString();
                                  dataCO32Input[index].resultUnit_1 = "% w/w";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
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
                                name: '${index}_9',
                                onChanged: (value) {
                                  dataCO32Input[index].result_1 = value;
                                  dataCO32Input[index].resultUnit_1 = "";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                initialValue: dataCO32Input[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC18,
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
                              width: widthC19,
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
                          /* DataCell(
                            Container(
                              width: widthC11,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue:
                                    dataCO32Input[index].no_2.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].no_2 =
                                      value.toString();
                                  },onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC12,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_12',
                                initialValue: dataCO32Input[index]
                                    .usedSample_2
                                    .toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].usedSample_2 =
                                      value.toString();
                                  },onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC13,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_13',
                                initialValue:
                                    dataCO32Input[index].w1_2.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].w1_2 = value.toString();
                                  },onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC14,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_14',
                                initialValue:
                                    dataCO32Input[index].w2_2.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].w2_2 = value.toString();
                                  },onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          /* DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC15,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_15',
                                initialValue:
                                    dataCO32Input[index].w1W2_2.toString(),
                                key: Key(
                                    dataCO32Input[index].w1W2_2.toString()),
                                enabled: false,
                                onChanged: (value) {
                                  dataCO32Input[index].w1W2_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ), */
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC16,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                keyboardType: TextInputType.multiline,
                                //enabled: false,
                                name: '${index}_16',
                                key: Key(
                                    dataCO32Input[index].result_2.toString()),
                                initialValue:
                                    dataCO32Input[index].result_2.toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].result_2 =
                                      value.toString();
                                  dataCO32Input[index].resultUnit_2 = "% w/w";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC17,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_17',
                                initialValue: dataCO32Input[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataCO32Input[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC18,
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
                              width: widthC19,
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
