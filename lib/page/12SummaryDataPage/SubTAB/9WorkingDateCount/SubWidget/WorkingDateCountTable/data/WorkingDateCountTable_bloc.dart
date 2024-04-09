import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/9WorkingDateCount/SubWidget/WorkingDateCountTable/data/WorkingDateCountTableStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/9WorkingDateCount/SubWidget/WorkingDateCountTable/data/WorkingDateCountTable_event.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/9WorkingDateCount/WorkingDateCount.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
//----------------------------------------------------------------

class ManageDataWorkingDateCount extends Bloc<WorkingDateCountEvent, int> {
  ManageDataWorkingDateCount() : super(0);

  @override
  Stream<int> mapEventToState(WorkingDateCountEvent event) async* {
    if (event == WorkingDateCountEvent.clearAndSearch) {
      yield* clearAndSearch();
    } else if (event == WorkingDateCountEvent.searchKPIdata) {
      yield* searchKPIData();
    }
  }
}

Stream<int> clearAndSearch() async* {
  yield 0;
  WorkingDateCountContext.read<ManageDataWorkingDateCount>()
      .add(WorkingDateCountEvent.searchKPIdata);
}

List<SearchWorkingDateCountModel> searchOption = [];
List<WorkingDateCountModel> dataTableWorkingDateCount = [];
Stream<int> searchKPIData() async* {
  Map<String, String> qParams = {
    'SearchOption': jsonEncode(searchOption),
  };
  EasyLoading.show(status: 'loading...');
  print("in /SummaryDataPage/WorkingDateCount_searchWorkingDateCountData");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$urlE/SummaryDataPage/WorkingDateCount_searchWorkingDateCountData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      if (response.body != "error") {
        //print(response.body);
        if (response.body != "[]") {
          EasyLoading.dismiss();
          dataTableWorkingDateCount =
              WorkingDateCountModelFromJson(response.body);
          yield 2;
        } else {
          EasyLoading.dismiss();
          alertError("NOT FOUND DATA");
          //yield 2;
        }
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
      }
    }
  } on TimeoutException catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    EasyLoading.dismiss();
    alertNetworkError();
  }
}

List<MasterCustomerRoutine> masterCustomer = [];
List<String> masterCustomerSearch = [];
List<MasterInstrument> instrumentData = [];
List<String> masterInstrumentSearch = [];
List<String> monthSearch = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  '9',
  "10",
  "11",
  "12"
];
List<String> yearSearch = [
  "2022",
  "2023",
  "2024",
  "2025",
  "2026",
  "2027",
  "2028",
  "2029",
  '2030',
  "2031",
  "2032",
  "2033",
  '2034',
  "2035",
  "2036",
  "2037",
  '2038',
  "2039",
  "2040"
];

Future searchMasterOption() async {
  print('in searchMasterOption');
  try {
    final response = await http
        .post(Uri.parse(
            "$urlE/SummaryDataPage/WorkingDateCount_searchMasterOption"))
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      dynamic buffObjData = jsonDecode(response.body);
      //Master Customer
      masterCustomerSearch.clear();
      // data from backend res.send({ masterCustomer: data[0], masterInstrument: data[1] });
      //print(buffData['masterCustomer']);
      String buffStringData = jsonEncode(buffObjData['masterCustomer']);
      masterCustomer = masterCustomerRoutineFromJson(buffStringData);

      for (int i = 0; i < masterCustomer.length; i++) {
        masterCustomerSearch.add(masterCustomer[i].custSearch);
      }

      //Master Instrument
      masterInstrumentSearch.clear();
      buffStringData = jsonEncode(buffObjData['masterInstrument']);
      instrumentData = masterInstrumentFromJson(buffStringData);
      //print(instrumentData);
      for (int i = 0; i < instrumentData.length; i++) {
        masterInstrumentSearch.add(instrumentData[i].instrumentName);
      }

      WorkingDateCountContext.read<ManageDataWorkingDateCount>()
          .add(WorkingDateCountEvent.clearAndSearch);

      return 1;
    } else {
      alertError("System Error");
      return 1;
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
    return 0;
  } on Error catch (e) {
    print(e);
    alertNetworkError();
    return 0;
  }
}
