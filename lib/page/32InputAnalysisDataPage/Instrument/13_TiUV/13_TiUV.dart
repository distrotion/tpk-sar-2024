import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/13_TiUV/data/13_TiUV_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/13_TiUV/data/13_TiUV_bloc.dart';

class Instrument_TiUV extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_TiUV(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataTiUV>(
          create: (BuildContext context) => ManageDataTiUV(),
        ),
      ],
      child: TiUV(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class TiUV extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  TiUV({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _TiUVState createState() => _TiUVState();
}

class _TiUVState extends State<TiUV> {
  int countData = 0;
  void initState() {
    print("InINITIAL TiUV");
    if (widget.headHeight == 0) {
      context.read<ManageDataTiUV>().add(TiUVEvent.searchTiUVForInput);
    } else {
      context.read<ManageDataTiUV>().add(TiUVEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      /* dataTiUVInput[index].result_1 =
          (double.parse(dataTiUVInput[index].dilutionTime_1) *
                  double.parse(dataTiUVInput[index].rawData_1))
              .toStringAsFixed(2); */
      dataTiUVInput[index].result_1 =
          double.parse(dataTiUVInput[index].rawData_1).toStringAsFixed(2);
      if (double.parse(dataTiUVInput[index].result_1) <
          (1 * double.parse(dataTiUVInput[index].dilutionTime_1))) {
        dataTiUVInput[index].result_1 = '<' +
            (1 * double.parse(dataTiUVInput[index].dilutionTime_1))
                .toStringAsFixed(2);
      }
      dataTiUVInput[index].resultUnit_1 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      /* dataTiUVInput[index].result_2 =
          (double.parse(dataTiUVInput[index].dilutionTime_2) *
                  double.parse(dataTiUVInput[index].rawData_2))
              .toStringAsFixed(2);  */
      dataTiUVInput[index].result_2 =
          double.parse(dataTiUVInput[index].rawData_2).toStringAsFixed(2);
      if (double.parse(dataTiUVInput[index].result_2) <
          (1 * double.parse(dataTiUVInput[index].dilutionTime_2))) {
        dataTiUVInput[index].result_2 = '<' +
            (1 * double.parse(dataTiUVInput[index].dilutionTime_2))
                .toStringAsFixed(2);
      }
      dataTiUVInput[index].resultUnit_2 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempTiUVsave.clear();
    dataTempTiUVsave.add(dataTiUVInput[index]);
    context.read<ManageDataTiUV>().add(TiUVEvent.tempSaveTiUVData);
  }

  void saveResult(int index) {
    if (dataTiUVInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataTiUVInput[index].stdMin.toString()}     STD MAX : ${dataTiUVInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataTiUVInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataTiUVInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataTiUVInput[index].result_1) >
                          double.parse(dataTiUVInput[index].stdMax) ||
                      double.parse(dataTiUVInput[index].result_1) <
                          double.parse(dataTiUVInput[index].stdMin) ||
                      double.parse(dataTiUVInput[index].result_2) >
                          double.parse(dataTiUVInput[index].stdMax) ||
                      double.parse(dataTiUVInput[index].result_2) <
                          double.parse(dataTiUVInput[index].stdMin)) {
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
                  if (double.parse(dataTiUVInput[index].result_1) >
                          double.parse(dataTiUVInput[index].stdMax) ||
                      double.parse(dataTiUVInput[index].result_1) <
                          double.parse(dataTiUVInput[index].stdMin)) {
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
            dataTiUVsave.clear();
            dataTiUVInput[index].userAnalysis = userName;
            dataTiUVInput[index].userAnalysisBranch = userBranch;
            dataTiUVsave.add(dataTiUVInput[index]);
            context.read<ManageDataTiUV>().add(TiUVEvent.saveTiUVData);
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
    return BlocBuilder<ManageDataTiUV, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataTiUVInput.length;
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
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SUBCODE',
                    'Re print',
                    widthC13,
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
                    'SUBCODE',
                    'Re print',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC12,
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
                              child: Text(dataTiUVInput[index].sampleRemark),
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
                                          dataTiUVInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataTiUVInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataTiUVInput[index]
                                              .stdMax
                                              .toString(),
                                          dataTiUVInput[index]
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
                              width: widthC13,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.print,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    // saveResult(index);

                                    Dio().post(
                                      'http://172.23.10.34:2500/printsubtag_TiUV',
                                      data: {
                                        "reqNo":
                                            dataTiUVInput[index].sampleCode,
                                        "itemName":
                                            dataTiUVInput[index].itemName,
                                        "dilutionTime": dataTiUVInput[index]
                                            .dilutionTime_1
                                            .toString(),
                                        "R": "R1",
                                        "custFull":
                                            dataTiUVInput[index].custFull,
                                        "sampleType":
                                            dataTiUVInput[index].sampleType,
                                        "sampleTank":
                                            dataTiUVInput[index].sampleTank,
                                        "plant": userBranch,
                                      },
                                    ).then((value) {});
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
                                initialValue: dataTiUVInput[index]
                                    .dilutionTime_1
                                    .toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].dilutionTime_1 =
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
                                    dataTiUVInput[index].rawData_1.toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].rawData_1 =
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
                                    dataTiUVInput[index].result_1.toString()),
                                initialValue:
                                    dataTiUVInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].result_1 =
                                      value.toString();
                                  dataTiUVInput[index].resultUnit_1 = "ppm";
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
                                  dataTiUVInput[index].result_1 = value;
                                  dataTiUVInput[index].resultUnit_1 = "";
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
                                initialValue: dataTiUVInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider2),
                          DataCell(
                            Container(
                              width: widthC13,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.print,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    // saveResult(index);

                                    Dio().post(
                                      'http://172.23.10.34:2500/printsubtag_TiUV',
                                      data: {
                                        "reqNo":
                                            dataTiUVInput[index].sampleCode,
                                        "itemName":
                                            dataTiUVInput[index].itemName,
                                        "dilutionTime": dataTiUVInput[index]
                                            .dilutionTime_2
                                            .toString(),
                                        "R": "R2",
                                        "custFull":
                                            dataTiUVInput[index].custFull,
                                        "sampleType":
                                            dataTiUVInput[index].sampleType,
                                        "sampleTank":
                                            dataTiUVInput[index].sampleTank,
                                        "plant": userBranch,
                                      },
                                    ).then((value) {});
                                  },
                                ),
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
                                initialValue: dataTiUVInput[index]
                                    .dilutionTime_2
                                    .toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].dilutionTime_2 =
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
                                    dataTiUVInput[index].rawData_2.toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].rawData_2 =
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
                                    dataTiUVInput[index].result_2.toString()),
                                initialValue:
                                    dataTiUVInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].result_2 =
                                      value.toString();
                                  dataTiUVInput[index].resultUnit_2 = "ppm";
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
                                initialValue: dataTiUVInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataTiUVInput[index].resultRemark_2 =
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
