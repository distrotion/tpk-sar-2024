import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/src/provider.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPDF/ShowPDF.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/RoutineRequestDetailRequesterPage.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/SubWidget/KAC_Report/data/KACReportStructure.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/data/RoutineRequestDetailRequesterPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/31RequestDetailRequester/data/RoutineRequestDetailRequesterPage_event.dart';

List<KACReportDataModel> kACReportData = [];
bool newCreate = true;
Future searchKACReportData(String reqNo) async {
  Map<String, String> qParams = {
    'reqNo': reqNo,
  };
  print("in searchKACReportData");
  try {
    final response = await http
        .post(Uri.parse("$urlE/KACReportData_searchKACReportData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      //print(response.body);
      kACReportData = KACReportDataModelFromJson(response.body);
      if (kACReportData[0].createReportDate == "") {
        newCreate = true;
      } else {
        newCreate = false;
      }

      var buffSubLeader = kACReportData[0].subLeader;
      var buffGl = kACReportData[0].gl;
      var buffJp = kACReportData[0].jp;
      var buffDgm = kACReportData[0].dgm;
      var buffPattern = kACReportData[0].patternReport;
      var buffSamplingDate = kACReportData[0].samplingDate;

      if (kACReportData[kACReportData.length - 1].reportOrder == 9999) {
        buffSubLeader = kACReportData[kACReportData.length - 1].subLeader;
        buffGl = kACReportData[kACReportData.length - 1].gl;
        buffJp = kACReportData[kACReportData.length - 1].jp;
        buffDgm = kACReportData[kACReportData.length - 1].dgm;
        buffPattern = kACReportData[kACReportData.length - 1].patternReport;
        buffSamplingDate = kACReportData[kACReportData.length - 1].samplingDate;
        kACReportData.removeAt(kACReportData.length - 1);
      }

      if (kACReportData[0].createReportDate == "") {
        double buff = 0;
        for (int i = 0; i < kACReportData.length; i++) {
          kACReportData[i].reviseNo = 0;
          if (kACReportData[i].sampleNo == 0) {
            //data from manual input after see result from lab
            kACReportData[i].enabled = true;
          } else if (kACReportData[i].std1 == "") {
            //data from manual input
            kACReportData[i].enabled = false;
          } else {
            /*  buff = (double.parse(kACReportData[i].result) +
                      double.parse(kACReportData[i].std1) -
                      double.parse(kACReportData[i].std2)) *
                  double.parse(kACReportData[i].std3) /
                  double.parse(kACReportData[i].std4);
              buff = ((buff +
                      double.parse(kACReportData[i].std5) -
                      double.parse(kACReportData[i].std6)) *
                  double.parse(kACReportData[i].std7) /
                  double.parse(kACReportData[i].std8));
              kACReportData[i].result = buff.toStringAsFixed(2); */
            if (kACReportData[i].resultIn.toString() == 'DELIVERY ERROR' ||
                kACReportData[i].resultIn.toString() ==
                    'INSTRUMENT BREAKDOWN' ||
                kACReportData[i].resultIn.toString() == '' ||
                kACReportData[i].resultIn.toString() == '-') {
              kACReportData[i].resultIn = "N/A";
            } else {
              try {
                if (double.parse(kACReportData[i].resultIn) is double) {
                  kACReportData[i].enabled = false;
                }
              } on Exception catch (e) {
                /* kACReportData[i].enabled = true; */
                kACReportData[i].enabled = false;
                //print('$i not double');
              }
            }
            /* try {
              if (i != 0) {
                if (kACReportData[i].reportOrder ==
                    kACReportData[i - 1].reportOrder) {
                  kACReportData[i - 1].resultIn =
                      ((double.parse(kACReportData[i].resultIn) +
                                  double.parse(kACReportData[i - 1].resultIn)) /
                              2)
                          .toStringAsFixed(2);
                  kACReportData.removeAt(i);
                  i--;
                }
              }
            } on Exception catch (e) {
              kACReportData.removeAt(i);
              i--;
              kACReportData[i].enabled = true;
              print("error$i $e");
            } */
          }
        }

        //mean result
        for (int i = 0; i < kACReportData.length; i++) {
          //print('$i');
          int countSameOrder = 1;
          List buffData = [];
          for (int j = i; j < kACReportData.length; j++) {
            if (j + 1 < kACReportData.length) {
              if (kACReportData[j].reportOrder ==
                  kACReportData[j + 1].reportOrder) {
                countSameOrder = countSameOrder + 1;
                //print("countSameOrder : " + countSameOrder.toString());
                if (j == i) {
                  try {
                    if (double.parse(kACReportData[j].resultIn) is double) {
                      buffData.add(kACReportData[j].resultIn);
                    }
                  } on Exception catch (e) {
                    //print ("1" + e.toString());
                  }
                  try {
                    if (double.parse(kACReportData[j + 1].resultIn) is double) {
                      buffData.add(kACReportData[j + 1].resultIn);
                    }
                  } on Exception catch (e) {
                    //print("2" + e.toString());
                  }
                } else {
                  try {
                    if (double.parse(kACReportData[j + 1].resultIn) is double) {
                      buffData.add(kACReportData[j + 1].resultIn);
                    }
                  } on Exception catch (e) {
                    //print("3" + e.toString());
                  }
                }
              } else {
                //mean value
                //print('not same');
                double buffMean = 0;
                for (int k = 0; k < buffData.length; k++) {
                  buffMean = buffMean + (double.parse(buffData[k]));
                }

                if (countSameOrder > 1) {
                  kACReportData[i].resultIn =
                      (buffMean / buffData.length).toStringAsFixed(2);
                  //print(kACReportData[i].resultIn);
                }
                //remove same report order
                for (int z = 1; z < countSameOrder; z++) {
                  //print('remove');
                  kACReportData.removeAt(i + 1);
                }
                break;
              }
            } else {
              //mean value
              //rint('Over range');
              double buffMean = 0;
              for (int k = 0; k < buffData.length; k++) {
                buffMean = buffMean + (double.parse(buffData[k]));
              }
              if (countSameOrder > 1) {
                kACReportData[i].resultIn =
                    (buffMean / buffData.length).toStringAsFixed(2);
              }
              //remove same report order
              for (int z = 1; z < countSameOrder; z++) {
                //print('remove');
                kACReportData.removeAt(i + 1);
              }
              break;
            }
          }
        }
        //print("99");
        /* kACReportData[i - 1].resultIn =
                      ((double.parse(kACReportData[i].resultIn) +
                                  double.parse(kACReportData[i - 1].resultIn)) /
                              2)
                          .toStringAsFixed(2); */

        for (int i = 0; i < kACReportData.length; i++) {
          kACReportData[i].createReportDate = (DateTime.now()).toString();
          try {
            kACReportData[i].resultIn =
                double.parse(kACReportData[i].resultIn).toStringAsFixed(1);
            kACReportData[i].resultReport = kACReportData[i].resultIn;
          } catch (e) {
            kACReportData[i].resultReport = (kACReportData[i].resultIn);
          }
          if (kACReportData[i].stdMin == '-' ||
              kACReportData[i].stdMin == '' ||
              kACReportData[i].stdMin == '0') {
            kACReportData[i].buffMin = -99999;
          } else {
            try {
              if (double.parse(kACReportData[i].stdMin) is double) {
                kACReportData[i].buffMin =
                    double.parse(kACReportData[i].stdMin);
              }
            } on Exception catch (e) {
              kACReportData[i].buffMin = -99999;
            }
          }
          if (kACReportData[i].stdMax == '-' ||
              kACReportData[i].stdMax == '' ||
              kACReportData[i].stdMax == '0') {
            kACReportData[i].buffMax = 99999;
          } else {
            try {
              if (double.parse(kACReportData[i].stdMax) is double) {
                kACReportData[i].buffMax =
                    double.parse(kACReportData[i].stdMax);
              }
            } on Exception catch (e) {
              kACReportData[i].buffMax = 99999;
            }
          }
        }
        /* 
        for (int i = kACReportData.length - 1; i >= 0; i--) {
          buffPattern = kACReportData[i].patternReport;
          if (kACReportData[i].patternReport != '') {
            break;
          }
        } */
        for (int i = 0; i < kACReportData.length; i++) {
          try {
            kACReportData[i].samplingDate = buffSamplingDate;
            kACReportData[i].incharge = userName;
            kACReportData[i].subLeader = buffSubLeader;
            kACReportData[i].gl = buffGl;
            kACReportData[i].jp = buffJp;
            kACReportData[i].dgm = buffDgm;
            kACReportData[i].patternReport = buffPattern;
            //print("intry$i");
            if (kACReportData[i].resultIn.toString() != null ||
                kACReportData[i].resultIn.toString() != '') {
              /* print(
                  "Result:${kACReportData[i].result.toString()},Max:${kACReportData[i].buffMax.toString()},Min:${kACReportData[i].buffMin.toString()}");
               */
              print(kACReportData[i].itemReportName.toString() +
                  ':' +
                  kACReportData[i].resultIn.toString() +
                  ':' +
                  kACReportData[i].buffMax.toString() +
                  ':' +
                  kACReportData[i].buffMin.toString());
              if (double.parse(kACReportData[i].resultIn.toString()) >
                  kACReportData[i].buffMax) {
                kACReportData[i].evaluation = 'HIGH';
              } else if (double.parse(kACReportData[i].resultIn.toString()) <
                  kACReportData[i].buffMin) {
                kACReportData[i].evaluation = 'LOW';
              } else if (kACReportData[i].controlRange == '' ||
                  kACReportData[i].controlRange == '-') {
                kACReportData[i].evaluation = '-';
              } else {
                kACReportData[i].evaluation = 'PASS';
              }
            } else {
              //print("else$i");
              kACReportData[i].evaluation = '-';
            }
          } on Exception catch (e) {
            //print("error$i $e");
            kACReportData[i].evaluation = '-';
          }
        }
      }
      return 1;
    } else {
      //print("nodata");
      alertNetworkError();
    }
  } on TimeoutException catch (e) {
    //print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    alertNetworkError();
  }
  return 0;
}

// String urlEs = "http://127.0.0.1:3002";

Future<void> createKACReport() async {
  Map<String, String> qParams = {
    'data': KACReportDataModelToJson(kACReportData),
  };
  print("in createKACReport");
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$urlE/KACReportData_createKACReport"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      print(response.body);
      //alertSuccess("CREATE REPORT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
      EasyLoading.dismiss();
      showPDF(response.body, contextBG);
    } else {
      print("nodata");
      EasyLoading.dismiss();
      alertNetworkError();
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
  }
  //return 0;
}

Future<void> reviseKACReport() async {
  print(kACReportData);

  Map<String, String> qParams = {
    'data': KACReportDataModelToJson(kACReportData),
  };
  print("in reviseKACReport");
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$urlE/KACReportData_reviseKACReport"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      print(response.body);
      //alertSuccess("CREATE REPORT COMPLETE");
      contextRoutineRequestDetail
          .read<ManageDataRoutineRequestDetailRequesterPage>()
          .add(RoutineRequestDetailRequesterPageEvent.searchRequestData);
      EasyLoading.dismiss();
      showPDF(response.body, contextBG);
    } else {
      print("nodata");
      EasyLoading.dismiss();
      alertNetworkError();
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
  }
  //return 0;
}

List<KACReportDataModel> kACReportPic = [];

Future<String> saveKACReportPic(String pic) async {
  Map<String, String> qParams = {
    'pic': pic,
    'data': KACReportDataModelToJson(kACReportPic),
  };
  print("in saveKACReportData");
  try {
    String path = '';
    final response = await http
        .post(Uri.parse("$url/KACReportData_saveKACReportPic"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      alertSuccess("SAVE PICTURE COMPLETE");
      print(response.body);
      path = response.body;
      return path;
    } else {
      print("nodata");
      alertNetworkError();
      return '';
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
    return '';
  } on Error catch (e) {
    print(e);
    alertNetworkError();
    return '';
  }
  //return 0;
}
