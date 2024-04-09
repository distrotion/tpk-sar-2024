import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/SubWidget/KPIItemCountTable/data/KPIItemCountTable_bloc.dart';

class TableKPIItemCount extends StatefulWidget {
  TableKPIItemCount({
    Key? key,
  }) : super(key: key);

  @override
  _TableKPIItemCountState createState() => _TableKPIItemCountState();
}

class _TableKPIItemCountState extends State<TableKPIItemCount> {
  void initState() {
    print("InINITIAL TableKPIItemCount");
    print(dataTableKPIItem.length.toString());
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
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'ALL COUNT',
                'ALL COUNT',
                widthC2,
              ),
              DataColumn(label: _verticalDivider),
              headerColumnRed(
                'OVER DUE ALL',
                'OVER DUE ALL COUNT',
                widthC3,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'MKT BP COUNT',
                'MKT BP ITEM COUNT',
                widthC4,
              ),
              DataColumn(label: _verticalDivider),
              headerColumnRed(
                'MKT BP OVER DUE',
                'MKT BANGPOO OVER DUE COUNT',
                widthC5,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'MKT RY COUNT',
                'MKT RAYONG ITEM COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider),
              headerColumnRed(
                'MKT RY OVER DUE',
                'MKT RAYONG OVER DUE COUNT',
                widthC7,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'CHE COUNT',
                'CHE ITEM COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider),
              headerColumnRed(
                'CHE OVER DUE',
                'CHE OVER DUE COUNT',
                widthC7,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'ENV COUNT',
                'ENV ITEM COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider),
              headerColumnRed(
                'ENV OVER DUE',
                'ENV OVER DUE COUNT',
                widthC7,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumn(
                'PHO COUNT',
                'PHO ITEM COUNT',
                widthC6,
              ),
              DataColumn(label: _verticalDivider),
              headerColumnRed(
                'PHO OVER DUE',
                'PHO OVER DUE COUNT',
                widthC7,
              ),
              DataColumn(label: _verticalDivider2),
              headerColumnRed(
                'ERROR ITEM',
                'INSTRUMENT ERROR COUNT',
                widthC8,
              ),
            ],
            rows: List<DataRow>.generate(
                dataTableKPIItem.length,
                (index) => DataRow(cells: [
                      DataCell(
                        Container(
                            width: widthC1,
                            child: Text(
                              dataTableKPIItem[index].instrumentName.toString(),
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC2,
                            child: Text(
                              dataTableKPIItem[index].allCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC3,
                            child: Text(
                              dataTableKPIItem[index].overDueCount.toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC4,
                            child: Text(
                              dataTableKPIItem[index].bPCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC5,
                            child: Text(
                              dataTableKPIItem[index].bPOverDueCount.toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableKPIItem[index].rYCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC7,
                            child: Text(
                              dataTableKPIItem[index].rYOverDueCount.toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableKPIItem[index].cHECount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC7,
                            child: Text(
                              dataTableKPIItem[index]
                                  .cHEOverDueCount
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableKPIItem[index].eNVCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC7,
                            child: Text(
                              dataTableKPIItem[index]
                                  .eNVOverDueCount
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC6,
                            child: Text(
                              dataTableKPIItem[index].pHOCount.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC7,
                            child: Text(
                              dataTableKPIItem[index]
                                  .pHOOverDueCount
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
                            )),
                      ),
                      DataCell(_verticalDivider2),
                      DataCell(
                        Container(
                            width: widthC8,
                            child: Text(
                              dataTableKPIItem[index]
                                  .instrumentBDCount
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: styleDataInTableRed,
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
