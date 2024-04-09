import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';

// ignore: must_be_immutable
class TableMainInputData extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  TableMainInputData(
      {Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _TableMainInputDataState createState() => _TableMainInputDataState();
}

class _TableMainInputDataState extends State<TableMainInputData> {
  void initState() {
    print("InINITIAL TableMainInputData");
    super.initState();
  }

  double widthC1 = 20;
  double widthC2 = 35;
  double widthC3 = 35;
  double widthC4 = 30;
  double widthC5 = 30;
  double widthC6 = 40;
  double widthC7 = 40;
  double widthC8 = 40;
  double widthC9 = 30;
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);
  TextStyle styleDataInTable =
      TextStyle(fontSize: 9, fontFamily: 'Mitr', color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return DataTable(
        headingRowHeight: widget.headHeight,
        headingTextStyle: styleHeaderTable,
        dataRowHeight: widget.dataHeight,
        dataTextStyle: styleDataInTable,
        columnSpacing: 4,
        horizontalMargin: 10,
        columns: [
          DataColumn(
            label: Container(
                width: widthC1,
                child: Center(
                    child: Text('NO',
                        style: styleHeaderTable, textAlign: TextAlign.center))),
            tooltip: "REMARK NO",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC2,
                child:
                    Center(child: Text('CUST', textAlign: TextAlign.center))),
            tooltip: "CUSTOMER NAME",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC3,
                child: Center(child: Text('REQ', textAlign: TextAlign.center))),
            tooltip: "REQUEST TYPE",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC4,
                child:
                    Center(child: Text('SAM.D', textAlign: TextAlign.center))),
            tooltip: "SAMPLING DATE",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC5,
                child:
                    Center(child: Text('REC.D', textAlign: TextAlign.center))),
            tooltip: "RECEIVE DATE",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC5,
                child:
                    Center(child: Text('DUE.D', textAlign: TextAlign.center))),
            tooltip: "DUE DATE",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC6,
                child:
                    Center(child: Text('TYPE', textAlign: TextAlign.center))),
            tooltip: "SAMPLE TYPE #SAMPLE TANK",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC7,
                child:
                    Center(child: Text('NAME', textAlign: TextAlign.center))),
            tooltip: "SAMPLE NAME",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC8,
                child:
                    Center(child: Text('ITEM', textAlign: TextAlign.center))),
            tooltip: "ITEM NAME",
          ),
          DataColumn(label: _verticalDivider),
          DataColumn(
            label: Container(
                width: widthC9,
                child:
                    Center(child: Text('STAUS', textAlign: TextAlign.center))),
            tooltip: "ITEM STATUS",
          ),
          DataColumn(label: _verticalDivider),
        ],
        rows: List<DataRow>.generate(
            mainDataInput.length,
            (index) => DataRow(cells: [
                  DataCell(
                    Container(
                      width: widthC1,
                      child: Center(
                          child: Text(mainDataInput[index].remarkNo.toString(),
                              textAlign: TextAlign.center)),
                    ),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                      width: widthC2,
                      child: Center(
                          child: Text(mainDataInput[index].custShort.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: 'Mitr',
                                  color: Colors.black))),
                    ),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                      width: widthC3,
                      child: Center(
                          child: Text(
                              mainDataInput[index].sampleCode.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: 'Mitr',
                                  color: Colors.black))),
                    ),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                        width: widthC4,
                        child: Center(
                          child: Text(
                              ((() {
                                String buff = "";
                                try {
                                  buff = DateFormat("dd-MM yyyy").format(
                                      DateTime.parse(
                                          mainDataInput[index].samplingDate));
                                } on Exception catch (e) {}
                                return buff;
                              }())),
                              textAlign: TextAlign.center),
                        )),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                        width: widthC5,
                        child: Center(
                          child: Text(
                              ((() {
                                String buff = "";
                                try {
                                  buff = DateFormat("dd-MM yyyy").format(
                                      DateTime.parse(
                                          mainDataInput[index].receiveDate));
                                } on Exception catch (e) {}
                                return buff;
                              }())),
                              textAlign: TextAlign.center),
                        )),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                        width: widthC5,
                        child: Center(
                          child: Text(
                              ((() {
                                String buff = "";
                                try {
                                  buff = DateFormat("dd-MM yyyy").format(
                                      DateTime.parse(mainDataInput[index]
                                          .analysisDueDate));
                                } on Exception catch (e) {}
                                return buff;
                              }())),
                              textAlign: TextAlign.center),
                        )),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(Container(
                    width: widthC6,
                    child: Center(
                      child: Text(
                          mainDataInput[index].sampleType +
                              mainDataInput[index].sampleTank,
                          textAlign: TextAlign.center),
                    ),
                  )),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                      width: widthC7,
                      child: Center(
                          child: Text(
                              mainDataInput[index].sampleName.toString(),
                              textAlign: TextAlign.center)),
                    ),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                      width: widthC8,
                      child: Center(
                          child: Text(mainDataInput[index].itemName.toString(),
                              textAlign: TextAlign.center)),
                    ),
                  ),
                  DataCell(_verticalDivider),
                  DataCell(
                    Container(
                      width: widthC9,
                      child: Center(
                        child: statusItemInstrumentInput(
                            mainDataInput[index].itemStatus.toString(), 9),
                      ),
                    ),
                  ),
                  DataCell(_verticalDivider),
                ])));
  }
}

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);
