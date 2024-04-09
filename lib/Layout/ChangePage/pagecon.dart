import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/refreshPage.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/AnalysisPage.dart';
import 'package:tpk_login_arsa_01/page/11ApproveResultPage/ApproveResultPage.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SummaryDataPage.dart';
import 'package:tpk_login_arsa_01/page/13EditPatternLab/EditPatternLab.dart';
import 'package:tpk_login_arsa_01/page/1LoginPage/loginpage.dart';
import 'package:tpk_login_arsa_01/page/2Mainapage/MainPage.dart';
import 'package:tpk_login_arsa_01/page/30RequestDetailTTC/RoutineRequestDetailTTCPage.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/RoutineRequestDetailRequesterPage.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/InputAnalysisDataPage.dart';
import 'package:tpk_login_arsa_01/page/3RoutineRequestPage/RoutineRequestPage.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/RequestListPage.dart';
import 'package:tpk_login_arsa_01/page/6SendSamplePage/SendSamplePage.dart';
import 'package:tpk_login_arsa_01/page/7ReceiveSamplePage/ReceiveSamplePage.dart';
import 'package:tpk_login_arsa_01/page/8ListJobPage/ListJobPage.dart';
import 'package:tpk_login_arsa_01/page/9ItemListPage/ItemListPage.dart';

Widget selectpage(String input) {
  Widget output = LoginPage();
  print("Page IN SelectPage : $input");
  if (input == "MainPage") {
    output = MainPage();
  } else if (input == "RoutineRequestPage") {
    output = RoutineRequestPage();
  } else if (input == "RequestListPage") {
    output = RequestListPage();
  } else if (input == "RequestListPage") {
    output = RequestListPage();
  } else if (input == "SendSamplePage") {
    output = SendSamplePage();
  } else if (input == "ReceiveSamplePage") {
    output = ReceiveSamplePage();
  } else if (input == "ListJobPage") {
    output = ListJobPage();
  } else if (input == "ItemListPage") {
    output = ItemListPage();
  } else if (input == "AnalysisPage") {
    output = AnalysisPage();
  } else if (input == "ApproveResultPage") {
    output = ApproveResultPage();
  } else if (input == "RoutineRequestDetailTTCPage") {
    output = RoutineRequestDetailTTCPage();
  } else if (input == "InputAnalysisDataPage") {
    output = InputAnalysisDataPage();
  } else if (input == "RoutineRequestDetailRequesterPage") {
    output = RoutineRequestDetailRequesterPage();
  } else if (input == "RefreshPage") {
    output = RefreshPage();
  } else if (input == "SummaryDataPage") {
    output = SummaryDataPage();
  } else if (input == "EditPatternLabPage") {
    output = EditPatternLabPage();
  }
  /* else if (input == "Page10") {
    output = Page10();
  } else if (input == 'LoginPage') {
    output = LoginPage();
  }  */
  else {
    output = LoginPage();
  }
  return output;
}

bool page_selected(String input1, String input2) {
  bool output = false;

  if (input1 == input2) {
    output = true;
  } else {
    output = false;
  }

  return output;
}
