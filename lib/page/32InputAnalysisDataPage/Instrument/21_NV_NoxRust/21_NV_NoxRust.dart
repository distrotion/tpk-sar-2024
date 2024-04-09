import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/21_NV_NoxRust/data/21_NV_NoxRust_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/21_NV_NoxRust/data/21_NV_NoxRust_event.dart';

class Instrument_NV_NoxRust extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_NV_NoxRust(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataNV_NoxRust>(
          create: (BuildContext context) => ManageDataNV_NoxRust(),
        ),
      ],
      child: NV_NoxRust(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class NV_NoxRust extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  NV_NoxRust({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _NV_NoxRustState createState() => _NV_NoxRustState();
}

class _NV_NoxRustState extends State<NV_NoxRust> {
  int countData = 0;
  void initState() {
    print("InINITIAL NV_NoxRust");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataNV_NoxRust>()
          .add(NV_NoxRustEvent.searchNV_NoxRustForInput);
    } else {
      context.read<ManageDataNV_NoxRust>().add(NV_NoxRustEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataNV_NoxRustInput[index].result_1 =
          (((double.parse(dataNV_NoxRustInput[index].w3_1) -
                          double.parse(dataNV_NoxRustInput[index].w1_1)) /
                      (double.parse(dataNV_NoxRustInput[index].w2_1) -
                          double.parse(dataNV_NoxRustInput[index].w1_1))) *
                  100)
              .toStringAsFixed(2);
      dataNV_NoxRustInput[index].resultUnit_1 = "%";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataNV_NoxRustInput[index].result_2 =
          (((double.parse(dataNV_NoxRustInput[index].w3_2) -
                          double.parse(dataNV_NoxRustInput[index].w1_2)) /
                      (double.parse(dataNV_NoxRustInput[index].w2_2) -
                          double.parse(dataNV_NoxRustInput[index].w1_2))) *
                  100)
              .toStringAsFixed(2);
      dataNV_NoxRustInput[index].resultUnit_2 = "%";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempNV_NoxRustsave.clear();
    dataTempNV_NoxRustsave.add(dataNV_NoxRustInput[index]);
    context
        .read<ManageDataNV_NoxRust>()
        .add(NV_NoxRustEvent.tempSaveNV_NoxRustData);
  }

  void saveResult(int index) {
    if (dataNV_NoxRustInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataNV_NoxRustInput[index].stdMin.toString()}     STD MAX : ${dataNV_NoxRustInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataNV_NoxRustInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataNV_NoxRustInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataNV_NoxRustInput[index].result_1) >
                          double.parse(dataNV_NoxRustInput[index].stdMax) ||
                      double.parse(dataNV_NoxRustInput[index].result_1) <
                          double.parse(dataNV_NoxRustInput[index].stdMin) ||
                      double.parse(dataNV_NoxRustInput[index].result_2) >
                          double.parse(dataNV_NoxRustInput[index].stdMax) ||
                      double.parse(dataNV_NoxRustInput[index].result_2) <
                          double.parse(dataNV_NoxRustInput[index].stdMin)) {
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
                  if (double.parse(dataNV_NoxRustInput[index].result_1) >
                          double.parse(dataNV_NoxRustInput[index].stdMax) ||
                      double.parse(dataNV_NoxRustInput[index].result_1) <
                          double.parse(dataNV_NoxRustInput[index].stdMin)) {
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
            dataNV_NoxRustsave.clear();
            dataNV_NoxRustInput[index].userAnalysis = userName;
            dataNV_NoxRustInput[index].userAnalysisBranch = userBranch;
            dataNV_NoxRustsave.add(dataNV_NoxRustInput[index]);
            context
                .read<ManageDataNV_NoxRust>()
                .add(NV_NoxRustEvent.saveNV_NoxRustData);
            //Navigator.pop(context);
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
  double widthC15 = 40;
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
    return BlocBuilder<ManageDataNV_NoxRust, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataNV_NoxRustInput.length;
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
                    'WEIGHT 1\n(g)',
                    'WEIGHT 1 (g)',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 2\n(g)',
                    'WEIGHT 2 (g)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 3\n(g)',
                    'WEIGHT 3 (g)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(%)',
                    'RESULT = (W3-W1)/(W2-W1)',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC7),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC8,
                  ),
                   DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC14,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC15,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn(
                    'WEIGHT 1\n(g)(2)',
                    'WEIGHT 1 (g)',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 2\n(g)(2)',
                    'WEIGHT 2 (g)',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 3\n(g)(2)',
                    'WEIGHT 3 (g)',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(%)(2)',
                    'RESULT = (W3-W1)/(W2-W1)',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC14,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC15,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child:
                                  Text(dataNV_NoxRustInput[index].sampleRemark),
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
                                          dataNV_NoxRustInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataNV_NoxRustInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataNV_NoxRustInput[index]
                                              .stdMax
                                              .toString(),
                                          dataNV_NoxRustInput[index]
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue:
                                    dataNV_NoxRustInput[index].w1_1.toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].w1_1 =
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
                              width: widthC4,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_4',
                                initialValue:
                                    dataNV_NoxRustInput[index].w2_1.toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].w2_1 =
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
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue:
                                    dataNV_NoxRustInput[index].w3_1.toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].w3_1 =
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
                              width: widthC6,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                //enabled: false,
                                name: '${index}_6',
                                key: Key(dataNV_NoxRustInput[index]
                                    .result_1
                                    .toString()),
                                initialValue: dataNV_NoxRustInput[index]
                                    .result_1
                                    .toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].result_1 =
                                      value.toString();
                                  dataNV_NoxRustInput[index].resultUnit_1 = "%";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC7,
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
                                name: '${index}_7',
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].result_1 = value;
                                  dataNV_NoxRustInput[index].resultUnit_1 = "";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_8',
                                initialValue: dataNV_NoxRustInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC14,
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
                              width: widthC15,
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
                              width: widthC9,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue:
                                    dataNV_NoxRustInput[index].w1_2.toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].w1_2 =
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
                              width: widthC10,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                initialValue:
                                    dataNV_NoxRustInput[index].w2_2.toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].w2_2 =
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
                              width: widthC11,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue:
                                    dataNV_NoxRustInput[index].w3_2.toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].w3_2 =
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
                              width: widthC12,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_12',
                                key: Key(dataNV_NoxRustInput[index]
                                    .result_2
                                    .toString()),
                                initialValue: dataNV_NoxRustInput[index]
                                    .result_2
                                    .toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].result_2 =
                                      value.toString();
                                  dataNV_NoxRustInput[index].resultUnit_2 = "%";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC13,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_13',
                                initialValue: dataNV_NoxRustInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataNV_NoxRustInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC14,
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
                              width: widthC15,
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
