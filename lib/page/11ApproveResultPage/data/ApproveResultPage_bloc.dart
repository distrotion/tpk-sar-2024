import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/11ApproveResultPage/ApproveResultPage.dart';
import 'package:tpk_login_arsa_01/page/11ApproveResultPage/SubWidget/TableSampleApprove.dart';
import 'package:tpk_login_arsa_01/page/11ApproveResultPage/data/ApproveResultPageStructure.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'ApproveResultPage_event.dart';

//----------------------------------------------------------------

class ManageDataApproveResultPage extends Bloc<ApproveResultPageEvent, int> {
  ManageDataApproveResultPage() : super(0);

  @override
  Stream<int> mapEventToState(ApproveResultPageEvent event) async* {
    if (event == ApproveResultPageEvent.clearState) {
      yield* clearState();
    } else if (event == ApproveResultPageEvent.fetchSampleData) {
      yield* fetchSampleData();
    } else if (event == ApproveResultPageEvent.searchSampleData) {
      yield* searchSampleData();
    }
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

Stream<int> fetchSampleData() async* {
  final response = await http
      .post(
        Uri.parse("$url/ApproveResultPage_fetchSampleData"),
      )
      .timeout(Duration(seconds: timeOut));

  if (response.statusCode == 200) {
    dataTableSampleApprove = modelFullRequestDataFromJson(response.body);
    yield 2;
  } else {
    yield 0;
  }
}

List<SearchApproveModel> searchOption = [];
Stream<int> searchSampleData() async* {
  Map<String, String> qParams = {
    'SearchOption': searchAnalysisModelToJson(searchOption),
  };
  EasyLoading.show(status: 'loading...');
  print("in searchSampleData");
  try {
    final response = await http
        .post(Uri.parse("$url/ApproveResultPage_searchSampleData"),
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

Stream<int> clearState() async* {
  yield 0;
  conextApproveResultPage
      .read<ManageDataApproveResultPage>()
      .add(ApproveResultPageEvent.searchSampleData);
}

List<MasterCustomerRoutine> masterCustomer = [];
List<String> masterCustomerSearch = [];
Future searchMasterCustomer() async {
  try {
    final response = await http
        .post(
          Uri.parse("$url/ApproveResultPage_searchCustomerData"),
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
