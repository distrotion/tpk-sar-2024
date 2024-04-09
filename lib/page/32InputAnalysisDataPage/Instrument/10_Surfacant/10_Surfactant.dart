import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/10_Surfacant/data/10_Surfactant_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/10_Surfacant/data/10_Surfactant_event.dart';

class Instrument_Surfactant extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_Surfactant(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataSurfactant>(
          create: (BuildContext context) => ManageDataSurfactant(),
        ),
      ],
      child: Surfactant(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class Surfactant extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Surfactant({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _SurfactantState createState() => _SurfactantState();
}

class _SurfactantState extends State<Surfactant> {
  int countData = 0;
  void initState() {
    print("InINITIAL Surfactant");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataSurfactant>()
          .add(SurfactantEvent.searchSurfactantForInput);
    } else {
      context.read<ManageDataSurfactant>().add(SurfactantEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataSurfactantInput[index].result_1 =
          (double.parse(dataSurfactantInput[index].finalPoint_1) -
                  double.parse(dataSurfactantInput[index].startPoint_1))
              .toStringAsFixed(2);
      dataSurfactantInput[index].resultUnit_1 = "mL";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataSurfactantInput[index].result_2 =
          (double.parse(dataSurfactantInput[index].finalPoint_2) -
                  double.parse(dataSurfactantInput[index].startPoint_2))
              .toStringAsFixed(2);
      dataSurfactantInput[index].resultUnit_2 = "mL";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempSurfactantsave.clear();
    dataTempSurfactantsave.add(dataSurfactantInput[index]);
    context
        .read<ManageDataSurfactant>()
        .add(SurfactantEvent.tempSaveSurfactantData);
  }

  void saveResult(int index) {
    if (dataSurfactantInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataSurfactantInput[index].stdMin.toString()}     STD MAX : ${dataSurfactantInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataSurfactantInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataSurfactantInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataSurfactantInput[index].result_1) >
                          double.parse(dataSurfactantInput[index].stdMax) ||
                      double.parse(dataSurfactantInput[index].result_1) <
                          double.parse(dataSurfactantInput[index].stdMin) ||
                      double.parse(dataSurfactantInput[index].result_2) >
                          double.parse(dataSurfactantInput[index].stdMax) ||
                      double.parse(dataSurfactantInput[index].result_2) <
                          double.parse(dataSurfactantInput[index].stdMin)) {
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
                  if (double.parse(dataSurfactantInput[index].result_1) >
                          double.parse(dataSurfactantInput[index].stdMax) ||
                      double.parse(dataSurfactantInput[index].result_1) <
                          double.parse(dataSurfactantInput[index].stdMin)) {
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
            dataSurfactantsave.clear();
            dataSurfactantInput[index].userAnalysis = userName;
            dataSurfactantInput[index].userAnalysisBranch = userBranch;
            dataSurfactantsave.add(dataSurfactantInput[index]);
            context
                .read<ManageDataSurfactant>()
                .add(SurfactantEvent.saveSurfactantData);
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
  double widthC15 = 50;
  double widthC16 = 50;
  double widthC17 = 40;
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
    return BlocBuilder<ManageDataSurfactant, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataSurfactantInput.length;
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
                  headerColumn('NO', 'NO', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'START PT\n(mL)',
                    'START POINT (mL)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'FINAL PT\n(mL)',
                    'FINAL POINT (mL)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(mL)',
                    'RESULT = Final - Start',
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
                  headerColumn('NO(2)', 'NO', widthC9),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'START PT\n(mL)(2)',
                    'START POINT (mL)',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'FINAL PT\n(mL)(2)',
                    'FINAL POINT (mL)',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(mL)(2)',
                    'RESULT = Final - Start',
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
                                  Text(dataSurfactantInput[index].sampleRemark),
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
                                          dataSurfactantInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataSurfactantInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataSurfactantInput[index]
                                              .stdMax
                                              .toString(),
                                          dataSurfactantInput[index]
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
                                    dataSurfactantInput[index].no_1.toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].no_1 =
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
                                initialValue: dataSurfactantInput[index]
                                    .startPoint_1
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].startPoint_1 =
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
                                initialValue: dataSurfactantInput[index]
                                    .finalPoint_1
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].finalPoint_1 =
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
                                key: Key(dataSurfactantInput[index]
                                    .result_1
                                    .toString()),
                                initialValue: dataSurfactantInput[index]
                                    .result_1
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].result_1 =
                                      value.toString();
                                  dataSurfactantInput[index].resultUnit_1 =
                                      "mL";
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
                                  dataSurfactantInput[index].result_1 = value;

                                  dataSurfactantInput[index].resultUnit_1 = "";
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
                                initialValue: dataSurfactantInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].resultRemark_1 =
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
                                    dataSurfactantInput[index].no_2.toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].no_2 =
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
                                initialValue: dataSurfactantInput[index]
                                    .startPoint_2
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].startPoint_2 =
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
                                initialValue: dataSurfactantInput[index]
                                    .finalPoint_2
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].finalPoint_2 =
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
                                //enabled: false,
                                name: '${index}_12',
                                key: Key(dataSurfactantInput[index]
                                    .result_2
                                    .toString()),
                                initialValue: dataSurfactantInput[index]
                                    .result_2
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].result_2 =
                                      value.toString();
                                  dataSurfactantInput[index].resultUnit_2 =
                                      "mL";
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
                                initialValue: dataSurfactantInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataSurfactantInput[index].resultRemark_2 =
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
