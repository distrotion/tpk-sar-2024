/* import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/6ItemRecheckCount/SubWidget/ItemRecheckCountTable/data/ItemRecheckCountTable_bloc.dart';

class ItemRecheckCountTable extends StatefulWidget {
  ItemRecheckCountTable({
    Key? key,
  }) : super(key: key);

  @override
  _ItemRecheckCountTableState createState() => _ItemRecheckCountTableState();
}

class _ItemRecheckCountTableState extends State<ItemRecheckCountTable> {
  void initState() {
    print("InINITIAL ItemRecheckCountTable");
    print(dataTableItemRecheck.length.toString());
    super.initState();
  }

  double widthC1 = 150;
  double widthC2 = 150;
  double widthC3 = 65;
  double widthC4 = 150;
  double widthC5 = 65;
  double widthC6 = 150;
  double widthC7 = 65;
  double widthC8 = 65;
  double fieldHeight = 30;

  TextStyle styleDataInTable =
      TextStyle(fontSize: 14, fontFamily: 'Mitr', color: Colors.black);
  TextStyle styleDataInTableRed =
      TextStyle(fontSize: 14, fontFamily: 'Mitr', color: Colors.red);
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
            //headingRowHeight: widget.headHeight,
            headingTextStyle: styleHeaderTable,
            // dataRowHeight: widget.dataHeight,
            dataTextStyle: styleDataInTable,
            columnSpacing: 5,
            horizontalMargin: 10,
            columns: [
              headerColumn(
                'INSTRUMENT NAME',
                'INSTRUMENT NAMET',
                widthC1,
              ),
              DataColumn(label: _verticalDivider),
              headerColumn(
                'ALL COUNT',
                'ALL COUNT',
                widthC2,
              ),
              /* DataColumn(label: _verticalDivider),
              headerColumnRed(
                'OVER DUE ALL',
                'OVER DUE ALL COUNT',
                widthC3,
              ), */
              DataColumn(label: _verticalDivider),
              headerColumn(
                'BP RECHECK COUNT',
                'BP RECHECK COUNT',
                widthC4,
              ),
              /* DataColumn(label: _verticalDivider),
              headerColumnRed(
                'BP OVER DUE',
                'BANGPOO OVER DUE COUNT',
                widthC5,
              ), */
              DataColumn(label: _verticalDivider),
              headerColumn(
                'RY RECHECK COUNT',
                'RAYONG RECHECK COUNT',
                widthC6,
              ),
              /*  DataColumn(label: _verticalDivider),
              headerColumnRed(
                'RY OVER DUE',
                'RAYONG OVER DUE COUNT',
                widthC7,
              ),
              DataColumn(label: _verticalDivider),
              headerColumnRed(
                'ERROR ITEM',
                'INSTRUMENT ERROR COUNT',
                widthC8,
              ), */
            ],
            rows: List<DataRow>.generate(
                dataTableItemRecheck.length,
                (index) => DataRow(cells: [
                      DataCell(
                        Container(
                            width: widthC1,
                            child: Text(
                              dataTableItemRecheck[index]
                                  .instrumentName
                                  .toString(),
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC2,
                            child: Text(
                              dataTableItemRecheck[index].allCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      /* DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC3,
                            child: Text(
                              dataTableItemRecheck[index].overDueCount.toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ), */
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC4,
                            child: Text(
                              dataTableItemRecheck[index].bPCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      /*  DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC5,
                            child: Text(
                              dataTableItemRecheck[index].bPOverDueCount.toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ), */
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableItemRecheck[index].rYCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      /*  DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC7,
                            child: Text(
                              dataTableItemRecheck[index].rYOverDueCount.toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC8,
                            child: Text(
                              dataTableItemRecheck[index]
                                  .instrumentBDCount
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ), */
                    ]))),
      ],
    );
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

headerColumnRed(
  String textIn,
  String tooltipIn,
  double widthData,
) {
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.red);
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
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/6ItemRecheckCount/SubWidget/ItemRecheckCountTable/data/ItemRecheckCountTable_bloc.dart';

class ItemRecheckCountTable extends StatefulWidget {
  ItemRecheckCountTable({
    Key? key,
  }) : super(key: key);

  @override
  _ItemRecheckCountTableState createState() => _ItemRecheckCountTableState();
}

class _ItemRecheckCountTableState extends State<ItemRecheckCountTable> {
  void initState() {
    print("InINITIAL ItemRecheckCountTable");
    print(dataTableItemRecheck.length.toString());
    super.initState();
  }

  double widthC1 = 150;
  double widthC2 = 65;
  double widthC3 = 65;
  double widthC4 = 65;
  double widthC5 = 65;
  double widthC6 = 65;
  double widthC7 = 65;
  double widthC8 = 65;
  double fieldHeight = 30;

  TextStyle styleDataInTable =
      TextStyle(fontSize: 14, fontFamily: 'Mitr', color: Colors.black);
  TextStyle styleDataInTableRed =
      TextStyle(fontSize: 14, fontFamily: 'Mitr', color: Colors.red);
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataTable(
            //headingRowHeight: widget.headHeight,
            headingTextStyle: styleHeaderTable,
            // dataRowHeight: widget.dataHeight,
            dataTextStyle: styleDataInTable,
            columnSpacing: 5,
            horizontalMargin: 10,
            columns: [
              headerColumn(
                'INSTRUMENT NAME',
                'INSTRUMENT NAMET',
                widthC1,
              ),
              DataColumn(label: _verticalDivider),
              headerColumn(
                'BRANCH',
                'BRANCH',
                widthC1,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'ALL COUNT',
                'ALL COUNT',
                widthC2,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'MKT COUNT',
                'MKT RECHECK OUNT',
                widthC4,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'CHE COUNT',
                'CHE RECHECK COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'ENV COUNT',
                'ENV RECHECK COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'PHO COUNT',
                'PHO RECHECK COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'GAS COUNT',
                'GAS RECHECK COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'ISN COUNT',
                'ISN RECHECK COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'KAN COUNT',
                'KAN RECHECK COUNT',
                widthC6,
              ),
            ],
            rows: List<DataRow>.generate(
                dataTableItemRecheck.length,
                (index) => DataRow(cells: [
                      DataCell(
                        Container(
                            width: widthC1,
                            child: Text(
                              dataTableItemRecheck[index]
                                  .instrumentName
                                  .toString(),
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC1,
                            child: Text(
                              dataTableItemRecheck[index].branch.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC2,
                            child: Text(
                              dataTableItemRecheck[index].allCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC4,
                            child: Text(
                              dataTableItemRecheck[index].mKTCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableItemRecheck[index].cHECount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableItemRecheck[index].eNVCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableItemRecheck[index].pHOCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableItemRecheck[index].gASCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableItemRecheck[index].iSNCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableItemRecheck[index].kANCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ]))),
      ],
    );
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

headerColumnRed(
  String textIn,
  String tooltipIn,
  double widthData,
) {
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.red);
  return DataColumn(
    label: Container(
        width: widthData,
        child: Center(
            child: Text(textIn,
                style: styleHeaderTable, textAlign: TextAlign.center))),
    tooltip: tooltipIn,
  );
}
