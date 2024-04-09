import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/18_Moisture_NoxRust/data/18_Moisture_NoxRust_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/18_Moisture_NoxRust/data/18_Moisture_NoxRust_bloc.dart';

class Instrument_Moisture_NoxRust extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_Moisture_NoxRust(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataMoisture_NoxRust>(
          create: (BuildContext context) => ManageDataMoisture_NoxRust(),
        ),
      ],
      child: Moisture_NoxRust(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class Moisture_NoxRust extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Moisture_NoxRust(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _Moisture_NoxRustState createState() => _Moisture_NoxRustState();
}

class _Moisture_NoxRustState extends State<Moisture_NoxRust> {
  int countData = 0;
  void initState() {
    print("InINITIAL Moisture_NoxRust");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataMoisture_NoxRust>()
          .add(Moisture_NoxRustEvent.searchMoisture_NoxRustForInput);
    } else {
      context
          .read<ManageDataMoisture_NoxRust>()
          .add(Moisture_NoxRustEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataMoisture_NoxRustInput[index].resultUnit_1 = "%";
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataMoisture_NoxRustInput[index].resultUnit_2 = "%";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempMoisture_NoxRustsave.clear();
    dataTempMoisture_NoxRustsave.add(dataMoisture_NoxRustInput[index]);
    context
        .read<ManageDataMoisture_NoxRust>()
        .add(Moisture_NoxRustEvent.tempSaveMoisture_NoxRustData);
  }

  void saveResult(int index) {
    if (dataMoisture_NoxRustInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataMoisture_NoxRustInput[index].stdMin.toString()}     STD MAX : ${dataMoisture_NoxRustInput[index].stdMax.toString()}'),
            Text(
                'RESULT : ${dataMoisture_NoxRustInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataMoisture_NoxRustInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataMoisture_NoxRustInput[index].result_1) >
                          double.parse(
                              dataMoisture_NoxRustInput[index].stdMax) ||
                      double.parse(dataMoisture_NoxRustInput[index].result_1) <
                          double.parse(
                              dataMoisture_NoxRustInput[index].stdMin) ||
                      double.parse(dataMoisture_NoxRustInput[index].result_2) >
                          double.parse(
                              dataMoisture_NoxRustInput[index].stdMax) ||
                      double.parse(dataMoisture_NoxRustInput[index].result_2) <
                          double.parse(
                              dataMoisture_NoxRustInput[index].stdMin)) {
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
                  if (double.parse(dataMoisture_NoxRustInput[index].result_1) >
                          double.parse(
                              dataMoisture_NoxRustInput[index].stdMax) ||
                      double.parse(dataMoisture_NoxRustInput[index].result_1) <
                          double.parse(
                              dataMoisture_NoxRustInput[index].stdMin)) {
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
            dataMoisture_NoxRustsave.clear();
            dataMoisture_NoxRustInput[index].userAnalysis = userName;
            dataMoisture_NoxRustInput[index].userAnalysisBranch = userBranch;
            dataMoisture_NoxRustsave.add(dataMoisture_NoxRustInput[index]);
            context
                .read<ManageDataMoisture_NoxRust>()
                .add(Moisture_NoxRustEvent.saveMoisture_NoxRustData);
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
    return BlocBuilder<ManageDataMoisture_NoxRust, int>(
        builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataMoisture_NoxRustInput.length;
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
                  /* headerColumn(
                    'Temperature\n(°C)',
                    'Temperature (°C)',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'RESULT (%)',
                    'RESULT (%)',
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
                  /* headerColumn(
                    'Temperature\n(°C)(2)',
                    'Temperature (°C)',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'RESULT (%)\n(2)',
                    'RESULT (%)',
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
                              child: Text(dataMoisture_NoxRustInput[index]
                                  .sampleRemark),
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
                                          dataMoisture_NoxRustInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataMoisture_NoxRustInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataMoisture_NoxRustInput[index]
                                              .stdMax
                                              .toString(),
                                          dataMoisture_NoxRustInput[index]
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
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_3',
                                key: Key(dataMoisture_NoxRustInput[index]
                                    .tempareture_1
                                    .toString()),
                                initialValue:
                                    dataMoisture_NoxRustInput[index].tempareture_1.toString(),
                                onChanged: (value) {
                                  dataMoisture_NoxRustInput[index].tempareture_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC4,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_4',
                                key: Key(dataMoisture_NoxRustInput[index]
                                    .result_1
                                    .toString()),
                                initialValue: dataMoisture_NoxRustInput[index]
                                    .result_1
                                    .toString(),
                                onChanged: (value) {
                                  dataMoisture_NoxRustInput[index].result_1 =
                                      value.toString();
                                  dataMoisture_NoxRustInput[index]
                                      .resultUnit_1 = "%";
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
                                  dataMoisture_NoxRustInput[index].result_1 =
                                      value;
                                  dataMoisture_NoxRustInput[index]
                                      .resultUnit_1 = "";
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
                                initialValue: dataMoisture_NoxRustInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataMoisture_NoxRustInput[index]
                                      .resultRemark_1 = value.toString();
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
                          /* DataCell(
                            Container(
                              width: widthC7,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_7',
                                key: Key(dataMoisture_NoxRustInput[index]
                                    .tempareture_2
                                    .toString()),
                                initialValue:
                                    dataMoisture_NoxRustInput[index].tempareture_2.toString(),
                                onChanged: (value) {
                                  dataMoisture_NoxRustInput[index].tempareture_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC8,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_8',
                                key: Key(dataMoisture_NoxRustInput[index]
                                    .result_2
                                    .toString()),
                                initialValue: dataMoisture_NoxRustInput[index]
                                    .result_2
                                    .toString(),
                                onChanged: (value) {
                                  dataMoisture_NoxRustInput[index].result_2 =
                                      value.toString();
                                  dataMoisture_NoxRustInput[index]
                                      .resultUnit_2 = "%";
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
                                initialValue: dataMoisture_NoxRustInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataMoisture_NoxRustInput[index]
                                      .resultRemark_2 = value.toString();
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
