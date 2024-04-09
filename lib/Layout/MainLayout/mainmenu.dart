import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Layout/MainLayout/sub_widget.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    //---------------------------------------------------------------

    return Container(
      height: (MediaQuery.of(context).size.height),
      width: 300,
      color: Color(0xff0b1327),
      //color: Colors.red,
      child: ListView(
        children: [
          Center(
            child: Data_Menu_mainmenu(),
          )
        ],
      ),
    );
  }
}

class Data_Menu_mainmenu extends StatelessWidget {
  //const Data_Menu_mainmenu({Key? key},this.pagein) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Axis-Y
        crossAxisAlignment: CrossAxisAlignment.center, //Axis-X

        children: [
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                  height: 40,
                  width: 250,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(1),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo_tpk.png"),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ))),
          new menu_normal(
            name: "MAIN PAGE",
            page: 'MainPage',
          ),
          if (userSection != "TTC" || userRoleId == 99)
            new menu_normal(
              name: "CREATE ROUTINE REQUEST",
              page: 'RoutineRequestPage',
            ),
          new menu_normal(
            name: "REQUEST LIST",
            page: 'RequestListPage',
          ),
          if (userSection == "TTC" || userRoleId == 99)
            new menu_normal(
              name: "ITEM LIST",
              page: 'ItemListPage',
            ),
          new menu_normal(
            name: "SEND SAMPLE",
            page: 'SendSamplePage',
          ),
          if (userSection == "TTC" || userRoleId == 99)
            new menu_normal(
              name: "RECEIVE SAMPLE",
              page: 'ReceiveSamplePage',
            ),
          if (userSection == "TTC" || userRoleId == 99)
            new menu_normal(
              name: "LIST JOB",
              page: 'ListJobPage',
            ),
          if (userSection == "TTC" || userRoleId == 99)
            new menu_normal(
              name: "ANALYSIS",
              page: 'AnalysisPage',
            ),
          if ((userSection == "TTC" && userRoleId > 5) || userRoleId == 99)
            new menu_normal(
              name: "APPROVERESULT",
              page: 'ApproveResultPage',
            ),
          if ((userSection == "TTC" /*  && userRoleId > 5 */) ||
              userRoleId == 99)
            new menu_normal(
              name: "SUMMARY DATA",
              page: 'SummaryDataPage',
            ),
          Divider(
            color: Color(0x4dffffff),
            height: 12,
          ),
          if ((true) ||
              userRoleId == 99)
            new menu_normal(
              name: "MASTER PATTERN",
              page: 'EditPatternLabPage',
            ),
        ],
      ),
    );
  }
}

class Logomenu extends StatelessWidget {
  const Logomenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      color: Colors.white,

      child: Padding(
        padding: const EdgeInsetsDirectional.all(1),
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/logo_tpk.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),

      //color: Colors.white,
    );
  }
}
