import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/27_Brix/data/27_Brix_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/27_Brix/data/27_Brix_bloc.dart';

class Instrument_Brix extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_Brix(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataBrix>(
          create: (BuildContext context) => ManageDataBrix(),
        ),
      ],
      child: Brix(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class Brix extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Brix({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _BrixState createState() => _BrixState();
}

class _BrixState extends State<Brix> {
  int countData = 0;
  void initState() {
    print("InINITIAL Brix");
    if (widget.headHeight == 0) {
      context.read<ManageDataBrix>().add(BrixEvent.searchBrixForInput);
    } else {
      context.read<ManageDataBrix>().add(BrixEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      /* dataBrixInput[index].w1W2_1 = (double.parse(dataBrixInput[index].w1_1) -
              double.parse(dataBrixInput[index].w2_1))
          .toStringAsFixed(4);
      dataBrixInput[index].result_1 =
          ((double.parse(dataBrixInput[index].w1W2_1) /
                      double.parse(dataBrixInput[index].size_1)) *
                  10000)
              .toStringAsFixed(2);
      dataBrixInput[index].resultUnit_1 = "g/m2";
      setState(() {}); */
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      /* dataBrixInput[index].w1W2_2 = (double.parse(dataBrixInput[index].w1_2) -
              double.parse(dataBrixInput[index].w2_2))
          .toStringAsFixed(4);
      dataBrixInput[index].result_2 =
          ((double.parse(dataBrixInput[index].w1W2_2) /
                      double.parse(dataBrixInput[index].size_2)) *
                  10000)
              .toStringAsFixed(2); */
      dataBrixInput[index].resultUnit_2 = "%";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempBrixsave.clear();
    dataTempBrixsave.add(dataBrixInput[index]);
    context.read<ManageDataBrix>().add(BrixEvent.tempSaveBrixData);
  }

  void saveResult(int index) {
    if (dataBrixInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataBrixInput[index].stdMin.toString()}     STD MAX : ${dataBrixInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataBrixInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataBrixInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataBrixInput[index].result_1) >
                          double.parse(dataBrixInput[index].stdMax) ||
                      double.parse(dataBrixInput[index].result_1) <
                          double.parse(dataBrixInput[index].stdMin) ||
                      double.parse(dataBrixInput[index].result_2) >
                          double.parse(dataBrixInput[index].stdMax) ||
                      double.parse(dataBrixInput[index].result_2) <
                          double.parse(dataBrixInput[index].stdMin)) {
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
                  dataBrixInput[index].resultUnit_1 = "%";
                  if (double.parse(dataBrixInput[index].result_1) >
                          double.parse(dataBrixInput[index].stdMax) ||
                      double.parse(dataBrixInput[index].result_1) <
                          double.parse(dataBrixInput[index].stdMin)) {
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
            dataBrixsave.clear();
            dataBrixInput[index].userAnalysis = userName;
            dataBrixInput[index].userAnalysisBranch = userBranch;
            dataBrixsave.add(dataBrixInput[index]);
            context.read<ManageDataBrix>().add(BrixEvent.saveBrixData);
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
  double widthC15 = 50;
  double widthC16 = 50;
  double widthC17 = 50;
  double widthC18 = 50;
  double widthC19 = 40;
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
    return BlocBuilder<ManageDataBrix, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataBrixInput.length;
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
                    'RESULT\n(%)',
                    'RESULT (%)',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC9),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC4,
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
                  DataColumn(label: _verticalDivider2),
                  headerColumn(
                    'RESULT\n(%)(2)',
                    'RESULT (%)',
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
                              child: Text(dataBrixInput[index].sampleRemark),
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
                                          dataBrixInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataBrixInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataBrixInput[index]
                                              .stdMax
                                              .toString(),
                                          dataBrixInput[index]
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
                                
                                name: '${index}_3',
                                key: Key(
                                    dataBrixInput[index].result_1.toString()),
                                initialValue:
                                    dataBrixInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataBrixInput[index].result_1 =
                                      value.toString();
                                  dataBrixInput[index].resultUnit_1 = "%";
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
                                  dataBrixInput[index].result_1 = value;
                                  dataBrixInput[index].resultUnit_1 = "";
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
                                initialValue: dataBrixInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataBrixInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ), DataCell(_verticalDivider),
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
                              width: widthC6,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_6',
                                key: Key(
                                    dataBrixInput[index].result_2.toString()),
                                initialValue:
                                    dataBrixInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataBrixInput[index].result_2 =
                                      value.toString();
                                  dataBrixInput[index].resultUnit_2 = "%";
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
                                initialValue: dataBrixInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataBrixInput[index].resultRemark_2 =
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
