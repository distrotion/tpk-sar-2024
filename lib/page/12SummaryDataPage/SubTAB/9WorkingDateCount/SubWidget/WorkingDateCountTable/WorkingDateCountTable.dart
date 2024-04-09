import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/9WorkingDateCount/SubWidget/WorkingDateCountTable/data/WorkingDateCountTable_bloc.dart';

class WorkingDateCountTable extends StatefulWidget {
  WorkingDateCountTable({
    Key? key,
  }) : super(key: key);

  @override
  _WorkingDateCountTableState createState() => _WorkingDateCountTableState();
}

class _WorkingDateCountTableState extends State<WorkingDateCountTable> {
  void initState() {
    print("InINITIAL WorkingDateCountTable");
    print(dataTableWorkingDateCount.length.toString());
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
                'REQUEST SECTION',
                'REQUEST SECTION',
                widthC1,
              ),
              DataColumn(label: _verticalDivider),
              headerColumn(
                'ANALYSIS DATE BP',
                'ANALYSIS DATE BP',
                widthC2,
              ),
              DataColumn(label: _verticalDivider),
              headerColumn(
                'ANALYSIS DATE RY',
                'ANALYSIS DATE RY',
                widthC2,
              ), DataColumn(label: _verticalDivider),
              headerColumn(
                'ANALYSIS DATE GW',
                'ANALYSIS DATE GW',
                widthC2,
              ),
            ],
            rows: List<DataRow>.generate(
                dataTableWorkingDateCount.length,
                (index) => DataRow(cells: [
                      DataCell(
                        Container(
                            width: widthC1,
                            child: Text(
                              dataTableWorkingDateCount[index].code.toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC2,
                            child: Text(
                              dataTableWorkingDateCount[index]
                                  .meanDaysBP
                                  .toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC2,
                            child: Text(
                              dataTableWorkingDateCount[index]
                                  .meanDaysRY
                                  .toString(),
                              textAlign: TextAlign.center,
                            )),
                      ),DataCell(_verticalDivider),
                      DataCell(
                        Container(
                            width: widthC2,
                            child: Text(
                              dataTableWorkingDateCount[index]
                                  .meanDaysGW
                                  .toString(),
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
