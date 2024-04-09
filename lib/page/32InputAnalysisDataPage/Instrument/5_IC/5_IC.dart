import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/5_IC/data/5_IC_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/5_IC/data/5_IC_event.dart';


class Instrument_IC extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_IC({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataIC>(
          create: (BuildContext context) => ManageDataIC(),
        ),
      ],
      child: IC(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class IC extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  IC({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _ICState createState() => _ICState();
}

class _ICState extends State<IC> {
  int lowerCurve = 1;
  int countData = 0;

  void initState() {
    print("InINITIAL IC");
    if (widget.headHeight == 0) {
      context.read<ManageDataIC>().add(ICEvent.searchICForInput);
    } else {
      context.read<ManageDataIC>().add(ICEvent.dummyHead);
    }
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void calculate(int index) {
    try {
      var buffCurve =
          lowerCurve * double.parse(dataICInput[index].dilutionTime_1);
      if (double.parse(dataICInput[index].dilutionTime_1) >= 0) {
        if (double.parse(dataICInput[index].rawData_1) >= 0) {
          dataICInput[index].result_1 =
              (double.parse(dataICInput[index].dilutionTime_1) *
                      double.parse(dataICInput[index].rawData_1))
                  .toStringAsFixed(2);
          dataICInput[index].resultUnit_1 = "ppm";
          /* if (double.parse(dataICInput[index].rawData_1) < buffCurve) {
            dataICInput[index].result_1 = "< 1";
          } */
          if (double.parse(dataICInput[index].result_1) < buffCurve) {
            dataICInput[index].result_1 = "< " + buffCurve.toString();
          }

          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      var buffCurve =
          lowerCurve * double.parse(dataICInput[index].dilutionTime_2);

      if (double.parse(dataICInput[index].dilutionTime_2) >= 0) {
        if (double.parse(dataICInput[index].rawData_2) >= 0) {
          dataICInput[index].result_2 =
              (double.parse(dataICInput[index].dilutionTime_2) *
                      double.parse(dataICInput[index].rawData_2))
                  .toStringAsFixed(2);
          dataICInput[index].resultUnit_2 = "ppm";
          /* if (double.parse(dataICInput[index].rawData_2) < buffCurve) {
            dataICInput[index].result_2 = "< 1";
          } */
          if (double.parse(dataICInput[index].result_2) < buffCurve) {
            dataICInput[index].result_2 = "< " + buffCurve.toString();
          }
          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempICsave.clear();
    dataTempICsave.add(dataICInput[index]);
    context.read<ManageDataIC>().add(ICEvent.tempSaveICData);
  }

  void saveResult(int index) {
    if (dataICInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataICInput[index].stdMin.toString()}     STD MAX : ${dataICInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataICInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataICInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataICInput[index].result_1) >
                          double.parse(dataICInput[index].stdMax) ||
                      double.parse(dataICInput[index].result_1) <
                          double.parse(dataICInput[index].stdMin) ||
                      double.parse(dataICInput[index].result_2) >
                          double.parse(dataICInput[index].stdMax) ||
                      double.parse(dataICInput[index].result_2) <
                          double.parse(dataICInput[index].stdMin)) {
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
                  if (double.parse(dataICInput[index].result_1) >
                          double.parse(dataICInput[index].stdMax) ||
                      double.parse(dataICInput[index].result_1) <
                          double.parse(dataICInput[index].stdMin)) {
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
            dataICsave.clear();
            dataICInput[index].userAnalysis = userName;
            dataICInput[index].userAnalysisBranch = userBranch;
            dataICsave.add(dataICInput[index]);
            context.read<ManageDataIC>().add(ICEvent.saveICData);
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
    return BlocBuilder<ManageDataIC, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataICInput.length;
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
                    'RAW DATA \n (ppm)',
                    'RAW DATA',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT \n (ppm)',
                    'Dilution x Raw data',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'ERROR',
                    'ERROR RESULT',
                    widthC6,
                  ),
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
                      'DILUTION \n TIMES', 'DILUTION TIMES(2)', widthC8),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA \n (ppm)(2)',
                    'RAW DATA',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT \n (ppm)(2)',
                    'Dilution x Raw data',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK(2)',
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
                              child: Text(dataICInput[index].sampleRemark),
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
                                          dataICInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataICInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataICInput[index].stdMax.toString(),
                                          dataICInput[index].stdMin.toString(),
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
                                name: '${index}_1',
                                initialValue: dataICInput[index]
                                    .dilutionTime_1
                                    .toString(),
                                onChanged: (value) {
                                  dataICInput[index].dilutionTime_1 =
                                      value.toString();
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC4,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_2',
                                initialValue:
                                    dataICInput[index].rawData_1.toString(),
                                onChanged: (value) {
                                  dataICInput[index].rawData_1 =
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
                              //height: fieldHeight,
                              child: /* TextField(
                                controller: TextEditingController(
                                    text: dataICInput[index].result_1),
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) {
                                  dataICInput[index].result_1 =
                                      value.toString();
                                  dataICInput[index].resultUnit_1 = "ppm";
                                },
                              ),
                            ),
                          ), */
                                  FormBuilderTextField(
                                //textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_3',
                                //enabled: false,
                                key:
                                    Key(dataICInput[index].result_1.toString()),
                                initialValue:
                                    dataICInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataICInput[index].result_1 =
                                      value.toString();
                                  dataICInput[index].resultUnit_1 = "ppm";
                                },
                              ),
                            ),
                          ),
                          //Text(dataICInput[index].result_1),

                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC6,
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
                                name: '${index}_4',
                                onChanged: (value) {
                                  dataICInput[index].result_1 = value;
                                  dataICInput[index].resultUnit_1 = "";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue: dataICInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataICInput[index].resultRemark_1 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue: dataICInput[index]
                                    .dilutionTime_2
                                    .toString(),
                                onChanged: (value) {
                                  dataICInput[index].dilutionTime_2 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue:
                                    dataICInput[index].rawData_2.toString(),
                                onChanged: (value) {
                                  dataICInput[index].rawData_2 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                //textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_8',
                                //enabled: false,
                                key:
                                    Key(dataICInput[index].result_2.toString()),
                                initialValue:
                                    dataICInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataICInput[index].result_2 =
                                      value.toString();
                                  dataICInput[index].resultUnit_2 = "ppm";
                                },
                              ),
                              //Text(dataICInput[index].result_1),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC11,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue: dataICInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataICInput[index].resultRemark_2 =
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
