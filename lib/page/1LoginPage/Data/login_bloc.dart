import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
//----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'login_event.dart';
//----------------------------------------------------------------

/* Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<String> token;

class LoginBloc extends Bloc<LoginEvent, String> {
  LoginBloc() : super('');

  @override
  Stream<String> mapEventToState(LoginEvent event) async* {
    if (event == LoginEvent.login) {
      yield* loginfn(state);
    } else if (event == LoginEvent.logout) {
      yield* logoutfn(state);
    } else if (event == LoginEvent.inintlogin) {
      yield* inintdata(state);
    }
  }
}

Stream<String> loginfn(String state) async* {
  //--------------------------------------------------------bloc/qbit
  print("Loginfn");
  final SharedPreferences prefs = await _prefs;
  state = (prefs.getString('token') ?? '');
  //===================================================
  final response = await http.post(Uri.parse("$url/Login"),
      body: {"user": GloUserID, "password": GloPassword});
  var databuff;

  if (response.statusCode == 200) {
    if (response.body != "error") {
      databuff = jsonDecode(response.body);
      if (databuff[0]['Status'] == 'ok') {
        GloUserID = '';
        GloPassword = '';
        userName = databuff[0]['name'];
        userSection = databuff[0]['section'];
        userRoleId = databuff[0]['roleid'];
        userBranch = databuff[0]['branch'];
        state = response.body;
      }
    } else {
      print("wrong password");
      state = '';
      userName = '';
      userSection = '';
      userBranch = '';
      userRoleId = 0;
      CoolAlert.show(
        width: 150,
        context: contextBG,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'INVALID USER OR PASSWORD',
        loopAnimation: false,
      );
    }
  } else {
    print("time out");
    userName = '';
    userSection = '';
    userBranch = '';
    userRoleId = 0;
    state = '';
  }

  //--------------------------------------------------------state return
  token = prefs.setString("token", state).then((bool success) {
    return state;
  });
  yield state;
}

Stream<String> logoutfn(String state) async* {
  final SharedPreferences prefs = await _prefs;
  String tokem_out_raw;
  tokem_out_raw = (prefs.getString('token') ?? '');
  userName = '';
  userSection = '';
  userRoleId = 0;
  userBranch = '';
  state = '';
  token = prefs.setString("token", state).then((bool success) {
    return state;
  });
  yield state;
}

Stream<String> inintdata(String state) async* {
  final SharedPreferences prefs = await _prefs;
  currentPage = (prefs.getString('currentPage') ?? "");
  //print("currentPageInInitial : $currentPage");
  state = (prefs.getString('token') ?? '');
  var databuff;
  if (state != '') {
    databuff = jsonDecode(state);
    userName = databuff[0]['name'];
    userSection = databuff[0]['section'];
    userRoleId = databuff[0]['roleid'];
    userBranch = databuff[0]['branch'];
  }
  print("state before yield $state");
  yield state;
  //showAlertDialog(contextBG);
}
 */

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<String> token;

class LoginBloc extends Bloc<LoginEvent, int> {
  LoginBloc() : super(0);

  @override
  Stream<int> mapEventToState(LoginEvent event) async* {
    if (event == LoginEvent.login) {
      yield* loginfn();
    } else if (event == LoginEvent.logout) {
      yield* logoutfn();
    } else if (event == LoginEvent.inintlogin) {
      yield* inintdata();
    }
  }
}

Stream<int> loginfn() async* {
  //--------------------------------------------------------bloc/qbit
  yield 1;
  print("Loginfn");
  final SharedPreferences prefs = await _prefs;
  //state = (prefs.getString('token') ?? '');
  //===================================================
  final response = await http.post(Uri.parse("$url/Login"),
      body: {"user": GloUserID, "password": GloPassword});
  var databuff;
  String state = "";
  if (response.statusCode == 200) {
    if (response.body != "error") {
      databuff = jsonDecode(response.body);
      if (databuff[0]['Status'] == 'ok') {
        GloUserID = '';
        GloPassword = '';
        userName = databuff[0]['name'];
        userSection = databuff[0]['section'];
        userRoleId = databuff[0]['roleid'];
        userBranch = databuff[0]['branch'];
        state = response.body;
        currentPage = 'MainPage';
      }
    } else {
      print("wrong password");
      state = '';
      userName = '';
      userSection = '';
      userBranch = '';
      userRoleId = 0;
      CoolAlert.show(
        width: 150,
        context: contextBG,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'INVALID USER OR PASSWORD',
        loopAnimation: false,
      );
    }
  } else {
    print("time out");
    userName = '';
    userSection = '';
    userBranch = '';
    userRoleId = 0;
    state = '';
  }

  //--------------------------------------------------------state return
  prefs.setString("token", state);
  yield 2;
}

Stream<int> logoutfn() async* {
  yield 1;
  final SharedPreferences prefs = await _prefs;
  String state = "";
  String tokem_out_raw;
  tokem_out_raw = (prefs.getString('token') ?? '');
  userName = '';
  userSection = '';
  userRoleId = 0;
  userBranch = '';
  state = '';
  prefs.setString("token", state);
  prefs.setString('MainPage_CurrentPageTable', "0");
  yield 2;
}

Stream<int> inintdata() async* {
  String state = "";
  final SharedPreferences prefs = await _prefs;
  currentPage = (prefs.getString('currentPage') ?? "");
  //print("currentPageInInitial : $currentPage");
  state = (prefs.getString('token') ?? '');
  var databuff;
  if (state != '') {
    databuff = jsonDecode(state);
    userName = databuff[0]['name'];
    userSection = databuff[0]['section'];
    userRoleId = databuff[0]['roleid'];
    userBranch = databuff[0]['branch'];
  }
  print("state before yield $state");
  Future.delayed(Duration(milliseconds: 10000), () {});
  yield 1;
  //showAlertDialog(contextBG);
}
