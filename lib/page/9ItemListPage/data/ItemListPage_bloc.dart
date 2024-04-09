import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/9ItemListPage/ItemListPage.dart';
import 'ItemListPageStructure.dart';
import 'ItemListPage_event.dart';
//----------------------------------------------------------------

class ManageDataItemListPage extends Bloc<ItemListPageEvent, int> {
  ManageDataItemListPage() : super(0);

  @override
  Stream<int> mapEventToState(ItemListPageEvent event) async* {
    if (event == ItemListPageEvent.fetchInstrumnetData) {
      yield* fetchMasterInstrument();
    } else if (event == ItemListPageEvent.fetchItemdata) {
      yield* fetchItemdata();
    } else if (event == ItemListPageEvent.clearState) {
      yield* clearState();
    } else if (event == ItemListPageEvent.searchjobData) {
      yield* searchjobData();
    } else if (event == ItemListPageEvent.selectInstrument) {
      yield* selectInstrument();
    } else if (event == ItemListPageEvent.returnItem) {
      yield* returnItem();
    }
    /* else if (event == ListJobEvent.rejectSample) {
      yield* rejectSample();
    } */
  }
}

List<MasterInstrument> instrumentData = [];
Stream<int> fetchMasterInstrument() async* {
  final response =
      await http.get(Uri.parse("$url/ItemListPage_fetchMasterInstrument"));
  if (response.statusCode == 200) {
    //print(response.body);
    instrumentData = masterInstrumentFromJson(response.body);
    yield 1;
  } else {
    //throw Exception('Failed to load posts');
  }
}

List<ModelFullRequestData> dataTablitemList = [];

Stream<int> fetchItemdata() async* {
  yield 0;
  Map<String, String> qParams = {
    'userName': userName,
  };
  print("In fetchItemJobdata");
  final response = await http
      .get(Uri.parse("$url/ItemListPage_fetchItemData"), headers: qParams);
  if (response.statusCode == 200) {
    //print(response.body);
    dataTablitemList = modelFullRequestDataFromJson(response.body);
    yield 2;
  } else {
    print("where is my server");
    yield 0;
  }
}

Stream<int> clearState() async* {
  //print("inclear");
  yield 0;
}

String sampleCode = "";
String instrumentName = "";
String remarkNo = "";

Stream<int> searchjobData() async* {
  Map<String, String> qParams = {
    'InstrumentName': instrumentName,
    'UserName': userName,
    'SampleCode': sampleCode,
    'RemarkNo': remarkNo,
  };
  print("in searchjobData");
  final response = await http.get(
    Uri.parse("$url/ItemListPage_searchjobData"),
    headers: qParams,
  );
  if (response.statusCode == 200) {
    //print(response.body);
    dataTablitemList = modelFullRequestDataFromJson(response.body);
    /* Future.delayed(Duration(milliseconds: 100), () {
      // Do something
    }); */
    yield 2;
  } else {
    print("where is my server");
    yield 0;
  }
}

List<ModelFullRequestData> dataItemSelected = [];
Stream<int> selectInstrument() async* {
  yield 3;
}

List<ModelFullRequestData> itemReturnData = [];
Stream<int> returnItem() async* {
  print("IN RETURN ITEM");
  Map<String, String> qParams = {
    'itemReturnData': modelFullRequestDataToJson(itemReturnData),
  };
  final response =
      await http.post(Uri.parse("$url/ItemListPage_returnItem"), body: qParams);
  if (response.statusCode == 200) {
    yield 2;
    itemListPageContext
        .read<ManageDataItemListPage>()
        .add(ItemListPageEvent.fetchItemdata);
    
  } else {
    print("where is my server");
    yield 0;
  }
}
