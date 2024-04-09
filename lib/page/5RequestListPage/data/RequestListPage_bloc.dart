import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/RequestListPage.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/SubWidget/TableRequestList.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/data/RequestListPageStructure.dart';
import 'RequestListPage_event.dart';

//----------------------------------------------------------------

class ManageDataRequestListPage extends Bloc<RequestListPageEvent, int> {
  ManageDataRequestListPage() : super(0);

  @override
  Stream<int> mapEventToState(RequestListPageEvent event) async* {
    if (event == RequestListPageEvent.clearAndSearch) {
      yield* clearAndSearch();
    } else if (event == RequestListPageEvent.fetchSampleData) {
      yield* fetchSampleData();
    } else if (event == RequestListPageEvent.searchSampleData) {
      yield* searchSampleData();
    }
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

Stream<int> fetchSampleData() async* {
  final response = await http
      .post(Uri.parse("$url/RequestListPage_fetchSampleData"))
      .timeout(Duration(seconds: timeOut));
  if (response.statusCode == 200) {
    dataTableRequestList = modelTableRequetJobFromJson(response.body);
    yield 2;
  } else {
    print("where is my server");
    yield 0;
  }
}

/* Stream<int> searchRequestData() async* {
  Map<String, String> qParams = {
    'reqNo': reqNoSelected,
  };
  print("in search");
  final response = await http.get(
      Uri.parse("$url/RequestListPage_searchSampleData"),
      headers: qParams);
  if (response.statusCode == 200) {
    requestData = modelTableRequestApproveFromJson(response.body);
    print("yield 11");
    yield 11;
  } else {
    print("where is my server");
    yield 0;
  }
  yield 11;
}
 */
Stream<int> clearAndSearch() async* {
  yield 0;
  contextRequestListPage
      .read<ManageDataRequestListPage>()
      .add(RequestListPageEvent.searchSampleData);
}

List<SearchRequestModel> searchOption = [];
Stream<int> searchSampleData() async* {
  Map<String, String> qParams = {
    'SearchOption': searchRequestModelToJson(searchOption),
  };
  EasyLoading.show(status: 'loading...');
  print("in searchSampleData");
  try {
    final response = await http
        .post(Uri.parse("$url/RequestListPage_searchSampleData"), body: qParams)
        .timeout(Duration(seconds: timeOut));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      if (response.body != "error") {
        dataTableRequestList = modelTableRequetJobFromJson(response.body);
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
        .post(Uri.parse("$url/RequestListPage_searchCustomerData"))
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
