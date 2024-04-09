import 'package:flutter/cupertino.dart';

//String url = "http://192.168.1.200:1885";
String url = "http://172.23.10.51:1885";
String urlE = "http://172.23.10.51:3002";
//String url = "http://127.0.0.1:1885";
//Login
String GloUserID = '';
String GloPassword = '';
String userName = '';
String userSection = '';
String userBranch = '';
int userRoleId = 0;
String currentPage = "";
String lastPage = "";
String buffferLastPage = "";
String alertText = "";
int timeOut = 120;

late BuildContext contextBG;

/* List errorData = [
  "",
  "NOT ANALYSIS",
  "SAMPLE ERROR",
  "ANALYSIS ERROR",
  "INSTRUMENT BREAKDOWN",
  "CONFIRM RESULT",
  "DELIVERY ERROR",
  "CAN NOT ANALYSIS"
]; */
List errorData = [
  "",
  "SAMPLE ERROR",
  "ANALYSIS ERROR",
  "CAN NOT ANALYSIS",
  "INSTRUMENT BREAKDOWN",
  "DELIVERY ERROR",
];

List<String> listStatusRequest = [
  "",
  "WAIT SAMPLE",
  "SEND SAMPLE",
  "RECEIVE SAMPLE",
  "WAIT ANALYSIS",
  "APPROVE",
  "COMPLETE",
  "CANCEL"
];

List<String> listStatusItem = [
  "WAIT SAMPLE",
  "SEND SAMPLE",
  "REJECT SAMPLE",
  "RECEIVE SAMPLE",
  "LIST NORMAL",
  "FINISH NORMAL",
  "RECHECK",
  "LIST RECHECK",
  "FINISH REHECK",
  "REQUEST RECONFIRM",
  "RECONFIRM",
  "LIST RECONFIRM",
  "FINISH RECONFIRM",
  "APPROVE",
  "COMPLETE",
  "CANCEL ITEM",
  "NOT ANAYSIS",
  "NOT SEND SAMPLE"
];

// sharedpreferences
// prefs.getString('token') ?? '');
// prefs.getString('currentPage');
// prefs.getString('MainPage_CurrentPageTable');
// prefs.getString('ApproveResultDetailPage_reqNo');
// prefs.getString('ItemDetailPage_itemId');//Not Use
// prefs.getString('RoutineRequestDetailTTCPage_reqNo')
// prefs.getString('RoutineRequestDetailRequesterPage_reqNo')
// prefs.setString('InputAnalysisDataPage_InstrumentName', dataBuff.instrumentName.toString());

//role security setup
// 1 Normal user
// 5 Approver User
// 9 Admin User

int sePage1 = 0;
int sePage2 = 0;
int sePage3 = 0;
int sePage4 = 0;
int sePage5 = 0;
int sePage6 = 0;
int sePage7 = 0;
int sePage8 = 0;
int sePage9 = 0;
int sePage10 = 0;

//Page setupname
String mainPage = "mainPage";
String routineRequestPage = "RoutineRequestPage";
String Page3 = "Page3";
String Page4 = "Page4";
String Page5 = "Page5";
String Page6 = "Page6";
String Page7 = "Page7";
String Page8 = "Page8";
String Page9 = "Page9";
String Page10 = "Page10";
