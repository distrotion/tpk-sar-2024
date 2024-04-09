import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/35_Dsmut/data/35_Dsmut_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/35_Dsmut/data/35_Dsmut_bloc.dart';

class Instrument_Dsmut extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_Dsmut(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataDsmut>(
          create: (BuildContext context) => ManageDataDsmut(),
        ),
      ],
      child: Dsmut(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class Dsmut extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Dsmut({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _DsmutState createState() => _DsmutState();
}

class _DsmutState extends State<Dsmut> {
  int countData = 0;
  void initState() {
    print("InINITIAL Dsmut");
    if (widget.headHeight == 0) {
      context.read<ManageDataDsmut>().add(DsmutEvent.searchDsmutForInput);
    } else {
      context.read<ManageDataDsmut>().add(DsmutEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataDsmutInput[index].resultUnit_1 = "";
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataDsmutInput[index].resultUnit_2 = "";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempDsmutsave.clear();
    dataTempDsmutsave.add(dataDsmutInput[index]);
    context.read<ManageDataDsmut>().add(DsmutEvent.tempSaveDsmutData);
  }

  void saveResult(int index) {
    if (dataDsmutInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataDsmutInput[index].stdMin.toString()}     STD MAX : ${dataDsmutInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataDsmutInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataDsmutInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataDsmutInput[index].result_1) >
                          double.parse(dataDsmutInput[index].stdMax) ||
                      double.parse(dataDsmutInput[index].result_1) <
                          double.parse(dataDsmutInput[index].stdMin) ||
                      double.parse(dataDsmutInput[index].result_2) >
                          double.parse(dataDsmutInput[index].stdMax) ||
                      double.parse(dataDsmutInput[index].result_2) <
                          double.parse(dataDsmutInput[index].stdMin)) {
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
                  if (double.parse(dataDsmutInput[index].result_1) >
                          double.parse(dataDsmutInput[index].stdMax) ||
                      double.parse(dataDsmutInput[index].result_1) <
                          double.parse(dataDsmutInput[index].stdMin)) {
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
            dataDsmutsave.clear();
            dataDsmutInput[index].userAnalysis = userName;
            dataDsmutInput[index].userAnalysisBranch = userBranch;
            dataDsmutsave.add(dataDsmutInput[index]);
            context.read<ManageDataDsmut>().add(DsmutEvent.saveDsmutData);
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
  double widthC11 = 40;
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
    return BlocBuilder<ManageDataDsmut, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataDsmutInput.length;
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
                  headerColumn(
                    'POSITION',
                    'POSITION',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'BLANK RESULT',
                    'BLANK RESULT',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT',
                    'RESULT',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC5),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC6,
                  ),DataColumn(label: _verticalDivider),
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
                  headerColumn(
                    'POSITION\n(2)',
                    'POSITION',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'BLANK RESULT\n(2)',
                    'BLANK RESULT',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(2)',
                    'RESULT',
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
                              child: Text(dataDsmutInput[index].sampleRemark),
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
                                          dataDsmutInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataDsmutInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataDsmutInput[index]
                                              .stdMax
                                              .toString(),
                                          dataDsmutInput[index]
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
                          DataCell(
                            Container(
                              width: widthC3,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_3',
                                key:
                                    Key(dataDsmutInput[index].pos_1.toString()),
                                initialValue:
                                    dataDsmutInput[index].pos_1.toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].pos_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_x3',
                                key: Key(
                                    dataDsmutInput[index].blank_1.toString()),
                                initialValue:
                                    dataDsmutInput[index].blank_1.toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].blank_1 =
                                      value.toString();
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
                               textInputAction: TextInputAction.done,
                                name: '${index}_4',
                                key: Key(
                                    dataDsmutInput[index].result_1.toString()),
                                initialValue:
                                    dataDsmutInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].result_1 =
                                      value.toString();
                                  dataDsmutInput[index].resultUnit_1 = "";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC5,
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
                                  dataDsmutInput[index].result_1 = value;
                                  dataDsmutInput[index].resultUnit_1 = "";
                                  setState(() {});
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
                                initialValue: dataDsmutInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),DataCell(_verticalDivider),
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
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_7',
                                key:
                                    Key(dataDsmutInput[index].pos_2.toString()),
                                initialValue:
                                    dataDsmutInput[index].pos_2.toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].pos_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC7,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_x7',
                                key: Key(
                                    dataDsmutInput[index].blank_2.toString()),
                                initialValue:
                                    dataDsmutInput[index].blank_2.toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].blank_2 =
                                      value.toString();
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
                                key: Key(
                                    dataDsmutInput[index].result_2.toString()),
                                initialValue:
                                    dataDsmutInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].result_2 =
                                      value.toString();
                                  dataDsmutInput[index].resultUnit_1 = "";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue: dataDsmutInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataDsmutInput[index].resultRemark_2 =
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
