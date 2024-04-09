import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/11_PH/data/11_PH_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/11_PH/data/11_PH_bloc.dart';

class Instrument_PH extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_PH({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataPH>(
          create: (BuildContext context) => ManageDataPH(),
        ),
      ],
      child: PH(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class PH extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  PH({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _PHState createState() => _PHState();
}

class _PHState extends State<PH> {
  int countData = 0;
  void initState() {
    print("InINITIAL PH");
    if (widget.headHeight == 0) {
      context.read<ManageDataPH>().add(PHEvent.searchPHForInput);
    } else {
      context.read<ManageDataPH>().add(PHEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataPHInput[index].resultUnit_1 = "";
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataPHInput[index].resultUnit_2 = "";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempPHsave.clear();
    dataTempPHsave.add(dataPHInput[index]);
    context.read<ManageDataPH>().add(PHEvent.tempSavePHData);
  }

  void saveResult(int index) {
    if (dataPHInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataPHInput[index].stdMin.toString()}     STD MAX : ${dataPHInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataPHInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataPHInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataPHInput[index].result_1) >
                          double.parse(dataPHInput[index].stdMax) ||
                      double.parse(dataPHInput[index].result_1) <
                          double.parse(dataPHInput[index].stdMin) ||
                      double.parse(dataPHInput[index].result_2) >
                          double.parse(dataPHInput[index].stdMax) ||
                      double.parse(dataPHInput[index].result_2) <
                          double.parse(dataPHInput[index].stdMin)) {
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
                  if (double.parse(dataPHInput[index].result_1) >
                          double.parse(dataPHInput[index].stdMax) ||
                      double.parse(dataPHInput[index].result_1) <
                          double.parse(dataPHInput[index].stdMin)) {
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
            dataPHsave.clear();
            dataPHInput[index].userAnalysis = userName;
            dataPHInput[index].userAnalysisBranch = userBranch;
            dataPHsave.add(dataPHInput[index]);
            context.read<ManageDataPH>().add(PHEvent.savePHData);
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
    return BlocBuilder<ManageDataPH, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataPHInput.length;
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
                    'Temperature\n(°C)',
                    'Temperature (°C)',
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
                  headerColumn(
                    'Temperature\n(°C)(2)',
                    'Temperature (°C)',
                    widthC7,
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
                              child: Text(dataPHInput[index].sampleRemark),
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
                                          dataPHInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataPHInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataPHInput[index].stdMax.toString(),
                                          dataPHInput[index].stdMin.toString(),
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
                                key: Key(dataPHInput[index]
                                    .tempareture_1
                                    .toString()),
                                initialValue:
                                    dataPHInput[index].tempareture_1.toString(),
                                onChanged: (value) {
                                  dataPHInput[index].tempareture_1 =
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
                                
                                name: '${index}_4',
                                key:
                                    Key(dataPHInput[index].result_1.toString()),
                                initialValue:
                                    dataPHInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataPHInput[index].result_1 =
                                      value.toString();
                                  dataPHInput[index].resultUnit_1 = "";
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
                                  dataPHInput[index].result_1 = value;
                                  dataPHInput[index].resultUnit_1 = "";
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
                                initialValue: dataPHInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataPHInput[index].resultRemark_1 =
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
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_7',
                                key: Key(dataPHInput[index]
                                    .tempareture_2
                                    .toString()),
                                initialValue:
                                    dataPHInput[index].tempareture_2.toString(),
                                onChanged: (value) {
                                  dataPHInput[index].tempareture_2 =
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
                                
                                name: '${index}_8',
                                key:
                                    Key(dataPHInput[index].result_2.toString()),
                                initialValue:
                                    dataPHInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataPHInput[index].result_2 =
                                      value.toString();
                                  dataPHInput[index].resultUnit_2 = "";
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
                                initialValue: dataPHInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataPHInput[index].resultRemark_2 =
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
