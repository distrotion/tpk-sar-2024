import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/52_CnUV/data/52_CnUV_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/52_CnUV/data/52_CnUV_bloc.dart';

class Instrument_CnUV extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_CnUV(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataCnUV>(
          create: (BuildContext context) => ManageDataCnUV(),
        ),
      ],
      child: CnUV(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class CnUV extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  CnUV({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _CnUVState createState() => _CnUVState();
}

class _CnUVState extends State<CnUV> {
  int countData = 0;
  void initState() {
    print("InINITIAL CnUV");
    if (widget.headHeight == 0) {
      context.read<ManageDataCnUV>().add(CnUVEvent.searchCnUVForInput);
    } else {
      context.read<ManageDataCnUV>().add(CnUVEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataCnUVInput[index].result_1 =
          double.parse(dataCnUVInput[index].rawData_1).toStringAsFixed(2);
      if (double.parse(dataCnUVInput[index].result_1) <
          (1 * double.parse(dataCnUVInput[index].dilutionTime_1))) {
        dataCnUVInput[index].result_1 = '<' +
            (1 * double.parse(dataCnUVInput[index].dilutionTime_1))
                .toStringAsFixed(2);
      }
      dataCnUVInput[index].resultUnit_1 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      /* dataCnUVInput[index].result_2 =
          (double.parse(dataCnUVInput[index].dilutionTime_2) *
                  double.parse(dataCnUVInput[index].rawData_2))
              .toStringAsFixed(2);  */
      dataCnUVInput[index].result_2 =
          double.parse(dataCnUVInput[index].rawData_2).toStringAsFixed(2);
      if (double.parse(dataCnUVInput[index].result_2) <
          (1 * double.parse(dataCnUVInput[index].dilutionTime_2))) {
        dataCnUVInput[index].result_2 = '<' +
            (1 * double.parse(dataCnUVInput[index].dilutionTime_2))
                .toStringAsFixed(2);
      }
      dataCnUVInput[index].resultUnit_2 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempCnUVsave.clear();
    dataTempCnUVsave.add(dataCnUVInput[index]);
    context.read<ManageDataCnUV>().add(CnUVEvent.tempSaveCnUVData);
  }

  void saveResult(int index) {
    if (dataCnUVInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataCnUVInput[index].stdMin.toString()}     STD MAX : ${dataCnUVInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataCnUVInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataCnUVInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataCnUVInput[index].result_1) >
                          double.parse(dataCnUVInput[index].stdMax) ||
                      double.parse(dataCnUVInput[index].result_1) <
                          double.parse(dataCnUVInput[index].stdMin) ||
                      double.parse(dataCnUVInput[index].result_2) >
                          double.parse(dataCnUVInput[index].stdMax) ||
                      double.parse(dataCnUVInput[index].result_2) <
                          double.parse(dataCnUVInput[index].stdMin)) {
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
                  if (double.parse(dataCnUVInput[index].result_1) >
                          double.parse(dataCnUVInput[index].stdMax) ||
                      double.parse(dataCnUVInput[index].result_1) <
                          double.parse(dataCnUVInput[index].stdMin)) {
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
            dataCnUVsave.clear();
            dataCnUVInput[index].userAnalysis = userName;
            dataCnUVInput[index].userAnalysisBranch = userBranch;
            dataCnUVsave.add(dataCnUVInput[index]);
            context.read<ManageDataCnUV>().add(CnUVEvent.saveCnUVData);
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
    return BlocBuilder<ManageDataCnUV, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataCnUVInput.length;
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
                    'DILUTION TIME',
                    'DILUTION TIME',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA \n (ppm)',
                    'RAW DATA (ppm)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT \n (ppm)',
                    'RESULT (ppm)',
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
                    'DILUTION TIME\n(2)',
                    'DILUTION TIME',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA \n (ppm)(2)',
                    'RAW DATA (ppm)',
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
                              child: Text(dataCnUVInput[index].sampleRemark),
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
                                          dataCnUVInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataCnUVInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataCnUVInput[index]
                                              .stdMax
                                              .toString(),
                                          dataCnUVInput[index]
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
                                initialValue: dataCnUVInput[index]
                                    .dilutionTime_1
                                    .toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].dilutionTime_1 =
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
                                textInputAction: TextInputAction.done,
                                decoration: formField(),
                                name: '${index}_4',
                                initialValue:
                                    dataCnUVInput[index].rawData_1.toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].rawData_1 =
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
                                name: '${index}_5',
                                key: Key(
                                    dataCnUVInput[index].result_1.toString()),
                                initialValue:
                                    dataCnUVInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].result_1 =
                                      value.toString();
                                  dataCnUVInput[index].resultUnit_1 = "ppm";
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
                                  dataCnUVInput[index].result_1 = value;
                                  dataCnUVInput[index].resultUnit_1 = "";
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
                                initialValue: dataCnUVInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].resultRemark_1 =
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
                                initialValue: dataCnUVInput[index]
                                    .dilutionTime_2
                                    .toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].dilutionTime_2 =
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
                                textInputAction: TextInputAction.done,
                                name: '${index}_9',
                                initialValue:
                                    dataCnUVInput[index].rawData_2.toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].rawData_2 =
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
                                textInputAction: TextInputAction.done,
                                //
                                name: '${index}_10',
                                key: Key(
                                    dataCnUVInput[index].result_2.toString()),
                                initialValue:
                                    dataCnUVInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].result_2 =
                                      value.toString();
                                  dataCnUVInput[index].resultUnit_2 = "ppm";
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
                                initialValue: dataCnUVInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataCnUVInput[index].resultRemark_2 =
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
