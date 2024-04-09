import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_ActualLineInput/data/ActualLineData.dart';

// ignore: non_constant_identifier_names
void ActualLineDataPopUp(
    String _reqNo, String _custFull, String _samplingDate) {
  showDialog(
      barrierDismissible: true,
      context: contextBG,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                //width: 600,
                child: ActualLineData(
                  reqNo: _reqNo,
                  custFull: _custFull,
                  samplingDate: _samplingDate,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      });
}

saveResult() {
  CoolAlert.show(
      width: 200,
      context: contextBG,
      type: CoolAlertType.confirm,
      text: (() {
        if (newCreate)
          return "CONFIRM SAVE DATA";
        else
          return "REINPUT DATA WILL CLEAR REPORT DATA";
      }()),
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () {
        for (int i = 0; i < actualLineData.length; i++) {
          actualLineData[i].samplingDate = actualLineData[0].samplingDate;
        }
        //Navigator.pop(contextBG);
        saveActualLineData();
        //Navigator.pop(contextBG);
      });
}

// ignore: must_be_immutable
class ActualLineData extends StatefulWidget {
  String reqNo = "";
  String custFull = "";
  String samplingDate = "";
  ActualLineData({
    required this.reqNo,
    required this.custFull,
    required this.samplingDate,
  });

  @override
  State<StatefulWidget> createState() => ActualLineDataState();
}

class ActualLineDataState extends State<ActualLineData> {
  @override
  void initState() {
    super.initState();
  }

  void editReportName(int indexItem) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('REPORT NAME EDIT'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 500,
                    child: EditReportName(
                      indexItem: indexItem,
                    )),
                Container(
                  //height: 50,
                  child: Center(
                    child: IconButton(
                      tooltip: "SAVE DATA",
                      icon: Icon(
                        Icons.save,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        dataEditReportName.clear();
                        dataEditReportName.add(actualLineData[indexItem]);
                        await submitEditReportName();
                      },
                    ),
                  ),
                )
              ],
            ),
            /* actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              )
            ], */
          );
        });
  }

  void showHistory(String _itemID, String _itemName, String _max, String _min) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            //title: Text('HISTORY DATA'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 600,
                  child: HistoryChart(
                    itemID: _itemID,
                    itemName: _itemName,
                    section: "MKTRAW",
                    max: _max,
                    min: _min,
                  ),
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

  final _formKey = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  TextStyle styleHeaderTable =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: FutureBuilder(
            future: searchActualLineData(
                widget.reqNo, widget.custFull, widget.samplingDate),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                if (snapshot.data != 0) {
                  return Container(
                    height: 500,
                    /*  decoration: BoxDecoration(
                      color: CustomTheme.colorWhite,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: CustomTheme.colorShadowBgStrong,
                            offset: Offset(0, 0),
                            blurRadius: 0,
                            spreadRadius: 0)
                      ],
                    ), */
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: heightBox1,
                            child:
                                Text("ACTUAL LINE INPUT", style: stylesection)),
                        Container(
                          height: heightBox1,
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  child: Text("Sampling Date",
                                      style: stylesection)),
                              Container(
                                width: 100,
                                child: FormBuilderDateTimePicker(
                                  style: styledata,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder()),
                                  initialValue: DateTime.parse(
                                      actualLineData[0].samplingDate),
                                  inputType: InputType.date,
                                  name: 'samplingDate',
                                  onChanged: (value) {
                                    actualLineData[0].samplingDate =
                                        value.toString();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: CustomTheme.colorWhite,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: CustomTheme.colorShadowBgStrong,
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                    spreadRadius: 0)
                              ],
                            ),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                  columnSpacing: 5,
                                  horizontalMargin: 10,
                                  dataRowHeight: heightBox1,
                                  columns: [
                                    DataColumn(
                                      label: Container(
                                        width: 200,
                                        child: Text('PROCESS',
                                            style: styleHeaderTable),
                                      ),
                                      tooltip: "PROCESS",
                                    ),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                      label: Container(
                                        width: 150,
                                        child: Text('ITEM NAME',
                                            style: styleHeaderTable),
                                      ),
                                      tooltip: "ITEM NAME",
                                    ),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                      label: Container(
                                        width: 25,
                                        child: Text('HISTORY',
                                            style: styleHeaderTable),
                                      ),
                                      tooltip: "HISTORY TREND",
                                    ),
                                    /* DataColumn(
                                      label: Container(
                                          width: 50,
                                          child: Text('MIN',
                                              style: styleHeaderTable)),
                                      tooltip: "MIN",
                                    ),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                      label: Container(
                                          width: 50,
                                          child: Text('MAX',
                                              style: styleHeaderTable)),
                                      tooltip: "MAX",
                                    ), */
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                      label: Container(
                                          //width: 50,
                                          child: Text('RANGE',
                                              style: styleHeaderTable)),
                                      tooltip: "CONTROL RANGE",
                                    ),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                      label: Text('RESULT',
                                          style: styleHeaderTable),
                                      tooltip: "RESULT",
                                    ),
                                    DataColumn(label: _verticalDivider),
                                    DataColumn(
                                      label: Text('REPORT',
                                          style: styleHeaderTable),
                                      tooltip: "REPORT ORDER",
                                    ),
                                  ],
                                  rows: List<DataRow>.generate(
                                      dataCount,
                                      (index) => DataRow(cells: [
                                            DataCell(
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                        actualLineData[index]
                                                            .processReportName
                                                            .toString(),
                                                        style:
                                                            styleDataInTable),
                                                  ),
                                                  Container(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      icon: Icon(
                                                        Icons.settings,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        editReportName(index);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            DataCell(_verticalDivider),
                                            DataCell(Container(
                                              width: 150,
                                              child: Text(
                                                  actualLineData[index]
                                                      .itemReportName
                                                      .toString(),
                                                  style: styleDataInTable),
                                            )),
                                            DataCell(_verticalDivider),
                                            DataCell(
                                              //History Data
                                              Center(
                                                child: IconButton(
                                                  icon: Icon(Icons.insights),
                                                  iconSize: 20,
                                                  onPressed: () {
                                                    showHistory(
                                                      actualLineData[index]
                                                          .id
                                                          .toString(),
                                                      actualLineData[index]
                                                          .itemName
                                                          .toString(),
                                                      actualLineData[index]
                                                          .stdMax
                                                          .toString(),
                                                      actualLineData[index]
                                                          .stdMin
                                                          .toString(),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            /* DataCell(Container(
                                              width: 50,
                                              child: Text(
                                                  actualLineData[index]
                                                      .stdMin
                                                      .toString(),
                                                  style: styleDataInTable),
                                            )),
                                            DataCell(_verticalDivider),
                                            DataCell(Container(
                                              width: 50,
                                              child: Text(
                                                  actualLineData[index]
                                                      .stdMax
                                                      .toString(),
                                                  style: styleDataInTable),
                                            )), */
                                            DataCell(_verticalDivider),
                                            DataCell(Container(
                                              width: 100,
                                              child: Text(
                                                  actualLineData[index]
                                                      .controlRange
                                                      .toString(),
                                                  style: styleDataInTable),
                                            )),
                                            DataCell(_verticalDivider),
                                            DataCell(
                                              Container(
                                                width: 100,
                                                child: FormBuilderTextField(
                                                  style: styleDataInTable,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(10.0),
                                                      border:
                                                          OutlineInputBorder()),
                                                  name: 'remark$index',
                                                  initialValue:
                                                      actualLineData[index]
                                                          .result,
                                                  onChanged: (value) {
                                                    actualLineData[index]
                                                            .result =
                                                        value.toString();
                                                  },
                                                ),
                                              ),
                                            ),
                                            DataCell(_verticalDivider),
                                            DataCell(Container(
                                              //width: 100,
                                              child: Text(
                                                  actualLineData[index]
                                                      .reportOrder
                                                      .toString(),
                                                  style: styleDataInTable),
                                            )),
                                          ]))),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: Center(
                            child: IconButton(
                              tooltip: "CREATE REPORT",
                              icon: Icon(
                                Icons.save,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                saveResult();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Text("NO DATA");
                }
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);

class EditReportName extends StatefulWidget {
  int indexItem = 0;
  EditReportName({required this.indexItem, Key? key}) : super(key: key);

  @override
  State<EditReportName> createState() => _EditReportNameState();
}

class _EditReportNameState extends State<EditReportName> {
  final _formKey2 = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  TextStyle styleHeaderTable =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');

  @override
  Widget build(BuildContext context) {
    int indexItem = widget.indexItem;
    return Form(
        key: _formKey2,
        child: Container(
          child: Column(
            children: [
              rowData(
                "PROCESS REPORT NAME",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'reportname',
                      initialValue: actualLineData[indexItem].processReportName,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      enabled: true,
                      onChanged: (val) {
                        actualLineData[indexItem].processReportName =
                            val.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "ITEM REPORT NAME",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'item',
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      initialValue: actualLineData[indexItem].itemReportName,
                      enabled: true,
                      onChanged: (value) {
                        actualLineData[indexItem].itemReportName =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD MIN",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'min',
                      initialValue: actualLineData[indexItem].stdMin,
                      enabled: true,
                      onChanged: (value) {
                        actualLineData[indexItem].stdMin = value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "STD MAX",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'max',
                      initialValue: actualLineData[indexItem].stdMax,
                      enabled: true,
                      onChanged: (value) {
                        actualLineData[indexItem].stdMax = value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "CONTROL RANGE",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'controlRange',
                      initialValue: actualLineData[indexItem].controlRange,
                      enabled: true,
                      onChanged: (value) {
                        actualLineData[indexItem].controlRange =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "REPORT ORDER",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'REPORT ORDER',
                      initialValue:
                          actualLineData[indexItem].reportOrder.toString(),
                      enabled: true,
                      onChanged: (value) {
                        actualLineData[indexItem].reportOrder =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
              rowData(
                "PATTERN REPORT",
                Container(
                  child: Container(
                    width: 150,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder()),
                      name: 'PATTERNREPORT',
                      initialValue:
                          actualLineData[indexItem].patternReport.toString(),
                      enabled: true,
                      onChanged: (value) {
                        actualLineData[indexItem].patternReport =
                            value.toString();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Container rowData(String sectionName, Widget data) {
  double heightBox1 = 25;
  double widthsection1 = 160;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

  return Container(
    //height: heightBox1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: widthsection1,
          child: Text(
            sectionName,
            style: stylesection,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        data,
      ],
    ),
  );
}
