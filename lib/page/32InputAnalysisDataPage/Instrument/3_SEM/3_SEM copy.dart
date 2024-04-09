/* import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/3_SEM/data/3_SEM_bloc.dart';


class Instrument_SEM extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_SEM(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataSEM>(
          create: (BuildContext context) => ManageDataSEM(),
        ),
      ],
      child: SEM(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class SEM extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  SEM({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _SEMState createState() => _SEMState();
}

class _SEMState extends State<SEM> {
  int countData = 0;
  void initState() {
    print("InINITIAL SEM");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataSEM>()
          .add(SEMEvent.searchSEMForInput);
    } else {
      context.read<ManageDataSEM>().add(SEMEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      if (double.parse(dataSEMInput[index].titrantFactor_1) > 0) {
        if (double.parse(dataSEMInput[index].endPt2_1) > 0) {
          dataSEMInput[index].result_1 = (0.95 *
                  double.parse(dataSEMInput[index].endPt2_1) *
                  double.parse(dataSEMInput[index].titrantFactor_1))
              .toStringAsFixed(2);
          dataSEMInput[index].resultUnit_1 = "g/L.";
          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      if (double.parse(dataSEMInput[index].titrantFactor_2) > 0) {
        if (double.parse(dataSEMInput[index].endPt2_2) > 0) {
          dataSEMInput[index].result_2 = (0.95 *
                  double.parse(dataSEMInput[index].endPt2_2) *
                  double.parse(dataSEMInput[index].titrantFactor_2))
              .toStringAsFixed(2);
          dataSEMInput[index].resultUnit_2 = "g/L.";
          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempSEMsave.clear();
    dataTempSEMsave.add(dataSEMInput[index]);
    context
        .read<ManageDataSEM>()
        .add(SEMEvent.tempSaveSEMData);
  }

  void saveResult(int index) {
    if (dataSEMInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: ((() {
            if (dataSEMInput[index].result_2.toString() != "") {
              try {
                if (double.parse(dataSEMInput[index].result_1) >
                        double.parse(dataSEMInput[index].stdMax) ||
                    double.parse(dataSEMInput[index].result_1) <
                        double.parse(dataSEMInput[index].stdMin) ||
                    double.parse(dataSEMInput[index].result_2) >
                        double.parse(dataSEMInput[index].stdMax) ||
                    double.parse(dataSEMInput[index].result_2) <
                        double.parse(dataSEMInput[index].stdMin)) {
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
                if (double.parse(dataSEMInput[index].result_1) >
                        double.parse(dataSEMInput[index].stdMax) ||
                    double.parse(dataSEMInput[index].result_1) <
                        double.parse(dataSEMInput[index].stdMin)) {
                  return Text('RESULT OUT OF RANGE',
                      style: TextStyle(color: Colors.red));
                } else
                  return Text('CONFIRM SAVE RESULT');
              } on Exception catch (e) {
                return Text('CONFIRM SAVE RESULT');
              }
            }
          }())),
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: () {
            dataSEMsave.clear();
            dataSEMsave.add(dataSEMInput[index]);
            context
                .read<ManageDataSEM>()
                .add(SEMEvent.saveSEMData);
            Navigator.pop(context);
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
    return BlocBuilder<ManageDataSEM, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataSEMInput.length;
        } else {
          countData = 0;
        }
        return FormBuilder(
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
                  DataColumn(label: _verticalDivider2),
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
                              child: Text(dataSEMInput[index].sampleRemark),
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
                                          dataSEMInput[index]
                                              .custFull
                                              .toString(),
                                          dataSEMInput[index]
                                              .itemName
                                              .toString(),
                                          dataSEMInput[index]
                                              .stdMax
                                              .toString(),
                                          dataSEMInput[index]
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
                                initialValue: dataSEMInput[index]
                                    .titrantFactor_1
                                    .toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].titrantFactor_1 =
                                      value.toString();
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
                                    dataSEMInput[index].endPt1_1.toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].endPt1_1 =
                                      value.toString();
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue:
                                    dataSEMInput[index].endPt2_1.toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].endPt2_1 =
                                      value.toString();
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
                                //textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                name: '${index}_4',
                                key: Key(
                                    dataSEMInput[index].result_1.toString()),
                                initialValue:
                                    dataSEMInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].result_1 =
                                      value.toString();
                                },
                              ),
                              //Text(dataSEMInput[index].result_1),
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
                                  dataSEMInput[index].result_1 = value;
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
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue: dataSEMInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].resultRemark_1 =
                                      value.toString();
                                },
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
                                initialValue: dataSEMInput[index]
                                    .titrantFactor_2
                                    .toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].titrantFactor_2 =
                                      value.toString();
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
                                    dataSEMInput[index].endPt1_2.toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].endPt1_2 =
                                      value.toString();
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue:
                                    dataSEMInput[index].endPt2_2.toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].endPt2_2 =
                                      value.toString();
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                initialValue:
                                    dataSEMInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].result_2 =
                                      value.toString();
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
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue: dataSEMInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataSEMInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider2),
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
 */