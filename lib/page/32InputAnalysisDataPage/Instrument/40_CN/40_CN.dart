import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/40_CN/data/40_CN_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/40_CN/data/40_CN_bloc.dart';

class Instrument_CN extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_CN({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataCN>(
          create: (BuildContext context) => ManageDataCN(),
        ),
      ],
      child: CN(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class CN extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  CN({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _CNState createState() => _CNState();
}

class _CNState extends State<CN> {
  int countData = 0;
  void initState() {
    print("InINITIAL CN");
    if (widget.headHeight == 0) {
      context.read<ManageDataCN>().add(CNEvent.searchCNForInput);
    } else {
      context.read<ManageDataCN>().add(CNEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      if (dataCNInput[index].itemName == 'CN-(UV)') {
        dataCNInput[index].result_1 =
            (double.parse(dataCNInput[index].dilutionTime_1) *
                    double.parse(dataCNInput[index].rawData_1))
                .toStringAsFixed(3);
        dataCNInput[index].resultUnit_1 = "ppm";
        if (double.parse(dataCNInput[index].result_1) < 0.03) {
          dataCNInput[index].result_1 = "< 0.03";
        }
      } else {
        dataCNInput[index].result_1 =
            (double.parse(dataCNInput[index].rawData_1) * 520.4)
                .toStringAsFixed(1);
        dataCNInput[index].resultUnit_1 = "ppm";
      }
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      if (dataCNInput[index].itemName == 'CN-(UV)') {
        dataCNInput[index].result_2 =
            (double.parse(dataCNInput[index].dilutionTime_2) *
                    double.parse(dataCNInput[index].rawData_2))
                .toStringAsFixed(3);
        dataCNInput[index].resultUnit_2 = "ppm";
        if (double.parse(dataCNInput[index].result_2) < 0.03) {
          dataCNInput[index].result_2 = "< 0.03";
        }
      } else {
        dataCNInput[index].result_2 =
            (double.parse(dataCNInput[index].rawData_2) * 520.4)
                .toStringAsFixed(1);
        dataCNInput[index].resultUnit_2 = "ppm";
      }
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempCNsave.clear();
    dataTempCNsave.add(dataCNInput[index]);
    context.read<ManageDataCN>().add(CNEvent.tempSaveCNData);
  }

  void saveResult(int index) {
    if (dataCNInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataCNInput[index].stdMin.toString()}     STD MAX : ${dataCNInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataCNInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataCNInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataCNInput[index].result_1) >
                          double.parse(dataCNInput[index].stdMax) ||
                      double.parse(dataCNInput[index].result_1) <
                          double.parse(dataCNInput[index].stdMin) ||
                      double.parse(dataCNInput[index].result_2) >
                          double.parse(dataCNInput[index].stdMax) ||
                      double.parse(dataCNInput[index].result_2) <
                          double.parse(dataCNInput[index].stdMin)) {
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
                  if (double.parse(dataCNInput[index].result_1) >
                          double.parse(dataCNInput[index].stdMax) ||
                      double.parse(dataCNInput[index].result_1) <
                          double.parse(dataCNInput[index].stdMin)) {
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
            dataCNsave.clear();
            dataCNInput[index].userAnalysis = userName;
            dataCNInput[index].userAnalysisBranch = userBranch;
            dataCNsave.add(dataCNInput[index]);
            context.read<ManageDataCN>().add(CNEvent.saveCNData);
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
    return BlocBuilder<ManageDataCN, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataCNInput.length;
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
                  headerColumn('DILUTION \n TIMES', 'DILUTION TIMES', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA \n (mL)',
                    'RAW DATA (mL)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT \n (ppm)',
                    'RESULT = Raw data x 520.4',
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
                      'DILUTION \n TIMES(2)', 'DILUTION TIMES(2)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA \n (mL)(2)',
                    'RAW DATA (mL)',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT (ppm)\n(2)',
                    'RESULT = Raw data x 520.4',
                    widthC10,
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
                              child: Text(dataCNInput[index].sampleRemark),
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
                                          dataCNInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataCNInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataCNInput[index].stdMax.toString(),
                                          dataCNInput[index].stdMin.toString(),
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
                                initialValue: dataCNInput[index]
                                    .dilutionTime_1
                                    .toString(),
                                onChanged: (value) {
                                  dataCNInput[index].dilutionTime_1 =
                                      value.toString();
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
                                    dataCNInput[index].rawData_1.toString(),
                                onChanged: (value) {
                                  dataCNInput[index].rawData_1 =
                                      value.toString();
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
                                textInputAction: TextInputAction.done,
                                name: '${index}_5',
                                key:
                                    Key(dataCNInput[index].result_1.toString()),
                                initialValue:
                                    dataCNInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataCNInput[index].result_1 =
                                      value.toString();
                                  dataCNInput[index].resultUnit_1 = "ppm";
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
                                  dataCNInput[index].result_1 = value;
                                  dataCNInput[index].resultUnit_1 = "";
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
                                initialValue: dataCNInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataCNInput[index].resultRemark_1 =
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
                              width: widthC9,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_8',
                                initialValue: dataCNInput[index]
                                    .dilutionTime_2
                                    .toString(),
                                onChanged: (value) {
                                  dataCNInput[index].dilutionTime_2 =
                                      value.toString();
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
                                textInputAction: TextInputAction.next,
                                name: '${index}_9',
                                initialValue:
                                    dataCNInput[index].rawData_2.toString(),
                                onChanged: (value) {
                                  dataCNInput[index].rawData_2 =
                                      value.toString();
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
                                key:
                                    Key(dataCNInput[index].result_2.toString()),
                                initialValue:
                                    dataCNInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataCNInput[index].result_2 =
                                      value.toString();
                                  dataCNInput[index].resultUnit_2 = "ppm";
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
                                initialValue: dataCNInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataCNInput[index].resultRemark_2 =
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
