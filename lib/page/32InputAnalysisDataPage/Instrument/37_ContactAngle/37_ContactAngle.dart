import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/37_ContactAngle/data/37_ContactAngle_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/37_ContactAngle/data/37_ContactAngle_bloc.dart';

class Instrument_ContactAngle extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_ContactAngle(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataContactAngle>(
          create: (BuildContext context) => ManageDataContactAngle(),
        ),
      ],
      child: ContactAngle(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class ContactAngle extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  ContactAngle({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _ContactAngleState createState() => _ContactAngleState();
}

class _ContactAngleState extends State<ContactAngle> {
  int countData = 0;
  void initState() {
    print("InINITIAL ContactAngle");
    if (widget.headHeight == 0) {
      context
          .read<ManageDataContactAngle>()
          .add(ContactAngleEvent.searchContactAngleForInput);
    } else {
      context.read<ManageDataContactAngle>().add(ContactAngleEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      List<double> dataBuff = [];
      dataBuff.add(double.parse(dataContactAngleInput[index].n1));
      dataBuff.add(double.parse(dataContactAngleInput[index].n2));
      dataBuff.add(double.parse(dataContactAngleInput[index].n3));
      dataBuff.add(double.parse(dataContactAngleInput[index].n4));
      dataBuff.add(double.parse(dataContactAngleInput[index].n5));
      dataBuff.add(double.parse(dataContactAngleInput[index].n6));
      dataBuff.add(double.parse(dataContactAngleInput[index].n7));
      dataBuff.add(double.parse(dataContactAngleInput[index].n8));
      dataBuff.add(double.parse(dataContactAngleInput[index].n9));
      dataBuff.add(double.parse(dataContactAngleInput[index].n10));
      dataBuff.add(double.parse(dataContactAngleInput[index].n11));
      dataBuff.add(double.parse(dataContactAngleInput[index].n12));
      dataBuff.add(double.parse(dataContactAngleInput[index].n13));
      dataBuff.add(double.parse(dataContactAngleInput[index].n14));
      dataBuff.add(double.parse(dataContactAngleInput[index].n15));
      dataBuff.sort();
      if (dataContactAngleInput[index].custFull ==
          'AIR INTERNATIONAL THERMAL SYSTEMS (THAILAND) LTD') {
        dataBuff.removeAt(14);
        dataBuff.removeAt(13);
        dataBuff.removeAt(0);
        dataContactAngleInput[index].result_1 = '';
        for (int i = 0; i < dataBuff.length; i++) {
          dataContactAngleInput[index].result_1 =
              dataContactAngleInput[index].result_1 +
                  dataBuff[i].toString() +
                  ' ';
        }
      } else if (dataContactAngleInput[index].custFull ==
          'VALEO SIAM THERMAL SYSTEMS CO., LTD.') {
        dataBuff.removeAt(14);
        dataBuff.removeAt(13);
        dataBuff.removeAt(12);
        dataBuff.removeAt(0);
        dataBuff.removeAt(0);
        double buff = 0;
        for (int i = 0; i < dataBuff.length; i++) {
          buff = buff + dataBuff[i];
        }
        dataContactAngleInput[index].result_1 =
            (buff / dataBuff.length).toStringAsFixed(2);
      }
      /* dataContactAngleInput[index].result_1 =
          ((double.parse(dataContactAngleInput[index].n1) +
                      double.parse(dataContactAngleInput[index].n2) +
                      double.parse(dataContactAngleInput[index].n3) +
                      double.parse(dataContactAngleInput[index].n4) +
                      double.parse(dataContactAngleInput[index].n5) +
                      double.parse(dataContactAngleInput[index].n6) +
                      double.parse(dataContactAngleInput[index].n7) +
                      double.parse(dataContactAngleInput[index].n8) +
                      double.parse(dataContactAngleInput[index].n9) +
                      double.parse(dataContactAngleInput[index].n10)) /
                  10)
              .toStringAsFixed(2);
      try {
        dataContactAngleInput[index].result_1 =
            ((double.parse(dataContactAngleInput[index].n1) +
                        double.parse(dataContactAngleInput[index].n2) +
                        double.parse(dataContactAngleInput[index].n3) +
                        double.parse(dataContactAngleInput[index].n4) +
                        double.parse(dataContactAngleInput[index].n5) +
                        double.parse(dataContactAngleInput[index].n6) +
                        double.parse(dataContactAngleInput[index].n7) +
                        double.parse(dataContactAngleInput[index].n8) +
                        double.parse(dataContactAngleInput[index].n9) +
                        double.parse(dataContactAngleInput[index].n10) +
                        double.parse(dataContactAngleInput[index].n11) +
                        double.parse(dataContactAngleInput[index].n12) +
                        double.parse(dataContactAngleInput[index].n13) +
                        double.parse(dataContactAngleInput[index].n14) +
                        double.parse(dataContactAngleInput[index].n15)) /
                    15)
                .toStringAsFixed(2);
      } on Exception catch (e) {
        // TODO
      } */
      dataContactAngleInput[index].resultUnit_1 = "Degree";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

/*   void calculate2(int index) {
    try {
      dataContactAngleInput[index].resultUnit_2 = "";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  } */

  void tempSave(int index) {
    dataTempContactAnglesave.clear();
    dataTempContactAnglesave.add(dataContactAngleInput[index]);
    context
        .read<ManageDataContactAngle>()
        .add(ContactAngleEvent.tempSaveContactAngleData);
  }

  void saveResult(int index) {
    if (dataContactAngleInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataContactAngleInput[index].stdMin.toString()}     STD MAX : ${dataContactAngleInput[index].stdMax.toString()}'),
            Text(
                'RESULT : ${dataContactAngleInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataContactAngleInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataContactAngleInput[index].result_1) >
                          double.parse(dataContactAngleInput[index].stdMax) ||
                      double.parse(dataContactAngleInput[index].result_1) <
                          double.parse(dataContactAngleInput[index].stdMin) ||
                      double.parse(dataContactAngleInput[index].result_2) >
                          double.parse(dataContactAngleInput[index].stdMax) ||
                      double.parse(dataContactAngleInput[index].result_2) <
                          double.parse(dataContactAngleInput[index].stdMin)) {
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
                  if (double.parse(dataContactAngleInput[index].result_1) >
                          double.parse(dataContactAngleInput[index].stdMax) ||
                      double.parse(dataContactAngleInput[index].result_1) <
                          double.parse(dataContactAngleInput[index].stdMin)) {
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
            dataContactAnglesave.clear();
            dataContactAngleInput[index].userAnalysis = userName;
            dataContactAngleInput[index].userAnalysisBranch = userBranch;
            dataContactAnglesave.add(dataContactAngleInput[index]);
            context
                .read<ManageDataContactAngle>()
                .add(ContactAngleEvent.saveContactAngleData);
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
  double widthCR = 300;
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
    return BlocBuilder<ManageDataContactAngle, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataContactAngleInput.length;
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
                    'POSITION',
                    'POSITION',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N1',
                    'N1',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N2',
                    'N2',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N3',
                    'N3',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N4',
                    'N4',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N5',
                    'N5',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N6',
                    'N6',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N7',
                    'N7',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N8',
                    'N8',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N9',
                    'N9',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N10',
                    'N10',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N11',
                    'N11',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N12',
                    'N12',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N13',
                    'N13',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N14',
                    'N14',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'N15',
                    'N15',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT',
                    'RESULT',
                    widthCR,
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
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(
                                  dataContactAngleInput[index].sampleRemark),
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
                                          dataContactAngleInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataContactAngleInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataContactAngleInput[index]
                                              .stdMax
                                              .toString(),
                                          dataContactAngleInput[index]
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
                                key: Key(dataContactAngleInput[index]
                                    .pos_1
                                    .toString()),
                                initialValue: dataContactAngleInput[index]
                                    .pos_1
                                    .toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].pos_1 =
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
                                textInputAction: TextInputAction.next,
                                name: '${index}_n1',
                                key: Key(
                                    dataContactAngleInput[index].n1.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n1.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n1 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n2',
                                key: Key(
                                    dataContactAngleInput[index].n2.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n2.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n2 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n3',
                                key: Key(
                                    dataContactAngleInput[index].n3.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n3.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n3 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n4',
                                key: Key(
                                    dataContactAngleInput[index].n4.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n4.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n4 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n5',
                                key: Key(
                                    dataContactAngleInput[index].n5.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n5.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n5 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n6',
                                key: Key(
                                    dataContactAngleInput[index].n6.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n6.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n6 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n7',
                                key: Key(
                                    dataContactAngleInput[index].n7.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n7.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n7 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n8',
                                key: Key(
                                    dataContactAngleInput[index].n8.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n8.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n8 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n9',
                                key: Key(
                                    dataContactAngleInput[index].n9.toString()),
                                initialValue:
                                    dataContactAngleInput[index].n9.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n9 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n10',
                                key: Key(dataContactAngleInput[index]
                                    .n10
                                    .toString()),
                                initialValue:
                                    dataContactAngleInput[index].n10.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n10 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n11',
                                key: Key(dataContactAngleInput[index]
                                    .n11
                                    .toString()),
                                initialValue:
                                    dataContactAngleInput[index].n11.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n11 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n12',
                                key: Key(dataContactAngleInput[index]
                                    .n12
                                    .toString()),
                                initialValue:
                                    dataContactAngleInput[index].n12.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n12 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n13',
                                key: Key(dataContactAngleInput[index]
                                    .n13
                                    .toString()),
                                initialValue:
                                    dataContactAngleInput[index].n13.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n13 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n14',
                                key: Key(dataContactAngleInput[index]
                                    .n14
                                    .toString()),
                                initialValue:
                                    dataContactAngleInput[index].n14.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n14 =
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
                                style: styleDataInTable,
                                decoration: formField(),
                                textInputAction: TextInputAction.next,
                                name: '${index}_n15',
                                key: Key(dataContactAngleInput[index]
                                    .n15
                                    .toString()),
                                initialValue:
                                    dataContactAngleInput[index].n15.toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].n15 =
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
                              width: widthCR,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_4',
                                key: Key(dataContactAngleInput[index]
                                    .result_1
                                    .toString()),
                                initialValue: dataContactAngleInput[index]
                                    .result_1
                                    .toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].result_1 =
                                      value.toString();
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
                                  dataContactAngleInput[index].result_1 = value;
                                  dataContactAngleInput[index].resultUnit_1 =
                                      "";
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
                                initialValue: dataContactAngleInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataContactAngleInput[index].resultRemark_1 =
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
