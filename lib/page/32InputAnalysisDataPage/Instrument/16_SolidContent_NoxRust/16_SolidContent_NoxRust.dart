import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/16_SolidContent_NoxRust/data/16_SolidContent_NoxRust_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/16_SolidContent_NoxRust/data/16_SolidContent_NoxRust_event.dart';

class Instrument_SolidContent_NoxRust extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_SolidContent_NoxRust(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataSolidContent_NoxRust>(
          create: (BuildContext context) => ManageDataSolidContent_NoxRust(),
        ),
      ],
      child:
          SolidContent_NoxRust(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class SolidContent_NoxRust extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  SolidContent_NoxRust(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _SolidContent_NoxRustState createState() => _SolidContent_NoxRustState();
}

class _SolidContent_NoxRustState extends State<SolidContent_NoxRust> {
  int countData = 0;
  void initState() {
    print("InINITIAL SolidContent_NoxRust");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataSolidContent_NoxRust>()
          .add(SolidContent_NoxRustEvent.searchSolidContent_NoxRustForInput);
    } else {
      context
          .read<ManageDataSolidContent_NoxRust>()
          .add(SolidContent_NoxRustEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataSolidContent_NoxRustInput[index].w1W2_1 =
          (double.parse(dataSolidContent_NoxRustInput[index].w2_1) -
                  double.parse(dataSolidContent_NoxRustInput[index].w1_1))
              .toStringAsFixed(4);
      dataSolidContent_NoxRustInput[index].result_1 =
          (double.parse(dataSolidContent_NoxRustInput[index].w1W2_1) * 1000)
              .toStringAsFixed(4);
      if (double.parse(dataSolidContent_NoxRustInput[index].result_1) >
          0.0010) {
        dataSolidContent_NoxRustInput[index].result_1 = '< 1';
      }
      dataSolidContent_NoxRustInput[index].resultUnit_1 = "mg/50 mL";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataSolidContent_NoxRustInput[index].w1W2_2 =
          (double.parse(dataSolidContent_NoxRustInput[index].w2_2) -
                  double.parse(dataSolidContent_NoxRustInput[index].w1_2))
              .toStringAsFixed(4);
      dataSolidContent_NoxRustInput[index].result_2 =
          (double.parse(dataSolidContent_NoxRustInput[index].w1W2_2) * 1000)
              .toStringAsFixed(4);
      if (double.parse(dataSolidContent_NoxRustInput[index].result_2) >
          0.0010) {
        dataSolidContent_NoxRustInput[index].result_2 = '< 1';
      }
      dataSolidContent_NoxRustInput[index].resultUnit_2 = "mg/50 mL";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempSolidContent_NoxRustsave.clear();
    dataTempSolidContent_NoxRustsave.add(dataSolidContent_NoxRustInput[index]);
    context
        .read<ManageDataSolidContent_NoxRust>()
        .add(SolidContent_NoxRustEvent.tempSaveSolidContent_NoxRustData);
  }

  void saveResult(int index) {
    if (dataSolidContent_NoxRustInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataSolidContent_NoxRustInput[index].stdMin.toString()}     STD MAX : ${dataSolidContent_NoxRustInput[index].stdMax.toString()}'),
            Text(
                'RESULT : ${dataSolidContent_NoxRustInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataSolidContent_NoxRustInput[index].result_2.toString() !=
                  "") {
                try {
                  if (double.parse(
                              dataSolidContent_NoxRustInput[index].result_1) >
                          double.parse(
                              dataSolidContent_NoxRustInput[index].stdMax) ||
                      double.parse(
                              dataSolidContent_NoxRustInput[index].result_1) <
                          double.parse(
                              dataSolidContent_NoxRustInput[index].stdMin) ||
                      double.parse(
                              dataSolidContent_NoxRustInput[index].result_2) >
                          double.parse(
                              dataSolidContent_NoxRustInput[index].stdMax) ||
                      double.parse(
                              dataSolidContent_NoxRustInput[index].result_2) <
                          double.parse(
                              dataSolidContent_NoxRustInput[index].stdMin)) {
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
                  if (double.parse(
                              dataSolidContent_NoxRustInput[index].result_1) >
                          double.parse(
                              dataSolidContent_NoxRustInput[index].stdMax) ||
                      double.parse(
                              dataSolidContent_NoxRustInput[index].result_1) <
                          double.parse(
                              dataSolidContent_NoxRustInput[index].stdMin)) {
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
            dataSolidContent_NoxRustsave.clear();
            dataSolidContent_NoxRustInput[index].userAnalysis = userName;
            dataSolidContent_NoxRustInput[index].userAnalysisBranch =
                userBranch;
            dataSolidContent_NoxRustsave
                .add(dataSolidContent_NoxRustInput[index]);
            context
                .read<ManageDataSolidContent_NoxRust>()
                .add(SolidContent_NoxRustEvent.saveSolidContent_NoxRustData);
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
    return BlocBuilder<ManageDataSolidContent_NoxRust, int>(
        builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataSolidContent_NoxRustInput.length;
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
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'USED\nSAMPLE(mL)',
                    'USED SAMPLE(mL)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'WEIGHT 1\n(g)',
                    'WEIGHT 1 (g)',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 2\n(g)',
                    'WEIGHT 2 (g)',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'W2-W1\n(g)',
                    'WEIGHT2- WEIGHT1 (g)',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(mg/50 mL)',
                    'RESULT = (W2-W1)*1000',
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
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'USED\nSAMPLE(mL)(2)',
                    'USED SAMPLE(mL)',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'WEIGHT 1\n(g)(2)',
                    'WEIGHT 1 (g)',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'WEIGHT 2\n(g)(2)',
                    'WEIGHT 2 (g)',
                    widthC14,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'W2-W1\n(g)(2)',
                    'WEIGHT2- WEIGHT1 (g)',
                    widthC15,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(mg/50 mL)(2)',
                    'RESULT = (W2-W1)*1000',
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
                              child: Text(dataSolidContent_NoxRustInput[index]
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
                                          dataSolidContent_NoxRustInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataSolidContent_NoxRustInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataSolidContent_NoxRustInput[index]
                                              .stdMax
                                              .toString(),
                                          dataSolidContent_NoxRustInput[index]
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
                                    dataSolidContent_NoxRustInput[index]
                                        .no_1
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].no_1 =
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
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .usedSample_1
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index]
                                      .usedSample_1 = value.toString();
                                   },onSubmitted: (value) {
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC5,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .w1_1
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].w1_1 =
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
                                    dataSolidContent_NoxRustInput[index]
                                        .w2_1
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].w2_1 =
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
                              width: widthC7,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .w1W2_1
                                        .toString(),
                                key: Key(dataSolidContent_NoxRustInput[index]
                                    .w1W2_1
                                    .toString()),
                                enabled: false,
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].w1W2_1 =
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
                              width: widthC8,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                //enabled: false,
                                name: '${index}_8',
                                key: Key(dataSolidContent_NoxRustInput[index]
                                    .result_1
                                    .toString()),
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .result_1
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index]
                                      .result_1 = value.toString();
                                  dataSolidContent_NoxRustInput[index]
                                      .resultUnit_1 = "mg/50 mL";
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
                                  dataSolidContent_NoxRustInput[index]
                                      .result_1 = value;
                                  dataSolidContent_NoxRustInput[index]
                                      .resultUnit_1 = "";
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
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .resultRemark_1
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index]
                                      .resultRemark_1 = value.toString();
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
                                    dataSolidContent_NoxRustInput[index]
                                        .no_2
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].no_2 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_12',
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .usedSample_2
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index]
                                      .usedSample_2 = value.toString();
                                   },onSubmitted: (value) {
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC13,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_13',
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .w1_2
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].w1_2 =
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
                                    dataSolidContent_NoxRustInput[index]
                                        .w2_2
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].w2_2 =
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
                                    dataSolidContent_NoxRustInput[index]
                                        .w1W2_2
                                        .toString(),
                                key: Key(dataSolidContent_NoxRustInput[index]
                                    .w1W2_2
                                    .toString()),
                                enabled: false,
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index].w1W2_2 =
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
                              width: widthC16,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                //enabled: false,
                                name: '${index}_16',
                                key: Key(dataSolidContent_NoxRustInput[index]
                                    .result_2
                                    .toString()),
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .result_2
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index]
                                      .result_2 = value.toString();
                                  dataSolidContent_NoxRustInput[index]
                                      .resultUnit_2 = "mg/50 mL";
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
                                initialValue:
                                    dataSolidContent_NoxRustInput[index]
                                        .resultRemark_2
                                        .toString(),
                                onChanged: (value) {
                                  dataSolidContent_NoxRustInput[index]
                                      .resultRemark_2 = value.toString();
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
