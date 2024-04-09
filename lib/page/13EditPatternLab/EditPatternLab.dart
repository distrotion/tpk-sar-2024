import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/dataTime.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/13EditPatternLab/data/EditPatternLabPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/13EditPatternLab/data/EditPatternLabPge_event.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPicture/ShowPicture.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_ActualLineInput/ActaulLineInput.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_Report/KACReport.dart';
import 'package:url_launcher/url_launcher.dart';

late BuildContext contextRoutineRequestDetail;

class EditPatternLabPage extends StatelessWidget {
  const EditPatternLabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataEditPatternLabPage>(
          create: (BuildContext context) => ManageDataEditPatternLabPage(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 10),
          child: Column(
            children: [
              SampleDetail(),
              //HistoryData(),
            ],
          ),
        ),
      ),
    );
  }
}

class SampleDetail extends StatefulWidget {
  const SampleDetail({Key? key}) : super(key: key);

  @override
  _SampleDetailState createState() => _SampleDetailState();
}

class _SampleDetailState extends State<SampleDetail> {
  void initState() {
    print("InINITIAL");
    super.initState();
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
  bool userCheck = false;

  InputDecoration formField() {
    return InputDecoration(
        contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 3),
        border: OutlineInputBorder(gapPadding: 0));
  }

  DataCell cellData(String data) {
    return DataCell(
      Container(
        child: Text(data, style: styleDataInTable),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    contextRoutineRequestDetail = context;
    return Form(
      key: _formKey,
      child: BlocBuilder<ManageDataEditPatternLabPage, int>(
          builder: (context, state) {
        print("rebuild state :$state");
        if (state >= 0) {
          return Column(
            children: [
              Row(
                children: [
                  Container(child: Text('CUSTOMER NAME')),
                  Container(
                    width: 100,
                    child: FormBuilderTextField(
                      style: styleDataInTable,
                      decoration: formField(),
                      keyboardType: TextInputType.text,
                      maxLines: null,
                      name: 'custName',
                      //enabled: false,
                      key: Key('custName'),
                      onChanged: (value) {
                        custFullSearch = value.toString();
                      },
                    ),
                    //Text(dataPO43Input[index].result_1),
                  ),
                  Container(
                    width: 50,
                    child: IconButton(
                      tooltip: "SEARCH",
                      icon: Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        context.read<ManageDataEditPatternLabPage>().add(
                              EditPatternLabPageEvent.searchPatternData,
                            );
                      },
                    ),
                  ),
                ],
              ),
              if (state == 1)
                Container(
                  /*  width: 500,
                  height: 500, */
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CustomTheme.colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                                color: CustomTheme.colorShadowBgStrong,
                                offset: Offset(0, 0),
                                blurRadius: 0,
                                spreadRadius: 0)
                          ],
                        ),
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 5,
                            horizontalMargin: 10,
                            dataRowHeight: 60,
                            columns: [
                              DataColumn(
                                label: Container(
                                  child: Text('CUSTOMER FULL',
                                      style: styleHeaderTable),
                                ),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Container(
                                  child: Text('CUSTOMER SHORT',
                                      style: styleHeaderTable),
                                ),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('branch', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('code', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('Incharge', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('frequencyRequest',
                                    style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('sampleNo', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('sampleGroup',
                                    style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('sampleType', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Container(
                                  child: Text('sampleTank',
                                      style: styleHeaderTable),
                                ),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('sampleName', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('sampleAmount',
                                    style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('processReportName',
                                    style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('frequency', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('itemNo', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('instrumentName',
                                    style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('itemName', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('itemReportName',
                                    style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('position', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('mag', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('temp', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('stdMinL', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('stdMaxL', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('stdFactor', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std1', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std2', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std3', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std4', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std5', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std6', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std7', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std8', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('std9', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('stdMin', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label:
                                    Text('stdSymbol', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('stdMax', style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('controlRange',
                                    style: styleHeaderTable),
                              ),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                label: Text('reportOrder',
                                    style: styleHeaderTable),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              patternData.length,
                              (indexItem) => DataRow(
                                cells: [
                                  cellData(patternData[indexItem]
                                      .custFull
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .custShort
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].branch.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].code.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .incharge
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .frequencyRequest
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .sampleNo
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .sampleGroup
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .sampleType
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .sampleTank
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .sampleName
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .sampleAmount
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .processReportName
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .frequency
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].itemNo.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .itemName
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .instrumentName
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .itemReportName
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .position
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].mag.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].temp.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .stdMinL
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .stdMaxL
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .stdFactor
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std1.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std2.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std3.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std4.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std5.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std6.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std7.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std8.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].std9.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].stdMin.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .stdSymbol
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(
                                      patternData[indexItem].stdMax.toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .controlRange
                                      .toString()),
                                  DataCell(_verticalDivider),
                                  cellData(patternData[indexItem]
                                      .reportOrder
                                      .toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        } else
          return CircularProgressIndicator();
      }),
    );
  }
}

Container rowData(String sectionName, Widget data) {
  double heightBox1 = 25;
  double widthsection1 = 160;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

  return Container(
    height: heightBox1,
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

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);

class HistoryData extends StatefulWidget {
  const HistoryData({Key? key}) : super(key: key);

  @override
  _HistoryDataState createState() => _HistoryDataState();
}

class _HistoryDataState extends State<HistoryData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: CustomTheme.colorWhite,
        borderRadius: BorderRadius.all(Radius.circular(0)),
        boxShadow: [
          BoxShadow(
              color: CustomTheme.colorShadowBgStrong,
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
      child: Container(), //TableResultApprove(),
    );
  }
}
