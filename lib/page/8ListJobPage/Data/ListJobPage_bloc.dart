import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'ListJobPageStructure.dart';
import 'ListJobPage_event.dart';

//----------------------------------------------------------------

class ManageDataListJob extends Bloc<ListJobEvent, int> {
  ManageDataListJob() : super(0);

  @override
  Stream<int> mapEventToState(ListJobEvent event) async* {
    if (event == ListJobEvent.fetchInstrumnetData) {
      yield* fetchMasterInstrument();
    } else if (event == ListJobEvent.searchItemData) {
      yield* searchItemData();
    } else if (event == ListJobEvent.clearState) {
      yield* clearState();
    } else if (event == ListJobEvent.fetchItemdata) {
      yield* fetchItemdata();
    } else if (event == ListJobEvent.createListitem) {
      yield* createListitem();
    }
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

List<MasterInstrument> instrumentData = [];
List<String> masterInstrumnetSearch = [];
Stream<int> fetchMasterInstrument() async* {
  final response = await http
      .post(Uri.parse("$url/ListJobPage_fetchMasterInstrument"))
      .timeout(Duration(seconds: timeOut));
  if (response.statusCode == 200) {
    //print(response.body);
    instrumentData = masterInstrumentFromJson(response.body);
    masterInstrumnetSearch.clear();
    if (instrumentData.length > 0) {
      for (int i = 0; i < instrumentData.length; i++) {
        masterInstrumnetSearch.add(instrumentData[i].instrumentName);
      }
    }
    yield 1;
  } else {
    //throw Exception('Failed to load posts');
  }
}

String instrumentName = "";
List<ModelTableWaitList> dataTableWaitList = [];

Stream<int> fetchItemdata() async* {
  Map<String, String> qParams = {
    'SearchOption': searchItemModelToJson(searchOption),
  };
  print("in fetch item data");
  final response = await http
      .post(Uri.parse("$url/ListJobPage_FetchItemData"), body: qParams)
      .timeout(Duration(seconds: timeOut));
  if (response.statusCode == 200) {
    dataTableWaitList = modelTableWaitListFromJson(response.body);
    yield 2;
  } else {
    print("where is my server");
    yield 0;
  }
}

List<ModelTableListJob> dataTableListJob = [];
List<SearchItemModel> searchOption = [];
Stream<int> searchItemData() async* {
  Map<String, String> qParams = {
    'SearchOption': searchItemModelToJson(searchOption),
  };
  print("in search item data");
  final response = await http
      .post(Uri.parse("$url/ListJobPage_SearchItemData"), body: qParams)
      .timeout(Duration(seconds: timeOut));
  if (response.statusCode == 200) {
    print(response.body);
    dataTableListJob = modelTableListJobFromJson(response.body);
    yield 3;
  } else {
    print("where is my server");
    yield 0;
  }
}

Stream<int> clearState() async* {
  //print("inclear");
  yield 0;
}

List<ModelTableListJob> itemListJob = [];

Stream<int> createListitem() async* {
  Map<String, String> qParams = {
    'instrumentName': instrumentName,
    'itemListJob': modelTableListJobToJson(itemListJob),
    'userName': userName,
    'userBranch': userBranch,
  };
  EasyLoading.show(status: 'loading...');
  print("increateListItem");
  try {
    final response = await http
        .post(Uri.parse("$url/ListJobPage_CreateListItem"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != "error") {
        EasyLoading.dismiss();
        alertSuccess("LIST JOB COMPELTE");
        yield 1;
      } else {
        EasyLoading.dismiss();
        alertError("SYSTEM ERROR");
      }
    } else {
      alertNetworkError();
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



/*

Stream<int> receiveSample() async* {
  var now = DateTime.now();
  var analysisDue = new DateTime(now.year, now.month, now.day + 3);

  Map<String, String> qParams = {
    'sampleCode': sampleCode,
    'userName': userName,
    'dateTimeReceive': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
    'analysisDue': DateFormat("yyyy-MM-dd").format(analysisDue),
  };
  print("insendsample");
  final response = await http
      .post(Uri.parse("$url/ReceiveSamplePage_ReceiveSample"), body: qParams);
  if (response.statusCode == 200) {
    //await searchRequestData();
    print("awaitOK");
    yield 2;
  } else {
    print("where is my server");
    yield 0;
  }
}

String rejectSampleRemark = "";
Stream<int> rejectSample() async* {
  Map<String, String> qParams = {
    'sampleCode': sampleCode,
    'userName': userName,
    'dateTimeReject': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
    'rejectSampleRemark': rejectSampleRemark,
  };
  print("insendsample");
  final response = await http
      .post(Uri.parse("$url/ReceiveSamplePage_RejectSample"), body: qParams);
  if (response.statusCode == 200) {
    //await searchRequestData();
    print("awaitOK");
    yield 2;
  } else {
    print("where is my server");
    yield 0;
  }
}
 */