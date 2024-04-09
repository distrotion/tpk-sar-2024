import 'dart:async';
//----------------------------------------------------------------
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'MainPage_event.dart';
import 'TableMainRequesterStructure.dart';
//----------------------------------------------------------------

//------------------------------------------------------- First
//
class ManageDataMainPage
    extends Bloc<EventMainPage, List<ModelTableMainRequester>> {
  ManageDataMainPage() : super([]);

  @override
  Stream<List<ModelTableMainRequester>> mapEventToState(
      EventMainPage event) async* {
    /* switch (event) {
      case EventMainPage.fetchRequesterData:
        yield* fetchRequestData();
        break;
      /* case EventMainPage.delete:
        yield* fetchRequestData();
        break; */
    } */
    /* else if (event == DataSequncePage1.update) {
      yield* updateData_fn(state);
    } else if (event == DataSequncePage1.delete) {
      yield* deleteData_fn(state);
    } else if (event == DataSequncePage1.insert) {
      yield* InsertData_fn(state);
    } */
  }
}

/* Stream<List<ModelTableMainRequester>> fetchRequestData() async* {
  /* Map<String, String> qParams = {
    'User': userName,
  }; */
  print("in fetchRequestData");
  /* final response = await http
      .get(Uri.parse("$url/MainPage_FetchRequesterData"), headers: qParams)
      .timeout(Duration(seconds: timeOut)); */
  final response = await http.post(
      Uri.parse("$url/MainPage_FetchRequesterData"),
      body: {"User": userName}).timeout(Duration(seconds: timeOut));
  List<ModelTableMainRequester> databuff = [];
  if (response.statusCode == 200) {
    //print(response.body);
    databuff = modelTableMainRequesterFromJson(response.body);
    mainRequesterData = modelTableMainRequesterFromJson(response.body);
  } else {
    print("where is my server");
  }
  yield databuff;
} */
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

int iniPage = 0;

Future fetchRequestData() async {
  /* Map<String, String> qParams = {
    'User': userName,
  }; */
  print("in fetchRequestData");
  try {
    final SharedPreferences prefs = await _prefs;
    iniPage = int.parse(prefs.getString('MainPage_CurrentPageTable') ?? "0");

    final response = await http.post(
        Uri.parse("$url/MainPage_FetchRequesterData"),
        body: {"User": userName}).timeout(Duration(seconds: timeOut));
    List<ModelTableMainRequester> databuff = [];
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        databuff = modelTableMainRequesterFromJson(response.body);
        mainRequesterData = modelTableMainRequesterFromJson(response.body);
        //print(modelTableMainRequesterToJson(databuff));
        return 1;
        /*  if (requestWaitApproveData.length > 0) {
          print('1');
          return 1;
        } else {
          print('0');
          return 0;
        } */
      } else {
        print("where is my server");
        return 0;
      }
    }
  } on TimeoutException catch (e) {
  } on Error catch (e) {}
}

List<ModelFullRequestData> requestWaitApproveData = [];
Future fetchRequestWaitApprove() async {
  /* Map<String, String> qParams = {
    'User': userName,
  }; */
  print("in fetchRequestWaitApprove");
  try {
    /* final response = await http
        .get(Uri.parse("$url/MainPage_fetchRequestWaitApprove"),
            headers: qParams)
        .timeout(Duration(seconds: timeOut)); */
    final response = await http.post(
        Uri.parse("$url/MainPage_fetchRequestWaitApprove"),
        body: {"User": userName}).timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        print("------------");
        print(response.body);
        requestWaitApproveData = modelFullRequestDataFromJson(response.body);
        print("------------");
        print(modelFullRequestDataToJson(requestWaitApproveData));
        if (requestWaitApproveData.length > 0)
          return 1;
        else {
          return 0;
        }
      } else {
        print("where is my server");
        return 0;
      }
    }
  } on TimeoutException catch (e) {
  } on Error catch (e) {
    print(e);
  }
}

List<ModelFullRequestData> dataTablitemList = [];

Future fetchItemJobdata() async {
  /* Map<String, String> qParams = {
    'userName': userName,
  }; */
  try {
    print("In fetchItemJobdata");
    /* final response = await http
        .get(Uri.parse("$url/MainPage_fetchItemJobdata"), headers: qParams)
        .timeout(Duration(seconds: timeOut)); */
    final response = await http.post(
        Uri.parse("$url/MainPage_fetchItemJobdata"),
        body: {"User": userName}).timeout(Duration(seconds: timeOut));
    if (response.statusCode == 200) {
      if (response.body != 'error') {
        dataTablitemList = modelFullRequestDataFromJson(response.body);
        return 1;
      } else {
        return 0;
      }
    }
  } on TimeoutException catch (e) {
    print(e);
  } on Error catch (e) {
    print(e);
  }
}
