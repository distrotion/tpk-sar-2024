import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/32_Density_WAX/data/32_Density_WAX_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/32_Density_WAX/data/32_Density_WAX_bloc.dart';

class Instrument_Density_WAX extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_Density_WAX(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataDensity_WAX>(
          create: (BuildContext context) => ManageDataDensity_WAX(),
        ),
      ],
      child: Density_WAX(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class Density_WAX extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Density_WAX({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _Density_WAXState createState() => _Density_WAXState();
}

class _Density_WAXState extends State<Density_WAX> {
  int countData = 0;
  void initState() {
    print("InINITIAL Density_WAX");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataDensity_WAX>()
          .add(Density_WAXEvent.searchDensity_WAXForInput);
    } else {
      context.read<ManageDataDensity_WAX>().add(Density_WAXEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {} on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempDensity_WAXsave.clear();
    dataTempDensity_WAXsave.add(dataDensity_WAXInput[index]);
    context
        .read<ManageDataDensity_WAX>()
        .add(Density_WAXEvent.tempSaveDensity_WAXData);
  }

  void saveResult(int index) {
    if (dataDensity_WAXInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataDensity_WAXInput[index].stdMin.toString()}     STD MAX : ${dataDensity_WAXInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataDensity_WAXInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataDensity_WAXInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataDensity_WAXInput[index].result_1) >
                          double.parse(dataDensity_WAXInput[index].stdMax) ||
                      double.parse(dataDensity_WAXInput[index].result_1) <
                          double.parse(dataDensity_WAXInput[index].stdMin) ||
                      double.parse(dataDensity_WAXInput[index].result_2) >
                          double.parse(dataDensity_WAXInput[index].stdMax) ||
                      double.parse(dataDensity_WAXInput[index].result_2) <
                          double.parse(dataDensity_WAXInput[index].stdMin)) {
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
                  if (double.parse(dataDensity_WAXInput[index].result_1) >
                          double.parse(dataDensity_WAXInput[index].stdMax) ||
                      double.parse(dataDensity_WAXInput[index].result_1) <
                          double.parse(dataDensity_WAXInput[index].stdMin)) {
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
            dataDensity_WAXsave.clear();
            dataDensity_WAXInput[index].userAnalysis = userName;
            dataDensity_WAXInput[index].userAnalysisBranch = userBranch;
            dataDensity_WAXsave.add(dataDensity_WAXInput[index]);
            context
                .read<ManageDataDensity_WAX>()
                .add(Density_WAXEvent.saveDensity_WAXData);
           // Navigator.pop(context);
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
  double widthC9 = 40;
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
    return BlocBuilder<ManageDataDensity_WAX, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataDensity_WAXInput.length;
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
                    'RESULT \n(g/m3)',
                    'RESULT',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC4),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC5,
                  ),DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn(
                    'Temperature\n(°C)',
                    'Temperature (°C)',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(g/m3)(2)',
                    'RESULT',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC9,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(
                                  dataDensity_WAXInput[index].sampleRemark),
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
                                          dataDensity_WAXInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataDensity_WAXInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataDensity_WAXInput[index]
                                              .stdMax
                                              .toString(),
                                          dataDensity_WAXInput[index]
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
                                textInputAction: TextInputAction.done,
                                name: '${index}_3',
                                key: Key(dataDensity_WAXInput[index]
                                    .tempareture_1
                                    .toString()),
                                initialValue: dataDensity_WAXInput[index]
                                    .tempareture_1
                                    .toString(),
                                onChanged: (value) {
                                  dataDensity_WAXInput[index].tempareture_1 =
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
                                
                                name: '${index}_3',
                                key: Key(dataDensity_WAXInput[index]
                                    .result_1
                                    .toString()),
                                initialValue: dataDensity_WAXInput[index]
                                    .result_1
                                    .toString(),
                                onChanged: (value) {
                                  dataDensity_WAXInput[index].result_1 =
                                      value.toString();
                                  dataDensity_WAXInput[index].resultUnit_1 =
                                      "g/m3";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC4,
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
                                  dataDensity_WAXInput[index].result_1 = value;
                                  dataDensity_WAXInput[index].resultUnit_1 = "";
                                  setState(() {});
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
                                initialValue: dataDensity_WAXInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataDensity_WAXInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
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
                              width: widthC9,
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
                              width: widthC3,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.done,
                                name: '${index}_3',
                                key: Key(dataDensity_WAXInput[index]
                                    .tempareture_2
                                    .toString()),
                                initialValue: dataDensity_WAXInput[index]
                                    .tempareture_2
                                    .toString(),
                                onChanged: (value) {
                                  dataDensity_WAXInput[index].tempareture_2 =
                                      value.toString();
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
                                
                                name: '${index}_6',
                                key: Key(dataDensity_WAXInput[index]
                                    .result_2
                                    .toString()),
                                initialValue: dataDensity_WAXInput[index]
                                    .result_2
                                    .toString(),
                                onChanged: (value) {
                                  dataDensity_WAXInput[index].result_2 =
                                      value.toString();
                                  dataDensity_WAXInput[index].resultUnit_2 =
                                      "g/m3";
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
                                initialValue: dataDensity_WAXInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataDensity_WAXInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
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
                              width: widthC9,
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
