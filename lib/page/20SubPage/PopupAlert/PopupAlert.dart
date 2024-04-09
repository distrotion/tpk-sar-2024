import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/widgets.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';

void alertLoading() {
  CoolAlert.show(
    width: 150,
    barrierDismissible: false,
    context: contextBG,
    type: CoolAlertType.loading,
  );
}

void alertSuccess(String textIn) {
  //Navigator.pop(contextBG);
  CoolAlert.show(
    width: 150,
    context: contextBG,
    type: CoolAlertType.success,
    title: 'Success',
    text: textIn,
    loopAnimation: false,
  );
}

void alertError(String textIn) {
  //Navigator.pop(contextBG);
  CoolAlert.show(
    width: 150,
    context: contextBG,
    type: CoolAlertType.error,
    title: 'ERROR',
    text: textIn,
    loopAnimation: false,
  );
}

void alertNetworkError() {
  //Navigator.pop(contextBG);
  CoolAlert.show(
    width: 150,
    context: contextBG,
    type: CoolAlertType.error,
    title: 'ERROR',
    text: 'PLESE RETRY AGAIN',
    loopAnimation: false,
  );
}
