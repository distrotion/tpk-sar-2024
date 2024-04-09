import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/6ItemRecheckCount/ItemRecheckCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/6ItemRecheckCount/SubWidget/ItemRecheckCountTable/data/ItemRecheckCountTableStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/6ItemRecheckCount/SubWidget/ItemRecheckCountTable/data/ItemRecheckCountTable_event.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
//----------------------------------------------------------------

class ManageDataItemRecheckCount extends Bloc<ItemRecheckCountEvent, int> {
  ManageDataItemRecheckCount() : super(0);

  @override
  Stream<int> mapEventToState(ItemRecheckCountEvent event) async* {
    if (event == ItemRecheckCountEvent.clearAndSearch) {
      yield* clearAndSearch();
    } else if (event == ItemRecheckCountEvent.searchKPIdata) {
      yield* searchKPIData();
    }
  }
}

Stream<int> clearAndSearch() async* {
  yield 0;
  ItemRecheckCountContext.read<ManageDataItemRecheckCount>()
      .add(ItemRecheckCountEvent.searchKPIdata);
}

List<SearchItemRecheckModel> searchOption = [];
List<ItemRecheckCountModel> dataTableItemRecheck = [];
Stream<int> searchKPIData() async* {
  Map<String, String> qParams = {
    'SearchOption': jsonEncode(searchOption),
  };
  EasyLoading.show(status: 'loading...');
  print("in /SummaryDataPage/ItemRecheckCount_searchKPIData");
  try {
    final response = await http
        .post(
            Uri.parse(
                "$urlE/SummaryDataPage/ItemRecheckCount_searchItemRecheckData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      if (response.body != "error") {
        //print(response.body);
        if (response.body != "[]") {
          EasyLoading.dismiss();
          dataTableItemRecheck = ItemRecheckCountModelFromJson(response.body);
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
            "$urlE/SummaryDataPage/ItemRecheckCount_searchMasterOption"))
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

      ItemRecheckCountContext.read<ManageDataItemRecheckCount>()
          .add(ItemRecheckCountEvent.clearAndSearch);

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
