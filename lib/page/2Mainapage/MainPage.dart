import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SummaryDataPage.dart';
import 'package:tpk_login_arsa_01/page/2Mainapage/SubWidget/TableMainRequester.dart';
import 'package:tpk_login_arsa_01/page/2Mainapage/SubWidget/TableWaitAnalysis.dart';
import 'package:tpk_login_arsa_01/page/2Mainapage/SubWidget/TableWaitApprove.dart';
//---------------------------------------------------------
import 'Data/MainPage_bloc.dart';
//import 'Data/MainPage_event.dart';
//import 'Data/TableMainRequesterStructure.dart';
//import 'SubWidget/TableMainRequester.dart';
//---------------------------------------------------------

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //height: 320,
        margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 0),
        child: Column(children: [
          if (userSection != 'TTC')
            FutureBuilder(
                future: fetchRequestData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == 1)
                    return Container(
                      height: 455,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: CustomTheme.colorWhite,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: CustomTheme.colorShadowBgStrong,
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ],
                      ),
                      padding: EdgeInsets.all(0),
                      child: Container(child: TableMainRequest()),
                    );
                  else
                    return Container();
                }),
          /* Container(
                height: 310,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: CustomTheme.colorWhite,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: CustomTheme.colorShadowBgStrong,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                ),
                padding: EdgeInsets.all(0),
                child: Container(child: TableMainRequest()),
              ), */
          FutureBuilder(
              future: fetchRequestWaitApprove(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == 1)
                  return Container(
                    height: 310,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: CustomTheme.colorWhite,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: CustomTheme.colorShadowBgStrong,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            spreadRadius: 0)
                      ],
                    ),
                    padding: EdgeInsets.all(0),
                    child: Container(child: TableWaitApprove()),
                  );
                else
                  return Container();
              }),
          if (userSection == 'TTC')
            FutureBuilder(
                future: fetchItemJobdata(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == 1)
                    return Container(
                      height: 310,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: CustomTheme.colorWhite,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: CustomTheme.colorShadowBgStrong,
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ],
                      ),
                      padding: EdgeInsets.all(0),
                      child: Container(child: TableJobListItem()),
                    );
                  else
                    return Container();
                }),
          /* Container(
            width: 500,
            child: SummaryDataPage(),
          ), */
        ]),
      ),
    );
  }
}

/* class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ManageDataMainPage>().add(EventMainPage.fetchRequesterData);
    return BlocBuilder<ManageDataMainPage, List<ModelTableMainRequester>>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            //height: 320,
            margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 0),
            child: Column(children: [
                FutureBuilder(
                    future: fetchItemJobdata(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == 1)
                        return Container(
                          height: 310,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: CustomTheme.colorWhite,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  color: CustomTheme.colorShadowBgStrong,
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                  spreadRadius: 0)
                            ],
                          ),
                          padding: EdgeInsets.all(0),
                          child: Container(child: TableJobListItem()),
                        );
                      else
                        return Container();
                    }),
              Container(
                height: 310,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: CustomTheme.colorWhite,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: CustomTheme.colorShadowBgStrong,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ],
                ),
                padding: EdgeInsets.all(0),
                child: Container(child: TableMainRequest()),
              ),
              FutureBuilder(
                  future: fetchRequestWaitApprove(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == 1)
                      return Container(
                        height: 310,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: CustomTheme.colorWhite,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                                color: CustomTheme.colorShadowBgStrong,
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 0)
                          ],
                        ),
                        padding: EdgeInsets.all(0),
                        child: Container(child: TableWaitApprove()),
                      );
                    else
                      return Container();
                  }),
              if (userSection == 'TTC')
                FutureBuilder(
                    future: fetchItemJobdata(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == 1)
                        return Container(
                          height: 310,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: CustomTheme.colorWhite,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  color: CustomTheme.colorShadowBgStrong,
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                  spreadRadius: 0)
                            ],
                          ),
                          padding: EdgeInsets.all(0),
                          child: Container(child: TableJobListItem()),
                        );
                      else
                        return Container();
                    }),
            ]),
          ),
        );
      },
    );
  }
}
 */