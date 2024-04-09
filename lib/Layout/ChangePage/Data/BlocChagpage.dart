import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//late Future<String> token;

class SwPageCubit extends Cubit<String> {
  SwPageCubit() : super("");

  void togglePage(String datain) async {
    //print("in change page : $datain");
    final SharedPreferences prefs = await _prefs;
    if (userName == '') {
      //print('1');
      emit("LoginPage");
      prefs.setString('currentPage', datain);
    } /*  else if (datain == 'RefreshPage') {
      prefs.setString('currentPage', datain);
      emit(datain);
      currentPage = datain;
    } */
    else {
      //print('2');
      prefs.setString('currentPage', datain);
      //print(datain);
      emit(datain);
      if (datain == "RefreshPage") {
        //lastPage = currentPage;
        buffferLastPage = currentPage;
      }
      lastPage = currentPage;
      if (lastPage == "RefreshPage") {
        lastPage = buffferLastPage;
      }
      currentPage = datain;
    }
  }
}
