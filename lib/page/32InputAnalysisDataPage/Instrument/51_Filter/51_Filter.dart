import 'dart:convert';
import 'package:image/image.dart' as IMG;
import 'dart:typed_data';
import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPicture/ShowPicture.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/51_Filter/data/51_Filter_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/51_Filter/data/51_Filter_event.dart';

class Instrument_Filter extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_Filter(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataFilter>(
          create: (BuildContext context) => ManageDataFilter(),
        ),
      ],
      child: Filter(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class Filter extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Filter({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int countData = 0;

  void initState() {
    print("InINITIAL Filter");
    if (widget.headHeight == 0) {
      context.read<ManageDataFilter>().add(FilterEvent.searchFilterForInput);
    } else {
      context.read<ManageDataFilter>().add(FilterEvent.dummyHead);
    }
    super.initState();
  }

  chooseImage1(int index) async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      Uint8List? imageByte;
      if (result?.files.first != null) {
        imageByte = result?.files.first.bytes;
        dataFilterInput[index].result_1 = base64.encode(imageByte!);
        dataFilterInput[index].fileName_1 = result?.files.first.name;
      }
      Uint8List? resizedData;
      IMG.Image? img = IMG.decodeImage(imageByte!);
      /* IMG.Image resized = IMG.copyResize(img!, width: 250, height: 250);
      resizedData = IMG.encodeJpg(resized) as Uint8List?; */
      resizedData = IMG.encodeJpg(img!) as Uint8List?;
      dataFilterInput[index].result_1 = base64.encode(resizedData!);
      //print(dataFilterInput[index].result_1);
      //var outputAsUint8List = new Uint8List.fromList(s.codeUnits);
      setState(() {});
    } on Error catch (e) {}
  }

  chooseImage2(int index) async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: false);
      Uint8List? imageByte;
      if (result?.files.first != null) {
        imageByte = result?.files.first.bytes;
        dataFilterInput[index].result_2 = base64.encode(imageByte!);
        dataFilterInput[index].fileName_2 = result?.files.first.name;
      }
      Uint8List? resizedData;
      IMG.Image? img = IMG.decodeImage(imageByte!);
      /* IMG.Image resized = IMG.copyResize(img!, width: 250, height: 250);
      resizedData = IMG.encodeJpg(resized) as Uint8List?; */
      resizedData = IMG.encodeJpg(img!) as Uint8List?;
      dataFilterInput[index].result_2 = base64.encode(resizedData!);
      //print(dataFilterInput[index].result_1);
      //var outputAsUint8List = new Uint8List.fromList(s.codeUnits);
      setState(() {});
    } on Error catch (e) {}
  }

  void showImage(int index, int result) {
    print('inshwimage');
    var outputAsUint8List;
    if (result == 1) {
      /* outputAsUint8List =
          new Uint8List.fromList(dataFilterInput[index].result_1.codeUnits); */
      outputAsUint8List = base64.decode(dataFilterInput[index].result_1);
    }
    if (result == 2) {
      /* outputAsUint8List =
          new Uint8List.fromList(dataFilterInput[index].result_2.codeUnits); */
      outputAsUint8List = base64.decode(dataFilterInput[index].result_2);
    }
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 600,
                  child: outputAsUint8List != null
                      ? Image.memory(outputAsUint8List!,
                          //width: 250, height: 250,
                          fit: BoxFit.cover)
                      : Container(),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  void tempSave(int index) {
    dataTempFiltersave.clear();
    dataTempFiltersave.add(dataFilterInput[index]);
    context.read<ManageDataFilter>().add(FilterEvent.tempSaveFilterData);
  }

  void saveResult(int index) {
    if (dataFilterInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: ((() {
            if (dataFilterInput[index].result_2.toString() != "") {
              try {
                if (double.parse(dataFilterInput[index].result_1) >
                        double.parse(dataFilterInput[index].stdMax) ||
                    double.parse(dataFilterInput[index].result_1) <
                        double.parse(dataFilterInput[index].stdMin) ||
                    double.parse(dataFilterInput[index].result_2) >
                        double.parse(dataFilterInput[index].stdMax) ||
                    double.parse(dataFilterInput[index].result_2) <
                        double.parse(dataFilterInput[index].stdMin)) {
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
                if (double.parse(dataFilterInput[index].result_1) >
                        double.parse(dataFilterInput[index].stdMax) ||
                    double.parse(dataFilterInput[index].result_1) <
                        double.parse(dataFilterInput[index].stdMin)) {
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
            dataFiltersave.clear();
            dataFilterInput[index].userAnalysis = userName;
            dataFilterInput[index].userAnalysisBranch = userBranch;
            dataFiltersave.add(dataFilterInput[index]);
            context.read<ManageDataFilter>().add(FilterEvent.saveFilterData);
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
  double widthC5 = 100;
  double widthC6 = 50;
  double widthC7 = 50;
  double widthC8 = 50;
  double widthC9 = 50;
  double widthC10 = 100;
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
    return BlocBuilder<ManageDataFilter, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataFilterInput.length;
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
                  headerColumn('MAG', 'MAGNIFICATION', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'POS',
                    'POSITION',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT',
                    'RESULT',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'FILENAME',
                    'FILENAME',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn('ERROR', 'ERROR', widthC6),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn('MAG\n(2)', 'MAGNIFICATION', widthC8),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'POS\n(2)',
                    'POSITION',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(2)',
                    'RESULT',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'FILENAME\n(2)',
                    'FILENAME',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC13,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataFilterInput[index].sampleRemark),
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
                                          dataFilterInput[index]
                                              .requestSampleId
                                              .toString(),
                                          dataFilterInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataFilterInput[index]
                                              .stdMax
                                              .toString(),
                                          dataFilterInput[index]
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_3',
                                initialValue: dataFilterInput[index]
                                    .magnification_1
                                    .toString(),
                                onChanged: (value) {
                                  dataFilterInput[index].magnification_1 =
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
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_4',
                                initialValue: dataFilterInput[index]
                                    .position_1
                                    .toString(),
                                onChanged: (value) {
                                  dataFilterInput[index].position_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(Container(
                            width: widthC5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (dataFilterInput[index].result_1.length >
                                        1000 ||
                                    (dataFilterInput[index].result_1)
                                        .contains('pic_'))
                                  Container(
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.image),
                                      onPressed: () {
                                        if ((dataFilterInput[index].result_1)
                                            .contains('pic_')) {
                                          showPicture(
                                              dataFilterInput[index].result_1,
                                              context);
                                        } else {
                                          showImage(index, 1);
                                        }
                                      },
                                    ),
                                  ),
                                if (dataFilterInput[index].result_1.length <
                                        1000 &&
                                    (dataFilterInput[index].result_1)
                                            .contains('pic_') ==
                                        false)
                                  Container(
                                      child: Text(
                                          dataFilterInput[index].result_1)),
                                Container(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.upload),
                                    onPressed: () {
                                      chooseImage1(index);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                enabled: false,
                                key: Key(dataFilterInput[index]
                                    .fileName_1
                                    .toString()),
                                initialValue: dataFilterInput[index]
                                    .fileName_1
                                    .toString(),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC6,
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
                                name: '${index}_6',
                                onChanged: (value) {
                                  dataFilterInput[index].result_1 = value;
                                  setState(() {});
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
                                initialValue: dataFilterInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataFilterInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC12,
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
                              width: widthC13,
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
                              width: widthC8,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_8',
                                initialValue: dataFilterInput[index]
                                    .magnification_2
                                    .toString(),
                                onChanged: (value) {
                                  dataFilterInput[index].magnification_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue: dataFilterInput[index]
                                    .position_2
                                    .toString(),
                                onChanged: (value) {
                                  dataFilterInput[index].position_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(Container(
                            width: widthC10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (dataFilterInput[index].result_2.length >
                                        1000 ||
                                    (dataFilterInput[index].result_2)
                                        .contains('pic_'))
                                  Container(
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.image),
                                      onPressed: () {
                                        if ((dataFilterInput[index].result_2)
                                            .contains('pic_')) {
                                          showPicture(
                                              dataFilterInput[index].result_2,
                                              context);
                                        } else {
                                          showImage(index, 2);
                                        }
                                      },
                                    ),
                                  ),
                                if (dataFilterInput[index].result_2.length <
                                        1000 &&
                                    (dataFilterInput[index].result_2)
                                            .contains('pic_') ==
                                        false)
                                  Container(
                                      width: widthC10 / 2,
                                      child: Text(
                                          dataFilterInput[index].result_2)),
                                Container(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.upload),
                                    onPressed: () {
                                      chooseImage2(index);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_10',
                                enabled: false,
                                key: Key(dataFilterInput[index]
                                    .fileName_2
                                    .toString()),
                                initialValue: dataFilterInput[index]
                                    .fileName_2
                                    .toString(),
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
                                initialValue: dataFilterInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataFilterInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC12,
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
                              width: widthC13,
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
