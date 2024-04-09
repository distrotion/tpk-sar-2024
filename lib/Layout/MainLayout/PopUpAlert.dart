import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';

class PopupAlert extends StatelessWidget {
  const PopupAlert(
      {Key? key,
      this.sTxtHead = "",
      this.sTxtBody = "",
      this.sTxtBtnYes = "",
      this.sTxtBtnNo = "",
      this.funcYes,
      this.funcNo,
      this.sFuncData = "",
      this.isSwitchYNBtnPos = false})
      : super(key: key);
  final String sTxtHead;
  final String sTxtBody;
  final String sTxtBtnYes;
  final String sTxtBtnNo;
  final Function? funcYes;
  final Function? funcNo;
  final String sFuncData; //func will return this value for only Yes btn
  final bool isSwitchYNBtnPos; //Switch Yes and No btn :  true = No, Yes

  @override
  Widget build(BuildContext context) {
    void tapYes() {
      funcYes!(sFuncData);
    }

    void tapNo() {
      funcNo!();
    }

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      content: Container(
        //width: 854,
        //cannot margin here because it will be empty space
        decoration: BoxDecoration(
          color: CustomTheme.colorGreyBg,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
                color: CustomTheme.colorShadowBgStrong,
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0)
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(sTxtHead,
                  style: TxtStyle(fontSize: 20), textAlign: TextAlign.center),
              Text(sTxtBody,
                  style: TxtStyle(fontSize: 12), textAlign: TextAlign.center),
              InkWell(
                child: Text("OK"),
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content:
        Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
