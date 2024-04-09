import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5NoOfItem/NoOfItem.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5NoOfItem/SubWidget/ItemAnalysisGraph/data/NoOfItemGraphStructure.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'NoOfItemGraph_event.dart';

//----------------------------------------------------------------

List<ModelNoOfItemGraph> NoOfItemGraphBuffBP = [];
List<ModelNoOfItemGraph> NoOfItemGraphBuffRY = [];
List<ModelNoOfItemGraph> NoOfItemGraphBuff = [];

class ManageDataNoOfItem extends Bloc<NoOfItemEvent, int> {
  ManageDataNoOfItem() : super(0);

  @override
  Stream<int> mapEventToState(NoOfItemEvent event) async* {
    if (event == NoOfItemEvent.clearState) {
      yield* clearState();
    } else if (event == NoOfItemEvent.fetchSampleData) {
      yield* fetchSampleData();
    } /*  else if (event == NoOfItemEvent.searchSampleData) {
      yield* searchSampleData();
    } */
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

Future<int> fetchNoOfItemGraph(String branch) async {
  print('fetchNoOfItemGraph');
  Map<String, String> qParams = {
    'Branch': branch,
  };
  EasyLoading.show(status: 'loading...');
  print("in fetchNoOfItemGraph");
  try {
    /* final response = await http
        .post(Uri.parse("$url/NoOfItem_fetchNoOfItemGraph"), body: qParams)
        .timeout(Duration(seconds: timeOut)); */
    final response = await http
        .post(Uri.parse("$urlE/SummaryDataPage/NoOfItem_fetchNoOfItemGraph"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      if (response.body != "error") {
        List<ModelNoOfItemGraph> buffer =
            ModelNoOfItemGraphFromJson(response.body);

        //remove date 0 data
        if (branch == "BANGPOO") {
          print("IN BP");
          NoOfItemGraphBuffBP = buffer;
        } else {
          print("IN RAYONG");
          NoOfItemGraphBuffRY = buffer;
        }
        NoOfItemGraphBuff = buffer;
      }
    } else {
      alertError("System Error");
    }
    return 2;
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 2;
  } on Error catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
    return 2;
  }
}

Stream<int> clearState() async* {
  yield 0;
  contextNoOfItem
      .read<ManageDataNoOfItem>()
      .add(NoOfItemEvent.searchSampleData);
}

Stream<int> fetchSampleData() async* {
  final response = await http
      .post(
        Uri.parse("$url/NoOfItem_fetchSampleData"),
      )
      .timeout(Duration(seconds: timeOut));

  if (response.statusCode == 200) {
    NoOfItemGraphBuff = ModelNoOfItemGraphFromJson(response.body);
    yield 2;
  } else {
    yield 0;
  }
}



/* List<SearchApproveModel> searchOption = [];
Stream<int> searchSampleData() async* {
  Map<String, String> qParams = {
    'SearchOption': searchAnalysisModelToJson(searchOption),
  };
  EasyLoading.show(status: 'loading...');
  print("in searchSampleData");
  try {
    final response = await http
        .post(Uri.parse("$url/NoOfItem_searchSampleData"),
            body: qParams)
        .timeout(Duration(seconds: timeOut));
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      print("searchSampleData response");
      if (response.body != "error") {
        dataTableSampleApprove = modelFullRequestDataFromJson(response.body);
        yield 2;
      } else {
        alertError("System Error");
      }
    }
  } on TimeoutException catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    EasyLoading.dismiss();
    print(e);
    alertNetworkError();
  }
}



List<MasterCustomerRoutine> masterCustomer = [];
List<String> masterCustomerSearch = [];
Future searchMasterCustomer() async {
  try {
    final response = await http
        .post(
          Uri.parse("$url/NoOfItem_searchCustomerData"),
        )
        .timeout(Duration(seconds: timeOut));
    print("response.body2");
    masterCustomerSearch.clear();
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        masterCustomer = masterCustomerRoutineFromJson(response.body);
        for (int i = 0; i < masterCustomer.length; i++) {
          masterCustomerSearch.add(masterCustomer[i].custSearch);
        }
        return 1;
      }
    } else {
      alertError("System Error");
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    alertNetworkError();
  }
}
 */