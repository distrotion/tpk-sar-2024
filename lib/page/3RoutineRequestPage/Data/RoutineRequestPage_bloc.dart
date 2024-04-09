import 'dart:async';
import 'dart:convert';
//----------------------------------------------------------------
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/PopupAlert/PopupAlert.dart';
import 'RoutineRequestPageStructure.dart';
import 'RoutineRequestPage_event.dart';

//------------------------------------------------------- First
// int state = step

List<MasterCustomerRoutine> masterCustormerRoutine = [];
String routineCusmerName = "";
List<AnalysisData> custormerRoutineAnalysisData = [];
String routinePrinter = "";
List routineSamplePrint = [];

class ManageDataRoutineRequest extends Bloc<EventRoutineRequestPage, int> {
  ManageDataRoutineRequest() : super(0);

  @override
  Stream<int> mapEventToState(EventRoutineRequestPage event) async* {
    switch (event) {
      case EventRoutineRequestPage.fetchMasterCustomerRoutine:
        yield* fetchMasterCustomerRoutine();
        break;
      case EventRoutineRequestPage.reselectCustomer:
        yield 1;
        break;
      case EventRoutineRequestPage.findCustomerData:
        yield* findCustomerData();
        break;
      case EventRoutineRequestPage.createRequest:
        yield* createRequest();
        break;
    }
  }
}

Stream<int> fetchMasterCustomerRoutine() async* {
  final response = await http.get(Uri.parse("$url/MasterCustName"));
  print("response.body2");
  if (response.statusCode == 200) {
    masterCustormerRoutine = masterCustomerRoutineFromJson(response.body);
    //fetchMasterInstrument();
    //print(response.body);
    //return masterCustomerRoutineFromJson(response.body);
    yield 1;
  } else {
    //throw Exception('Failed to load posts');
  }
}

/* Future fetchMasterInstrument() async {
  final response = await http.get(Uri.parse("$url/fetchMasterInstrument"));
  if (response.statusCode == 200) {
    print(response.body);
    instrumentData = masterInstrumentFromJson(response.body);
    //print(masterInstrument);
  } else {
    throw Exception('Failed to load posts');
  }
} */

//List<ModelRountineDataSQL> requestData = [];
List<ModelFullRequestData> patternData = [];
List<ModelFullRequestData> sampleData = []; // index = sample
List<List<ModelFullRequestData>> requestData =
    []; // index1 = sampleNo, index2 = itemNO
dynamic samplingDate = DateTime.now();

Stream<int> findCustomerData() async* {
  Map<String, String> qParams = {
    'customerName': routineCusmerName,
    'samplingDate': samplingDate.toString(),
  };
  patternData.clear();
  sampleData.clear();
  requestData.clear();
  routineSamplePrint.clear();
  print("FindCustData: $routineCusmerName");
  /* final response = await http
      .get(Uri.parse("$url/FindCustomerData"), headers: qParams)
      .timeout(Duration(seconds: timeOut)); */
  final response = await http
      .post(Uri.parse("$url/FindCustomerData"), body: qParams)
      .timeout(Duration(seconds: timeOut));
  if (response.statusCode == 200) {
    patternData = modelFullRequestDataFromJson(response.body);
    //print(patternData);
    int bufferSampleNo = 0;
    for (int i = 0; i < patternData.length; i++) {
      /* if (int.tryParse(patternData[i].sampleNo.toString()) != bufferSampleNo) {
        bufferSampleNo = int.tryParse(patternData[i].sampleNo.toString()) ?? 1;
        routineSamplePrint.add(1);
        requestData.add([]);
      } */
      if (i == 0) {
        bufferSampleNo = 1;
        requestData.add([]);
      } else if (patternData[i].sampleNo != patternData[i - 1].sampleNo) {
        bufferSampleNo++;
        requestData.add([]);
      }
      requestData[(bufferSampleNo) - 1].add(patternData[i]);
    }
/*     print(requestData.length.toString());
    print(requestData[0].length.toString()); */
    //DateTime now = DateTime.now();
    for (int i = 0; i < requestData.length; i++) {
      routineSamplePrint.add(1);

      for (int j = 0; j < requestData[i].length; j++) {
        requestData[i][j].samplingDate = samplingDate;
        requestData[i][j].jobType = "ROUTINE";
        requestData[i][j].reqUser = userName;
        requestData[i][j].requestSection = userSection;
        requestData[i][j].requestStatus = "WAIT SAMPLE";
        requestData[i][j].itemStatus = "WAIT SAMPLE";
        requestData[i][j].sampleStatus = "WAIT SAMPLE";
        //requestData[i][j].samplingDate = now;
        requestData[i][j].selected = true;
        /*  if (requestData[i][j].sampleAmount == 0) {
          requestData[i][j].itemStatus = "NOT ANALYSIS";
          requestData[i][j].sampleStatus = "NOT ANALYSIS";
          requestData[i][j].selected = false;
        } */
        if (requestData[i][j].sampleGroup == 'NO LAB') {
          requestData[i][j].requestStatus = "COMPLETE NO LAB";
          requestData[i][j].itemStatus = "COMPLETE NO LAB";
          requestData[i][j].sampleStatus = "COMPLETE NO LAB";
          requestData[i][j]..selected = false;
        }
      }
    }
    yield 2;
  } else {
    print(response.body);
    throw Exception('Failed to load posts');
  }
}

Stream<int> createRequest() async* {
  List<ModelFullRequestData> buffer = [];
  for (int i = 0; i < requestData.length; i++) {
    for (int j = 0; j < requestData[i].length; j++) {
      buffer.add(requestData[i][j]);
    }
  }
  Map<String, String> qParams = {
    'requestData': modelFullRequestDataToJson(buffer),
    'samplePrint': jsonEncode(routineSamplePrint),
    'printer': routinePrinter,
  };
  print("increateRequest");
  try {
    final response = await http
        .post(Uri.parse("$url/createRequest"), body: qParams)
        .timeout(Duration(seconds: timeOut));

    if (response.statusCode == 200) {
      print("In Future DataGet : ${response.body}");
      CoolAlert.show(
        width: 150,
        context: contextBG,
        type: CoolAlertType.success,
        //title: 'Oops...',
        text: 'REQUEST NUMBER ${response.body}',
        loopAnimation: false,
      );
      yield 3;
    } else {
      throw Exception('Failed to load posts');
    }
  } on TimeoutException catch (e) {
    print(e);
    alertNetworkError();
  } on Error catch (e) {
    print(e);
    alertNetworkError();
  }
}

List<MasterInstrument> itemtToAdd = [];
String sampleTypeName = "";
Future<int> searchItemAdd() async {
  Map<String, String> qParams = {
    'sampleTypeName': sampleTypeName,
  };
  print("in searchItemAdd");
  try {
    /* final response = await http
        .get(Uri.parse("$url/RoutineRequestPage_SearchItemAdd"),
            headers: qParams)
        .timeout(Duration(seconds: timeOut)); */
    final response = await http
        .post(Uri.parse("$url/RoutineRequestPage_SearchItemAdd"), body: qParams)
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      itemtToAdd = masterInstrumentFromJson(response.body);
      //await searchTempAdd();
      //await searchPosAdd();
      return 1;
    } else {
      return 0;
    }
  } on TimeoutException catch (e) {
    print(e);
  } on Error catch (e) {
    print(e);
  }
  return 0;
}

List tempToAdd = [];
Future<void> searchTempAdd() async {
  print("in searchTempAdd");
  try {
    final response = await http
        .post(
          Uri.parse("$url/RoutineRequestPage_SearchTempAdd"),
        )
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      tempToAdd = jsonDecode(response.body);
    } else {}
  } on TimeoutException catch (e) {
    print(e);
  } on Error catch (e) {
    print(e);
  }
}

List posToAdd = [];
Future<void> searchPosAdd() async {
  print("in searchPosAdd");
  try {
    final response = await http
        .post(
          Uri.parse("$url/RoutineRequestPage_SearchPosAdd"),
        )
        .timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      posToAdd = jsonDecode(response.body);
    } else {}
  } on TimeoutException catch (e) {
    print(e);
  } on Error catch (e) {
    print(e);
  }
}
