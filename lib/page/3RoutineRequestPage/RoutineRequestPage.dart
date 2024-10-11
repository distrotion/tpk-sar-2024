import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/global/style.dart';
import 'Data/RoutineRequestPageStructure.dart';
import 'Data/RoutineRequestPage_bloc.dart';
import 'Data/RoutineRequestPage_event.dart';

List<MasterAddItem> selectedItemAdd = [];

class RoutineRequestPage extends StatelessWidget {
  const RoutineRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.yellow,
      ),
      child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(left: 50, right: 50, top: 20),
            child: RoutineCreateRequest()),
      ),
    );
  }
}

class RoutineCreateRequest extends StatefulWidget {
  @override
  _RoutineCreateRequestState createState() => _RoutineCreateRequestState();
}

class _RoutineCreateRequestState extends State<RoutineCreateRequest> {
  void initState() {
    print("InINITIAL");
    context
        .read<ManageDataRoutineRequest>()
        .add(EventRoutineRequestPage.fetchMasterCustomerRoutine);
    super.initState();
  }

  void selectPrint() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          String initialPrint = "";
          if (userSection == "MKT") {
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
          routinePrinter = initialPrint;
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
                  routinePrinter = value.toString();
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    context
                        .read<ManageDataRoutineRequest>()
                        .add(EventRoutineRequestPage.createRequest);
                    _dismissDialog();
                  },
                  child: Text('YES')),
              TextButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('NO'),
              )
            ],
          );
        });
  }

  void addItem(int sampleNo) async {
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
                      requestData[sampleNo].add(ModelFullRequestData(
                          jobType: requestData[sampleNo][0].jobType,
                          reqUser: requestData[sampleNo][0].reqUser,
                          branch: requestData[sampleNo][0].branch,
                          requestSection:
                              requestData[sampleNo][0].requestSection,
                          reqDate: requestData[sampleNo][0].reqDate,
                          custId: requestData[sampleNo][0].custId,
                          custFull: requestData[sampleNo][0].custFull,
                          custShort: requestData[sampleNo][0].custShort,
                          code: requestData[sampleNo][0].code,
                          incharge: requestData[sampleNo][0].incharge,
                          requestRound: requestData[sampleNo][0].requestRound,
                          sampleNo: requestData[sampleNo][0].sampleNo,
                          sampleStatus: requestData[sampleNo][0].sampleStatus,
                          groupNameTs: requestData[sampleNo][0].groupNameTs,
                          sampleGroup: requestData[sampleNo][0].sampleGroup,
                          sampleType: requestData[sampleNo][0].sampleType,
                          sampleTank: requestData[sampleNo][0].sampleTank,
                          sampleName: requestData[sampleNo][0].sampleName,
                          processReportName:
                              requestData[sampleNo][0].processReportName,
                          sampleAmount: requestData[sampleNo][0].sampleAmount,
                          samplingDate: requestData[sampleNo][0].samplingDate,
                          sampleRemark: requestData[sampleNo][0].sampleRemark,
                          sampleAttachFile:
                              requestData[sampleNo][0].sampleAttachFile,
                          itemNo: requestData[sampleNo][0].itemNo + 1,
                          instrumentName:
                              requestData[sampleNo][0].instrumentName,
                          itemName: requestData[sampleNo][0].itemName,
                          itemStatus: requestData[sampleNo][0].itemStatus,
                          position: requestData[sampleNo][0].position,
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

                      requestData[sampleNo][requestData[sampleNo].length - 1]
                          .instrumentName = selectedItemAdd[0].instrumentName;
                      requestData[sampleNo][requestData[sampleNo].length - 1]
                          .itemName = selectedItemAdd[0].itemName;
                      //item > 100 = Add item
                      requestData[sampleNo][requestData[sampleNo].length - 1]
                          .itemNo = requestData[sampleNo].length + 100;
                      requestData[sampleNo][requestData[sampleNo].length - 1]
                          .temp = selectedItemAdd[0].temp ?? "-";
                      requestData[sampleNo][requestData[sampleNo].length - 1]
                          .position = selectedItemAdd[0].pos ?? "-";
                      requestData[sampleNo][requestData[sampleNo].length - 1]
                          .mag = selectedItemAdd[0].mag ?? "-";
                    });
                    _dismissDialog();
                  },
                  child: Text('ADD')),
              TextButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('NO'),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  void manageData() {
    for (int i = 0; i < requestData.length; i++) {
      for (int j = 0; j < requestData[i].length; j++) {
        //requestData[i][j].samplingDate = requestData[0][0].samplingDate;
        requestData[i][j].samplingDate = samplingDate;
        requestData[i][j].requestRemark = requestData[0][0].requestRemark;
        requestData[i][j].sampleStatus = requestData[i][0].sampleStatus;
        requestData[i][j].sampleRemark = requestData[i][0].sampleRemark;
        requestData[i][j].itemStatus = requestData[i][0].itemStatus;
        requestData[i][j].sampleName = requestData[i][0].sampleName;
        requestData[i][j].processReportName =
            requestData[i][0].processReportName;
      }
    }
/*     for (int i = 0; i < requestData.length; i++) {
      for (int j = 0; j < requestData[i].length; j++) {
        //requestData[i][j].samplingDate = requestData[0][0].samplingDate;
        requestData[i][j].samplingDate = samplingDate;
        requestData[i][j].requestRemark = requestData[0][0].requestRemark;
        requestData[i][j].sampleStatus = requestData[i][0].sampleStatus;
        requestData[i][j].sampleRemark = requestData[i][0].sampleRemark;
        requestData[i][j].itemStatus = requestData[i][0].itemStatus;
        requestData[i][j].sampleName = requestData[i][0].sampleName;

        if (requestData[i][j].processReportName == "TEST PIECE" ||
            requestData[i][j].processReportName == "WORK PIECE") {
          requestData[i][j].processReportName =
              requestData[i][0].processReportName;
        }
      }
    } */
  }

  void clearData() {
    itemToSearch1.clear();
    itemToSearch2.clear();
    itemToSearch3.clear();
    itemToSearch4.clear();
    itemToSearch5.clear();
    item1 = "";
    item2 = "";
    item3 = "";
    item4 = "";
    item5 = "";
    routineSamplePrint.clear();
  }

  int statusLoadCustomer = 0;
  int selectCustomer = 0;
  int sampleCount = 0;
  int itemCount = 0;
  int request = 0;
  List<MasterInstrument> itemToSearch1 = [];
  List<MasterInstrument> itemToSearch2 = [];
  List<MasterInstrument> itemToSearch3 = [];
  List<MasterInstrument> itemToSearch4 = [];
  List<MasterInstrument> itemToSearch5 = [];
  List<MasterInstrument> addItem1 = [];
  List<MasterInstrument> addItem2 = [];
  List<MasterInstrument> addItem3 = [];
  List<MasterInstrument> addItem4 = [];
  List<MasterInstrument> addItem5 = [];
  String item1 = "", item2 = "", item3 = "", item4 = "", item5 = "";
  double amountSample1 = 1,
      amountSample2 = 1,
      amountSample3 = 1,
      amountSample4 = 1,
      amountSample5 = 1;

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

  final _formKey = GlobalKey<FormBuilderState>();
  int step = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocBuilder<ManageDataRoutineRequest, int>(
          builder: (context, state) {
            step = state;
            if (state > 0) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 15, bottom: 15),
                        width: 600,
                        //height: 280,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
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
                                      child: FormBuilderDateTimePicker(
                                        format: DateFormat("dd-MM-yyyy"),
                                        style: styledata,
                                        decoration: input(),
                                        initialValue: samplingDate,
                                        inputType: InputType.date,
                                        name: 'samplingDate',
                                        onChanged: (value) {
                                          samplingDate = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: widthsection1,
                                          child: Text("CUSTOMER",
                                              style: stylesection)),
                                      Container(
                                        child: Expanded(
                                          child: CustomSearchableDropDown(
                                            primaryColor: Colors.black,
                                            menuMode: true,
                                            //labelStyle: styledata,
                                            labelStyle: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Mitr'),
                                            dropdownItemStyle: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Mitr'),
                                            items: masterCustormerRoutine,
                                            label: 'SELECT CUSTOMER',
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Icon(Icons.search),
                                            ),
                                            dropDownMenuItems:
                                                masterCustormerRoutine
                                                    .map((item) {
                                              return item.custSearch;
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                /*  setState(() { */
                                                routineCusmerName =
                                                    value.custShort.toString();
                                                clearData();
                                                context
                                                    .read<
                                                        ManageDataRoutineRequest>()
                                                    .add(EventRoutineRequestPage
                                                        .reselectCustomer);
                                                context
                                                    .read<
                                                        ManageDataRoutineRequest>()
                                                    .add(EventRoutineRequestPage
                                                        .findCustomerData);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              if (state == 2) ...[
                                /* Container(
                                  height: heightBox1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          decoration: input(),
                                          initialValue:
                                              requestData[0][0].samplingDate,
                                          inputType: InputType.date,
                                          name: 'samplingDate',
                                          onChanged: (value) {
                                            requestData[0][0].samplingDate =
                                                value.toString();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ), */
                                Container(
                                  height: heightBox1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: widthsection1,
                                        child: Text(
                                          "ROUND COUNT",
                                          style: stylesection,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          requestData[0][0].requestRound,
                                          style: styledata,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: heightBox1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: widthsection1,
                                        child: Text(
                                          "ATTACH FILE",
                                          style: stylesection,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 30),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.upload_file,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                          onPressed: () {},
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: widthsection1,
                                        child: Text(
                                          "REMARK",
                                          style: stylesection,
                                        ),
                                      ),
                                      Expanded(
                                        /* 
                                              width: 150,
                                              height: 40, */
                                        child: FormBuilderTextField(
                                          style: styledata,
                                          decoration: input(),
                                          name: 'requestRemark',
                                          onChanged: (value) {
                                            requestData[0][0].requestRemark =
                                                value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: heightBox1,
                                  width: 600,
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
                                        child: Text("SAVE AND PRINT LABEL"),
                                        onPressed: () {
                                          manageData();
                                          selectPrint();
                                          _formKey.currentState?.save();
                                          //manageRequestData();
                                        }),
                                  ),
                                ),
                              ]
                            ]),
                      ),
                    ),
                    SizedBox(height: 10),
                    if (state == 2) ...[
                      Builder(builder: (BuildContext context) {
                        return Container(
                          height: 400,
                          child: SingleChildScrollView(
                            child: Container(
                                width: 600,
                                margin: EdgeInsets.only(top: 15, bottom: 15),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 10,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: requestData.length,
                                  itemBuilder:
                                      (BuildContext context, int indexSample) {
                                    return Container(
                                      width: 600,
                                      padding: EdgeInsets.only(
                                        top: 25,
                                        left: 25,
                                        right: 25,
                                        bottom: 25,
                                      ),
                                      decoration: BoxDecoration(
                                        color: CustomTheme.colorWhite,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: CustomTheme
                                                  .colorShadowBgStrong,
                                              offset: Offset(0, 0),
                                              blurRadius: 10,
                                              spreadRadius: 0)
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "SAMPLE NO ${requestData[indexSample][0].sampleNo.toString()}"),
                                                  rowData(
                                                    "SAMPLE GROUP",
                                                    Container(
                                                      child: Text(
                                                        requestData[indexSample]
                                                                [0]
                                                            .sampleGroup
                                                            .toString(),
                                                        style: styledata,
                                                      ),
                                                    ),
                                                  ),
                                                  rowData(
                                                    "SAMPLE TYPE",
                                                    Container(
                                                      child: Text(
                                                        requestData[indexSample]
                                                                [0]
                                                            .sampleType
                                                            .toString(),
                                                        style: styledata,
                                                      ),
                                                    ),
                                                  ),
                                                  rowData(
                                                    "SAMPLE TANK",
                                                    Container(
                                                      child: Text(
                                                        requestData[indexSample]
                                                                [0]
                                                            .sampleTank
                                                            .toString(),
                                                        style: styledata,
                                                      ),
                                                    ),
                                                  ),
                                                  if (requestData[indexSample]
                                                                  [0]
                                                              .sampleName !=
                                                          "TEST PIECE" &&
                                                      requestData[indexSample]
                                                                  [0]
                                                              .sampleName !=
                                                          "WORK PIECE")
                                                    rowData(
                                                      "SAMPLE NAME",
                                                      Container(
                                                        child: Text(
                                                          requestData[
                                                                  indexSample][0]
                                                              .sampleName
                                                              .toString(),
                                                          style: styledata,
                                                        ),
                                                      ),
                                                    ),
                                                  if (requestData[indexSample]
                                                                  [0]
                                                              .sampleName ==
                                                          "TEST PIECE" ||
                                                      requestData[indexSample]
                                                                  [0]
                                                              .sampleName ==
                                                          "WORK PIECE")
                                                    rowData(
                                                      "SAMPLE NAME",
                                                      Expanded(
                                                        child:
                                                            FormBuilderTextField(
                                                          style:
                                                              styleDataInTable,
                                                          decoration: input(),
                                                          name:
                                                              'samplename$indexSample',
                                                          onChanged: (value) {
                                                            requestData[indexSample]
                                                                        [0]
                                                                    .sampleName =
                                                                value
                                                                    .toString();
                                                            requestData[indexSample]
                                                                        [0]
                                                                    .processReportName =
                                                                value
                                                                    .toString();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  rowData(
                                                    "SAMPLE AMOUNT",
                                                    Container(
                                                      width: 100,
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child:
                                                          FormBuilderTouchSpin(
                                                        name:
                                                            'amount$indexSample',
                                                        textStyle: TextStyle(
                                                            fontSize: 15),
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                            border: InputBorder
                                                                .none),
                                                        min: 1,
                                                        max: 5,
                                                        step: 1,
                                                        iconSize: 13,
                                                        initialValue: requestData[
                                                                indexSample][0]
                                                            .sampleAmount,
                                                        addIcon: Icon(Icons
                                                            .add_circle_outline),
                                                        subtractIcon: Icon(Icons
                                                            .remove_circle_outline),
                                                        iconActiveColor:
                                                            Colors.green,
                                                        iconDisabledColor:
                                                            Colors.grey,
                                                        iconPadding:
                                                            EdgeInsets.only(
                                                                left: 0),
                                                        onChanged: (val) {
                                                          requestData[indexSample]
                                                                      [0]
                                                                  .sampleAmount =
                                                              val;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  rowData(
                                                    "SAMPLE REMARK",
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        style: styleDataInTable,
                                                        decoration: input(),
                                                        name:
                                                            'remark$indexSample',
                                                        onChanged: (value) {
                                                          requestData[indexSample]
                                                                      [0]
                                                                  .sampleRemark =
                                                              value.toString();
                                                          print(requestData[
                                                                  indexSample][0]
                                                              .sampleRemark
                                                              .toString());
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: CustomTheme.colorWhite,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: CustomTheme
                                                        .colorShadowBgStrong,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 0,
                                                    spreadRadius: 0)
                                              ],
                                            ),
                                            child: SingleChildScrollView(
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                  columnSpacing: 5,
                                                  horizontalMargin: 10,
                                                  dataRowHeight: 60,
                                                  columns: [
                                                    DataColumn(
                                                      label: Text('NO',
                                                          style:
                                                              styleHeaderTable),
                                                      tooltip: "ITEM NO",
                                                    ),
                                                    DataColumn(
                                                        label:
                                                            _verticalDivider),
                                                    DataColumn(
                                                      label: Text('INSTRUMENT',
                                                          style:
                                                              styleHeaderTable),
                                                      tooltip:
                                                          "INSTRUMENT NAME",
                                                    ),
                                                    DataColumn(
                                                        label:
                                                            _verticalDivider),
                                                    DataColumn(
                                                      label: Text('ITEM NAME',
                                                          style:
                                                              styleHeaderTable),
                                                      tooltip: "ITEM NAME",
                                                    ),
                                                    DataColumn(
                                                        label:
                                                            _verticalDivider),
                                                    DataColumn(
                                                      label: Text('POS',
                                                          style:
                                                              styleHeaderTable),
                                                      tooltip: "POSITION",
                                                    ),
                                                    DataColumn(
                                                        label:
                                                            _verticalDivider),
                                                    DataColumn(
                                                      label: Text('TEMP',
                                                          style:
                                                              styleHeaderTable),
                                                      tooltip: "TEMPERATURE",
                                                    ),
                                                    DataColumn(
                                                        label:
                                                            _verticalDivider),
                                                    DataColumn(
                                                      label: Text('MAG',
                                                          style:
                                                              styleHeaderTable),
                                                      tooltip: "MAGNIFICATION",
                                                    ),
                                                    DataColumn(
                                                        label:
                                                            _verticalDivider),
                                                    DataColumn(
                                                      label: Text('STATUS',
                                                          style:
                                                              styleHeaderTable),
                                                      tooltip: "ITEM STATUS",
                                                    )
                                                  ],
                                                  rows: List<DataRow>.generate(
                                                      requestData[indexSample]
                                                          .length,
                                                      (indexItem) => DataRow(
                                                              cells: [
                                                                DataCell(
                                                                  Container(
                                                                    child: Text(
                                                                        requestData[indexSample][indexItem]
                                                                            .itemNo
                                                                            .toString(),
                                                                        style:
                                                                            styleDataInTable),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    _verticalDivider),
                                                                DataCell(
                                                                  Container(
                                                                    child: Text(
                                                                        requestData[indexSample][indexItem]
                                                                            .instrumentName
                                                                            .toString(),
                                                                        style:
                                                                            styleDataInTable),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    _verticalDivider),
                                                                DataCell(
                                                                  Container(
                                                                    child: Text(
                                                                        requestData[indexSample][indexItem]
                                                                            .itemName
                                                                            .toString(),
                                                                        style:
                                                                            styleDataInTable),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    _verticalDivider),
                                                                DataCell(
                                                                  Container(
                                                                    child: Text(
                                                                        requestData[indexSample][indexItem]
                                                                            .position
                                                                            .toString(),
                                                                        style:
                                                                            styleDataInTable),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    _verticalDivider),
                                                                DataCell(
                                                                  Container(
                                                                    child: Text(
                                                                        requestData[indexSample][indexItem]
                                                                            .temp
                                                                            .toString(),
                                                                        style:
                                                                            styleDataInTable),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    _verticalDivider),
                                                                DataCell(
                                                                  Container(
                                                                    child: Text(
                                                                        requestData[indexSample][indexItem]
                                                                            .mag
                                                                            .toString(),
                                                                        style:
                                                                            styleDataInTable),
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    _verticalDivider),
                                                                DataCell(
                                                                  Container(
                                                                    child: Text(
                                                                        requestData[indexSample][indexItem]
                                                                            .itemStatus
                                                                            .toString(),
                                                                        style:
                                                                            styleDataInTable),
                                                                  ),
                                                                ),
                                                              ]))),
                                            ),
                                          ),
                                          Center(
                                            child: rowData(
                                              "ADD ITEM ANALYSIS",
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add_circle,
                                                  size: 20,
                                                  color: Colors.green,
                                                ),
                                                onPressed: () {
                                                  sampleTypeName =
                                                      requestData[indexSample]
                                                              [0]
                                                          .sampleType
                                                          .toString();
                                                  addItem(indexSample);
                                                },
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 400,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 25),
                                                  Expanded(
                                                    child: FormBuilderCheckbox(
                                                      // Core attributes
                                                      activeColor: Colors.green,
                                                      name:
                                                          'samplesend$indexSample',
                                                      initialValue: requestData[
                                                              indexSample][0]
                                                          .selected,
                                                      title: Text('SEND'),
                                                      onChanged: (value) {
                                                        if (value == true) {
                                                          requestData[indexSample]
                                                                      [0]
                                                                  .sampleStatus =
                                                              "WAIT SAMPLE";
                                                        } else {
                                                          requestData[indexSample]
                                                                      [0]
                                                                  .sampleStatus =
                                                              "NOT SEND SAMPLE";
                                                          requestData[indexSample]
                                                                      [0]
                                                                  .itemStatus =
                                                              "NOT SEND SAMPLE";
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 25),
                                                  Expanded(
                                                    child: FormBuilderCheckbox(
                                                      activeColor: Colors.green,
                                                      // Core attributes
                                                      name: 'print$indexSample',
                                                      initialValue: requestData[
                                                              indexSample][0]
                                                          .selected,
                                                      title: Text('PRINT'),
                                                      onChanged: (value) {
                                                        if (value == true) {
                                                          routineSamplePrint[
                                                              indexSample] = 1;
                                                        } else {
                                                          routineSamplePrint[
                                                              indexSample] = 0;
                                                        }
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )),
                          ),
                        );
                      }),
                    ]
                  ]);
            } else {
              return Container();
            }
          },
        ));
  }
}

Container rowData(String sectionName, Widget data) {
  double heightBox1 = 30;
  double widthsection1 = 150;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

  return Container(
    height: heightBox1,
    width: 400,
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
                              child:
                                  Text("INSTRU | ITEM", style: stylesection)),
                          Container(
                            child: Expanded(
                              child: CustomSearchableDropDown(
                                primaryColor: Colors.black,
                                menuMode: true,
                                menuHeight: 100,
                                labelStyle: styledata,
                                items: itemtToAdd,
                                label: 'INSTRUMENT | ITEM NAME',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: itemtToAdd.map((item) {
                                  return item.itemSearch;
                                }).toList(),
                                onChanged: (value) {
                                  print('instrument' + value.instrumentName);
                                  if (value != null) {
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
