import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/33_ClAUTO/data/33_ClAUTO_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/33_ClAUTO/data/33_ClAUTO_bloc.dart';

class Instrument_ClAUTO extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_ClAUTO(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataClAUTO>(
          create: (BuildContext context) => ManageDataClAUTO(),
        ),
      ],
      child: ClAUTO(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class ClAUTO extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  ClAUTO({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _ClAUTOState createState() => _ClAUTOState();
}

class _ClAUTOState extends State<ClAUTO> {
  int countData = 0;
  void initState() {
    print("InINITIAL ClAUTO");
    if (widget.headHeight == 0) {
      context.read<ManageDataClAUTO>().add(ClAUTOEvent.searchClAUTOForInput);
    } else {
      context.read<ManageDataClAUTO>().add(ClAUTOEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataClAUTOInput[index].resultUnit_1 = "ppm";
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataClAUTOInput[index].resultUnit_2 = "";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempClAUTOsave.clear();
    dataTempClAUTOsave.add(dataClAUTOInput[index]);
    context.read<ManageDataClAUTO>().add(ClAUTOEvent.tempSaveClAUTOData);
  }

  void saveResult(int index) {
    if (dataClAUTOInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataClAUTOInput[index].stdMin.toString()}     STD MAX : ${dataClAUTOInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataClAUTOInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataClAUTOInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataClAUTOInput[index].result_1) >
                          double.parse(dataClAUTOInput[index].stdMax) ||
                      double.parse(dataClAUTOInput[index].result_1) <
                          double.parse(dataClAUTOInput[index].stdMin) ||
                      double.parse(dataClAUTOInput[index].result_2) >
                          double.parse(dataClAUTOInput[index].stdMax) ||
                      double.parse(dataClAUTOInput[index].result_2) <
                          double.parse(dataClAUTOInput[index].stdMin)) {
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
                  if (double.parse(dataClAUTOInput[index].result_1) >
                          double.parse(dataClAUTOInput[index].stdMax) ||
                      double.parse(dataClAUTOInput[index].result_1) <
                          double.parse(dataClAUTOInput[index].stdMin)) {
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
            dataClAUTOsave.clear();
            dataClAUTOInput[index].userAnalysis = userName;
            dataClAUTOInput[index].userAnalysisBranch = userBranch;
            dataClAUTOsave.add(dataClAUTOInput[index]);
            context.read<ManageDataClAUTO>().add(ClAUTOEvent.saveClAUTOData);
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
    return BlocBuilder<ManageDataClAUTO, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataClAUTOInput.length;
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
                    'SAMPLE SIZE\n(mL)',
                    'SAMPLE SIZE\n(mL)',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA\n(mL)',
                    'RAW DATA\n(mL)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT(ppm)',
                    'RESULT(ppm)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC6),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC7,
                  ), DataColumn(label: _verticalDivider),
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
                    'SAMPLE SIZE\n(mL)(2)',
                    'SAMPLE SIZE (mL)',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA\n(mL)(2)',
                    'RAW DATA (mL)',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(ppm)(2)',
                    'RESULT (ppm)',
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
                              child: Text(dataClAUTOInput[index].sampleRemark),
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
                                          dataClAUTOInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataClAUTOInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataClAUTOInput[index]
                                              .stdMax
                                              .toString(),
                                          dataClAUTOInput[index]
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
                                key: Key(
                                    dataClAUTOInput[index].size_1.toString()),
                                initialValue:
                                    dataClAUTOInput[index].size_1.toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].size_1 =
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
                                name: '${index}_3',
                                key: Key(dataClAUTOInput[index]
                                    .rawData_1
                                    .toString()),
                                initialValue:
                                    dataClAUTOInput[index].rawData_1.toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].rawData_1 =
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
                                key: Key(
                                    dataClAUTOInput[index].result_1.toString()),
                                initialValue:
                                    dataClAUTOInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].result_1 =
                                      value.toString();
                                  dataClAUTOInput[index].resultUnit_1 = "ppm";
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
                                  dataClAUTOInput[index].result_1 = value;
                                  dataClAUTOInput[index].resultUnit_1 = "";
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
                                initialValue: dataClAUTOInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].resultRemark_1 =
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
                                key: Key(
                                    dataClAUTOInput[index].size_2.toString()),
                                initialValue:
                                    dataClAUTOInput[index].size_2.toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].size_2 =
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
                                name: '${index}_7',
                                key: Key(dataClAUTOInput[index]
                                    .rawData_2
                                    .toString()),
                                initialValue:
                                    dataClAUTOInput[index].rawData_2.toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].rawData_2 =
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
                                key: Key(
                                    dataClAUTOInput[index].result_2.toString()),
                                initialValue:
                                    dataClAUTOInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].result_2 =
                                      value.toString();
                                  dataClAUTOInput[index].resultUnit_2 = "ppm";
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
                                initialValue: dataClAUTOInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataClAUTOInput[index].resultRemark_2 =
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
