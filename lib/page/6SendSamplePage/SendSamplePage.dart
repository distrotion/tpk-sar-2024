import 'package:cool_alert/cool_alert.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/6SendSamplePage/Data/SendSamplePageStructure.dart';
import 'package:tpk_login_arsa_01/page/6SendSamplePage/Data/SendSamplePage_event.dart';
import 'Data/SendSamplePage_bloc.dart';
import 'SubWidget/TableSendSample.dart';

late BuildContext contextSendSamplePage;

class SendSamplePage extends StatelessWidget {
  const SendSamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataSendSample>(
          create: (BuildContext context) => ManageDataSendSample(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20),
          child: SendSampleData(),
        ),
      ),
    );
  }
}

class SendSampleData extends StatefulWidget {
  const SendSampleData({Key? key}) : super(key: key);

  @override
  _SendSampleDataState createState() => _SendSampleDataState();
}

class _SendSampleDataState extends State<SendSampleData> {
  void initState() {
    print("InINITIAL");
    super.initState();
    myFocusNode = FocusNode();
  }

  void selectPrint() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          String initialPrint = "";
          if (userSection == "MARKETING") {
            if (userBranch == "BANGPOO") {
              initialPrint = "BPMKT";
            } else {
              initialPrint = "RYMKT";
            }
          } else {
            if (userBranch == "BANGPOO") {
              initialPrint = "BPTTC";
            } else {
              initialPrint = "RYTTC";
            }
          }
          selectedPrinter = initialPrint;
          return AlertDialog(
            title: Text('SELECT PRINTER'),
            content: Container(
              width: 600,
              child: FormBuilderSegmentedControl(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                name: 'printer',
                initialValue: initialPrint,
                options: [
                  FormBuilderFieldOption(
                      value: 'BPMKT',
                      child: Text(
                        'MARKETING BANGPOO',
                        style: styleHeaderTable,
                      )),
                  FormBuilderFieldOption(
                      value: 'RYMKT',
                      child: Text(
                        'MARKETING RAYONG',
                        style: styleHeaderTable,
                      )),
                  FormBuilderFieldOption(
                      value: 'BPTTC',
                      child: Text(
                        'TTC BANGPOO',
                        style: styleHeaderTable,
                      )),
                  FormBuilderFieldOption(
                      value: 'RYTTC',
                      child: Text(
                        'TTC RAYONG',
                        style: styleHeaderTable,
                      )),
                ],
                onChanged: (value) {
                  selectedPrinter = value.toString();
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    sendSample();
                  },
                  child: Text('YES')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('NO'),
              )
            ],
          );
        });
  }

  void addItem(int itemNo) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: selectAddItem(),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      sampleData.add(ModelFullRequestData(
                          reqNo: sampleData[0].reqNo,
                          jobType: sampleData[0].jobType,
                          reqUser: sampleData[0].reqUser,
                          branch: sampleData[0].branch,
                          requestSection: sampleData[0].requestSection,
                          reqDate: sampleData[0].reqDate,
                          custId: sampleData[0].custId,
                          custFull: sampleData[0].custFull,
                          custShort: sampleData[0].custShort,
                          code: sampleData[0].code,
                          incharge: sampleData[0].incharge,
                          requestRound: sampleData[0].requestRound,
                          sampleNo: sampleData[0].sampleNo,
                          sampleStatus: sampleData[0].sampleStatus,
                          groupNameTs: sampleData[0].groupNameTs,
                          sampleGroup: sampleData[0].sampleGroup,
                          sampleType: sampleData[0].sampleType,
                          sampleTank: sampleData[0].sampleTank,
                          sampleName: sampleData[0].sampleName,
                          processReportName: sampleData[0].processReportName,
                          sampleAmount: sampleData[0].sampleAmount,
                          samplingDate: sampleData[0].samplingDate,
                          sampleRemark: sampleData[0].sampleRemark,
                          sampleAttachFile: sampleData[0].sampleAttachFile,
                          //itemNo: (sampleData[sampleData.length-1].itemNo + 1).toString(),
                          instrumentName: sampleData[0].instrumentName,
                          itemName: sampleData[0].itemName,
                          itemStatus: sampleData[0].itemStatus,
                          position: sampleData[0].position,
                          mag: '-',
                          temp: '-',
                          stdFactor: '-',
                          stdMax: '-',
                          stdMin: '-',
                          stdMinL: '-',
                          stdMaxL: '-',
                          std1: '-',
                          std2: '-',
                          std3: '-',
                          std4: '-',
                          std5: '-',
                          std6: '-',
                          std7: '-',
                          std8: '-',
                          std9: '-',
                          reportOrder: 0));

                      sampleData[sampleData.length - 1].instrumentName =
                          selectedItemAdd[0].instrumentName;
                      sampleData[sampleData.length - 1].itemName =
                          selectedItemAdd[0].itemName;
                      sampleData[sampleData.length - 1].itemNo =
                          sampleData.length + 100;
                      sampleData[sampleData.length - 1].temp =
                          selectedItemAdd[0].temp ?? "-";
                      sampleData[sampleData.length - 1].position =
                          selectedItemAdd[0].pos ?? "-";
                      sampleData[sampleData.length - 1].mag =
                          selectedItemAdd[0].mag ?? "-";
                    });
                    Navigator.pop(context);
                  },
                  child: Text('ADD')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('NO'),
              )
            ],
          );
        });
  }

  void manageData() {
    for (int i = 0; i < sampleData.length; i++) {
      sampleData[i].samplingDate = sampleData[0].samplingDate;
      sampleData[i].sampleCode = sampleData[0].sampleCode;
      sampleData[i].remarkSend = sampleData[0].remarkSend;
      sampleData[i].userSend = userName;
      sampleData[i].requestStatus = 'WAIT SAMPLE';
      if (sampleData[i].sampleStatus == 'WAIT SAMPLE') {
        sampleData[i].sampleStatus = 'SEND SAMPLE';
      }
      if (sampleData[i].itemStatus != 'NOT ANALYSIS' &&
          sampleData[i].itemStatus != 'NOT SEND SAMPLE') {
        sampleData[i].itemStatus = 'SEND SAMPLE';
      }
    }
  }

  void sendSample() {
    CoolAlert.show(
      barrierDismissible: false,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'SEND SAMPLE',
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
        for (int i = 0; i < sampleData.length; i++) {}
        context
            .read<ManageDataSendSample>()
            .add(SendSamplePageEvent.clearState);
        context
            .read<ManageDataSendSample>()
            .add(SendSamplePageEvent.sendSample);
        //  Navigator.pop(context);
      },
      onCancelBtnTap: () {
        //  Navigator.pop(context);
      },
    );
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
  bool changeSamDate = false;
  late FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    contextSendSamplePage = context;
    return Form(
      key: _formKey,
      child: BlocBuilder<ManageDataSendSample, int>(builder: (context, state) {
        print("rebuild state :$state");
        if (state >= 0 && state < 9) {
          myFocusNode.requestFocus();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 600,
                  //height: 390,
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: heightBox1,
                          child: Row(
                            children: [
                              Container(
                                width: widthsection1,
                                child: Text(
                                  "SAMPLE CODE",
                                  style: stylesection,
                                ),
                              ),
                              Expanded(
                                child: FormBuilderTextField(
                                    focusNode: myFocusNode,
                                    autofocus: true,
                                    name: "sampleCode",
                                    style: styledata,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: 10,
                                        bottom: heightBox2 / 2,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    initialValue: '',
                                    key: Key(sampleCode.toString()),
                                    enabled: true,
                                    onSubmitted: (value) {
                                      if (value != null) {
                                        sampleCode = value;
                                        _formKey.currentState?.reset();
                                        //myFocusNode.requestFocus();
                                        context
                                            .read<ManageDataSendSample>()
                                            .add(
                                                SendSamplePageEvent.clearState);
                                        context
                                            .read<ManageDataSendSample>()
                                            .add(SendSamplePageEvent
                                                .searchSampleData);
                                        changeSamDate = false;
                                        selectedPrinter = "-";
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                        if (state >= 1) ...[
                          Container(
                              child: Builder(builder: (BuildContext context) {
                            EasyLoading.dismiss();
                            return Container();
                          })),
                          //Container(
                          /*  child:  */ /* Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [ */
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
                                    initialValue:
                                        sampleData[0].sampleAmount.toString(),
                                    name: 'sampleAmount',
                                    enabled: true,
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
                                    child: statusSample(
                                        sampleData[0].sampleStatus)),
                              ],
                            ),
                          ),
                          Container(
                            height: heightBox1,
                            /* decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 0)), */
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
                                    style: styledata,
                                    initialValue:
                                        sampleData[0].sampleRemark ?? "",
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                          bottom: heightBox2 / 2,
                                        ),
                                        border: OutlineInputBorder()),
                                    name: 'sendSampleRemark',
                                    enabled: true,
                                    onChanged: (val) {
                                      sampleData[0].sampleRemark =
                                          val.toString();
                                    },
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
                                    style: styledata,
                                    initialValue:
                                        sampleData[0].remarkSend ?? "",
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                          bottom: heightBox2 / 2,
                                        ),
                                        border: OutlineInputBorder()),
                                    name: 'sendSampleRemark',
                                    enabled: true,
                                    onChanged: (val) {
                                      sampleData[0].remarkSend = val.toString();
                                    },
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
                                  child: FormBuilderDateTimePicker(
                                    style: styledata,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                          bottom: heightBox2 / 2,
                                        ),
                                        border: OutlineInputBorder()),
                                    initialValue: DateTime.parse(
                                        sampleData[0].samplingDate),
                                    inputType: InputType.date,
                                    name: 'samplingDate',
                                    onChanged: (val) {
                                      sampleData[0].samplingDate =
                                          val.toString();
                                      changeSamDate = true;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

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
                                    label: Text('INSTRUMENT',
                                        style: styleHeaderTable),
                                    tooltip: "INSTRUMENT NAME",
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  DataColumn(
                                    label:
                                        Text('ITEM', style: styleHeaderTable),
                                    tooltip: "ITEM NAME",
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  DataColumn(
                                    label: Text('POS', style: styleHeaderTable),
                                    tooltip: "POSITION",
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  DataColumn(
                                    label:
                                        Text('TEMP', style: styleHeaderTable),
                                    tooltip: "TEMPERATURE",
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  DataColumn(
                                    label: Text('MAG', style: styleHeaderTable),
                                    tooltip: "MAGNIFICATION",
                                  ),
                                  DataColumn(label: _verticalDivider),
                                  DataColumn(
                                    label:
                                        Text('STATUS', style: styleHeaderTable),
                                    tooltip: "ITEM STATUS",
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    sampleData.length,
                                    (i) => DataRow(cells: [
                                          DataCell(
                                            Container(
                                              child: Text(
                                                  sampleData[i]
                                                      .itemNo
                                                      .toString(),
                                                  style: styleDataInTable),
                                            ),
                                          ),
                                          DataCell(_verticalDivider),
                                          DataCell(
                                            Container(
                                              child: Text(
                                                  sampleData[i]
                                                      .instrumentName
                                                      .toString(),
                                                  style: styleDataInTable),
                                            ),
                                          ),
                                          DataCell(_verticalDivider),
                                          DataCell(
                                            Container(
                                              child: Text(
                                                  sampleData[i]
                                                      .itemName
                                                      .toString(),
                                                  style: styleDataInTable),
                                            ),
                                          ),
                                          DataCell(_verticalDivider),
                                          DataCell(
                                            Container(
                                              child: Text(
                                                  sampleData[i]
                                                      .position
                                                      .toString(),
                                                  style: styleDataInTable),
                                            ),
                                          ),
                                          DataCell(_verticalDivider),
                                          DataCell(
                                            Container(
                                              child: Text(
                                                  sampleData[i].temp.toString(),
                                                  style: styleDataInTable),
                                            ),
                                          ),
                                          DataCell(_verticalDivider),
                                          DataCell(
                                            Container(
                                              child: Text(
                                                  sampleData[i].mag.toString(),
                                                  style: styleDataInTable),
                                            ),
                                          ),
                                          DataCell(_verticalDivider),
                                          DataCell(
                                            Container(
                                              child: Text(
                                                  sampleData[i]
                                                      .itemStatus
                                                      .toString(),
                                                  style: styleDataInTable),
                                            ),
                                          ),
                                        ]))),
                          ),
                          if (sampleData[0].sampleStatus == "WAIT SAMPLE" ||
                              sampleData[0].sampleStatus ==
                                  "REJECT SAMPLE") ...[
                            Container(
                              height: heightBox1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ADD ITEM ANALYSIS",
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      sampleTypeName =
                                          sampleData[0].sampleType.toString();
                                      addItem(0);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: heightBox1,
                              /* decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue, width: 0)), */
                              child: Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: styledata,
                                      // primary: Colors.blue,
                                      /* padding: EdgeInsets.symmetric(
                                                      horizontal: 50,
                                                      vertical: 20), */
                                    ),
                                    child: Text("SEND SAMPLE"),
                                    onPressed: () {
                                      manageData();
                                      if (changeSamDate) {
                                        selectPrint();
                                      } else {
                                        sendSample();
                                      }
                                      _formKey.currentState?.reset();
                                    }),
                              ),
                            ),
                          ]
                        ],
                      ]
                      /////////////////////////////////////////////////////////////////////////////////////////////////
                      /* ],
                            ), */
                      //)
                      /* ] */
                      ),
                ),
              ),
              if (state >= 2) ...[
                Container(
                  height: 249,
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
                  child: /* Expanded(
                    child:  */
                      TableSendSample(),
                  /* FutureBuilder<int>(
                          future:
                              searchRequestData(), // a previously-obtained Future<String> or null
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == 1) {
                              return TableSendSample();
                            } else {
                              return Center(
                                child: Container(
                                    width: 100,
                                    child: CircularProgressIndicator()),
                              );
                            }
                          }) */
                ),
              ],
            ],
          );
        }
        /* else if (state == 9) {
          print("in 9");
          /* return showAlertDialog(context); */
          return PopupAlert(sTxtHead: "aaaaa",);
        }  */
        else
          return Container();
      }),
    );
  }
}

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);

InputDecoration input() {
  return InputDecoration(
      contentPadding: EdgeInsets.only(left: 10, bottom: 10),
      border: OutlineInputBorder());
}

InputDecoration noInput() {
  return InputDecoration(
      contentPadding: EdgeInsets.all(10.0), border: OutlineInputBorder());
}

class selectAddItem extends StatefulWidget {
  const selectAddItem({Key? key}) : super(key: key);

  @override
  _selectAddItemState createState() => _selectAddItemState();
}

class _selectAddItemState extends State<selectAddItem> {
  void initState() {
    super.initState();
  }

  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  TextStyle styleHeaderTable =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styleDataInTable = TextStyle(fontSize: 12, fontFamily: 'Mitr');

  @override
  Widget build(BuildContext context) {
    selectedItemAdd.clear();
    selectedItemAdd.add(MasterAddItem());
    return FutureBuilder(
        future: searchItemAdd(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: EdgeInsets.all(20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              child: Text("INSTRUMENT | ITEM NAME",
                                  style: stylesection)),
                          Container(
                            child: Expanded(
                              child: CustomSearchableDropDown(
                                primaryColor: Colors.black,
                                menuMode: true,
                                menuHeight: 100,
                                labelStyle: styledata,
                                items: itemtToAdd,
                                label: 'INSTRUMENT|ITEM NAME',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: itemtToAdd.map((item) {
                                  return item.itemSearch;
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    print(value);
                                    print(value.instrumentName);
                                    print(value.itemName);
                                    selectedItemAdd[0].instrumentName =
                                        value.instrumentName;
                                    selectedItemAdd[0].itemName =
                                        value.itemName;
                                  }
                                },
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    width: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              child: Text("POSITION", style: stylesection)),
                          Container(
                            child: Expanded(
                              child: FormBuilderTextField(
                                style: styledata,
                                decoration: input(),
                                name: 'pos',
                                initialValue: '-',
                                onChanged: (value) {
                                  selectedItemAdd[0].pos = value;
                                },
                              ), /* CustomSearchableDropDown(
                                primaryColor: Colors.black,
                                menuMode: true,
                                labelStyle: styledata,
                                items: posToAdd,
                                menuHeight: 100,
                                label: 'POSITION',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: posToAdd.map((item) {
                                  return item['Position'];
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedItemAdd[0].pos = value['Position'];
                                  }
                                },
                              ), */
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    width: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              child: Text("TEMPERATURE", style: stylesection)),
                          Container(
                            child: Expanded(
                              child: FormBuilderTextField(
                                style: styledata,
                                decoration: input(),
                                name: 'temp',
                                initialValue: '-',
                                onChanged: (value) {
                                  selectedItemAdd[0].temp = value;
                                },
                              ), /* CustomSearchableDropDown(
                                primaryColor: Colors.black,
                                menuMode: true,
                                menuHeight: 100,
                                labelStyle: styledata,
                                items: tempToAdd,
                                label: 'TEMPERATURE',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: tempToAdd.map((item) {
                                  return item['Temp'];
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedItemAdd[0].temp = value['Temp'];
                                    print(selectedItemAdd[0].temp);
                                  }
                                },
                              ), */
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    width: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              child:
                                  Text("MAGNIFICATION", style: stylesection)),
                          Container(
                            child: Expanded(
                              child: FormBuilderTextField(
                                style: styledata,
                                decoration: input(),
                                name: 'mag',
                                initialValue: '-',
                                onChanged: (value) {
                                  selectedItemAdd[0].mag = value;
                                },
                              ),
                            ),
                          ),
                        ]),
                  ),
                ]));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
