import 'dart:async';
import 'dart:convert';
//----------------------------------------------------------------
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'RoutineRequestPageStructure.dart';
import 'RoutineRequestPage_event.dart';

//------------------------------------------------------- First
// int state = step

List<MasterCustomerRoutine> masterCustormerRoutine = [];
String routineCusmerName = "";
List<AnalysisData> custormerRoutineAnalysisData = [];

List<ModelRountineDataSQL> requestData = [];
List<ModelSampleDataSQL> sampleData = [];
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
    fetchMasterInstrument();
    //print(response.body);
    //return masterCustomerRoutineFromJson(response.body);
    yield 1;
  } else {
    //throw Exception('Failed to load posts');
  }
}

List<MasterInstrument> instrumentData = [];
Future fetchMasterInstrument() async {
  final response = await http.get(Uri.parse("$url/fetchMasterInstrument"));
  if (response.statusCode == 200) {
    print(response.body);
    instrumentData = masterInstrumentFromJson(response.body);
    //print(masterInstrument);
  } else {
    throw Exception('Failed to load posts');
  }
}

/* Stream<int> Clear() async* {
  Map<String, String> qParams = {
    'customerName': routineCusmerName,
  };
  print("FindCustData: $routineCusmerName");
  final response =
      await http.get(Uri.parse("$url/FindCustomerData"), headers: qParams);
  if (response.statusCode == 200) {
    print(response.body);
    custormerRoutineAnalysisData = analysisDataFromJson(response.body);
    custormerRoutineAnalysisData = analysisDataFromJson(response.body);
    print(custormerRoutineAnalysisData);
    yield 2;
  } else {
    print(response.body);
    throw Exception('Failed to load posts');
  }
} */

Stream<int> findCustomerData() async* {
  Map<String, String> qParams = {
    'customerName': routineCusmerName,
  };
  print("FindCustData: $routineCusmerName");
  final response =
      await http.get(Uri.parse("$url/FindCustomerData"), headers: qParams);
  if (response.statusCode == 200) {
    print(response.body);
    custormerRoutineAnalysisData = analysisDataFromJson(response.body);
    custormerRoutineAnalysisData = analysisDataFromJson(response.body);
    print(custormerRoutineAnalysisData);
    yield 2;
  } else {
    print(response.body);
    throw Exception('Failed to load posts');
  }
}

Stream<int> createRequest() async* {
  Map<String, String> qParams = {
    'requestData': routineDataSQLToJson(requestData),
    'sampleData': sampleDataSQLToJson(sampleData),
    'samplePrint': jsonEncode(routineSamplePrint),
    'printer':routinePrinter,
  };
  print("increateRequest");
  final response =
      await http.post(Uri.parse("$url/createRequest"), body: qParams);
  //await http.post(Uri.parse("$url/createRequest"));
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
}
