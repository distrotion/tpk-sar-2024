/* import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/global_var.dart';

import 'Data/RoutineRequestPageStructure.dart';

class RoutineCreteRequestPage extends StatelessWidget {
  
  const RoutineCreteRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50, top: 50),
      child: Column(
        children: [
          RoutineCreateRequest(),
        ],
      ),
    );
  }
}

class RoutineCreateRequest extends StatefulWidget {
  @override
  _RoutineCreateRequestState createState() => _RoutineCreateRequestState();
}

List<MasterInstrument> instrumentData = [];

class _RoutineCreateRequestState extends State<RoutineCreateRequest> {

  void initialRoutineRequestData() {
    for (int i = 0; i < 5; i++) {
      requestData.add(ModelRountineDataSQL(
          jobType: "ROUTINE",
          reqUser: userName,
          requestSection: section,
          requestStatus: "WAIT SAMPLE"));
    }
  }

  void initialRoutineSampletData() {
    for (int i = 0; i < 120; i++) {
      sampleData.add(ModelSampleDataSQL(
          jobType: "ROUTINE", reqUser: userName, requestSection: section));
    }
  }

  void initState() {
    initialRoutineRequestData();
    initialRoutineSampletData();
    super.initState();
  }

  void createGroupItem() {
    for (int i = 0; i < instrumentData.length; i++) {
      if (sampleCount > 0) {
        if (requestData[0].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch1.add(MasterInstrument(
              instrument: instrumentData[i].instrument,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 1) {
        if (requestData[1].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch2.add(MasterInstrument(
              instrument: instrumentData[i].instrument,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 2) {
        if (requestData[2].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch3.add(MasterInstrument(
              instrument: instrumentData[i].instrument,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 3) {
        if (requestData[3].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch4.add(MasterInstrument(
              instrument: instrumentData[i].instrument,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 4) {
        if (requestData[4].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch5.add(MasterInstrument(
              instrument: instrumentData[i].instrument,
              itemName: instrumentData[i].itemName));
        }
      }
    }
  }

  void manageRequestData() {
    final formData = _formKey.currentState?.value;
    //print(DateFormat("yyyy-MM-dd").format(formData['samplingDate']));
    for (int i = 0; i < sampleCount; i++) {
      requestData[i].reqDate =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      requestData[i].samplingDate =
          DateFormat("yyyy-MM-dd").format(formData['samplingDate']);
      requestData[i].requestRemark = formData['requestRemark'];
      requestData[i].requestAttachFile = "";
    }
    if (sampleCount > 0) {
      if (formData['sampleStatus${1}'] == true) {
        requestData[0].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[0].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 1) {
      if (formData['sampleStatus2'] == true) {
        requestData[1].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[1].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 2) {
      if (formData['sampleStatus3'] == true) {
        requestData[2].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[2].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 3) {
      if (formData['sampleStatus4'] == true) {
        requestData[3].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[3].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 4) {
      if (formData['sampleStatus5'] == true) {
        requestData[4].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[4].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    //print(routineDataSQLToJson(requestData));
    int countItem1 = 0;
    int endItem1 = 0;
    int countItem2 = 0;
    int endItem2 = 0;
    int countItem3 = 0;
    int endItem3 = 0;
    int countItem4 = 0;
    int endItem4 = 0;
    int countItem5 = 0;
    int endItem5 = 0;
    for (int i = 0; i < itemCount; i++) {
      sampleData[i].reqDate =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      sampleData[i].samplingDate =
          DateFormat("yyyy-MM-dd").format(formData['samplingDate']);
      if (sampleData[i].sampleNo == 1) {
        sampleData[i].sampleRemark = formData['sampleRemark1'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus1'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        countItem1 = sampleData[i].itemNo;
        endItem1 = i;
      }
      if (sampleData[i].sampleNo == 2) {
        sampleData[i].sampleRemark = formData['sampleRemark2'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus2'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        countItem2 = sampleData[i].itemNo;
        endItem2 = i;
      }
      if (sampleData[i].sampleNo == 3) {
        sampleData[i].sampleRemark = formData['sampleRemark3'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus3'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        countItem3 = sampleData[i].itemNo;
        endItem3 = i;
      }
      if (sampleData[i].sampleNo == 4) {
        sampleData[i].sampleRemark = formData['sampleRemark4'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus4'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        countItem4 = sampleData[i].itemNo;
        endItem4 = i;
      }
      if (sampleData[i].sampleNo == 5) {
        sampleData[i].sampleRemark = formData['sampleRemark5'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus5'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        countItem5 = sampleData[i].itemNo;
        endItem5 = i;
      }
    }
    //var bufferList = List.from(sampleData);
    if (addItem5.length > 0) {
      for (int i = 0; i < addItem5.length; i++) {
        sampleData.add(ModelSampleDataSQL(
            jobType: sampleData[endItem5].jobType,
            reqUser: sampleData[endItem5].reqUser,
            branch: sampleData[endItem5].branch,
            requestSection: sampleData[endItem5].requestSection,
            reqDate: sampleData[endItem5].reqDate,
            custId: sampleData[endItem5].custId,
            custFull: sampleData[endItem5].custFull,
            custShort: sampleData[endItem5].custShort,
            code: sampleData[endItem5].code,
            incharge: sampleData[endItem5].incharge,
            requestRound: sampleData[endItem5].requestRound,
            sampleNo: sampleData[endItem5].sampleNo,
            sampleStatus: sampleData[endItem5].sampleStatus,
            groupNameTs: sampleData[endItem5].groupNameTs,
            sampleGroup: sampleData[endItem5].sampleGroup,
            sampleType: sampleData[endItem5].sampleType,
            sampleTank: sampleData[endItem5].sampleTank,
            sampleName: sampleData[endItem5].sampleName,
            sampleAmount: sampleData[endItem5].sampleAmount,
            samplingDate: sampleData[endItem5].samplingDate,
            sampleRemark: sampleData[endItem5].sampleRemark,
            sampleAttachFile: sampleData[endItem5].sampleAttachFile,
            itemNo: countItem5 + 1 + i,
            instrument: addItem5[i].instrument,
            itemName: addItem5[i].itemName,
            itemStatus: sampleData[endItem5].itemStatus,
            position: sampleData[endItem5].position,
            mag: sampleData[endItem5].mag,
            temp: sampleData[endItem5].temp,
            stdFactor: sampleData[endItem5].stdFactor,
            stdMax: sampleData[endItem5].stdMax,
            stdMin: sampleData[endItem5].stdMin));
      }
    }
    if (addItem4.length > 0) {
      for (int i = 0; i < addItem4.length; i++) {
        sampleData.insert(
            endItem4 + i + 1,
            ModelSampleDataSQL(
                jobType: sampleData[endItem4].jobType,
                reqUser: sampleData[endItem4].reqUser,
                branch: sampleData[endItem4].branch,
                requestSection: sampleData[endItem4].requestSection,
                reqDate: sampleData[endItem4].reqDate,
                custId: sampleData[endItem4].custId,
                custFull: sampleData[endItem4].custFull,
                custShort: sampleData[endItem4].custShort,
                code: sampleData[endItem4].code,
                incharge: sampleData[endItem4].incharge,
                requestRound: sampleData[endItem4].requestRound,
                sampleNo: sampleData[endItem4].sampleNo,
                sampleStatus: sampleData[endItem4].sampleStatus,
                groupNameTs: sampleData[endItem4].groupNameTs,
                sampleGroup: sampleData[endItem4].sampleGroup,
                sampleType: sampleData[endItem4].sampleType,
                sampleTank: sampleData[endItem4].sampleTank,
                sampleName: sampleData[endItem4].sampleName,
                sampleAmount: sampleData[endItem4].sampleAmount,
                samplingDate: sampleData[endItem4].samplingDate,
                sampleRemark: sampleData[endItem4].sampleRemark,
                sampleAttachFile: sampleData[endItem4].sampleAttachFile,
                itemNo: countItem4 + 1 + i,
                instrument: addItem4[i].instrument,
                itemName: addItem4[i].itemName,
                itemStatus: sampleData[endItem4].itemStatus,
                position: sampleData[endItem4].position,
                mag: sampleData[endItem4].mag,
                temp: sampleData[endItem4].temp,
                stdFactor: sampleData[endItem4].stdFactor,
                stdMax: sampleData[endItem4].stdMax,
                stdMin: sampleData[endItem4].stdMin));
      }
    }
    if (addItem3.length > 0) {
      for (int i = 0; i < addItem3.length; i++) {
        sampleData.insert(
            endItem3 + i + 1,
            ModelSampleDataSQL(
                jobType: sampleData[endItem3].jobType,
                reqUser: sampleData[endItem3].reqUser,
                branch: sampleData[endItem3].branch,
                requestSection: sampleData[endItem3].requestSection,
                reqDate: sampleData[endItem3].reqDate,
                custId: sampleData[endItem3].custId,
                custFull: sampleData[endItem3].custFull,
                custShort: sampleData[endItem3].custShort,
                code: sampleData[endItem3].code,
                incharge: sampleData[endItem3].incharge,
                requestRound: sampleData[endItem3].requestRound,
                sampleNo: sampleData[endItem3].sampleNo,
                sampleStatus: sampleData[endItem3].sampleStatus,
                groupNameTs: sampleData[endItem3].groupNameTs,
                sampleGroup: sampleData[endItem3].sampleGroup,
                sampleType: sampleData[endItem3].sampleType,
                sampleTank: sampleData[endItem3].sampleTank,
                sampleName: sampleData[endItem3].sampleName,
                sampleAmount: sampleData[endItem3].sampleAmount,
                samplingDate: sampleData[endItem3].samplingDate,
                sampleRemark: sampleData[endItem3].sampleRemark,
                sampleAttachFile: sampleData[endItem3].sampleAttachFile,
                itemNo: countItem3 + 1 + i,
                instrument: addItem3[i].instrument,
                itemName: addItem3[i].itemName,
                itemStatus: sampleData[endItem3].itemStatus,
                position: sampleData[endItem3].position,
                mag: sampleData[endItem3].mag,
                temp: sampleData[endItem3].temp,
                stdFactor: sampleData[endItem3].stdFactor,
                stdMax: sampleData[endItem3].stdMax,
                stdMin: sampleData[endItem3].stdMin));
      }
    }
    if (addItem2.length > 0) {
      for (int i = 0; i < addItem2.length; i++) {
        sampleData.insert(
            endItem2 + i + 1,
            ModelSampleDataSQL(
                jobType: sampleData[endItem2].jobType,
                reqUser: sampleData[endItem2].reqUser,
                branch: sampleData[endItem2].branch,
                requestSection: sampleData[endItem2].requestSection,
                reqDate: sampleData[endItem2].reqDate,
                custId: sampleData[endItem2].custId,
                custFull: sampleData[endItem2].custFull,
                custShort: sampleData[endItem2].custShort,
                code: sampleData[endItem2].code,
                incharge: sampleData[endItem2].incharge,
                requestRound: sampleData[endItem2].requestRound,
                sampleNo: sampleData[endItem2].sampleNo,
                sampleStatus: sampleData[endItem2].sampleStatus,
                groupNameTs: sampleData[endItem2].groupNameTs,
                sampleGroup: sampleData[endItem2].sampleGroup,
                sampleType: sampleData[endItem2].sampleType,
                sampleTank: sampleData[endItem2].sampleTank,
                sampleName: sampleData[endItem2].sampleName,
                sampleAmount: sampleData[endItem2].sampleAmount,
                samplingDate: sampleData[endItem2].samplingDate,
                sampleRemark: sampleData[endItem2].sampleRemark,
                sampleAttachFile: sampleData[endItem2].sampleAttachFile,
                itemNo: countItem2 + 1 + i,
                instrument: addItem2[i].instrument,
                itemName: addItem2[i].itemName,
                itemStatus: sampleData[endItem2].itemStatus,
                position: sampleData[endItem2].position,
                mag: sampleData[endItem2].mag,
                temp: sampleData[endItem2].temp,
                stdFactor: sampleData[endItem2].stdFactor,
                stdMax: sampleData[endItem2].stdMax,
                stdMin: sampleData[endItem2].stdMin));
      }
    }
    if (addItem1.length > 0) {
      for (int i = 0; i < addItem1.length; i++) {
        sampleData.insert(
            endItem1 + i + 1,
            ModelSampleDataSQL(
                jobType: sampleData[endItem1].jobType,
                reqUser: sampleData[endItem1].reqUser,
                branch: sampleData[endItem1].branch,
                requestSection: sampleData[endItem1].requestSection,
                reqDate: sampleData[endItem1].reqDate,
                custId: sampleData[endItem1].custId,
                custFull: sampleData[endItem1].custFull,
                custShort: sampleData[endItem1].custShort,
                code: sampleData[endItem1].code,
                incharge: sampleData[endItem1].incharge,
                requestRound: sampleData[endItem1].requestRound,
                sampleNo: sampleData[endItem1].sampleNo,
                sampleStatus: sampleData[endItem1].sampleStatus,
                groupNameTs: sampleData[endItem1].groupNameTs,
                sampleGroup: sampleData[endItem1].sampleGroup,
                sampleType: sampleData[endItem1].sampleType,
                sampleTank: sampleData[endItem1].sampleTank,
                sampleName: sampleData[endItem1].sampleName,
                sampleAmount: sampleData[endItem1].sampleAmount,
                samplingDate: sampleData[endItem1].samplingDate,
                sampleRemark: sampleData[endItem1].sampleRemark,
                sampleAttachFile: sampleData[endItem1].sampleAttachFile,
                itemNo: countItem1 + 1 + i,
                instrument: addItem1[i].instrument,
                itemName: addItem1[i].itemName,
                itemStatus: sampleData[endItem1].itemStatus,
                position: sampleData[endItem1].position,
                mag: sampleData[endItem1].mag,
                temp: sampleData[endItem1].temp,
                stdFactor: sampleData[endItem1].stdFactor,
                stdMax: sampleData[endItem1].stdMax,
                stdMin: sampleData[endItem1].stdMin));
      }
    }
  }

  List<ModelRountineDataSQL> requestData = [];
  List<ModelSampleDataSQL> sampleData = [];
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

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 2000,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 0)),
            child: Container(
              margin: EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /* FutureBuilder(
                      future: fetchMasterInstrument(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text("aaa");
                        } else if (snapshot.hasError) {
                          print("snapshoterror");
                          return Center(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 60, right: 60, top: 40, bottom: 0),
                                  child: Text("NETWORK Eror")));
                        } else {
                          EasyLoading.show(status: 'loading...');
                          return CircularProgressIndicator();
                          //return EasyLoading.show(status: 'loading...');
                        }
                      }), */
                  FutureBuilder<List>(
                      future: fetchMasterCustomerRoutine(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          /* print(selectCustomer);
                          print(requestData.length);
                          print(sampleData.length); */
                          EasyLoading.dismiss();
                          //print("snapshot : ${snapshot.data}");
                          List data = [];
                          for (int i = 0; i < snapshot.data.length; i++) {
                            data.add({
                              'no': snapshot.data[i].no,
                              'custId': snapshot.data[i].custId,
                              'custFull': snapshot.data[i].custFull,
                              'custShort': snapshot.data[i].custShort,
                              'branch': snapshot.data[i].branch,
                              'code': snapshot.data[i].code,
                              'frequencyRequest':
                                  snapshot.data[i].frequencyRequest,
                              'incharge': snapshot.data[i].incharge,
                              'subLeader': snapshot.data[i].subLeader,
                              'gl': snapshot.data[i].gl,
                              'jp': snapshot.data[i].jp,
                              'dmg': snapshot.data[i].dmg
                            });
                          }

                          return Center(
                            child: Container(
                              width: 700,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      width: 150,
                                      child: Text("CUSTOMER"),
                                    ),
                                    Expanded(
                                      child: CustomSearchableDropDown(
                                        primaryColor: Colors.black,
                                        menuMode: true,
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        items: data,
                                        label: 'SELECT CUSTOMER',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Icon(Icons.search),
                                        ),
                                        dropDownMenuItems: data.map((item) {
                                          return item['custFull'];
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            for (int i = 0; i < 5; i++) {
                                              requestData[i].custId =
                                                  value['custId'].toString();
                                              requestData[i].custFull =
                                                  value['custFull'].toString();
                                              requestData[i].custShort =
                                                  value['custShort'].toString();
                                              requestData[i].branch =
                                                  value['branch'].toString();
                                              requestData[i].code =
                                                  value['code'].toString();
                                              requestData[i].incharge =
                                                  value['incharge'].toString();
                                              requestData[i].subLeader =
                                                  value['subLeader'].toString();
                                              requestData[i].gl =
                                                  value['gl'].toString();
                                              requestData[i].jp =
                                                  value['jp'].toString();
                                              requestData[i].dmg =
                                                  value['dmg'].toString();
                                            }
                                            selectCustomer = 1;
                                            setState(() {
                                              /* print(
                                                  'requestHeadData: ${requestHeadData}');
                                              print(
                                                  'requestHeadData[0]: ${requestHeadData[0]}');
                                              print(
                                                  'requestHeadData[0].custShort: ${requestHeadData[4].custShort}'); */
                                              EasyLoading.show(
                                                  status: 'loading...');
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ]),
                                  /*  SizedBox(
                                    height: 10,
                                  ), */
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print("snapshoterror${snapshot.error}");
                          return Center(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 60, right: 60, top: 40, bottom: 0),
                                  child: Text("NETWORK Eror")));
                        } else {
                          EasyLoading.show(status: 'loading...');
                          return CircularProgressIndicator();
                        }
                      }),
                  if (selectCustomer == 1)
                    FutureBuilder<List>(
                        future: findCustomerData(requestData[0].custFull),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            //print(requestData[0].custFull);
                            EasyLoading.dismiss();
                            DateTime now = DateTime.now();
                            var requestRound = snapshot.data[0].requestRound;
                            //List<AnalysisData> data = snapshot.data;
                            for (int i = 0; i < snapshot.data.length; i++) {
                              if (sampleCount != snapshot.data[i].sampleNo) {
                                sampleCount = snapshot.data[i].sampleNo;
                                requestData[sampleCount - 1].sampleNo =
                                    snapshot.data[i].sampleNo;
                                requestData[sampleCount - 1].sampleName =
                                    snapshot.data[i].sampleName;
                                requestData[sampleCount - 1].sampleGroup =
                                    snapshot.data[i].sampleGroup;
                                requestData[sampleCount - 1].sampleType =
                                    snapshot.data[i].sampleType;
                                requestData[sampleCount - 1].sampleTank =
                                    snapshot.data[i].sampleTank;
                                requestData[sampleCount - 1].requestRound =
                                    requestRound;
                              }
                            }
                            //print("length:${requestData.length}");
                            requestData.removeRange(
                                sampleCount, requestData.length);
                            //print("length:${requestData.length}");
                            itemCount = snapshot.data.length;
                            for (int j = 0; j < snapshot.data.length; j++) {
                              sampleData[j].custId = requestData[0].custId;
                              sampleData[j].custFull = requestData[0].custFull;
                              sampleData[j].custShort =
                                  requestData[0].custShort;
                              sampleData[j].branch = requestData[0].branch;
                              sampleData[j].code = requestData[0].code;
                              sampleData[j].incharge = requestData[0].incharge;
                              sampleData[j].requestRound =
                                  requestData[0].requestRound;
                              sampleData[j].sampleNo =
                                  snapshot.data[j].sampleNo;
                              sampleData[j].groupNameTs = "";
                              sampleData[j].sampleGroup =
                                  snapshot.data[j].sampleGroup;
                              sampleData[j].sampleType =
                                  snapshot.data[j].sampleType;
                              sampleData[j].sampleTank =
                                  snapshot.data[j].sampleTank;
                              sampleData[j].sampleName =
                                  snapshot.data[j].sampleName;
                              sampleData[j].sampleAmount = 1;
                              sampleData[j].itemNo = snapshot.data[j].itemNo;
                              sampleData[j].instrument =
                                  snapshot.data[j].instrument;
                              sampleData[j].itemName =
                                  snapshot.data[j].itemName;
                              sampleData[j].itemStatus = "WAIT SAMPLE";
                              sampleData[j].position =
                                  snapshot.data[j].position;
                              sampleData[j].mag = snapshot.data[j].mag;
                              sampleData[j].temp = snapshot.data[j].temp;
                              sampleData[j].stdMax = snapshot.data[j].stdMax;
                              sampleData[j].stdMin = snapshot.data[j].stdMin;
                              if (sampleData[j].sampleNo == 1) {
                                item1 = item1 +
                                    "  " +
                                    snapshot.data[j].itemName.toString();
                              }
                              if (sampleData[j].sampleNo == 2) {
                                item2 = item2 +
                                    "  " +
                                    snapshot.data[j].itemName.toString();
                              }
                              if (sampleData[j].sampleNo == 3) {
                                item3 = item3 +
                                    "  " +
                                    snapshot.data[j].itemName.toString();
                              }
                              if (sampleData[j].sampleNo == 4) {
                                item4 = item4 +
                                    "  " +
                                    snapshot.data[j].itemName.toString();
                              }
                              if (sampleData[j].sampleNo == 5) {
                                item5 = item5 +
                                    "  " +
                                    snapshot.data[j].itemName.toString();
                              }
                            }
                            createGroupItem();
                            //print("item1:$itemToSearch1");
                            //print("item1 name:${itemToSearch1[0].itemName}");
                            //print("item:$itemCount");
                            //print("length:${sampleData.length}");
                            sampleData.removeRange(
                                itemCount, sampleData.length);
                            //print("length:${sampleData.length}");
                            //print(requestSampleData[0]["sampleGroup"]);
                            return FormBuilder(
                              key: _formKey,
                              child: Column(
                                /* mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly, */
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      width:700,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text("SAMPLING DATE"),
                                              ),
                                              Expanded(
                                                child:
                                                    FormBuilderDateTimePicker(
                                                  initialValue: now,
                                                  inputType: InputType.date,
                                                  name: 'samplingDate',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text("ROUND COUNT"),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  name: 'roundCount',
                                                  initialValue: requestRound,
                                                  enabled: false,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text("ATTACH FILE"),
                                              ),
                                              ElevatedButton(
                                                child: Text("SELECT FILE"),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text("REMARK"),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  name: 'requestRemark',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 30),
                                  //Sample 1
                                  //-----------------------------------------------------------------------------------------------------------------------------------
                                  Container(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          if (sampleCount > 0)
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 60,
                                                  right: 60,
                                                  top: 40,
                                                  bottom: 40),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0)),
                                              //height: 100,
                                              width: 600,
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Expanded(
                                                      child:
                                                          FormBuilderCheckbox(
                                                        // Core attributes
                                                        name: 'sampleStatus1',
                                                        initialValue: true,
                                                        title: Text('SAMPLE 1'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("GROUP"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'group1',
                                                        initialValue:
                                                            requestData[0]
                                                                .sampleGroup,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TYPE"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'type1',
                                                        initialValue:
                                                            requestData[0]
                                                                .sampleType,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TANK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'tank1',
                                                        initialValue:
                                                            requestData[0]
                                                                .sampleTank,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE NAME"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'name1',
                                                        initialValue:
                                                            requestData[0]
                                                                .sampleName,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("AMOUNT"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'amont1',
                                                        initialValue: "1",
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'item1',
                                                        initialValue: item1,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ADD ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CustomSearchableDropDown(
                                                        items: itemToSearch1,
                                                        label:
                                                            'SELECT ADD ITEM',
                                                        multiSelectValuesAsWidget:
                                                            true,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue)),
                                                        multiSelect: true,
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Icon(
                                                              Icons.search),
                                                        ),
                                                        dropDownMenuItems:
                                                            itemToSearch1
                                                                .map((item) {
                                                          return item.itemName;
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          if (value != null) {
                                                            /* print("value : ${value}"); */
                                                            addItem1 =
                                                                masterInstrumentFromJson(
                                                                    value);
                                                            //selectedList = jsonDecode(value);
                                                            /* print(
                                                            "value : ${addItem1.length}"); */
                                                            /* print(
                                                            "data2:${selectedList[1].sampleTypeName}"); */
                                                          } else {
                                                            //selectedList.clear();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 50),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("ATTACH FILE"),
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          Text("SELECT FILE"),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("REMARK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'sampleRemark1',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          //SAMPLE 2
                                          /*---------------------------------------------------------------------------------------------------------------------------------------*/
                                          if (sampleCount > 1)
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 60,
                                                  right: 60,
                                                  top: 40,
                                                  bottom: 40),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0)),
                                              //height: 100,
                                              width: 600,
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Expanded(
                                                      child:
                                                          FormBuilderCheckbox(
                                                        // Core attributes
                                                        name: 'sampleStatus2',
                                                        initialValue: true,
                                                        title: Text('SAMPLE 2'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("GROUP"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'group2',
                                                        initialValue:
                                                            requestData[1]
                                                                .sampleGroup,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TYPE"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'type2',
                                                        initialValue:
                                                            requestData[1]
                                                                .sampleType,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TANK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'tank2',
                                                        initialValue:
                                                            requestData[1]
                                                                .sampleTank,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE NAME"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'name2',
                                                        initialValue:
                                                            requestData[1]
                                                                .sampleName,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("AMOUNT"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'amont2',
                                                        initialValue: "1",
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'item2',
                                                        initialValue: item2,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ADD ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CustomSearchableDropDown(
                                                        items: itemToSearch2,
                                                        label:
                                                            'SELECT ADD ITEM',
                                                        multiSelectValuesAsWidget:
                                                            true,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue)),
                                                        multiSelect: true,
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Icon(
                                                              Icons.search),
                                                        ),
                                                        dropDownMenuItems:
                                                            itemToSearch2
                                                                .map((item) {
                                                          return item.itemName;
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          if (value != null) {
                                                            addItem2 =
                                                                masterInstrumentFromJson(
                                                                    value);
                                                          } else {
                                                            //selectedList.clear();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 50),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("ATTACH FILE"),
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          Text("SELECT FILE"),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("REMARK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'sampleRemark2',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          //SAMPLE 3
                                          //--------------------------------------------------------------------------------------------------------------------------------
                                          if (sampleCount > 2)
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 60,
                                                  right: 60,
                                                  top: 40,
                                                  bottom: 40),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0)),
                                              //height: 100,
                                              width: 600,
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Expanded(
                                                      child:
                                                          FormBuilderCheckbox(
                                                        // Core attributes
                                                        name: 'sampleStatus3',
                                                        initialValue: true,
                                                        title: Text('SAMPLE 3'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("GROUP"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'group3',
                                                        initialValue:
                                                            requestData[2]
                                                                .sampleGroup,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TYPE"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'type3',
                                                        initialValue:
                                                            requestData[2]
                                                                .sampleType,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TANK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'tank3',
                                                        initialValue:
                                                            requestData[2]
                                                                .sampleTank,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE NAME"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'name3',
                                                        initialValue:
                                                            requestData[2]
                                                                .sampleName,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("AMOUNT"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'amont3',
                                                        initialValue: "1",
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'item3',
                                                        initialValue: item3,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ADD ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CustomSearchableDropDown(
                                                        items: itemToSearch3,
                                                        label:
                                                            'SELECT ADD ITEM',
                                                        multiSelectValuesAsWidget:
                                                            true,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue)),
                                                        multiSelect: true,
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Icon(
                                                              Icons.search),
                                                        ),
                                                        dropDownMenuItems:
                                                            itemToSearch3
                                                                .map((item) {
                                                          return item.itemName;
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          if (value != null) {
                                                            addItem3 =
                                                                masterInstrumentFromJson(
                                                                    value);
                                                          } else {
                                                            //selectedList.clear();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 50),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("ATTACH FILE"),
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          Text("SELECT FILE"),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("REMARK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'sampleRemark3',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          //SAMPLE 4
                                          //-----------------------------------------------------------------------------------------------------
                                          if (sampleCount > 3)
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 60,
                                                  right: 60,
                                                  top: 40,
                                                  bottom: 40),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0)),
                                              //height: 100,
                                              width: 600,
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Expanded(
                                                      child:
                                                          FormBuilderCheckbox(
                                                        // Core attributes
                                                        name: 'sampleStatus4',
                                                        initialValue: true,
                                                        title: Text('SAMPLE 4'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("GROUP"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'group4',
                                                        initialValue:
                                                            requestData[3]
                                                                .sampleGroup,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TYPE"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'type4',
                                                        initialValue:
                                                            requestData[3]
                                                                .sampleType,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TANK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'tank4',
                                                        initialValue:
                                                            requestData[3]
                                                                .sampleTank,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE NAME"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'name4',
                                                        initialValue:
                                                            requestData[3]
                                                                .sampleName,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("AMOUNT"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'amont4',
                                                        initialValue: "1",
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'item4',
                                                        initialValue: item4,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ADD ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CustomSearchableDropDown(
                                                        items: itemToSearch4,
                                                        label:
                                                            'SELECT ADD ITEM',
                                                        multiSelectValuesAsWidget:
                                                            true,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue)),
                                                        multiSelect: true,
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Icon(
                                                              Icons.search),
                                                        ),
                                                        dropDownMenuItems:
                                                            itemToSearch4
                                                                .map((item) {
                                                          return item.itemName;
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          if (value != null) {
                                                            addItem4 =
                                                                masterInstrumentFromJson(
                                                                    value);
                                                          } else {}
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 50),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("ATTACH FILE"),
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          Text("SELECT FILE"),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("REMARK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'sampleRemark4',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          //SAMPLE 5
                                          //------------------------------------------------------------------------------------------------------------
                                          if (sampleCount > 4)
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 60,
                                                  right: 60,
                                                  top: 40,
                                                  bottom: 40),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0)),
                                              //height: 100,
                                              width: 600,
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Expanded(
                                                      child:
                                                          FormBuilderCheckbox(
                                                        // Core attributes
                                                        name: 'sampleStatus5',
                                                        initialValue: true,
                                                        title: Text('SAMPLE 5'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("GROUP"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'group5',
                                                        initialValue:
                                                            requestData[4]
                                                                .sampleGroup,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TYPE"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'type5',
                                                        initialValue:
                                                            requestData[4]
                                                                .sampleType,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE TANK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'tank5',
                                                        initialValue:
                                                            requestData[4]
                                                                .sampleTank,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("SAMPLE NAME"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'name5',
                                                        initialValue:
                                                            requestData[4]
                                                                .sampleName,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("AMOUNT"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'amont5',
                                                        initialValue: "1",
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'item5',
                                                        initialValue: item5,
                                                        enabled: false,
                                                      ),
                                                    ),
                                                    SizedBox(width: 25),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("ADD ITEM"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CustomSearchableDropDown(
                                                        items: itemToSearch5,
                                                        label:
                                                            'SELECT ADD ITEM',
                                                        multiSelectValuesAsWidget:
                                                            true,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue)),
                                                        multiSelect: true,
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: Icon(
                                                              Icons.search),
                                                        ),
                                                        dropDownMenuItems:
                                                            itemToSearch5
                                                                .map((item) {
                                                          return item.itemName;
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          if (value != null) {
                                                            addItem5 =
                                                                masterInstrumentFromJson(
                                                                    value);
                                                          } else {}
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 50),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child:
                                                          Text("ATTACH FILE"),
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          Text("SELECT FILE"),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 25),
                                                    Container(
                                                      width: 150,
                                                      child: Text("REMARK"),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          FormBuilderTextField(
                                                        name: 'sampleRemark5',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  ElevatedButton(
                                      child: Text("SAVE AND PRINT LABEL"),
                                      onPressed: () async {
                                        _formKey.currentState?.save();
                                        manageRequestData();
                                        setState(() {
                                          request = 1;
                                        });
                                      }),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            print("snapshoterror : ${snapshot.error}");
                            return Center(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 60,
                                        right: 60,
                                        top: 40,
                                        bottom: 0),
                                    child: Text("NETWORK Eror")));
                          } else {
                            EasyLoading.show(status: 'loading...');
                            return CircularProgressIndicator();
                            //return EasyLoading.show(status: 'loading...');
                          }
                        }),
                  if (request == 1)
                    Container(
                      child: FutureBuilder<String>(
                          future: createRequest(
                              routineDataSQLToJson(requestData),
                              sampleDataSQLToJson(sampleData)),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return AlertDialog(
                                  title: Text(snapshot.data),
                                  content: TextField(
                                    onChanged: (value) {},
                                  ));
                            } else if (snapshot.hasError) {
                              print("snapshoterror : ${snapshot.error}");
                              return Text("aaaa");
                            } else {
                              print("snapshoterror : ${snapshot.error}");
                              EasyLoading.show(status: 'loading...');
                              return CircularProgressIndicator();
                              //return EasyLoading.show(status: 'loading...');
                            }
                          }),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* class hide {
  String? aaa;
  int? bbb;
  hide({this.aaa, this.bbb});
}

void bbbbb() {
  var a = hide();
  a.aaa = "asd";
  List<hide> bbb = [hide(aaa:"aaa"),hide(bbb:1)];

  List asd = 
}

list a = []
a[i]["KeyName"]
//print(requestSampleData[0]["sampleGroup"]);
*/
 */