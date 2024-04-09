import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/14_Cwt3Layer/data/14_Cwt3Layer_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/14_Cwt3Layer/data/14_Cwt3Layer_bloc.dart';

class Instrument_Cwt3layers extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_Cwt3layers(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataCwt3layers>(
          create: (BuildContext context) => ManageDataCwt3layers(),
        ),
      ],
      child: Cwt3layers(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class Cwt3layers extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Cwt3layers({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _Cwt3layersState createState() => _Cwt3layersState();
}

class _Cwt3layersState extends State<Cwt3layers> {
  int countData = 0;
  void initState() {
    print("InINITIAL Cwt3layers");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataCwt3layers>()
          .add(Cwt3layersEvent.searchCwt3layersForInput);
    } else {
      context.read<ManageDataCwt3layers>().add(Cwt3layersEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      try {
        dataCwt3layersInput[index].w1W2 =
            (double.parse(dataCwt3layersInput[index].w1) -
                    double.parse(dataCwt3layersInput[index].w2))
                .toStringAsFixed(4);
      } on Exception catch (e) {
        // TODO
      }
      try {
        dataCwt3layersInput[index].result_Non =
            (double.parse(dataCwt3layersInput[index].w1W2) /
                    double.parse(dataCwt3layersInput[index].size) *
                    10000)
                .toStringAsFixed(4);
      } on Exception catch (e) {
        // TODO
      }
      try {
        dataCwt3layersInput[index].w2W3 =
            (double.parse(dataCwt3layersInput[index].w2) -
                    double.parse(dataCwt3layersInput[index].w3))
                .toStringAsFixed(4);
      } on Exception catch (e) {
        // TODO
      }
      try {
        dataCwt3layersInput[index].result_Met =
            (double.parse(dataCwt3layersInput[index].w2W3) /
                    double.parse(dataCwt3layersInput[index].size) *
                    10000)
                .toStringAsFixed(4);
      } on Exception catch (e) {
        // TODO
      }
      try {
        dataCwt3layersInput[index].w3W4 =
            (double.parse(dataCwt3layersInput[index].w3) -
                    double.parse(dataCwt3layersInput[index].w4))
                .toStringAsFixed(4);
      } on Exception catch (e) {
        // TODO
      }
      try {
        dataCwt3layersInput[index].result_Zn =
            (double.parse(dataCwt3layersInput[index].w3W4) /
                    double.parse(dataCwt3layersInput[index].size) *
                    10000)
                .toStringAsFixed(4);
      } on Exception catch (e) {
        // TODO
      }
      dataCwt3layersInput[index].resultUnit = "g/m2";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempCwt3layerssave.clear();
    dataTempCwt3layerssave.add(dataCwt3layersInput[index]);
    context
        .read<ManageDataCwt3layers>()
        .add(Cwt3layersEvent.tempSaveCwt3layersData);
  }

  void saveResult(int index) {
    if (dataCwt3layersInput[index].result_Zn.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text('NON-METALLIC LAYER'),
            Text(
                'STD MIN : ${dataCwt3layersInput[index].stdMin_Non.toString()}     STD MAX : ${dataCwt3layersInput[index].stdMax_Non.toString()}'),
            Text(
                'RESULT : ${dataCwt3layersInput[index].result_Non.toString()}'),
            Text('METALLIC LAYER'),
            Text(
                'STD MIN : ${dataCwt3layersInput[index].stdMin_Met.toString()}     STD MAX : ${dataCwt3layersInput[index].stdMax_Met.toString()}'),
            Text(
                'RESULT : ${dataCwt3layersInput[index].result_Met.toString()}'),
            Text('Zn-Phosphate LAYER'),
            Text(
                'STD MIN : ${dataCwt3layersInput[index].stdMin_Zn.toString()}     STD MAX : ${dataCwt3layersInput[index].stdMax_Zn.toString()}'),
            Text('RESULT : ${dataCwt3layersInput[index].result_Zn.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataCwt3layersInput[index].result_Zn.toString() != "") {
                try {
                  if (double.parse(dataCwt3layersInput[index].result_Zn) >
                          double.parse(dataCwt3layersInput[index].stdMax) ||
                      double.parse(dataCwt3layersInput[index].result_Zn) <
                          double.parse(dataCwt3layersInput[index].stdMin) ||
                      double.parse(dataCwt3layersInput[index].result_Zn) >
                          double.parse(dataCwt3layersInput[index].stdMax) ||
                      double.parse(dataCwt3layersInput[index].result_Zn) <
                          double.parse(dataCwt3layersInput[index].stdMin)) {
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
                  if (double.parse(dataCwt3layersInput[index].result_Zn) >
                          double.parse(dataCwt3layersInput[index].stdMax) ||
                      double.parse(dataCwt3layersInput[index].result_Zn) <
                          double.parse(dataCwt3layersInput[index].stdMin)) {
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
            dataCwt3layerssave.clear();
            dataCwt3layersInput[index].userAnalysis = userName;
            dataCwt3layersInput[index].userAnalysisBranch = userBranch;
            dataCwt3layerssave.add(dataCwt3layersInput[index]);
            context
                .read<ManageDataCwt3layers>()
                .add(Cwt3layersEvent.saveCwt3layersData);
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
    return BlocBuilder<ManageDataCwt3layers, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataCwt3layersInput.length;
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
                  DataColumn(
                    label: Container(
                        width: widthC1,
                        child: Text(
                          'REMARK2',
                        )),
                    tooltip: "SAMPLE REMARK",
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn(
                    'SIZE\n(cm2)',
                    'SIZE(cm2)',
                    widthC2,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'NON\nMETALLIC\nHISTORY',
                    'DATA/CHART',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 1\n(g)',
                    'WEIGHT 1 (g)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 2\n(g)',
                    'WEIGHT 2 (g)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'NON-METALLIC\nW1-W2(g)',
                    'NON-METALLIC\nW1-W2(g)',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'NON-METALLIC\nRESULT(g/m2)',
                    'NON-METALLIC\nRESULT(g/m2)',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC18,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'METALLIC\nHISTORY',
                    'DATA/CHART',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 3\n(g)',
                    'WEIGHT 3 (g)',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'METALLIC\nW2-W3(g)',
                    'METALLIC\nW2-W3(g)',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'METALIC\nRESULT(g/m2)',
                    'METALIC\nRESULT(g/m2)',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC18,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Zn-Phosphate\nHISTORY',
                    'DATA/CHART',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 4\n(g)',
                    'WEIGHT 4 (g)',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Zn-Phosphate\nW3-W4(g)',
                    'Zn-Phosphate\nW3-W4(g)',
                    widthC14,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'Zn-Phosphate\nRESULT(g/m2)',
                    'Zn-Phosphate\nRESULT(g/m2)',
                    widthC15,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC16),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
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
                                  Text(dataCwt3layersInput[index].sampleRemark),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataCwt3layersInput[index].mag),
                            ),
                          ),
                          DataCell(_verticalDivider2),
                          DataCell(
                            Container(
                              width: widthC2,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_2',
                                initialValue:
                                    dataCwt3layersInput[index].size.toString(),
                                onChanged: (value) {
                                  dataCwt3layersInput[index].size =
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
                              width: widthC3,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.insights),
                                  onPressed: () {
                                    setState(() {
                                      showHistory(
                                          dataCwt3layersInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataCwt3layersInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataCwt3layersInput[index]
                                              .stdMax_Non
                                              .toString(),
                                          dataCwt3layersInput[index]
                                              .stdMin_Non
                                              .toString(),
                                          context);
                                    });
                                  },
                                ),
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
                                    dataCwt3layersInput[index].w1.toString(),
                                onChanged: (value) {
                                  dataCwt3layersInput[index].w1 =
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
                                    dataCwt3layersInput[index].w2.toString(),
                                onChanged: (value) {
                                  dataCwt3layersInput[index].w2 =
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
                                //enabled: false,
                                key: Key(
                                    dataCwt3layersInput[index].w1W2.toString()),
                                initialValue:
                                    dataCwt3layersInput[index].w1W2.toString(),
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
                                //enabled: false,
                                key: Key(dataCwt3layersInput[index]
                                    .result_Non
                                    .toString()),
                                initialValue: dataCwt3layersInput[index]
                                    .result_Non
                                    .toString(),
                                onChanged: (value) {
                                  dataCwt3layersInput[index].result_Non =
                                      value.toString();
                                  dataCwt3layersInput[index].resultUnit =
                                      "g/m2";
                                  // },onSubmitted: (value) {
                                  calculate(index);
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
                              width: widthC8,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.insights),
                                  onPressed: () {
                                    setState(() {
                                      showHistory(
                                          (dataCwt3layersInput[index]
                                                      .requestSampleId +
                                                  1)
                                              .toString(),
                                          dataCwt3layersInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataCwt3layersInput[index]
                                              .stdMax_Met
                                              .toString(),
                                          dataCwt3layersInput[index]
                                              .stdMin_Met
                                              .toString(),
                                          context);
                                    });
                                  },
                                ),
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
                                initialValue:
                                    dataCwt3layersInput[index].w3.toString(),
                                onChanged: (value) {
                                  dataCwt3layersInput[index].w3 =
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
                              width: widthC10,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                //enabled: false,
                                key: Key(
                                    dataCwt3layersInput[index].w2W3.toString()),
                                initialValue:
                                    dataCwt3layersInput[index].w2W3.toString(),
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
                                  //enabled: false,
                                  key: Key(dataCwt3layersInput[index]
                                      .result_Met
                                      .toString()),
                                  initialValue: dataCwt3layersInput[index]
                                      .result_Met
                                      .toString(),
                                  onChanged: (value) {
                                    dataCwt3layersInput[index].result_Met =
                                        value.toString();
                                    dataCwt3layersInput[index].resultUnit =
                                        "g/m2";
                                  }),
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
                              width: widthC12,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.insights),
                                  onPressed: () {
                                    setState(() {
                                      showHistory(
                                          (dataCwt3layersInput[index]
                                                      .requestSampleId +
                                                  2)
                                              .toString(),
                                          dataCwt3layersInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataCwt3layersInput[index]
                                              .stdMax_Zn
                                              .toString(),
                                          dataCwt3layersInput[index]
                                              .stdMin_Zn
                                              .toString(),
                                          context);
                                    });
                                  },
                                ),
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
                                    dataCwt3layersInput[index].w4.toString(),
                                onChanged: (value) {
                                  dataCwt3layersInput[index].w4 =
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
                              width: widthC14,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_14',
                                //enabled: false,
                                key: Key(
                                    dataCwt3layersInput[index].w3W4.toString()),
                                initialValue:
                                    dataCwt3layersInput[index].w3W4.toString(),
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
                                  //enabled: false,
                                  key: Key(dataCwt3layersInput[index]
                                      .result_Zn
                                      .toString()),
                                  initialValue: dataCwt3layersInput[index]
                                      .result_Zn
                                      .toString(),
                                  onChanged: (value) {
                                    dataCwt3layersInput[index].result_Zn =
                                        value.toString();
                                    dataCwt3layersInput[index].resultUnit =
                                        "g/m2";
                                  }),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC16,
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
                                name: '${index}_16',
                                onChanged: (value) {
                                  dataCwt3layersInput[index].result_Met = value;
                                  dataCwt3layersInput[index].result_Non = value;
                                  dataCwt3layersInput[index].result_Zn = value;
                                  dataCwt3layersInput[index].resultUnit = "";
                                  setState(() {});
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
                                initialValue: dataCwt3layersInput[index]
                                    .resultRemark
                                    .toString(),
                                onChanged: (value) {
                                  dataCwt3layersInput[index].resultRemark =
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
