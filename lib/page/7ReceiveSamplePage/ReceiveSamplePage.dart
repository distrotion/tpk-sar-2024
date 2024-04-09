import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/dataTime.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/7ReceiveSamplePage/Data/ReceiveSamplePageStructure.dart';
import 'package:tpk_login_arsa_01/page/7ReceiveSamplePage/SubWidget/TableReceiveSample.dart';
import 'Data/ReceiveSamplePage_bloc.dart';
import 'Data/ReceiveSamplePage_event.dart';

late BuildContext contextReceiveSamplePage;

class ReceiveSamplePage extends StatelessWidget {
  const ReceiveSamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataReceiveSample>(
          create: (BuildContext context) => ManageDataReceiveSample(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
          child: ReceiveSampleData(),
        ),
      ),
    );
  }
}

double heightBox1 = 30;
double widthsection1 = 130;
double heightBox2 = 30;
double widthsection2 = 130;
TextStyle stylesection =
    TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');

class ReceiveSampleData extends StatefulWidget {
  const ReceiveSampleData({Key? key}) : super(key: key);

  @override
  _ReceiveSampleDataState createState() => _ReceiveSampleDataState();
}

class _ReceiveSampleDataState extends State<ReceiveSampleData> {
  void initState() {
    print("InINITIAL");
    context
        .read<ManageDataReceiveSample>()
        .add(ReceiveSampleEvent.fetchRequestData);
    super.initState();
    searchBranch.clear();
    searchBranch.add(SearchReceiveSample());
    if (userBranch == "RAYONG") {
      searchBranch[0].rayong = true;
      searchBranch[0].bangpoo = false;
    } else {
      searchBranch[0].rayong = false;
      searchBranch[0].bangpoo = true;
    }
  }

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    contextReceiveSamplePage = context;
    return Form(
      key: _formKey,
      child:
          BlocBuilder<ManageDataReceiveSample, int>(builder: (context, state) {
        print("rebuild state :$state");
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchSampleBar(),
            if (state >= 1) ...[
              Container(
                //width: 1100,
                height: 500,
                decoration: BoxDecoration(
                  color: CustomTheme.colorWhite,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: CustomTheme.colorShadowBgStrong,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                ),
                padding: EdgeInsets.all(0),
                child: TebleReceiveSample(),
              ),
            ],
          ],
        );
      }),
    );
  }
}

class SearchSampleBar extends StatefulWidget {
  const SearchSampleBar({Key? key}) : super(key: key);

  @override
  _SearchSampleBarState createState() => _SearchSampleBarState();
}

TextStyle styleHeaderTable = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontFamily: 'Mitr',
    color: Colors.black);
TextStyle styleDataInTable =
    TextStyle(fontSize: 10, fontFamily: 'Mitr', color: Colors.black);

class _SearchSampleBarState extends State<SearchSampleBar> {
  void sampleDataPopUp() {
    showDialog(
        barrierDismissible: true,
        context: contextBG,
        builder: (context) {
          return AlertDialog(
            content: DataSampleReceive(),
          );
        });
  }

  void initState() {
    myFocusNode = FocusNode();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  late FocusNode myFocusNode;
  @override
  Widget build(BuildContext context) {
    myFocusNode.requestFocus();
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 100,
                    child: Text(
                      "SAMPLE CODE",
                      style: styleHeaderTable,
                    )),
                Container(
                  width: 200,
                  height: 30,
                  child: FormBuilderTextField(
                    focusNode: myFocusNode,
                    autofocus: true,
                    //textInputAction: TextInputAction.next,
                    style: styleDataInTable,
                    decoration: formField(),
                    name: 'sample',
                    key: Key(sampleCode),
                    initialValue: '',
                    onSubmitted: (value) async {
                      sampleCode = value.toString();
                      _formKey.currentState?.reset();

                      int dataStatus = 0;
                      dataStatus = await searchSampleData();
                      print(dataStatus.toString());
                      if (dataStatus == 1) {
                        sampleDataPopUp();
                        myFocusNode.requestFocus();
                        setState(() {});
                      } else {
                        setState(() {
                          myFocusNode.requestFocus();
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    sampleCode = await FlutterBarcodeScanner.scanBarcode(
                        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
                    int data = 0;
                    data = await searchSampleData();
                    if (data == 1) {
                      sampleDataPopUp();
                    }
                  },
                  icon: Icon(Icons.camera),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: FormBuilderCheckbox(
                    title: Text("RAYONG", style: styleHeaderTable),
                    name: 'rayong',
                    initialValue: searchBranch[0].rayong,
                    onChanged: (value) {
                      searchBranch[0].rayong = value;
                    },
                  ),
                ),
                Container(
                  width: 100,
                  child: FormBuilderCheckbox(
                    title: Text("BANGPOO", style: styleHeaderTable),
                    name: 'bangpoo',
                    initialValue: searchBranch[0].bangpoo,
                    onChanged: (value) {
                      searchBranch[0].bangpoo = value;
                    },
                  ),
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
                      context
                          .read<ManageDataReceiveSample>()
                          .add(ReceiveSampleEvent.fetchRequestData);
                    },
                  ),
                ),
                Container(
                  width: 50,
                  child: IconButton(
                    tooltip: "CLEAR",
                    icon: Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        //searchOption = SearchAnalysisModel();
                        _formKey.currentState?.reset();
                      });
                    },
                  ),
                )
              ],
            ),
            Center(
              child: Text("SAMPLE WAIT RECEIVE"),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration formField() {
  return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(gapPadding: 8));
}

class DataSampleReceive extends StatefulWidget {
  const DataSampleReceive({Key? key}) : super(key: key);

  @override
  _DataSampleReceiveState createState() => _DataSampleReceiveState();
}

class _DataSampleReceiveState extends State<DataSampleReceive> {
  void receiveSample() {
    CoolAlert.show(
      barrierDismissible: false,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'RECEIVE SAMPLE',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(sampleData[0].custFull),
          Text(sampleData[0].sampleCode),
        ],
      ),
      onConfirmBtnTap: () {
        contextReceiveSamplePage
            .read<ManageDataReceiveSample>()
            .add(ReceiveSampleEvent.receiveSample);
        contextReceiveSamplePage
            .read<ManageDataReceiveSample>()
            .add(ReceiveSampleEvent.clearState);
        contextReceiveSamplePage
            .read<ManageDataReceiveSample>()
            .add(ReceiveSampleEvent.fetchRequestData);
       // Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //Navigator.pop(context);
      },
    );
  }

  void rejectSample() {
    CoolAlert.show(
      barrierDismissible: false,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'REJECT SAMPLE',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(sampleData[0].custFull),
          Text(sampleData[0].sampleCode),
        ],
      ),
      onConfirmBtnTap: () {
        //Navigator.pop(context);
        contextReceiveSamplePage
            .read<ManageDataReceiveSample>()
            .add(ReceiveSampleEvent.rejectSample);
        _formKey.currentState?.reset();
        contextReceiveSamplePage
            .read<ManageDataReceiveSample>()
            .add(ReceiveSampleEvent.clearState);
        contextReceiveSamplePage
            .read<ManageDataReceiveSample>()
            .add(ReceiveSampleEvent.fetchRequestData);
        Navigator.pop(context);
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
    );
  }

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    dueDate = "3";
    return FutureBuilder(
        future: searchSampleData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != 0) {
            return SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "CUSTOMER NAME",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].custFull,
                          name: 'custName',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE GROUP",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].sampleGroup,
                          name: 'sampleGroup',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  /* decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey, width: 0)), */
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE TYPE",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].sampleType,
                          name: 'sampleType',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE TANK",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].sampleTank,
                          name: 'sampleTank',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE NAME",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].sampleName,
                          name: 'sampleName',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE AMOUNT",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].sampleAmount.toString(),
                          name: 'sampleAmount',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLING DATE",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue:
                              toDateOnly(sampleData[0].samplingDate).toString(),
                          name: 'samplingDate',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE REMARK",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Mitr',
                              color: Colors.red),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].sampleRemark,
                          name: 'sampleremark',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SEND REMARK",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Mitr',
                              color: Colors.red),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: sampleData[0].remarkSend,
                          name: 'semdremark',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE STATUS",
                          style: stylesection,
                        ),
                      ),
                      Container(
                          child: statusSample(sampleData[0].sampleStatus)),
                    ],
                  ),
                ),
                Container(
                  //height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "DUE DATE",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderRadioGroup(
                          options: ['3', '5', '6']
                              .map(
                                  (lang) => FormBuilderFieldOption(value: lang))
                              .toList(growable: false),

                          //style: styledata,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                //bottom: heightBox2 / 2,
                              ),
                              border: InputBorder.none),
                          initialValue: dueDate,
                          name: 'dueDate',
                          //enabled: false,
                          onChanged: (value) {
                            dueDate = value.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightBox1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "REJECT REMARK",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                          style: styledata,
                          initialValue: sampleData[0].remarkReject,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: OutlineInputBorder()),
                          name: 'rejectSampleRemark',
                          enabled: true,
                          onChanged: (val) {
                            rejectSampleRemark = val.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (sampleData[0].sampleStatus == "SEND SAMPLE") ...[
                  SizedBox(height: 10),
                  Container(
                    height: heightBox1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 170,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: styledata,
                                primary: Colors.blue,
                              ),
                              child: Text("RECEIVE SAMPLE"),
                              onPressed: () {
                                receiveSample();
                              }),
                        ),
                        Container(
                          width: 170,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: styledata,
                                primary: Colors.orange,
                              ),
                              child: Text("REJECT SAMPLE"),
                              onPressed: () {
                                rejectSample();
                              }),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
                Container(
                  child: DataTable(
                      columnSpacing: 5,
                      horizontalMargin: 10,
                      dataRowHeight: 60,
                      columns: [
                        DataColumn(
                          label: Text('NO', style: styleHeaderTable),
                          tooltip: "ITEM NO",
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('INSTRUMENT', style: styleHeaderTable),
                          tooltip: "INSTRUMENT NAME",
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('ITEM', style: styleHeaderTable),
                          tooltip: "ITEM NAME",
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('POS', style: styleHeaderTable),
                          tooltip: "POSITION",
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('TEMP', style: styleHeaderTable),
                          tooltip: "TEMPERATURE",
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('MAG', style: styleHeaderTable),
                          tooltip: "MAGNIFICATION",
                        ),
                        DataColumn(label: _verticalDivider),
                        DataColumn(
                          label: Text('STATUS', style: styleHeaderTable),
                          tooltip: "ITEM STATUS",
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          sampleData.length,
                          (i) => DataRow(cells: [
                                DataCell(
                                  Container(
                                    child: Text(sampleData[i].itemNo.toString(),
                                        style: styleDataInTable),
                                  ),
                                ),
                                DataCell(_verticalDivider),
                                DataCell(
                                  Container(
                                    child: Text(
                                        sampleData[i].instrumentName.toString(),
                                        style: styleDataInTable),
                                  ),
                                ),
                                DataCell(_verticalDivider),
                                DataCell(
                                  Container(
                                    child: Text(
                                        sampleData[i].itemName.toString(),
                                        style: styleDataInTable),
                                  ),
                                ),
                                DataCell(_verticalDivider),
                                DataCell(
                                  Container(
                                    child: Text(
                                        sampleData[i].position.toString(),
                                        style: styleDataInTable),
                                  ),
                                ),
                                DataCell(_verticalDivider),
                                DataCell(
                                  Container(
                                    child: Text(sampleData[i].temp.toString(),
                                        style: styleDataInTable),
                                  ),
                                ),
                                DataCell(_verticalDivider),
                                DataCell(
                                  Container(
                                    child: Text(sampleData[i].mag.toString(),
                                        style: styleDataInTable),
                                  ),
                                ),
                                DataCell(_verticalDivider),
                                DataCell(
                                  Container(
                                    child: Text(
                                        sampleData[i].itemStatus.toString(),
                                        style: styleDataInTable),
                                  ),
                                ),
                              ]))),
                ),
              ]),
            );
          } else {
            return Container();
          }
        });
  }
}

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);
