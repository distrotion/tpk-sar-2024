import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/49_XRD_PRatio/data/49_XRD_PRatio_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/49_XRD_PRatio/data/49_XRD_PRatio_event.dart';

class Instrument_XRD_PRatio extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_XRD_PRatio(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataXRD_PRatio>(
          create: (BuildContext context) => ManageDataXRD_PRatio(),
        ),
      ],
      child: XRD_PRatio(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class XRD_PRatio extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  XRD_PRatio({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _XRD_PRatioState createState() => _XRD_PRatioState();
}

class _XRD_PRatioState extends State<XRD_PRatio> {
  int countData = 0;
  void initState() {
    print("InINITIAL XRD_PRatio");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataXRD_PRatio>()
          .add(XRD_PRatioEvent.searchXRD_PRatioForInput);
    } else {
      context.read<ManageDataXRD_PRatio>().add(XRD_PRatioEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataXRD_PRatioInput[index].result_1 =
          ((double.parse(dataXRD_PRatioInput[index].phosIntensity_1) * 100) /
                  (double.parse(dataXRD_PRatioInput[index].phosIntensity_1) +
                      double.parse(
                          dataXRD_PRatioInput[index].hopiteIntensity_1)))
              .toStringAsFixed(1);
      dataXRD_PRatioInput[index].resultUnit_1 = "%";
      if (double.parse(dataXRD_PRatioInput[index].phosPeak_1) > 14.90) {
        dataXRD_PRatioInput[index].result_1 = "NOT ANALYSIS";
        dataXRD_PRatioInput[index].resultUnit_1 = "";
      }
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataXRD_PRatioInput[index].result_2 =
          ((double.parse(dataXRD_PRatioInput[index].phosIntensity_2) * 100) /
                  (double.parse(dataXRD_PRatioInput[index].phosIntensity_2) +
                      double.parse(
                          dataXRD_PRatioInput[index].hopiteIntensity_2)))
              .toStringAsFixed(1);
      dataXRD_PRatioInput[index].resultUnit_2 = "%";
      if (double.parse(dataXRD_PRatioInput[index].phosPeak_2) > 14.90) {
        dataXRD_PRatioInput[index].result_2 = "NOT ANALYSIS";
        dataXRD_PRatioInput[index].resultUnit_2 = "";
      }
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempXRD_PRatiosave.clear();
    dataTempXRD_PRatiosave.add(dataXRD_PRatioInput[index]);
    context
        .read<ManageDataXRD_PRatio>()
        .add(XRD_PRatioEvent.tempSaveXRD_PRatioData);
  }

  void saveResult(int index) {
    if (dataXRD_PRatioInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataXRD_PRatioInput[index].stdMin.toString()}     STD MAX : ${dataXRD_PRatioInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataXRD_PRatioInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataXRD_PRatioInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataXRD_PRatioInput[index].result_1) >
                          double.parse(dataXRD_PRatioInput[index].stdMax) ||
                      double.parse(dataXRD_PRatioInput[index].result_1) <
                          double.parse(dataXRD_PRatioInput[index].stdMin) ||
                      double.parse(dataXRD_PRatioInput[index].result_2) >
                          double.parse(dataXRD_PRatioInput[index].stdMax) ||
                      double.parse(dataXRD_PRatioInput[index].result_2) <
                          double.parse(dataXRD_PRatioInput[index].stdMin)) {
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
                  if (double.parse(dataXRD_PRatioInput[index].result_1) >
                          double.parse(dataXRD_PRatioInput[index].stdMax) ||
                      double.parse(dataXRD_PRatioInput[index].result_1) <
                          double.parse(dataXRD_PRatioInput[index].stdMin)) {
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
            dataXRD_PRatiosave.clear();
            dataXRD_PRatioInput[index].userAnalysis = userName;
            dataXRD_PRatioInput[index].userAnalysisBranch = userBranch;
            dataXRD_PRatiosave.add(dataXRD_PRatioInput[index]);
            context
                .read<ManageDataXRD_PRatio>()
                .add(XRD_PRatioEvent.saveXRD_PRatioData);
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
    return BlocBuilder<ManageDataXRD_PRatio, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataXRD_PRatioInput.length;
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
                  /* headerColumn('NO', 'NO', widthC3),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'Phosphophyllite(P)\nPeak position(2theta)',
                    'Phosphophyllite(P)\nPeak position(2theta)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Phosphophyllite(P)\nIntensity(cps)',
                    'Phosphophyllite(P)\nIntensity(cps)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Hopite(H)\nPeak position(2theta)',
                    'Hopite(H)\nPeak position(2theta)',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Hopite(H)\nIntensity(cps)',
                    'Hopite(H)\nIntensity(cps)',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT(%)',
                    'RESULT = Phosphophyllite(P) x 100/(Phosphophyllite(P)+Hopite(H))',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC9),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC18,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC19,
                  ),
                  DataColumn(label: _verticalDivider2),
                  /*  headerColumn('NO', 'NO', widthC11),
                  DataColumn(label: _verticalDivider),*/
                  headerColumn(
                    'Phosphophyllite(P)\nPeak position(2theta)\n(2)',
                    'Phosphophyllite(P)\nPeak position(2theta)',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Phosphophyllite(P)\nIntensity(cps)\n(2)',
                    'Phosphophyllite(P)\nIntensity(cps)',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Hopite(H)\nPeak position(2theta)\n(2)',
                    'Hopite(H)\nPeak position(2theta)',
                    widthC14,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Hopite(H)\nIntensity(cps)\n(2)',
                    'Hopite(H)\nIntensity(cps)',
                    widthC15,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT(%)\n(2)',
                    'RESULT = Phosphophyllite(P) x 100/(Phosphophyllite(P)+Hopite(H))',
                    widthC16,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC17,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC18,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC19,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child:
                                  Text(dataXRD_PRatioInput[index].sampleRemark),
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
                                          dataXRD_PRatioInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataXRD_PRatioInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataXRD_PRatioInput[index]
                                              .stdMax
                                              .toString(),
                                          dataXRD_PRatioInput[index]
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue:
                                    dataXRD_PRatioInput[index]
                                        .no_1
                                        .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].no_1 =
                                      value.toString();
                                  },onSubmitted: (value) {
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC4,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_4',
                                initialValue: dataXRD_PRatioInput[index]
                                    .phosPeak_1
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].phosPeak_1 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue: dataXRD_PRatioInput[index]
                                    .phosIntensity_1
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].phosIntensity_1 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue: dataXRD_PRatioInput[index]
                                    .hopitePeak_1
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].hopitePeak_1 =
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
                              width: widthC7,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue: dataXRD_PRatioInput[index]
                                    .hopiteIntensity_1
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].hopiteIntensity_1 =
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
                              width: widthC8,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                              
                                name: '${index}_8',
                                key: Key(dataXRD_PRatioInput[index]
                                    .result_1
                                    .toString()),
                                initialValue: dataXRD_PRatioInput[index]
                                    .result_1
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].result_1 =
                                      value.toString();
                                  dataXRD_PRatioInput[index].resultUnit_1 = "%";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
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
                                name: '${index}_9',
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].result_1 = value;
                                  dataXRD_PRatioInput[index].resultUnit_1 = "";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                initialValue: dataXRD_PRatioInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC18,
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
                              width: widthC19,
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
                              width: widthC11,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue:
                                    dataXRD_PRatioInput[index]
                                        .no_2
                                        .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].no_2 =
                                      value.toString();
                                  },onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC12,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_12',
                                initialValue: dataXRD_PRatioInput[index]
                                    .phosPeak_2
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].phosPeak_2 =
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
                              width: widthC13,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_13',
                                initialValue: dataXRD_PRatioInput[index]
                                    .phosIntensity_2
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].phosIntensity_2 =
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
                              width: widthC14,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_14',
                                initialValue: dataXRD_PRatioInput[index]
                                    .hopitePeak_2
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].hopitePeak_2 =
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
                              width: widthC15,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_15',
                                initialValue: dataXRD_PRatioInput[index]
                                    .hopiteIntensity_2
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].hopiteIntensity_2 =
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
                              width: widthC16,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_16',
                                key: Key(dataXRD_PRatioInput[index]
                                    .result_2
                                    .toString()),
                                initialValue: dataXRD_PRatioInput[index]
                                    .result_2
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].result_2 =
                                      value.toString();
                                  dataXRD_PRatioInput[index].resultUnit_2 = "%";
                                },
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
                                initialValue: dataXRD_PRatioInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataXRD_PRatioInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC18,
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
                              width: widthC19,
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
