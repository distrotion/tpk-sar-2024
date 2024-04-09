import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'data/1_PO43Titrate_bloc.dart';
import 'data/1_PO43Titrate_event.dart';

class Instrument_PO43Titrate extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_PO43Titrate(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataPO43Titrate>(
          create: (BuildContext context) => ManageDataPO43Titrate(),
        ),
      ],
      child: PO43Titrate(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class PO43Titrate extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  PO43Titrate({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _PO43TitrateState createState() => _PO43TitrateState();
}

class _PO43TitrateState extends State<PO43Titrate> {
  int countData = 0;
  void initState() {
    print("InINITIAL PO43");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataPO43Titrate>()
          .add(PO43TitrateEvent.searchPO43ForInput);
    } else {
      context.read<ManageDataPO43Titrate>().add(PO43TitrateEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      if (double.parse(dataPO43Input[index].titrantFactor_1) > 0) {
        if (double.parse(dataPO43Input[index].endPt2_1) > 0) {
          dataPO43Input[index].result_1 = (0.95 *
                  double.parse(dataPO43Input[index].endPt2_1) *
                  double.parse(dataPO43Input[index].titrantFactor_1))
              .toStringAsFixed(2);
          dataPO43Input[index].resultUnit_1 = "g/L.";
          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      if (double.parse(dataPO43Input[index].titrantFactor_2) > 0) {
        if (double.parse(dataPO43Input[index].endPt2_2) > 0) {
          dataPO43Input[index].result_2 = (0.95 *
                  double.parse(dataPO43Input[index].endPt2_2) *
                  double.parse(dataPO43Input[index].titrantFactor_2))
              .toStringAsFixed(2);
          dataPO43Input[index].resultUnit_2 = "g/L.";
          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempPO43save.clear();
    dataTempPO43save.add(dataPO43Input[index]);
    context
        .read<ManageDataPO43Titrate>()
        .add(PO43TitrateEvent.tempSavePO43Data);
  }

  void saveResult(int index) {
    if (dataPO43Input[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 400,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(
            children: [
              Text(
                  'STD MIN : ${dataPO43Input[index].stdMin.toString()}     STD MAX : ${dataPO43Input[index].stdMax.toString()}'),
              Text('RESULT : ${dataPO43Input[index].result_1.toString()}'),
              SizedBox(
                height: 10,
              ),
              ((() {
                if (dataPO43Input[index].result_2.toString() != "") {
                  try {
                    if (double.parse(dataPO43Input[index].result_1) >
                            double.parse(dataPO43Input[index].stdMax) ||
                        double.parse(dataPO43Input[index].result_1) <
                            double.parse(dataPO43Input[index].stdMin) ||
                        double.parse(dataPO43Input[index].result_2) >
                            double.parse(dataPO43Input[index].stdMax) ||
                        double.parse(dataPO43Input[index].result_2) <
                            double.parse(dataPO43Input[index].stdMin)) {
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
                    if (double.parse(dataPO43Input[index].result_1) >
                            double.parse(dataPO43Input[index].stdMax) ||
                        double.parse(dataPO43Input[index].result_1) <
                            double.parse(dataPO43Input[index].stdMin)) {
                      return Text('RESULT OUT OF RANGE',
                          style: TextStyle(color: Colors.red));
                    } else
                      return Text('CONFIRM SAVE RESULT');
                  } on Exception catch (e) {
                    return Text('CONFIRM SAVE RESULT');
                  }
                }
              }())),
            ],
          ),
          /* 
          ((() {  
            if (dataPO43Input[index].result_2.toString() != "") {
              try {
                if (double.parse(dataPO43Input[index].result_1) >
                        double.parse(dataPO43Input[index].stdMax) ||
                    double.parse(dataPO43Input[index].result_1) <
                        double.parse(dataPO43Input[index].stdMin) ||
                    double.parse(dataPO43Input[index].result_2) >
                        double.parse(dataPO43Input[index].stdMax) ||
                    double.parse(dataPO43Input[index].result_2) <
                        double.parse(dataPO43Input[index].stdMin)) {
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
                if (double.parse(dataPO43Input[index].result_1) >
                        double.parse(dataPO43Input[index].stdMax) ||
                    double.parse(dataPO43Input[index].result_1) <
                        double.parse(dataPO43Input[index].stdMin)) {
                  return Text('RESULT OUT OF RANGE',
                      style: TextStyle(color: Colors.red));
                } else
                  return Text('CONFIRM SAVE RESULT');
              } on Exception catch (e) {
                return Text('CONFIRM SAVE RESULT');
              }
            }
          }())), */
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: () {
            dataPO43save.clear();
            dataPO43Input[index].userAnalysis = userName;
            dataPO43Input[index].userAnalysisBranch = userBranch;
            dataPO43save.add(dataPO43Input[index]);
            context
                .read<ManageDataPO43Titrate>()
                .add(PO43TitrateEvent.savePO43Data);
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
    return BlocBuilder<ManageDataPO43Titrate, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataPO43Input.length;
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
                      'TRITRANT \n FACTOR', 'TRITRANT FACTOR', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'END Pt 1',
                    'END AT POINT 1',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'END Pt 2',
                    'END AT POINT 2',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(g/L.)',
                    '0.95 x End pt 2 (mL) x Titration Factor',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'ERROR',
                    'ERROR RESULT',
                    widthC7,
                  ),
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
                  headerColumn(
                    'TRITRANT \nFACTOR(2)',
                    'TRITRANT FACTOR',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'END pt 1 \n(2)',
                    'END AT POINT 1',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'END pt 2 \n(2)',
                    'END AT POINT 2',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT \n(g/L.)(2)',
                    '0.95 x End pt 2 (mL) x Titration Factor',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK \n(2)',
                    'RESULT REMARK',
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
                              child: Text(dataPO43Input[index].sampleRemark),
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
                                          dataPO43Input[index]
                                              .requestSampleId
                                              .toString(),
                                          dataPO43Input[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataPO43Input[index]
                                              .stdMax
                                              .toString(),
                                          dataPO43Input[index]
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue: dataPO43Input[index]
                                    .titrantFactor_1
                                    .toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].titrantFactor_1 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_2',
                                initialValue:
                                    dataPO43Input[index].endPt1_1.toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].endPt1_1 =
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
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue:
                                    dataPO43Input[index].endPt2_1.toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].endPt2_1 =
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
                              width: widthC6,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_4',
                                //enabled: false,
                                key: Key(
                                    dataPO43Input[index].result_1.toString()),
                                initialValue:
                                    dataPO43Input[index].result_1.toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].result_1 =
                                      value.toString();
                                  dataPO43Input[index].resultUnit_1 = "g/L.";
                                },
                              ),
                              //Text(dataPO43Input[index].result_1),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC7,
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
                                name: '${index}_5',
                                onChanged: (value) {
                                  dataPO43Input[index].result_1 = value;
                                  dataPO43Input[index].resultUnit_1 = "";
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
                                textInputAction: TextInputAction.next,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue: dataPO43Input[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].resultRemark_1 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue: dataPO43Input[index]
                                    .titrantFactor_2
                                    .toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].titrantFactor_2 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_8',
                                initialValue:
                                    dataPO43Input[index].endPt1_2.toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].endPt1_2 =
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
                              width: widthC11,
                              // height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue:
                                    dataPO43Input[index].endPt2_2.toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].endPt2_2 =
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
                              width: widthC12,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                key: Key(
                                    dataPO43Input[index].result_2.toString()),
                                //enabled: false,
                                initialValue:
                                    dataPO43Input[index].result_2.toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].result_2 =
                                      value.toString();
                                  dataPO43Input[index].resultUnit_2 = "g/L.";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC13,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue: dataPO43Input[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataPO43Input[index].resultRemark_2 =
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
