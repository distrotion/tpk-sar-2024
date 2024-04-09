import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/25_SSM/data/25_SSM_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/25_SSM/data/25_SSM_bloc.dart';

class Instrument_SSM extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_SSM({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataSSM>(
          create: (BuildContext context) => ManageDataSSM(),
        ),
      ],
      child: SSM(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class SSM extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  SSM({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _SSMState createState() => _SSMState();
}

class _SSMState extends State<SSM> {
  int countData = 0;
  void initState() {
    print("InINITIAL SSM");
    if (widget.headHeight == 0) {
      context.read<ManageDataSSM>().add(SSMEvent.searchSSMForInput);
    } else {
      context.read<ManageDataSSM>().add(SSMEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      if (dataSSMInput[index].custFull ==
          'HANON SYSTEMS (THAILAND) CO., LTD.') {
        dataSSMInput[index].result_1 =
            ((double.parse(dataSSMInput[index].tC_1) / 1000) *
                    (135 / double.parse(dataSSMInput[index].w_1)))
                .toStringAsFixed(2);
        dataSSMInput[index].resultUnit_1 = 'mg/m2';
      } else if (dataSSMInput[index].custFull ==
          'AIR INTERNATIONAL THERMAL SYSTEMS (THAILAND) LTD') {
        dataSSMInput[index].result_1 =
            ((double.parse(dataSSMInput[index].tC_1) / 1000) *
                    (216 / double.parse(dataSSMInput[index].w_1)))
                .toStringAsFixed(2);
        dataSSMInput[index].resultUnit_1 = 'mg/m2';
      } else if (dataSSMInput[index].custFull ==
          'VALEO SIAM THERMAL SYSTEMS CO., LTD.') {
        dataSSMInput[index].result_1 =
            ((double.parse(dataSSMInput[index].tC_1) / 104.66) *
                    (10 / double.parse(dataSSMInput[index].w_1)))
                .toStringAsFixed(2);
        dataSSMInput[index].resultUnit_1 = 'mg/m2';
      } else {
        dataSSMInput[index].resultUnit_1 = 'ugC';
      }
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      if (dataSSMInput[index].custFull ==
          'HANON SYSTEMS (THAILAND) CO., LTD.') {
        dataSSMInput[index].result_2 =
            ((double.parse(dataSSMInput[index].tC_2) / 1000) *
                    (135 / double.parse(dataSSMInput[index].w_2)))
                .toStringAsFixed(2);
        dataSSMInput[index].resultUnit_2 = 'mg/m2';
      } else if (dataSSMInput[index].custFull ==
          'AIR INTERNATIONAL THERMAL SYSTEMS (THAILAND) LTD') {
        dataSSMInput[index].result_2 =
            ((double.parse(dataSSMInput[index].tC_2) / 1000) *
                    (216 / double.parse(dataSSMInput[index].w_2)))
                .toStringAsFixed(2);
        dataSSMInput[index].resultUnit_2 = 'mg/m2';
      } else if (dataSSMInput[index].custFull ==
          'VALEO SIAM THERMAL SYSTEMS CO., LTD.') {
        dataSSMInput[index].result_2 =
            ((double.parse(dataSSMInput[index].tC_2) / 104.66) *
                    (10 / double.parse(dataSSMInput[index].w_2)))
                .toStringAsFixed(2);
        dataSSMInput[index].resultUnit_2 = 'mg/m2';
      } else {
        dataSSMInput[index].resultUnit_2 = 'ugC';
      }
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempSSMsave.clear();
    dataTempSSMsave.add(dataSSMInput[index]);
    context.read<ManageDataSSM>().add(SSMEvent.tempSaveSSMData);
  }

  void saveResult(int index) {
    if (dataSSMInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataSSMInput[index].stdMin.toString()}     STD MAX : ${dataSSMInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataSSMInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataSSMInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataSSMInput[index].result_1) >
                          double.parse(dataSSMInput[index].stdMax) ||
                      double.parse(dataSSMInput[index].result_1) <
                          double.parse(dataSSMInput[index].stdMin) ||
                      double.parse(dataSSMInput[index].result_2) >
                          double.parse(dataSSMInput[index].stdMax) ||
                      double.parse(dataSSMInput[index].result_2) <
                          double.parse(dataSSMInput[index].stdMin)) {
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
                  if (double.parse(dataSSMInput[index].result_1) >
                          double.parse(dataSSMInput[index].stdMax) ||
                      double.parse(dataSSMInput[index].result_1) <
                          double.parse(dataSSMInput[index].stdMin)) {
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
            dataSSMsave.clear();
            dataSSMInput[index].userAnalysis = userName;
            dataSSMInput[index].userAnalysisBranch = userBranch;
            dataSSMsave.add(dataSSMInput[index]);
            context.read<ManageDataSSM>().add(SSMEvent.saveSSMData);
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
  double widthC13 = 40;
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
    return BlocBuilder<ManageDataSSM, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataSSMInput.length;
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
                    'POSITION',
                    'POSITION',
                    widthC2,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'HISTORY',
                    'DATA/CHART',
                    widthC2,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn(
                    'WEIGHT (g)',
                    'WEIGHT (g)',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TC (μgC)',
                    'TC (μgC)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT',
                    'RESULT',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'UNIT',
                    'RESULT UNIT',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC6),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn(
                    'WEIGHT (g)\n(2)',
                    'WEIGHT (g)',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TC (μgC) \n (2)',
                    'TC (μgC)',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(2)',
                    'RESULT',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'UNIT (2)',
                    'RESULT UNIT (2)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC13,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataSSMInput[index].sampleRemark),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC2,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue:
                                    dataSSMInput[index].position.toString(),
                                enabled: false,
                              ),
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
                                          dataSSMInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataSSMInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataSSMInput[index].stdMax.toString(),
                                          dataSSMInput[index].stdMin.toString(),
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
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_3',
                                initialValue:
                                    dataSSMInput[index].w_1.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].w_1 = value.toString();
                                },
                                onSubmitted: (value) {
                                  calculate(index);
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
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_4',
                                initialValue:
                                    dataSSMInput[index].tC_1.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].tC_1 = value.toString();
                                },
                                onSubmitted: (value) {
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
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                key: Key(
                                    dataSSMInput[index].result_1.toString()),
                                initialValue:
                                    dataSSMInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].result_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC5,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_66',
                                key: Key(dataSSMInput[index]
                                    .resultUnit_1
                                    .toString()),
                                initialValue:
                                    dataSSMInput[index].resultUnit_1.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].resultUnit_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC6,
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
                                name: '${index}_6',
                                onChanged: (value) {
                                  dataSSMInput[index].result_1 = value;
                                  dataSSMInput[index].resultUnit_1 = "";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC7,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue: dataSSMInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC12,
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
                              width: widthC13,
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
                              width: widthC8,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_8',
                                initialValue:
                                    dataSSMInput[index].w_2.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].w_2 = value.toString();
                                },
                                onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.done,
                                name: '${index}_9',
                                initialValue:
                                    dataSSMInput[index].tC_2.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].tC_2 = value.toString();
                                },
                                onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                key: Key(
                                    dataSSMInput[index].result_2.toString()),
                                initialValue:
                                    dataSSMInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].result_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC5,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_77',
                                key: Key(dataSSMInput[index]
                                    .resultUnit_2
                                    .toString()),
                                initialValue:
                                    dataSSMInput[index].resultUnit_2.toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].resultUnit_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC11,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue: dataSSMInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataSSMInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC12,
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
                              width: widthC13,
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
