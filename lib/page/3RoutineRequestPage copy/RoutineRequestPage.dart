import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/global/style.dart';
import 'Data/RoutineRequestPageStructure.dart';
import 'Data/RoutineRequestPage_bloc.dart';
import 'Data/RoutineRequestPage_event.dart';

class RoutineRequestPage extends StatelessWidget {
  const RoutineRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.yellow,
      ),
      child: Container(
        margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        child: RoutineCreateRequest(),
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

  void initialRoutineRequestData() {
    for (int i = 0; i < 5; i++) {
      requestData.add(ModelRountineDataSQL(
          jobType: "ROUTINE",
          reqUser: userName,
          requestSection: userSection,
          requestStatus: "WAIT SAMPLE"));
    }
  }

  void initialRoutineSampletData() {
    for (int i = 0; i < 120; i++) {
      sampleData.add(ModelSampleDataSQL(
          jobType: "ROUTINE", reqUser: userName, requestSection: userSection));
    }
  }

  void createGroupItem() {
    for (int i = 0; i < instrumentData.length; i++) {
      if (sampleCount > 0) {
        if (requestData[0].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch1.add(MasterInstrument(
              instrumentName: instrumentData[i].instrumentName,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 1) {
        if (requestData[1].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch2.add(MasterInstrument(
              instrumentName: instrumentData[i].instrumentName,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 2) {
        if (requestData[2].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch3.add(MasterInstrument(
              instrumentName: instrumentData[i].instrumentName,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 3) {
        if (requestData[3].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch4.add(MasterInstrument(
              instrumentName: instrumentData[i].instrumentName,
              itemName: instrumentData[i].itemName));
        }
      }
      if (sampleCount > 4) {
        if (requestData[4].sampleType == instrumentData[i].sampleTypeName) {
          itemToSearch5.add(MasterInstrument(
              instrumentName: instrumentData[i].instrumentName,
              itemName: instrumentData[i].itemName));
        }
      }
    }
  }

  void manageRequestData() {
    final formData = _formKey.currentState!.value;
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
      requestData[0].sampleName = formData['name1'];
      if (formData['sampleStatus${1}'] == true) {
        requestData[0].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[0].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 1) {
      requestData[0].sampleName = formData['name2'];
      if (formData['sampleStatus2'] == true) {
        requestData[1].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[1].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 2) {
      requestData[0].sampleName = formData['name3'];
      if (formData['sampleStatus3'] == true) {
        requestData[2].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[2].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 3) {
      requestData[0].sampleName = formData['name4'];
      if (formData['sampleStatus4'] == true) {
        requestData[3].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[3].sampleStatus = "NOT SEND SAMPLE";
      }
    }
    if (sampleCount > 4) {
      requestData[0].sampleName = formData['name5'];
      if (formData['sampleStatus5'] == true) {
        requestData[4].sampleStatus = "WAIT SAMPLE";
      } else {
        requestData[4].sampleStatus = "NOT SEND SAMPLE";
      }
    }

    //print(routineDataSQLToJson(requestData));
    int countItem1 = 0;
    int startitem1 = 0;
    int endItem1 = 0;
    int countItem2 = 0;
    int startitem2 = 0;
    int endItem2 = 0;
    int countItem3 = 0;
    int startitem3 = 0;
    int endItem3 = 0;
    int countItem4 = 0;
    int startitem4 = 0;
    int endItem4 = 0;
    int countItem5 = 0;
    int startitem5 = 0;
    int endItem5 = 0;

    for (int i = 0; i < sampleData.length; i++) {
      sampleData[i].reqDate =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      sampleData[i].samplingDate =
          DateFormat("yyyy-MM-dd").format(formData['samplingDate']);
      if (sampleData[i].sampleNo == 1) {
        if (sampleData[i].itemNo == 1) {
          startitem1 = i;
        }
        sampleData[i].sampleName = formData['name1'];
        sampleData[i].sampleAmount = amountSample1;
        sampleData[i].sampleRemark = formData['sampleRemark1'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus1'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        if (sampleData[i].instrumentName == 'SEM for Cwt. 3 layers') {
          //duplicate SEM 3 item
          sampleData.insert(
              i + 1,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo + 1,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          sampleData.insert(
              i + 2,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          for (int j = i + 2; j < sampleData.length; j++) {
            if (sampleData[j].sampleNo == sampleData[i].sampleNo) {
              sampleData[j].itemNo = sampleData[j].itemNo + 2;
            }
          }
          i = i + 2;
        }
        countItem1 = sampleData[i].itemNo;
        endItem1 = i;
      }
      if (sampleData[i].sampleNo == 2) {
        if (sampleData[i].itemNo == 1) {
          startitem2 = i;
        }
        sampleData[i].sampleName = formData['name2'];
        sampleData[i].sampleAmount = amountSample2;
        sampleData[i].sampleRemark = formData['sampleRemark2'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus2'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        if (sampleData[i].instrumentName == 'SEM for Cwt. 3 layers') {
          //duplicate SEM 3 item
          sampleData.insert(
              i + 1,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo + 1,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          sampleData.insert(
              i + 2,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          for (int j = i + 2; j < sampleData.length; j++) {
            if (sampleData[j].sampleNo == sampleData[i].sampleNo) {
              sampleData[j].itemNo = sampleData[j].itemNo + 2;
            }
          }
          i = i + 2;
        }
        countItem2 = sampleData[i].itemNo;
        endItem2 = i;
      }
      if (sampleData[i].sampleNo == 3) {
        if (sampleData[i].itemNo == 1) {
          startitem3 = i;
        }
        sampleData[i].sampleName = formData['name3'];
        sampleData[i].sampleAmount = amountSample3;
        sampleData[i].sampleRemark = formData['sampleRemark3'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus3'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        if (sampleData[i].instrumentName == 'SEM for Cwt. 3 layers') {
          //duplicate SEM 3 item
          sampleData.insert(
              i + 1,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo + 1,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          sampleData.insert(
              i + 2,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          for (int j = i + 2; j < sampleData.length; j++) {
            if (sampleData[j].sampleNo == sampleData[i].sampleNo) {
              sampleData[j].itemNo = sampleData[j].itemNo + 2;
            }
          }
          i = i + 2;
        }
        countItem3 = sampleData[i].itemNo;
        endItem3 = i;
      }
      if (sampleData[i].sampleNo == 4) {
        if (sampleData[i].itemNo == 1) {
          startitem4 = i;
        }
        sampleData[i].sampleName = formData['name4'];
        sampleData[i].sampleAmount = amountSample4;
        sampleData[i].sampleRemark = formData['sampleRemark4'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus4'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        if (sampleData[i].instrumentName == 'SEM for Cwt. 3 layers') {
          //duplicate SEM 3 item
          sampleData.insert(
              i + 1,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo + 1,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          sampleData.insert(
              i + 2,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          for (int j = i + 2; j < sampleData.length; j++) {
            if (sampleData[j].sampleNo == sampleData[i].sampleNo) {
              sampleData[j].itemNo = sampleData[j].itemNo + 2;
            }
          }
          i = i + 2;
        }
        countItem4 = sampleData[i].itemNo;
        endItem4 = i;
      }
      if (sampleData[i].sampleNo == 5) {
        if (sampleData[i].itemNo == 1) {
          startitem5 = i;
        }
        sampleData[i].sampleName = formData['name5'];
        sampleData[i].sampleAmount = amountSample5;
        sampleData[i].sampleRemark = formData['sampleRemark5'];
        sampleData[i].sampleAttachFile = "";
        if (formData['sampleStatus5'] == true) {
          sampleData[i].sampleStatus = "WAIT SAMPLE";
        } else {
          sampleData[i].sampleStatus = "NOT SEND SAMPLE";
        }
        if (sampleData[i].instrumentName == 'SEM for Cwt. 3 layers') {
          //duplicate SEM 3 item
          sampleData.insert(
              i + 1,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo + 1,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          sampleData.insert(
              i + 2,
              ModelSampleDataSQL(
                  jobType: sampleData[i].jobType,
                  reqUser: sampleData[i].reqUser,
                  branch: sampleData[i].branch,
                  requestSection: sampleData[i].requestSection,
                  reqDate: sampleData[i].reqDate,
                  custId: sampleData[i].custId,
                  custFull: sampleData[i].custFull,
                  custShort: sampleData[i].custShort,
                  code: sampleData[i].code,
                  incharge: sampleData[i].incharge,
                  requestRound: sampleData[i].requestRound,
                  sampleNo: sampleData[i].sampleNo,
                  sampleStatus: sampleData[i].sampleStatus,
                  groupNameTs: sampleData[i].groupNameTs,
                  sampleGroup: sampleData[i].sampleGroup,
                  sampleType: sampleData[i].sampleType,
                  sampleTank: sampleData[i].sampleTank,
                  sampleName: sampleData[i].sampleName,
                  sampleAmount: sampleData[i].sampleAmount,
                  samplingDate: sampleData[i].samplingDate,
                  sampleRemark: sampleData[i].sampleRemark,
                  sampleAttachFile: sampleData[i].sampleAttachFile,
                  itemNo: sampleData[i].itemNo,
                  instrumentName: sampleData[i].instrumentName,
                  itemName: sampleData[i].itemName,
                  itemStatus: sampleData[i].itemStatus,
                  position: sampleData[i].position,
                  mag: sampleData[i].mag,
                  temp: sampleData[i].temp,
                  stdFactor: sampleData[i].stdFactor,
                  stdMax: sampleData[i].stdMax,
                  stdMin: sampleData[i].stdMin));
          for (int j = i + 2; j < sampleData.length; j++) {
            if (sampleData[j].sampleNo == sampleData[i].sampleNo) {
              sampleData[j].itemNo = sampleData[j].itemNo + 2;
            }
          }
          i = i + 2;
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
          itemNo: countItem5 + 1,
          instrumentName: addItem5[i].instrumentName,
          itemName: addItem5[i].itemName,
          itemStatus: sampleData[endItem5].itemStatus,
          /* position: sampleData[endItem5].position,
            mag: sampleData[endItem5].mag,
            temp: sampleData[endItem5].temp,
            stdFactor: sampleData[endItem5].stdFactor,
            stdMax: sampleData[endItem5].stdMax,
            stdMin: sampleData[endItem5].stdMin */
        ));
        endItem5 = endItem5 + 1;
        countItem5 = countItem5 + 1;
      }
    }

    if (amountSample5 > 1) {
      bool alreadySkipXRF = false;
      for (int i = 1; i < amountSample5; i++) {
        for (int j = startitem5; j <= endItem5; j++) {
          if (sampleData[j].instrumentName != "XRF") {
            sampleData.add(ModelSampleDataSQL(
              jobType: sampleData[j].jobType,
              reqUser: sampleData[j].reqUser,
              branch: sampleData[j].branch,
              requestSection: sampleData[j].requestSection,
              reqDate: sampleData[j].reqDate,
              custId: sampleData[j].custId,
              custFull: sampleData[j].custFull,
              custShort: sampleData[j].custShort,
              code: sampleData[j].code,
              incharge: sampleData[j].incharge,
              requestRound: sampleData[j].requestRound,
              sampleNo: sampleData[j].sampleNo,
              sampleStatus: sampleData[j].sampleStatus,
              groupNameTs: sampleData[j].groupNameTs,
              sampleGroup: sampleData[j].sampleGroup,
              sampleType: sampleData[j].sampleType,
              sampleTank: sampleData[j].sampleTank,
              sampleName: sampleData[j].sampleName,
              sampleAmount: sampleData[j].sampleAmount,
              samplingDate: sampleData[j].samplingDate,
              sampleRemark: sampleData[j].sampleRemark,
              sampleAttachFile: sampleData[j].sampleAttachFile,
              itemNo: countItem5 + 1,
              instrumentName: sampleData[j].instrumentName,
              itemName: sampleData[j].itemName,
              itemStatus: sampleData[j].itemStatus,
              /* position: sampleData[endItem5].position,
            mag: sampleData[endItem5].mag,
            temp: sampleData[endItem5].temp,
            stdFactor: sampleData[endItem5].stdFactor,
            stdMax: sampleData[endItem5].stdMax,
            stdMin: sampleData[endItem5].stdMin */
            ));
            countItem5 = countItem5 + 1;
          } else {
            if (alreadySkipXRF == false) {
              amountSample5 = amountSample5 - 1;
              alreadySkipXRF = true;
            }
          }
        }
      }
    }
    if (addItem4.length > 0) {
      for (int i = 0; i < addItem4.length; i++) {
        sampleData.insert(
            endItem4 + 1,
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
              itemNo: countItem4 + 1,
              instrumentName: addItem4[i].instrumentName,
              itemName: addItem4[i].itemName,
              itemStatus: sampleData[endItem4].itemStatus,
              /* position: sampleData[endItem4].position,
                mag: sampleData[endItem4].mag,
                temp: sampleData[endItem4].temp,
                stdFactor: sampleData[endItem4].stdFactor,
                stdMax: sampleData[endItem4].stdMax,
                stdMin: sampleData[endItem4].stdMin */
            ));
        endItem4 = endItem4 + 1;
        countItem4 = countItem4 + 1;
      }
    }
    if (amountSample4 > 1) {
      bool alreadySkipXRF = false;
      int newEndItem4 = endItem4;
      for (int i = 1; i < amountSample4; i++) {
        for (int j = startitem4; j <= endItem4; j++) {
          if (sampleData[j].instrumentName != "XRF") {
            sampleData.insert(
                newEndItem4 + 1,
                ModelSampleDataSQL(
                  jobType: sampleData[j].jobType,
                  reqUser: sampleData[j].reqUser,
                  branch: sampleData[j].branch,
                  requestSection: sampleData[j].requestSection,
                  reqDate: sampleData[j].reqDate,
                  custId: sampleData[j].custId,
                  custFull: sampleData[j].custFull,
                  custShort: sampleData[j].custShort,
                  code: sampleData[j].code,
                  incharge: sampleData[j].incharge,
                  requestRound: sampleData[j].requestRound,
                  sampleNo: sampleData[j].sampleNo,
                  sampleStatus: sampleData[j].sampleStatus,
                  groupNameTs: sampleData[j].groupNameTs,
                  sampleGroup: sampleData[j].sampleGroup,
                  sampleType: sampleData[j].sampleType,
                  sampleTank: sampleData[j].sampleTank,
                  sampleName: sampleData[j].sampleName,
                  sampleAmount: sampleData[j].sampleAmount,
                  samplingDate: sampleData[j].samplingDate,
                  sampleRemark: sampleData[j].sampleRemark,
                  sampleAttachFile: sampleData[j].sampleAttachFile,
                  itemNo: countItem4 + 1,
                  instrumentName: sampleData[j].instrumentName,
                  itemName: sampleData[j].itemName,
                  itemStatus: sampleData[j].itemStatus,
                  /* position: sampleData[endItem5].position,
            mag: sampleData[endItem5].mag,
            temp: sampleData[endItem5].temp,
            stdFactor: sampleData[endItem5].stdFactor,
            stdMax: sampleData[endItem5].stdMax,
            stdMin: sampleData[endItem5].stdMin */
                ));
            newEndItem4 = newEndItem4 + 1;
            countItem4 = countItem4 + 1;
          } else {
            if (alreadySkipXRF == false) {
              amountSample4 = amountSample4 - 1;
              alreadySkipXRF = true;
            }
          }
        }
      }
    }

    if (addItem3.length > 0) {
      for (int i = 0; i < addItem3.length; i++) {
        sampleData.insert(
            endItem3 + 1,
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
              itemNo: countItem3 + 1,
              instrumentName: addItem3[i].instrumentName,
              itemName: addItem3[i].itemName,
              itemStatus: sampleData[endItem3].itemStatus,
              /* position: sampleData[endItem3].position,
                mag: sampleData[endItem3].mag,
                temp: sampleData[endItem3].temp,
                stdFactor: sampleData[endItem3].stdFactor,
                stdMax: sampleData[endItem3].stdMax,
                stdMin: sampleData[endItem3].stdMin */
            ));
        endItem3 = endItem3 + 1;
        countItem3 = countItem3 + 1;
      }
    }

    if (amountSample3 > 1) {
      bool alreadySkipXRF = false;
      int newEndItem3 = endItem3;
      for (int i = 1; i < amountSample3; i++) {
        for (int j = startitem3; j <= endItem3; j++) {
          if (sampleData[j].instrumentName != "XRF") {
            sampleData.insert(
                newEndItem3 + 1,
                ModelSampleDataSQL(
                  jobType: sampleData[j].jobType,
                  reqUser: sampleData[j].reqUser,
                  branch: sampleData[j].branch,
                  requestSection: sampleData[j].requestSection,
                  reqDate: sampleData[j].reqDate,
                  custId: sampleData[j].custId,
                  custFull: sampleData[j].custFull,
                  custShort: sampleData[j].custShort,
                  code: sampleData[j].code,
                  incharge: sampleData[j].incharge,
                  requestRound: sampleData[j].requestRound,
                  sampleNo: sampleData[j].sampleNo,
                  sampleStatus: sampleData[j].sampleStatus,
                  groupNameTs: sampleData[j].groupNameTs,
                  sampleGroup: sampleData[j].sampleGroup,
                  sampleType: sampleData[j].sampleType,
                  sampleTank: sampleData[j].sampleTank,
                  sampleName: sampleData[j].sampleName,
                  sampleAmount: sampleData[j].sampleAmount,
                  samplingDate: sampleData[j].samplingDate,
                  sampleRemark: sampleData[j].sampleRemark,
                  sampleAttachFile: sampleData[j].sampleAttachFile,
                  itemNo: countItem3 + 1,
                  instrumentName: sampleData[j].instrumentName,
                  itemName: sampleData[j].itemName,
                  itemStatus: sampleData[j].itemStatus,
                  /* position: sampleData[endItem5].position,
            mag: sampleData[endItem5].mag,
            temp: sampleData[endItem5].temp,
            stdFactor: sampleData[endItem5].stdFactor,
            stdMax: sampleData[endItem5].stdMax,
            stdMin: sampleData[endItem5].stdMin */
                ));
            newEndItem3 = newEndItem3 + 1;
            countItem3 = countItem3 + 1;
          } else {
            if (alreadySkipXRF == false) {
              amountSample3 = amountSample3 - 1;
              alreadySkipXRF = true;
            }
          }
        }
      }
    }
    if (addItem2.length > 0) {
      for (int i = 0; i < addItem2.length; i++) {
        sampleData.insert(
            endItem2 + 1,
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
              itemNo: countItem2 + 1,
              instrumentName: addItem2[i].instrumentName,
              itemName: addItem2[i].itemName,
              itemStatus: sampleData[endItem2].itemStatus,
              /* position: sampleData[endItem2].position,
                mag: sampleData[endItem2].mag,
                temp: sampleData[endItem2].temp,
                stdFactor: sampleData[endItem2].stdFactor,
                stdMax: sampleData[endItem2].stdMax,
                stdMin: sampleData[endItem2].stdMin */
            ));
        endItem2 = endItem2 + 1;
        countItem2 = countItem2 + 1;
      }
    }
    if (amountSample2 > 1) {
      bool alreadySkipXRF = false;
      int newEndItem2 = endItem2;
      for (int i = 1; i < amountSample2; i++) {
        for (int j = startitem2; j <= endItem2; j++) {
          if (sampleData[j].instrumentName != "XRF") {
            sampleData.insert(
                newEndItem2 + 1,
                ModelSampleDataSQL(
                  jobType: sampleData[j].jobType,
                  reqUser: sampleData[j].reqUser,
                  branch: sampleData[j].branch,
                  requestSection: sampleData[j].requestSection,
                  reqDate: sampleData[j].reqDate,
                  custId: sampleData[j].custId,
                  custFull: sampleData[j].custFull,
                  custShort: sampleData[j].custShort,
                  code: sampleData[j].code,
                  incharge: sampleData[j].incharge,
                  requestRound: sampleData[j].requestRound,
                  sampleNo: sampleData[j].sampleNo,
                  sampleStatus: sampleData[j].sampleStatus,
                  groupNameTs: sampleData[j].groupNameTs,
                  sampleGroup: sampleData[j].sampleGroup,
                  sampleType: sampleData[j].sampleType,
                  sampleTank: sampleData[j].sampleTank,
                  sampleName: sampleData[j].sampleName,
                  sampleAmount: sampleData[j].sampleAmount,
                  samplingDate: sampleData[j].samplingDate,
                  sampleRemark: sampleData[j].sampleRemark,
                  sampleAttachFile: sampleData[j].sampleAttachFile,
                  itemNo: countItem2 + 1,
                  instrumentName: sampleData[j].instrumentName,
                  itemName: sampleData[j].itemName,
                  itemStatus: sampleData[j].itemStatus,
                  /* position: sampleData[endItem5].position,
            mag: sampleData[endItem5].mag,
            temp: sampleData[endItem5].temp,
            stdFactor: sampleData[endItem5].stdFactor,
            stdMax: sampleData[endItem5].stdMax,
            stdMin: sampleData[endItem5].stdMin */
                ));
            newEndItem2 = newEndItem2 + 1;
            countItem2 = countItem2 + 1;
          } else {
            if (alreadySkipXRF == false) {
              amountSample2 = amountSample2 - 1;
              alreadySkipXRF = true;
            }
          }
        }
      }
    }
    if (addItem1.length > 0) {
      for (int i = 0; i < addItem1.length; i++) {
        sampleData.insert(
            endItem1 + 1,
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
              itemNo: countItem1 + 1,
              instrumentName: addItem1[i].instrumentName,
              itemName: addItem1[i].itemName,
              itemStatus: sampleData[endItem1].itemStatus,
              /* position: sampleData[endItem1].position,
                mag: sampleData[endItem1].mag,
                temp: sampleData[endItem1].temp,
                stdFactor: sampleData[endItem1].stdFactor,
                stdMax: sampleData[endItem1].stdMax,
                stdMin: sampleData[endItem1].stdMin */
            ));
        endItem1 = endItem1 + 1;
        countItem1 = countItem1 + 1;
      }
    }
    if (amountSample1 > 1) {
      bool alreadySkipXRF = false;
      int newEndItem1 = endItem1;
      for (int i = 1; i < amountSample1; i++) {
        for (int j = startitem1; j <= endItem1; j++) {
          if (sampleData[j].instrumentName != "XRF") {
            sampleData.insert(
                newEndItem1 + 1,
                ModelSampleDataSQL(
                  jobType: sampleData[j].jobType,
                  reqUser: sampleData[j].reqUser,
                  branch: sampleData[j].branch,
                  requestSection: sampleData[j].requestSection,
                  reqDate: sampleData[j].reqDate,
                  custId: sampleData[j].custId,
                  custFull: sampleData[j].custFull,
                  custShort: sampleData[j].custShort,
                  code: sampleData[j].code,
                  incharge: sampleData[j].incharge,
                  requestRound: sampleData[j].requestRound,
                  sampleNo: sampleData[j].sampleNo,
                  sampleStatus: sampleData[j].sampleStatus,
                  groupNameTs: sampleData[j].groupNameTs,
                  sampleGroup: sampleData[j].sampleGroup,
                  sampleType: sampleData[j].sampleType,
                  sampleTank: sampleData[j].sampleTank,
                  sampleName: sampleData[j].sampleName,
                  sampleAmount: sampleData[j].sampleAmount,
                  samplingDate: sampleData[j].samplingDate,
                  sampleRemark: sampleData[j].sampleRemark,
                  sampleAttachFile: sampleData[j].sampleAttachFile,
                  itemNo: countItem1 + 1,
                  instrumentName: sampleData[j].instrumentName,
                  itemName: sampleData[j].itemName,
                  itemStatus: sampleData[j].itemStatus,
                  /* position: sampleData[endItem5].position,
            mag: sampleData[endItem5].mag,
            temp: sampleData[endItem5].temp,
            stdFactor: sampleData[endItem5].stdFactor,
            stdMax: sampleData[endItem5].stdMax,
            stdMin: sampleData[endItem5].stdMin */
                ));
            newEndItem1 = newEndItem1 + 1;
            countItem1 = countItem1 + 1;
          } else {
            if (alreadySkipXRF == false) {
              amountSample1 = amountSample1 - 1;
              alreadySkipXRF = true;
            }
          }
        }
      }
    }
/*     if (formData['printStatus1'] == true) {
      routineSamplePrint.add(1);
    } */ //short
    if (sampleCount > 0)
      formData['printStatus1']
          ? routineSamplePrint.add(1)
          : routineSamplePrint.add(0);
    if (sampleCount > 1)
      formData['printStatus2']
          ? routineSamplePrint.add(1)
          : routineSamplePrint.add(0);
    if (sampleCount > 2)
      formData['printStatus3']
          ? routineSamplePrint.add(1)
          : routineSamplePrint.add(0);
    if (sampleCount > 3)
      formData['printStatus4']
          ? routineSamplePrint.add(1)
          : routineSamplePrint.add(0);
    if (sampleCount > 4)
      formData['printStatus5']
          ? routineSamplePrint.add(1)
          : routineSamplePrint.add(0);
  }

  void selectPrint() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          String initialPrint = "";
          if (userSection == "MARKETING") {
            if (userBranch == "BANGPOO") {
              initialPrint = "MKTBP";
            } else {
              initialPrint = "MKTRY";
            }
          } else {
            if (userBranch == "BANGPOO") {
              initialPrint = "TTCBP";
            } else {
              initialPrint = "TTCRY";
            }
          }
          routinePrinter = initialPrint;
          return AlertDialog(
            title: Text('CONFIRM CREATE REQUEST'),
            content: Text('SELECT PRINTER'),
            actions: <Widget>[
              FormBuilderSegmentedControl(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                name: 'printer',
                initialValue: initialPrint,
                options: [
                  FormBuilderFieldOption(
                      value: 'MKTBP', child: Text('MARKETING BANGPOO')),
                  FormBuilderFieldOption(
                      value: 'MKTRY', child: Text('MARKETING RAYONG')),
                  FormBuilderFieldOption(
                      value: 'TTCBP', child: Text('TTC BANGPOO')),
                  FormBuilderFieldOption(
                      value: 'TTCRY', child: Text('TTC RAYONG')),
                ],
                onChanged: (value) {
                  routinePrinter = value.toString();
                },
              ),
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

  _dismissDialog() {
    Navigator.pop(context);
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

  final _formKey = GlobalKey<FormBuilderState>();
  int step = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocBuilder<ManageDataRoutineRequest, int>(
          builder: (context, state) {
            step = state;
            print("state in $state");
            if (state > 0) {
              EasyLoading.dismiss();
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 15, bottom: 15),
                      width: 600,
                      height: 280,
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
                              //height: heightBox1,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: widthsection1,
                                    child: Text(
                                      "CUSTOMER",
                                      style: stylesection,
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomSearchableDropDown(
                                      primaryColor: Colors.black,
                                      menuMode: true,
                                      labelStyle: styledata,
                                      items: masterCustormerRoutine,
                                      label: 'SELECT CUSTOMER',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Icon(Icons.search),
                                      ),
                                      dropDownMenuItems:
                                          masterCustormerRoutine.map((item) {
                                        return item.custFull;
                                      }).toList(),
                                      onChanged: (value) {
                                        initialRoutineRequestData();
                                        initialRoutineSampletData();
                                        if (value != null) {
                                          for (int i = 0; i < 5; i++) {
                                            requestData[i].custId =
                                                value.custId.toString();
                                            requestData[i].custFull =
                                                value.custFull.toString();
                                            requestData[i].custShort =
                                                value.custShort.toString();
                                            requestData[i].branch =
                                                value.branch.toString();
                                            requestData[i].code =
                                                value.code.toString();
                                            requestData[i].incharge =
                                                value.incharge.toString();
                                            requestData[i].subLeader =
                                                value.subLeader.toString();
                                            requestData[i].gl =
                                                value.gl.toString();
                                            requestData[i].jp =
                                                value.jp.toString();
                                            requestData[i].dmg =
                                                value.dmg.toString();
                                          }
                                          /*  setState(() { */
                                          routineCusmerName =
                                              requestData[0].custFull;
                                          EasyLoading.show(
                                              status: 'loading...');
                                          clearData();
                                          context
                                              .read<ManageDataRoutineRequest>()
                                              .add(EventRoutineRequestPage
                                                  .reselectCustomer);

                                          context
                                              .read<ManageDataRoutineRequest>()
                                              .add(EventRoutineRequestPage
                                                  .findCustomerData);
                                          /*  }); */
                                          /* context
                                          .read<ManageDataRoutineRequest>()
                                          .add(EventRoutineRequestPage
                                              .findCustomerData); */

                                          /* print(
                                                    'requestHeadData: ${requestHeadData}');
                                                print(
                                                    'requestHeadData[0]: ${requestHeadData[0]}');
                                                print(
                                                    'requestHeadData[0].custShort: ${requestHeadData[4].custShort}'); */
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (state == 2)
                              Expanded(
                                child: Builder(builder: (BuildContext context) {
                                  DateTime now = DateTime.now();
                                  var requestRound =
                                      custormerRoutineAnalysisData[0]
                                          .requestRound;
                                  EasyLoading.dismiss();
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: heightBox1,
                                        /* decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 0)), */
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    border:
                                                        OutlineInputBorder()),
                                                initialValue: now,
                                                inputType: InputType.date,
                                                name: 'samplingDate',
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
                                              MainAxisAlignment.center,
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
                                                requestRound,
                                                style: styledata,
                                              ),
                                            )
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
                                              MainAxisAlignment.start,
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
                                            ElevatedButton(
                                              child: Text("SELECT FILE",
                                                  style: styledata),
                                              style: ElevatedButton.styleFrom(
                                                textStyle: styledata,
                                                // primary: Colors.blue,
                                                /* padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 20), */
                                              ),
                                              onPressed: () {},
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
                                              MainAxisAlignment.start,
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
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    border:
                                                        OutlineInputBorder()),
                                                name: 'requestRemark',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                              child:
                                                  Text("SAVE AND PRINT LABEL"),
                                              onPressed: () {
                                                _formKey.currentState?.save();
                                                manageRequestData();
                                                selectPrint();
                                              }),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                          ]),
                    ),
                  ),
                  if (state == 2) ...[
                    Builder(builder: (BuildContext context) {
                      DateTime now = DateTime.now();
                      var requestRound =
                          custormerRoutineAnalysisData[0].requestRound;
                      //List<AnalysisData> data = snapshot.data;
                      for (int i = 0;
                          i < custormerRoutineAnalysisData.length;
                          i++) {
                        if (sampleCount !=
                            custormerRoutineAnalysisData[i].sampleNo) {
                          sampleCount =
                              custormerRoutineAnalysisData[i].sampleNo;
                          requestData[sampleCount - 1].sampleNo =
                              custormerRoutineAnalysisData[i].sampleNo;
                          requestData[sampleCount - 1].sampleName =
                              custormerRoutineAnalysisData[i].sampleName;
                          requestData[sampleCount - 1].sampleGroup =
                              custormerRoutineAnalysisData[i].sampleGroup;
                          requestData[sampleCount - 1].sampleType =
                              custormerRoutineAnalysisData[i].sampleType;
                          requestData[sampleCount - 1].sampleTank =
                              custormerRoutineAnalysisData[i].sampleTank;
                          requestData[sampleCount - 1].requestRound =
                              requestRound;
                        }
                      }
                      //print("length:${requestData.length}");
                      requestData.removeRange(sampleCount, requestData.length);
                      //print("length:${requestData.length}");
                      itemCount = custormerRoutineAnalysisData.length;
                      for (int j = 0;
                          j < custormerRoutineAnalysisData.length;
                          j++) {
                        sampleData[j].custId = requestData[0].custId;
                        sampleData[j].custFull = requestData[0].custFull;
                        sampleData[j].custShort = requestData[0].custShort;
                        sampleData[j].branch = requestData[0].branch;
                        sampleData[j].code = requestData[0].code;
                        sampleData[j].incharge = requestData[0].incharge;
                        sampleData[j].requestRound =
                            requestData[0].requestRound;
                        sampleData[j].sampleNo =
                            custormerRoutineAnalysisData[j].sampleNo;
                        sampleData[j].groupNameTs = "";
                        sampleData[j].sampleGroup =
                            custormerRoutineAnalysisData[j].sampleGroup;
                        sampleData[j].sampleType =
                            custormerRoutineAnalysisData[j].sampleType;
                        sampleData[j].sampleTank =
                            custormerRoutineAnalysisData[j].sampleTank;
                        sampleData[j].sampleName =
                            custormerRoutineAnalysisData[j].sampleName;
                        sampleData[j].sampleAmount = 1;
                        sampleData[j].itemNo =
                            custormerRoutineAnalysisData[j].itemNo;
                        sampleData[j].instrumentName =
                            custormerRoutineAnalysisData[j].instrumentName;
                        sampleData[j].itemName =
                            custormerRoutineAnalysisData[j].itemName;
                        sampleData[j].itemStatus = "WAIT SAMPLE";
                        sampleData[j].position =
                            custormerRoutineAnalysisData[j].position;
                        sampleData[j].mag = custormerRoutineAnalysisData[j].mag;
                        sampleData[j].temp =
                            custormerRoutineAnalysisData[j].temp;
                        sampleData[j].stdMax =
                            custormerRoutineAnalysisData[j].stdMax;
                        sampleData[j].stdMin =
                            custormerRoutineAnalysisData[j].stdMin;
                        if (sampleData[j].sampleNo == 1) {
                          item1 = item1 +
                              custormerRoutineAnalysisData[j]
                                  .itemName
                                  .toString() +
                              " ";
                          print(
                              "item1${custormerRoutineAnalysisData[j].itemName.toString()} j : $j");
                        }
                        if (sampleData[j].sampleNo == 2) {
                          item2 = item2 +
                              custormerRoutineAnalysisData[j]
                                  .itemName
                                  .toString() +
                              " ";
                        }
                        if (sampleData[j].sampleNo == 3) {
                          item3 = item3 +
                              custormerRoutineAnalysisData[j]
                                  .itemName
                                  .toString() +
                              " ";
                        }
                        if (sampleData[j].sampleNo == 4) {
                          item4 = item4 +
                              custormerRoutineAnalysisData[j]
                                  .itemName
                                  .toString() +
                              " ";
                        }
                        if (sampleData[j].sampleNo == 5) {
                          item5 = item5 +
                              custormerRoutineAnalysisData[j]
                                  .itemName
                                  .toString() +
                              " ";
                        }
                      }
                      createGroupItem();
                      //print("item1:$itemToSearch1");
                      //print("item1 name:${itemToSearch1[0].itemName}");
                      //print("item:$itemCount");
                      //print("length:${sampleData.length}");
                      sampleData.removeRange(itemCount, sampleData.length);
                      //print("length:${sampleData.length}");
                      //print(requestSampleData[0]["sampleGroup"]);
                      print("Sample:$sampleCount");
                      return Container(
                        width: 1200,
                        height: 370,
                        /*  decoration: BoxDecoration(
                          color: CustomTheme.colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          boxShadow: [
                            BoxShadow(
                                color: CustomTheme.colorShadowBgStrong,
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 0)
                          ],
                        ), */
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //Sample 1
//-----------------------------------------------------------------------------------------------------------------------------------
                                if (sampleCount > 0)
                                  SizedBox(
                                    width: 25,
                                  ),
                                Container(
                                  height: 350,
                                  width: 450,
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 15, bottom: 15),
                                  decoration: BoxDecoration(
                                    color: CustomTheme.colorWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              CustomTheme.colorShadowBgStrong,
                                          offset: Offset(0, 0),
                                          blurRadius: 10,
                                          spreadRadius: 0)
                                    ],
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: FormBuilderCheckbox(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      bottom: 20,
                                                    ),
                                                    border: InputBorder.none,
                                                    /*  border:
                                                            OutlineInputBorder() */
                                                  ),
                                                  name: 'sampleStatus1',
                                                  initialValue: true,
                                                  title: Text('SAMPLE SEND',
                                                      style: stylesection),
                                                ),
                                              ),
                                              Expanded(
                                                child: FormBuilderCheckbox(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      bottom: 20,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  name: 'printStatus1',
                                                  initialValue: true,
                                                  title: Text('PRINT',
                                                      style: stylesection),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("GROUP",
                                                    style: stylesection),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 10,
                                                      bottom: heightBox2 / 2,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  style: styledata,
                                                  name: 'group1',
                                                  initialValue: requestData[0]
                                                      .sampleGroup,
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("SAMPLE TYPE",
                                                    style: stylesection),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  style: styledata,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 10,
                                                      bottom: heightBox2 / 2,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  name: 'type1',
                                                  initialValue:
                                                      requestData[0].sampleType,
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("SAMPLE TANK",
                                                    style: stylesection),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  style: styledata,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 10,
                                                      bottom: heightBox2 / 2,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  name: 'tank1',
                                                  initialValue:
                                                      requestData[0].sampleTank,
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("SAMPLE NAME",
                                                    style: stylesection),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  style: styledata,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 10,
                                                      bottom: heightBox2 / 2,
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  name: 'name1',
                                                  initialValue:
                                                      requestData[0].sampleName,
                                                  enabled: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("AMOUNT",
                                                    style: stylesection),
                                              ),
                                              Container(
                                                width: 99,
                                                child: SpinBox(
                                                    textStyle: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    min: 1,
                                                    value: 1,
                                                    step: 1,
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        amountSample1 = value;
                                                      }
                                                    }), /* FormBuilderTextField(
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                        bottom: heightBox2 /
                                                            2,),
                                                        border:
                                                            OutlineInputBorder()),
                                                    name: 'amont1',
                                                    initialValue: "1",
                                                    enabled: false,
                                                  ), */
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("ITEM",
                                                    style: stylesection),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  style: styledata,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 5,
                                                      bottom: heightBox2 / 2,
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  name: 'item1',
                                                  initialValue: item1,
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          //height: heightBox2,
                                          /*  decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("ADD ITEM",
                                                    style: stylesection),
                                              ),
                                              Expanded(
                                                child: CustomSearchableDropDown(
                                                  items: itemToSearch1,
                                                  label: 'SELECT ADD ITEM',
                                                  multiSelectValuesAsWidget:
                                                      true,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue)),
                                                  multiSelect: true,
                                                  dropDownMenuItems:
                                                      itemToSearch1.map((item) {
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
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("ATTACH FILE",
                                                    style: stylesection),
                                              ),
                                              ElevatedButton(
                                                child: Text(
                                                  "SELECT FILE",
                                                  style: styledata,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: heightBox2,
                                          /* decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0)), */
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: widthsection2,
                                                child: Text("REMARK",
                                                    style: stylesection),
                                              ),
                                              Expanded(
                                                child: FormBuilderTextField(
                                                  style: styledata,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border:
                                                          OutlineInputBorder()),
                                                  name: 'sampleRemark1',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                //SAMPLE 2
                                /*---------------------------------------------------------------------------------------------------------------------------------------*/
                                if (sampleCount > 1)
                                  Container(
                                    height: 350,
                                    width: 450,
                                    padding: EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 15,
                                        bottom: 15),
                                    decoration: BoxDecoration(
                                      color: CustomTheme.colorWhite,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                CustomTheme.colorShadowBgStrong,
                                            offset: Offset(0, 0),
                                            blurRadius: 10,
                                            spreadRadius: 0)
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'sampleStatus2',
                                                    initialValue: true,
                                                    title: Text('SAMPLE SEND',
                                                        style: stylesection),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'printStatus2',
                                                    initialValue: true,
                                                    title: Text('PRINT',
                                                        style: stylesection),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("GROUP",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    style: styledata,
                                                    name: 'group2',
                                                    initialValue: requestData[1]
                                                        .sampleGroup,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TYPE",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'type2',
                                                    initialValue: requestData[1]
                                                        .sampleType,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TANK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'tank2',
                                                    initialValue: requestData[1]
                                                        .sampleTank,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE NAME",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    name: 'name2',
                                                    initialValue: requestData[1]
                                                        .sampleName,
                                                    enabled: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("AMOUNT",
                                                      style: stylesection),
                                                ),
                                                Container(
                                                  width: 99,
                                                  child: SpinBox(
                                                      textStyle: styledata,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      min: 1,
                                                      value: 1,
                                                      step: 1,
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          amountSample2 = value;
                                                        }
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'item2',
                                                    initialValue: item2,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ADD ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child:
                                                      CustomSearchableDropDown(
                                                    items: itemToSearch2,
                                                    label: 'SELECT ADD ITEM',
                                                    multiSelectValuesAsWidget:
                                                        true,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.blue)),
                                                    multiSelect: true,
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
                                                      } else {}
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ATTACH FILE",
                                                      style: stylesection),
                                                ),
                                                ElevatedButton(
                                                  child: Text(
                                                    "SELECT FILE",
                                                    style: styledata,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("REMARK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder()),
                                                    name: 'sampleRemark2',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                SizedBox(
                                  width: 25,
                                ),
//SAMPLE 3
//--------------------------------------------------------------------------------------------------------------------------------
                                if (sampleCount > 2)
                                  Container(
                                    height: 350,
                                    width: 450,
                                    padding: EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 15,
                                        bottom: 15),
                                    decoration: BoxDecoration(
                                      color: CustomTheme.colorWhite,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                CustomTheme.colorShadowBgStrong,
                                            offset: Offset(0, 0),
                                            blurRadius: 10,
                                            spreadRadius: 0)
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'sampleStatus3',
                                                    initialValue: true,
                                                    title: Text('SAMPLE SEND',
                                                        style: stylesection),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'printStatus3',
                                                    initialValue: true,
                                                    title: Text('PRINT',
                                                        style: stylesection),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("GROUP",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    style: styledata,
                                                    name: 'group3',
                                                    initialValue: requestData[2]
                                                        .sampleGroup,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TYPE",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'type3',
                                                    initialValue: requestData[2]
                                                        .sampleType,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TANK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'tank3',
                                                    initialValue: requestData[2]
                                                        .sampleTank,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE NAME",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    name: 'name3',
                                                    initialValue: requestData[2]
                                                        .sampleName,
                                                    enabled: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("AMOUNT",
                                                      style: stylesection),
                                                ),
                                                Container(
                                                  width: 99,
                                                  child: SpinBox(
                                                      textStyle: styledata,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      min: 1,
                                                      value: 1,
                                                      step: 1,
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          amountSample3 = value;
                                                        }
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'item3',
                                                    initialValue: item3,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ADD ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child:
                                                      CustomSearchableDropDown(
                                                    items: itemToSearch3,
                                                    label: 'SELECT ADD ITEM',
                                                    multiSelectValuesAsWidget:
                                                        true,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.blue)),
                                                    multiSelect: true,
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
                                                      } else {}
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ATTACH FILE",
                                                      style: stylesection),
                                                ),
                                                ElevatedButton(
                                                  child: Text(
                                                    "SELECT FILE",
                                                    style: styledata,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("REMARK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder()),
                                                    name: 'sampleRemark3',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                SizedBox(
                                  width: 25,
                                ),
//SAMPLE 4
//-----------------------------------------------------------------------------------------------------
                                if (sampleCount > 3)
                                  Container(
                                    height: 350,
                                    width: 450,
                                    padding: EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 15,
                                        bottom: 15),
                                    decoration: BoxDecoration(
                                      color: CustomTheme.colorWhite,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                CustomTheme.colorShadowBgStrong,
                                            offset: Offset(0, 0),
                                            blurRadius: 10,
                                            spreadRadius: 0)
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'sampleStatus4',
                                                    initialValue: true,
                                                    title: Text('SAMPLE SEND',
                                                        style: stylesection),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'printStatus4',
                                                    initialValue: true,
                                                    title: Text('PRINT',
                                                        style: stylesection),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("GROUP",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    style: styledata,
                                                    name: 'group4',
                                                    initialValue: requestData[3]
                                                        .sampleGroup,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TYPE",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'type4',
                                                    initialValue: requestData[3]
                                                        .sampleType,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TANK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'tank4',
                                                    initialValue: requestData[3]
                                                        .sampleTank,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE NAME",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    name: 'name4',
                                                    initialValue: requestData[3]
                                                        .sampleName,
                                                    enabled: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("AMOUNT",
                                                      style: stylesection),
                                                ),
                                                Container(
                                                  width: 99,
                                                  child: SpinBox(
                                                      textStyle: styledata,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      min: 1,
                                                      value: 1,
                                                      step: 1,
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          amountSample4 = value;
                                                        }
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'item4',
                                                    initialValue: item4,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ADD ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child:
                                                      CustomSearchableDropDown(
                                                    items: itemToSearch4,
                                                    label: 'SELECT ADD ITEM',
                                                    multiSelectValuesAsWidget:
                                                        true,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.blue)),
                                                    multiSelect: true,
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ATTACH FILE",
                                                      style: stylesection),
                                                ),
                                                ElevatedButton(
                                                  child: Text(
                                                    "SELECT FILE",
                                                    style: styledata,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("REMARK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder()),
                                                    name: 'sampleRemark4',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                SizedBox(
                                  width: 25,
                                ),
//SAMPLE 5
//------------------------------------------------------------------------------------------------------------
                                if (sampleCount > 4)
                                  Container(
                                    height: 350,
                                    width: 450,
                                    padding: EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 15,
                                        bottom: 15),
                                    decoration: BoxDecoration(
                                      color: CustomTheme.colorWhite,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                CustomTheme.colorShadowBgStrong,
                                            offset: Offset(0, 0),
                                            blurRadius: 10,
                                            spreadRadius: 0)
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'sampleStatus5',
                                                    initialValue: true,
                                                    title: Text('SAMPLE SEND',
                                                        style: stylesection),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: FormBuilderCheckbox(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        bottom: 20,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'printStatus5',
                                                    initialValue: true,
                                                    title: Text('PRINT',
                                                        style: stylesection),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("GROUP",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    style: styledata,
                                                    name: 'group5',
                                                    initialValue: requestData[4]
                                                        .sampleGroup,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TYPE",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'type5',
                                                    initialValue: requestData[4]
                                                        .sampleType,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE TANK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'tank5',
                                                    initialValue: requestData[4]
                                                        .sampleTank,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("SAMPLE NAME",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    name: 'name5',
                                                    initialValue: requestData[4]
                                                        .sampleName,
                                                    enabled: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("AMOUNT",
                                                      style: stylesection),
                                                ),
                                                Container(
                                                  width: 99,
                                                  child: SpinBox(
                                                      textStyle: styledata,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      min: 1,
                                                      value: 1,
                                                      step: 1,
                                                      onChanged: (value) {
                                                        if (value != null) {
                                                          amountSample5 = value;
                                                        }
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        bottom: heightBox2 / 2,
                                                      ),
                                                      border: InputBorder.none,
                                                    ),
                                                    name: 'item5',
                                                    initialValue: item5,
                                                    enabled: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ADD ITEM",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child:
                                                      CustomSearchableDropDown(
                                                    items: itemToSearch5,
                                                    label: 'SELECT ADD ITEM',
                                                    multiSelectValuesAsWidget:
                                                        true,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.blue)),
                                                    multiSelect: true,
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
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("ATTACH FILE",
                                                      style: stylesection),
                                                ),
                                                ElevatedButton(
                                                  child: Text(
                                                    "SELECT FILE",
                                                    style: styledata,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: heightBox2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: widthsection2,
                                                  child: Text("REMARK",
                                                      style: stylesection),
                                                ),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    style: styledata,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          bottom:
                                                              heightBox2 / 2,
                                                        ),
                                                        border:
                                                            OutlineInputBorder()),
                                                    name: 'sampleRemark5',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                SizedBox(
                                  width: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              );
            } else {
              EasyLoading.show(status: 'loading...');
              return Container();
            }
          },
        ));
  }
}
