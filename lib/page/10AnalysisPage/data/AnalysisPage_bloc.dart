import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/AnalysisPage.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'AnalysisPageStructure.dart';
import 'AnalysisPage_event.dart';
//----------------------------------------------------------------

class ManageDataAnalysisPage extends Bloc<AnalysisPageEvent, int> {
  ManageDataAnalysisPage() : super(0);

  @override
  Stream<int> mapEventToState(AnalysisPageEvent event) async* {
    if (event == AnalysisPageEvent.fetchInstrumnetData) {
      yield* fetchMasterInstrument();
    } else if (event == AnalysisPageEvent.fetchItemJobdata) {
      yield* fetchItemJobdata();
    } else if (event == AnalysisPageEvent.clearState) {
      yield* clearState();
    } else if (event == AnalysisPageEvent.searchjobData) {
      yield* searchjobData();
    } else if (event == AnalysisPageEvent.selectInstrument) {
      yield* selectInstrument();
    } else if (event == AnalysisPageEvent.returnItem) {
      yield* returnItem();
    }
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

List<MasterInstrument> instrumentData = [];
List<String> instrumentSearch = [];
Stream<int> fetchMasterInstrument() async* {
  EasyLoading.show(status: 'loading...');
  try {
    final response = await http
        .post(Uri.parse("$url/AnalysisPage_fetchMasterInstrument"))
        .timeout(Duration(seconds: timeOut));

    instrumentSearch.clear();
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        instrumentData = masterInstrumentFromJson(response.body);
        for (int i = 0; i < instrumentData.length; i++) {
          instrumentSearch.add(instrumentData[i].instrument);
        }
        yield 1;
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

List<ModelFullRequestData> dataTablitemList = [];
Stream<int> fetchItemJobdata() async* {
  yield 0;
  Map<String, String> qParams = {
    'userName': userName,
  };
  EasyLoading.show(status: 'loading...');
  try {
    print("In fetchItemJobdata");
    final response = await http
        .post(Uri.parse("$url/AnalysisPage_fetchItemJobdata"), body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        dataTablitemList = modelFullRequestDataFromJson(response.body);
        yield 2;
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
        yield 0;
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

Stream<int> clearState() async* {
  //print("inclear");
  yield 0;
}

String sampleCode = "";
String instrumentName = "";
String remarkNo = "";
SearchItemModel searchOption = SearchItemModel();

Stream<int> searchjobData() async* {
  Map<String, String> qParams = {
    'UserName': userName,
    'SearchOption': jsonEncode(searchOption),
  };
  EasyLoading.show(status: 'loading...');
  print("in searchjobData");
  try {
    final response = await http
        .post(Uri.parse("$url/AnalysisPage_searchjobData"), body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      if (response.body != "error") {
        print(response.body);
        if (response.body != "[]") {
          EasyLoading.dismiss();
          dataTablitemList = modelFullRequestDataFromJson(response.body);
          yield 2;
        } else {
          EasyLoading.dismiss();
          alertError("NOT FOUND DATA");
          yield 2;
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

List<ModelFullRequestData> dataItemSelected = [];
Stream<int> selectInstrument() async* {
  yield 3;
}

List<ModelFullRequestData> itemReturnData = [];
Stream<int> returnItem() async* {
  print("IN RETURN ITEM");
  EasyLoading.show(status: 'loading...');
  Map<String, String> qParams = {
    'itemReturnData': modelFullRequestDataToJson(itemReturnData),
  };
  try {
    final response = await http
        .post(Uri.parse("$url/AnalysisPage_returnItem"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        EasyLoading.dismiss();
        alertSuccess("RETURN COMPLETE");
        yield 2;
        analysisPageContext
            .read<ManageDataAnalysisPage>()
            .add(AnalysisPageEvent.fetchItemJobdata);
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
        yield 0;
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
