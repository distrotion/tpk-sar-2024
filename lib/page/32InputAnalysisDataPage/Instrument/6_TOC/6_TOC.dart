import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/6_TOC/data/6_TOC_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/6_TOC/data/6_TOC_event.dart';

class Instrument_TOC extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_TOC({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataTOC>(
          create: (BuildContext context) => ManageDataTOC(),
        ),
      ],
      child: TOC(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class TOC extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  TOC({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _TOCState createState() => _TOCState();
}

class _TOCState extends State<TOC> {
  int countData = 0;
  void initState() {
    print("InINITIAL TOC");
    if (widget.headHeight == 0) {
      context.read<ManageDataTOC>().add(TOCEvent.searchTOCForInput);
    } else {
      context.read<ManageDataTOC>().add(TOCEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      if (dataTOCInput[index].tC_DilutionTime_1 == "") {
        dataTOCInput[index].tC_DilutionTime_1 = 0;
      }
      if (dataTOCInput[index].tC_RawData_1 == "") {
        dataTOCInput[index].tC_RawData_1 = 0;
      }
      if (dataTOCInput[index].iC_DilutionTime_1 == "") {
        dataTOCInput[index].iC_DilutionTime_1 = 0;
      }
      if (dataTOCInput[index].iC_RawData_1 == "") {
        dataTOCInput[index].iC_RawData_1 = 0;
      }
      /* dataTOCInput[index].result_1 =
          ((double.parse(dataTOCInput[index].tC_DilutionTime_1) *
                      double.parse(dataTOCInput[index].tC_RawData_1)) -
                  (double.parse(dataTOCInput[index].iC_DilutionTime_1) *
                      double.parse(dataTOCInput[index].iC_RawData_1)))
              .toStringAsFixed(2); */
      dataTOCInput[index].result_1 =
          (double.parse(dataTOCInput[index].tC_RawData_1) -
                  double.parse(dataTOCInput[index].iC_RawData_1))
              .toStringAsFixed(2);
      dataTOCInput[index].resultUnit_1 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      if (dataTOCInput[index].tC_DilutionTime_2 == "") {
        dataTOCInput[index].tC_DilutionTime_2 = 0;
      }
      if (dataTOCInput[index].tC_RawData_2 == "") {
        dataTOCInput[index].tC_RawData_2 = 0;
      }
      if (dataTOCInput[index].iC_DilutionTime_2 == "") {
        dataTOCInput[index].iC_DilutionTime_2 = 0;
      }
      if (dataTOCInput[index].iC_RawData_2 == "") {
        dataTOCInput[index].iC_RawData_2 = 0;
      }
      /* dataTOCInput[index].result_2 =
          ((double.parse(dataTOCInput[index].tC_DilutionTime_2) *
                      double.parse(dataTOCInput[index].tC_RawData_2)) -
                  (double.parse(dataTOCInput[index].iC_DilutionTime_2) *
                      double.parse(dataTOCInput[index].iC_RawData_2)))
              .toStringAsFixed(2); */
      dataTOCInput[index].result_2 =
          (double.parse(dataTOCInput[index].tC_RawData_2) -
                  double.parse(dataTOCInput[index].iC_RawData_2))
              .toStringAsFixed(2);
      dataTOCInput[index].resultUnit_2 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempTOCsave.clear();
    dataTempTOCsave.add(dataTOCInput[index]);
    context.read<ManageDataTOC>().add(TOCEvent.tempSaveTOCData);
  }

  void saveResult(int index) {
    if (dataTOCInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataTOCInput[index].stdMin.toString()}     STD MAX : ${dataTOCInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataTOCInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataTOCInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataTOCInput[index].result_1) >
                          double.parse(dataTOCInput[index].stdMax) ||
                      double.parse(dataTOCInput[index].result_1) <
                          double.parse(dataTOCInput[index].stdMin) ||
                      double.parse(dataTOCInput[index].result_2) >
                          double.parse(dataTOCInput[index].stdMax) ||
                      double.parse(dataTOCInput[index].result_2) <
                          double.parse(dataTOCInput[index].stdMin)) {
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
                  if (double.parse(dataTOCInput[index].result_1) >
                          double.parse(dataTOCInput[index].stdMax) ||
                      double.parse(dataTOCInput[index].result_1) <
                          double.parse(dataTOCInput[index].stdMin)) {
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
            dataTOCsave.clear();
            dataTOCInput[index].userAnalysis = userName;
            dataTOCInput[index].userAnalysisBranch = userBranch;
            dataTOCsave.add(dataTOCInput[index]);
            context.read<ManageDataTOC>().add(TOCEvent.saveTOCData);
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
    return BlocBuilder<ManageDataTOC, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataTOCInput.length;
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
                  headerColumn('TC\nVIAL', 'TC VIAL', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn('TC\nDILUTION', 'TC DILUTION TIMES', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TC RAW\n(ppm)',
                    'TC RAW DATA (ppm)',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('IC\nVIAL', 'IC VIAL', widthC5),
                  DataColumn(label: _verticalDivider),
                  headerColumn('IC\nDILUTION', 'IC DILUTION TIMES', widthC5),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'IC RAW\n(ppm)',
                    'IC RAW DATA (ppm)',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(ppm)',
                    'TC(Raw data)-IC(Raw data)',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'ERROR',
                    'ERROR RESULT',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC16,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC17,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn('TC\nVIAL\n(2)', 'TC VIAL', widthC10),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                      'TC\nDILUTION\n(2)', 'TC DILUTION TIMES', widthC10),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TC RAW\n(ppm)(2)',
                    'TC RAW DATA (ppm)',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('IC \nVIAL\n(2)', 'IC VIAL', widthC12),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                      'IC \nDILUTION\n(2)', 'IC DILUTION TIMES', widthC12),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'IC RAW\n(ppm)(2)',
                    'IC RAW DATA (ppm)',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(ppm)(2)',
                    'TC(Raw data)-IC(Raw data)',
                    //'TC(Dilution x Raw data)-ICTC(Dilution x Raw data)',
                    widthC14,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC15,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC16,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC17,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataTOCInput[index].sampleRemark),
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
                                          dataTOCInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataTOCInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataTOCInput[index].stdMax.toString(),
                                          dataTOCInput[index].stdMin.toString(),
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
                                name: '${index}_3',
                                initialValue:
                                    dataTOCInput[index].tC_Vial_1.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].tC_Vial_1 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue: dataTOCInput[index]
                                    .tC_DilutionTime_1
                                    .toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].tC_DilutionTime_1 =
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
                                name: '${index}_4',
                                initialValue:
                                    dataTOCInput[index].tC_RawData_1.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].tC_RawData_1 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue:
                                    dataTOCInput[index].iC_Vial_1.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].iC_Vial_1 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue: dataTOCInput[index]
                                    .iC_DilutionTime_1
                                    .toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].iC_DilutionTime_1 =
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
                                name: '${index}_6',
                                initialValue:
                                    dataTOCInput[index].iC_RawData_1.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].iC_RawData_1 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                //textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),

                                name: '${index}_7',
                                //enabled: false,
                                key: Key(
                                    dataTOCInput[index].result_1.toString()),
                                initialValue:
                                    dataTOCInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].result_1 =
                                      value.toString();
                                },
                              ),
                              //Text(dataTOCInput[index].result_1),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
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
                                name: '${index}_8',
                                onChanged: (value) {
                                  dataTOCInput[index].result_1 = value;
                                  dataTOCInput[index].resultUnit_1 = "ppm";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue: dataTOCInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].resultRemark_1 =
                                      value.toString();
                                  dataTOCInput[index].resultUnit_1 = "";
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC16,
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
                              width: widthC17,
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
                              width: widthC10,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                initialValue:
                                    dataTOCInput[index].tC_Vial_2.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].tC_Vial_2 =
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
                                name: '${index}_10',
                                initialValue: dataTOCInput[index]
                                    .tC_DilutionTime_2
                                    .toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].tC_DilutionTime_2 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue:
                                    dataTOCInput[index].tC_RawData_2.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].tC_RawData_2 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_11',
                                initialValue:
                                    dataTOCInput[index].iC_Vial_2.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].iC_Vial_2 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_12',
                                initialValue: dataTOCInput[index]
                                    .iC_DilutionTime_2
                                    .toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].iC_DilutionTime_2 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_13',
                                initialValue:
                                    dataTOCInput[index].iC_RawData_2.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].iC_RawData_2 =
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
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                //textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),

                                name: '${index}_14',
                                //enabled: false,
                                key: Key(
                                    dataTOCInput[index].result_2.toString()),
                                initialValue:
                                    dataTOCInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].result_2 =
                                      value.toString();
                                  dataTOCInput[index].resultUnit_2 = "ppm";
                                },
                              ),
                              //Text(dataTOCInput[index].result_1),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC15,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_15',
                                initialValue: dataTOCInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataTOCInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC16,
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
                              width: widthC17,
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

/* 
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/6_TOC/data/6_TOC_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/6_TOC/data/6_TOC_event.dart';
import 'package:tpk_login_arsa_01/page/7ReceiveSamplePage/ReceiveSamplePage.dart';

class Instrument_TOC extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_TOC({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataTOC>(
          create: (BuildContext context) => ManageDataTOC(),
        ),
      ],
      child: TOC(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class TOC extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  TOC({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _TOCState createState() => _TOCState();
}

class _TOCState extends State<TOC> {
  int countData = 0;
  void initState() {
    print("InINITIAL TOC");
    if (widget.headHeight == 0) {
      context.read<ManageDataTOC>().add(TOCEvent.searchTOCForInput);
    } else {
      context.read<ManageDataTOC>().add(TOCEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      if (dataTOCInput[index].tC_DilutionTime_1 == "") {
        dataTOCInput[index].tC_DilutionTime_1 = 0;
      }
      if (dataTOCInput[index].tC_RawData_1 == "") {
        dataTOCInput[index].tC_RawData_1 = 0;
      }
      if (dataTOCInput[index].iC_DilutionTime_1 == "") {
        dataTOCInput[index].iC_DilutionTime_1 = 0;
      }
      if (dataTOCInput[index].iC_RawData_1 == "") {
        dataTOCInput[index].iC_RawData_1 = 0;
      }
      /* dataTOCInput[index].result_1 =
          ((double.parse(dataTOCInput[index].tC_DilutionTime_1) *
                      double.parse(dataTOCInput[index].tC_RawData_1)) -
                  (double.parse(dataTOCInput[index].iC_DilutionTime_1) *
                      double.parse(dataTOCInput[index].iC_RawData_1)))
              .toStringAsFixed(2); */
      dataTOCInput[index].result_1 =
          (double.parse(dataTOCInput[index].tC_RawData_1) -
                  double.parse(dataTOCInput[index].iC_RawData_1))
              .toStringAsFixed(2);
      dataTOCInput[index].resultUnit_1 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      if (dataTOCInput[index].tC_DilutionTime_2 == "") {
        dataTOCInput[index].tC_DilutionTime_2 = 0;
      }
      if (dataTOCInput[index].tC_RawData_2 == "") {
        dataTOCInput[index].tC_RawData_2 = 0;
      }
      if (dataTOCInput[index].iC_DilutionTime_2 == "") {
        dataTOCInput[index].iC_DilutionTime_2 = 0;
      }
      if (dataTOCInput[index].iC_RawData_2 == "") {
        dataTOCInput[index].iC_RawData_2 = 0;
      }
      /* dataTOCInput[index].result_2 =
          ((double.parse(dataTOCInput[index].tC_DilutionTime_2) *
                      double.parse(dataTOCInput[index].tC_RawData_2)) -
                  (double.parse(dataTOCInput[index].iC_DilutionTime_2) *
                      double.parse(dataTOCInput[index].iC_RawData_2)))
              .toStringAsFixed(2); */
      dataTOCInput[index].result_2 =
          (double.parse(dataTOCInput[index].tC_RawData_2) -
                  double.parse(dataTOCInput[index].iC_RawData_2))
              .toStringAsFixed(2);
      dataTOCInput[index].resultUnit_2 = "ppm";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempTOCsave.clear();
    dataTempTOCsave.add(dataTOCInput[index]);
    context.read<ManageDataTOC>().add(TOCEvent.tempSaveTOCData);
  }

  void saveResult(int index) {
    if (dataTOCInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataTOCInput[index].stdMin.toString()}     STD MAX : ${dataTOCInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataTOCInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataTOCInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataTOCInput[index].result_1) >
                          double.parse(dataTOCInput[index].stdMax) ||
                      double.parse(dataTOCInput[index].result_1) <
                          double.parse(dataTOCInput[index].stdMin) ||
                      double.parse(dataTOCInput[index].result_2) >
                          double.parse(dataTOCInput[index].stdMax) ||
                      double.parse(dataTOCInput[index].result_2) <
                          double.parse(dataTOCInput[index].stdMin)) {
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
                  if (double.parse(dataTOCInput[index].result_1) >
                          double.parse(dataTOCInput[index].stdMax) ||
                      double.parse(dataTOCInput[index].result_1) <
                          double.parse(dataTOCInput[index].stdMin)) {
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
            dataTOCsave.clear();
            dataTOCInput[index].userAnalysis = userName;
            dataTOCInput[index].userAnalysisBranch = userBranch;
            dataTOCsave.add(dataTOCInput[index]);
            context.read<ManageDataTOC>().add(TOCEvent.saveTOCData);
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
    return BlocBuilder<ManageDataTOC, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataTOCInput.length;
        } else {
          countData = 0;
        }
        return Form(
            key: _formKey,
            child: Container(
              height: 500,
              width: 500,
              child: ListView.builder(
                  itemCount: dataTOCInput.length,
                  prototypeItem: ListTile(
                    title:
                        Container(height: 50, width: 50, child: Text("Blank")),
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 500,
                      width: 500,
                      child: Row(children: [
                        Container(
                          width: widthC1,
                          height: fieldHeight,
                          child: Text(dataTOCInput[index].sampleRemark),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC2,
                          height: fieldHeight,
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.insights),
                              onPressed: () {
                                setState(() {
                                  showHistory(
                                      dataTOCInput[index].custFull.toString(),
                                      dataTOCInput[index].itemName.toString(),
                                      "TTC",
                                      dataTOCInput[index].stdMax.toString(),
                                      dataTOCInput[index].stdMin.toString(),
                                      context);
                                });
                              },
                            ),
                          ),
                        ),
                        //_verticalDivider2,
                        Container(
                          width: widthC3,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_3',
                            initialValue: dataTOCInput[index]
                                .tC_DilutionTime_1
                                .toString(),
                            onChanged: (value) {
                              dataTOCInput[index].tC_DilutionTime_1 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC4,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_4',
                            initialValue:
                                dataTOCInput[index].tC_RawData_1.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].tC_RawData_1 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC5,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_5',
                            initialValue: dataTOCInput[index]
                                .iC_DilutionTime_1
                                .toString(),
                            onChanged: (value) {
                              dataTOCInput[index].iC_DilutionTime_1 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC6,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.done,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_6',
                            initialValue:
                                dataTOCInput[index].iC_RawData_1.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].iC_RawData_1 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC7,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            //textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            name: '${index}_7',
                            //enabled: false,
                            key: Key(dataTOCInput[index].result_1.toString()),
                            initialValue:
                                dataTOCInput[index].result_1.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].result_1 = value.toString();
                            },
                          ),
                          //Text(dataTOCInput[index].result_1),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC8,
                          height: fieldHeight,
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
                            name: '${index}_8',
                            onChanged: (value) {
                              dataTOCInput[index].result_1 = value;
                              dataTOCInput[index].resultUnit_1 = "ppm";
                              setState(() {});
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC9,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_9',
                            initialValue:
                                dataTOCInput[index].resultRemark_1.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].resultRemark_1 =
                                  value.toString();
                              dataTOCInput[index].resultUnit_1 = "";
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC16,
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
                         _verticalDivider,
                        Container(
                          width: widthC17,
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
                        //_verticalDivider2,
                        Container(
                          width: widthC10,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_10',
                            initialValue: dataTOCInput[index]
                                .tC_DilutionTime_2
                                .toString(),
                            onChanged: (value) {
                              dataTOCInput[index].tC_DilutionTime_2 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate2(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC11,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_11',
                            initialValue:
                                dataTOCInput[index].tC_RawData_2.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].tC_RawData_2 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate2(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC12,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_12',
                            initialValue: dataTOCInput[index]
                                .iC_DilutionTime_2
                                .toString(),
                            onChanged: (value) {
                              dataTOCInput[index].iC_DilutionTime_2 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate2(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC13,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.done,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_13',
                            initialValue:
                                dataTOCInput[index].iC_RawData_2.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].iC_RawData_2 =
                                  value.toString();
                            },
                            onSubmitted: (value) {
                              calculate2(index);
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC14,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            //textInputAction: TextInputAction.next,
                            style: styleDataInTable,
                            decoration: formField(),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            name: '${index}_14',
                            //enabled: false,
                            key: Key(dataTOCInput[index].result_2.toString()),
                            initialValue:
                                dataTOCInput[index].result_2.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].result_2 = value.toString();
                              dataTOCInput[index].resultUnit_2 = "ppm";
                            },
                          ),
                          //Text(dataTOCInput[index].result_1),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC15,
                          height: fieldHeight,
                          child: FormBuilderTextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: styleDataInTable,
                            decoration: formField(),
                            name: '${index}_15',
                            initialValue:
                                dataTOCInput[index].resultRemark_2.toString(),
                            onChanged: (value) {
                              dataTOCInput[index].resultRemark_2 =
                                  value.toString();
                            },
                          ),
                        ),
                         _verticalDivider,
                        Container(
                          width: widthC16,
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
                         _verticalDivider,
                        Container(
                          width: widthC17,
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
                      ]),
                    );
                  }),
            ));
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