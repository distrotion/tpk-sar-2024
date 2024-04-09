import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/31_FlashPoint_WAX/data/31_FlashPoint_WAX_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/31_FlashPoint_WAX/data/31_FlashPoint_WAX_bloc.dart';

class Instrument_FlashPoint_WAX extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_FlashPoint_WAX({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataFlashPoint_WAX>(
          create: (BuildContext context) => ManageDataFlashPoint_WAX(),
        ),
      ],
      child: FlashPoint_WAX(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class FlashPoint_WAX extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  FlashPoint_WAX({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _FlashPoint_WAXState createState() => _FlashPoint_WAXState();
}

class _FlashPoint_WAXState extends State<FlashPoint_WAX> {
  int countData = 0;
  void initState() {
    print("InINITIAL FlashPoint_WAX");
    if (widget.headHeight == 0) {
      context.read<ManageDataFlashPoint_WAX>().add(FlashPoint_WAXEvent.searchFlashPoint_WAXForInput);
    } else {
      context.read<ManageDataFlashPoint_WAX>().add(FlashPoint_WAXEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    try {
      dataFlashPoint_WAXInput[index].resultUnit_1 = "°C";
    } on Exception catch (e) {
      // TODO
    }
  }

  void calculate2(int index) {
    try {
      dataFlashPoint_WAXInput[index].resultUnit_2 = "°C";
      setState(() {});
    } on Exception catch (e) {
      // TODO
    }
  }

  void tempSave(int index) {
    dataTempFlashPoint_WAXsave.clear();
    dataTempFlashPoint_WAXsave.add(dataFlashPoint_WAXInput[index]);
    context.read<ManageDataFlashPoint_WAX>().add(FlashPoint_WAXEvent.tempSaveFlashPoint_WAXData);
  }

  void saveResult(int index) {
    if (dataFlashPoint_WAXInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(
            children: [
              Text(
                  'STD MIN : ${dataFlashPoint_WAXInput[index].stdMin.toString()}     STD MAX : ${dataFlashPoint_WAXInput[index].stdMax.toString()}'),
              Text('RESULT : ${dataFlashPoint_WAXInput[index].result_1.toString()}'),
              SizedBox(
                height: 10,
              ),((() {
            if (dataFlashPoint_WAXInput[index].result_2.toString() != "") {
              try {
                if (double.parse(dataFlashPoint_WAXInput[index].result_1) >
                        double.parse(dataFlashPoint_WAXInput[index].stdMax) ||
                    double.parse(dataFlashPoint_WAXInput[index].result_1) <
                        double.parse(dataFlashPoint_WAXInput[index].stdMin) ||
                    double.parse(dataFlashPoint_WAXInput[index].result_2) >
                        double.parse(dataFlashPoint_WAXInput[index].stdMax) ||
                    double.parse(dataFlashPoint_WAXInput[index].result_2) <
                        double.parse(dataFlashPoint_WAXInput[index].stdMin)) {
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
                if (double.parse(dataFlashPoint_WAXInput[index].result_1) >
                        double.parse(dataFlashPoint_WAXInput[index].stdMax) ||
                    double.parse(dataFlashPoint_WAXInput[index].result_1) <
                        double.parse(dataFlashPoint_WAXInput[index].stdMin)) {
                  return Text('RESULT OUT OF RANGE',
                      style: TextStyle(color: Colors.red));
                } else
                  return Text('CONFIRM SAVE RESULT');
              } on Exception catch (e) {
                return Text('CONFIRM SAVE RESULT');
              }
            }
          }()))]),
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: () {
            dataFlashPoint_WAXsave.clear();
            dataFlashPoint_WAXInput[index].userAnalysis = userName;
            dataFlashPoint_WAXInput[index].userAnalysisBranch = userBranch;
            dataFlashPoint_WAXsave.add(dataFlashPoint_WAXInput[index]);
            context.read<ManageDataFlashPoint_WAX>().add(FlashPoint_WAXEvent.saveFlashPoint_WAXData);
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
    return BlocBuilder<ManageDataFlashPoint_WAX, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataFlashPoint_WAXInput.length;
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
                  /* headerColumn(
                    'Temperature\n(°C)',
                    'Temperature (°C)',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'RESULT(°C)',
                    'RESULT',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC5),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC6,
                  ),DataColumn(label: _verticalDivider),
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
                  DataColumn(label: _verticalDivider2),
                  /* headerColumn(
                    'Temperature\n(°C)(2)',
                    'Temperature (°C)',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider), */
                  headerColumn(
                    'RESULT(°C)\n(2)',
                    'RESULT',
                    widthC8,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC9,
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
                              child: Text(dataFlashPoint_WAXInput[index].sampleRemark),
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
                                          dataFlashPoint_WAXInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataFlashPoint_WAXInput[index]
                                              .itemName
                                              .toString(),"TTC",
                                          dataFlashPoint_WAXInput[index].stdMax.toString(),
                                          dataFlashPoint_WAXInput[index].stdMin.toString(),
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
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_3',
                                key: Key(dataFlashPoint_WAXInput[index]
                                    .tempareture_1
                                    .toString()),
                                initialValue:
                                    dataFlashPoint_WAXInput[index].tempareture_1.toString(),
                                onChanged: (value) {
                                  dataFlashPoint_WAXInput[index].tempareture_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC4,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_4',
                                key:
                                    Key(dataFlashPoint_WAXInput[index].result_1.toString()),
                                initialValue:
                                    dataFlashPoint_WAXInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataFlashPoint_WAXInput[index].result_1 =
                                      value.toString();
                                      dataFlashPoint_WAXInput[index].resultUnit_1 = "C";
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
                                  dataFlashPoint_WAXInput[index].result_1 = value;
                                  dataFlashPoint_WAXInput[index].resultUnit_1 = "";
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
                                initialValue: dataFlashPoint_WAXInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataFlashPoint_WAXInput[index].resultRemark_1 =
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
                          /* DataCell(
                            Container(
                              width: widthC7,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_7',
                                key: Key(dataFlashPoint_WAXInput[index]
                                    .tempareture_2
                                    .toString()),
                                initialValue:
                                    dataFlashPoint_WAXInput[index].tempareture_2.toString(),
                                onChanged: (value) {
                                  dataFlashPoint_WAXInput[index].tempareture_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider), */
                          DataCell(
                            Container(
                              width: widthC8,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                
                                name: '${index}_8',
                                key:
                                    Key(dataFlashPoint_WAXInput[index].result_2.toString()),
                                initialValue:
                                    dataFlashPoint_WAXInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataFlashPoint_WAXInput[index].result_2 =
                                      value.toString();
                                      dataFlashPoint_WAXInput[index].resultUnit_2 = "C";
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
                                initialValue: dataFlashPoint_WAXInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataFlashPoint_WAXInput[index].resultRemark_2 =
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
