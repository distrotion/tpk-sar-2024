import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/2_OCA/data/2_OCA_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/2_OCA/data/2_OCA_event.dart';

class Instrument_OCA extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_OCA({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataOCA>(
          create: (BuildContext context) => ManageDataOCA(),
        ),
      ],
      child: OCA(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class OCA extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  OCA({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _OCAState createState() => _OCAState();
}

class _OCAState extends State<OCA> {
  int countData = 0;
  void initState() {
    print("InINITIAL OCA");
    if (widget.headHeight == 0) {
      context.read<ManageDataOCA>().add(OCAEvent.searchOCAForInput);
    } else {
      context.read<ManageDataOCA>().add(OCAEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataOCAInput[index].a_1 = (double.parse(dataOCAInput[index].abs260_1) -
              double.parse(dataOCAInput[index].abs370_1))
          .toStringAsFixed(4);
      dataOCAInput[index].b_1 = (double.parse(dataOCAInput[index].abs290_1) -
              double.parse(dataOCAInput[index].abs370_1))
          .toStringAsFixed(4);
      dataOCAInput[index].c_1 = ((((double.parse(dataOCAInput[index].a_1) -
                      (double.parse(dataOCAInput[index].b_1) * 0.29)) *
                  3.1) /
              2.81))
          .toStringAsFixed(4);

      dataOCAInput[index].result_1 =
          ((double.parse(dataOCAInput[index].c_1) * 313.03) - 2.87)
              .toStringAsFixed(2);
      dataOCAInput[index].resultUnit_1 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataOCAInput[index].a_2 = (double.parse(dataOCAInput[index].abs260_2) -
              double.parse(dataOCAInput[index].abs370_2))
          .toStringAsFixed(4);
      dataOCAInput[index].b_2 = (double.parse(dataOCAInput[index].abs290_2) -
              double.parse(dataOCAInput[index].abs370_2))
          .toStringAsFixed(4);
      dataOCAInput[index].c_2 = ((((double.parse(dataOCAInput[index].a_2) -
                      (double.parse(dataOCAInput[index].b_2) * 0.29)) *
                  3.1) /
              2.81))
          .toStringAsFixed(4);

      dataOCAInput[index].result_2 =
          ((double.parse(dataOCAInput[index].c_2) * 313.03) - 2.87)
              .toStringAsFixed(2);
      dataOCAInput[index].resultUnit_2 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempOCAsave.clear();
    dataTempOCAsave.add(dataOCAInput[index]);
    context.read<ManageDataOCA>().add(OCAEvent.tempSaveOCAData);
  }

  void saveResult(int index) {
    if (dataOCAInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataOCAInput[index].stdMin.toString()}     STD MAX : ${dataOCAInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataOCAInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataOCAInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataOCAInput[index].result_1) >
                          double.parse(dataOCAInput[index].stdMax) ||
                      double.parse(dataOCAInput[index].result_1) <
                          double.parse(dataOCAInput[index].stdMin) ||
                      double.parse(dataOCAInput[index].result_2) >
                          double.parse(dataOCAInput[index].stdMax) ||
                      double.parse(dataOCAInput[index].result_2) <
                          double.parse(dataOCAInput[index].stdMin)) {
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
                  if (double.parse(dataOCAInput[index].result_1) >
                          double.parse(dataOCAInput[index].stdMax) ||
                      double.parse(dataOCAInput[index].result_1) <
                          double.parse(dataOCAInput[index].stdMin)) {
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
            dataOCAsave.clear();
            dataOCAInput[index].userAnalysis = userName;
            dataOCAInput[index].userAnalysisBranch = userBranch;
            dataOCAsave.add(dataOCAInput[index]);
            context.read<ManageDataOCA>().add(OCAEvent.saveOCAData);
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
  double widthC19 = 50;
  double widthC20 = 50;
  double widthC21 = 40;
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
    return BlocBuilder<ManageDataOCA, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataOCAInput.length;
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
                    'Abs@260\n nm',
                    'Abs@260 nm',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Abs@290\n nm',
                    'Abs@290 nm',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Abs@370\n nm',
                    'Abs@370 nm',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'A',
                    'A (Abs@260-Abs@370)',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'B',
                    'B (Abs@290-Abs@370)',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'C',
                    'C [((A-0.29B)x3.1)/2.81]',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(ppm)',
                    'RESULT = (313.03C-2.87)',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC10),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC20,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC21,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn(
                    'Abs@260\n nm(2)',
                    'Abs@260 nm',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Abs@290\n nm(2)',
                    'Abs@290 nm',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Abs@370\n nm(2)',
                    'Abs@370 nm',
                    widthC14,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'A(2)',
                    'A (Abs@260-Abs@370)',
                    widthC15,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'B(2)',
                    'B (Abs@290-Abs@370)',
                    widthC16,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'C(2)',
                    'C [((A-0.29B)x3.1)/2.81]',
                    widthC17,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(ppm)(2)',
                    'RESULT = (313.03C-2.87)',
                    widthC18,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC19,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC20,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC21,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataOCAInput[index].sampleRemark),
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
                                          dataOCAInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataOCAInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataOCAInput[index].stdMax.toString(),
                                          dataOCAInput[index].stdMin.toString(),
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
                                    dataOCAInput[index].abs260_1.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].abs260_1 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_4',
                                initialValue:
                                    dataOCAInput[index].abs290_1.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].abs290_1 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue:
                                    dataOCAInput[index].abs370_1.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].abs370_1 =
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
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue:
                                    dataOCAInput[index].a_1.toString(),
                                key: Key(dataOCAInput[index].a_1.toString()),
                                enabled: false,
                                onChanged: (value) {
                                  dataOCAInput[index].a_1 = value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC7,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue:
                                    dataOCAInput[index].b_1.toString(),
                                key: Key(dataOCAInput[index].b_1.toString()),
                                enabled: false,
                                onChanged: (value) {
                                  dataOCAInput[index].b_1 = value.toString();
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
                                initialValue:
                                    dataOCAInput[index].c_1.toString(),
                                key: Key(dataOCAInput[index].c_1.toString()),
                                enabled: false,
                                onChanged: (value) {
                                  dataOCAInput[index].c_1 = value.toString();
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

                                //enabled: false,

                                name: '${index}_9',
                                key: Key(
                                    dataOCAInput[index].result_1.toString()),
                                initialValue:
                                    dataOCAInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].result_1 =
                                      value.toString();
                                  dataOCAInput[index].resultUnit_1 = "ppm";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
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
                                name: '${index}_10',
                                onChanged: (value) {
                                  dataOCAInput[index].result_1 = value;
                                  dataOCAInput[index].resultUnit_1 = "";
                                  setState(() {});
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
                                initialValue: dataOCAInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC20,
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
                              width: widthC21,
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
                              width: widthC12,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_12',
                                initialValue:
                                    dataOCAInput[index].abs260_2.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].abs260_2 =
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
                              width: widthC13,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_13',
                                initialValue:
                                    dataOCAInput[index].abs290_2.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].abs290_2 =
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
                              width: widthC14,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_14',
                                initialValue:
                                    dataOCAInput[index].abs370_2.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].abs370_2 =
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
                              width: widthC15,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_15',
                                initialValue:
                                    dataOCAInput[index].a_2.toString(),
                                key: Key(dataOCAInput[index].a_2.toString()),
                                enabled: false,
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC16,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_16',
                                initialValue:
                                    dataOCAInput[index].b_2.toString(),
                                key: Key(dataOCAInput[index].b_2.toString()),
                                enabled: false,
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC17,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_17',
                                initialValue:
                                    dataOCAInput[index].c_2.toString(),
                                key: Key(dataOCAInput[index].c_2.toString()),
                                enabled: false,
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC18,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_18',
                                key: Key(
                                    dataOCAInput[index].result_2.toString()),
                                initialValue:
                                    dataOCAInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].result_2 =
                                      value.toString();
                                  dataOCAInput[index].resultUnit_2 = "ppm";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC19,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_19',
                                initialValue: dataOCAInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataOCAInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC20,
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
                              width: widthC21,
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
