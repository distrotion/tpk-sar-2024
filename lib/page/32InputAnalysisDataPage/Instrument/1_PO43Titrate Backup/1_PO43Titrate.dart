import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'data/1_PO43Titrate_bloc.dart';
import 'data/1_PO43Titrate_event.dart';

class Instrument_PO43Titrate extends StatelessWidget {
  const Instrument_PO43Titrate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataPO43Titrate>(
          create: (BuildContext context) => ManageDataPO43Titrate(),
        ),
      ],
      child: PO43Titrate(),
    );
  }
}

class PO43Titrate extends StatefulWidget {
  const PO43Titrate({Key? key}) : super(key: key);

  @override
  _PO43TitrateState createState() => _PO43TitrateState();
}

class _PO43TitrateState extends State<PO43Titrate> {
  void initState() {
    context
        .read<ManageDataPO43Titrate>()
        .add(PO43TitrateEvent.searcPO43hOldData);
    print("InINITIAL PO43");
    super.initState();
  }

  void calculate() {
    if (double.parse(dataPO43[0].titrantFactor_1) > 0) {
      if (double.parse(dataPO43[0].endPt2_1) > 0) {
        dataPO43[0].result_1 = (0.95 *
                double.parse(dataPO43[0].endPt2_1) *
                double.parse(dataPO43[0].titrantFactor_1))
            .toStringAsFixed(2);
        dataPO43[0].resultUnit_1 = "g/L.";
        setState(() {});
      }
    }
  }

  void calculate2() {
    try {
      if (double.parse(dataPO43[0].titrantFactor_2) > 0) {
        if (double.parse(dataPO43[0].endPt2_2) > 0) {
          dataPO43[0].result_2 = (0.95 *
                  double.parse(dataPO43[0].endPt2_2) *
                  double.parse(dataPO43[0].titrantFactor_2))
              .toStringAsFixed(2);
          dataPO43[0].resultUnit_2 = "g/L.";
          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 155;
  bool normal = true;
  bool recheck = false;
  bool reconfirm = false;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageDataPO43Titrate, int>(builder: (context, state) {
      if (state == 1) {
        return Form(
          key: _formKey,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index1) {
                return SizedBox(
                  height: 10,
                );
              },
              shrinkWrap: true,
              //padding: const EdgeInsets.all(8),
              itemCount: dataPO43.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 15, bottom: 15),
                      width: 900,
                      //height: 50,
                      decoration: BoxDecoration(
                        color: CustomTheme.colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        boxShadow: [
                          BoxShadow(
                              color: CustomTheme.colorShadowBgStrong,
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              spreadRadius: 0)
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: heightBox2,
                            child: Text(
                              "${dataPO43[index].itemStatus} RESULT",
                              style: stylesection,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 400,
                                child: Column(
                                  children: [
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "ERROR RESULT",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderDropdown(
                                              items: errorData
                                                  .map((error) =>
                                                      DropdownMenuItem(
                                                        value: error,
                                                        child: Text('$error'),
                                                      ))
                                                  .toList(),
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'errorResult$index',
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].result_1 = value;
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "TITRANT FACTOR",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'titrantFactor$index',
                                              initialValue: dataPO43[index]
                                                  .titrantFactor_1
                                                  .toString(),
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].titrantFactor_1 =
                                                    value;
                                              },
                                              onSubmitted: (value) {
                                                calculate();
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value == "") {
                                                  return 'ENTER VALUE';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "END AT POINT 1 (mL.)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'endAtPoint1$index',
                                              initialValue: dataPO43[index]
                                                  .endPt1_1
                                                  .toString(),
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].endPt1_1 = value;
                                              },
                                              onSubmitted: (value) {
                                                calculate();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "END AT POINT 2(mL.)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'endAtPoint2$index',
                                              initialValue: dataPO43[index]
                                                  .endPt2_1
                                                  .toString(),
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].endPt2_1 = value;
                                              },
                                              onSubmitted: (value) {
                                                calculate();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Tooltip(
                                              message:
                                                  "0.95 x End pt 2 (mL) x Titration Factor",
                                              child: Text(
                                                "RESULT",
                                                style: stylesection,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            dataPO43[index].result_1.toString(),
                                            style: styledata,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "UNIT",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 10,
                                                    bottom: heightBox2 / 2,
                                                  ),
                                                  border: InputBorder.none),
                                              name: 'unit$index',
                                              initialValue:
                                                  dataPO43[index].resultUnit_1,
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "REAMRK RESULT",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'resultRemark$index',
                                              initialValue: dataPO43[index]
                                                  .resultRemark_1
                                                  .toString(),
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].resultRemark_1 =
                                                    value.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "USER ANALYSIS",
                                              style: stylesection,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            dataPO43[index]
                                                .userAnalysis
                                                .toString(),
                                            style: styledata,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "ANALYSIS DATE",
                                              style: stylesection,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            dataPO43[index]
                                                .analysisDate
                                                .toString(),
                                            style: styledata,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
////////////// result2
                              Container(
                                width: 400,
                                child: Column(
                                  children: [
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "ERROR RESULT(2)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderDropdown(
                                              items: errorData
                                                  .map((error) =>
                                                      DropdownMenuItem(
                                                        value: error,
                                                        child: Text('$error'),
                                                      ))
                                                  .toList(),
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'errorResult2$index',
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].result_2 = value;
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "TITRANT FACTOR (2)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'titrantFactor2$index',
                                              initialValue: dataPO43[index]
                                                  .titrantFactor_2
                                                  .toString(),
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].titrantFactor_2 =
                                                    value;
                                              },
                                              onSubmitted: (value) {
                                                calculate2();
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value == "") {
                                                  return 'ENTER VALUE';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "END AT POINT 1 (mL.)(2)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'endAtPoint12$index',
                                              initialValue: dataPO43[index]
                                                  .endPt1_2
                                                  .toString(),
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].endPt1_2 = value;
                                              },
                                              onSubmitted: (value) {
                                                calculate2();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "END AT POINT 2(mL.)(2)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'endAtPoint22$index',
                                              initialValue:
                                                  dataPO43[index].endPt2_2,
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].endPt2_2 = value;
                                              },
                                              onSubmitted: (value) {
                                                calculate2();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Tooltip(
                                              message:
                                                  "0.95 x End pt 2 (mL) x Titration Factor",
                                              child: Text(
                                                "RESULT(2)",
                                                style: stylesection,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            dataPO43[index].result_2.toString(),
                                            style: styledata,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "UNIT(2)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                    left: 10,
                                                    bottom: heightBox2 / 2,
                                                  ),
                                                  border: InputBorder.none),
                                              name: 'unit2$index',
                                              initialValue:
                                                  dataPO43[index].resultUnit_2,
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "REAMRK RESULT(2)",
                                              style: stylesection,
                                            ),
                                          ),
                                          Expanded(
                                            child: FormBuilderTextField(
                                              style: styledata,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  border: OutlineInputBorder()),
                                              name: 'resultRemark2$index',
                                              initialValue: dataPO43[index]
                                                  .resultRemark_2
                                                  .toString(),
                                              enabled: dataPO43[index].canEdit,
                                              onChanged: (value) {
                                                dataPO43[0].resultRemark_2 =
                                                    value.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "USER ANALYSIS",
                                              style: stylesection,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            dataPO43[index]
                                                .userAnalysis
                                                .toString(),
                                            style: styledata,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: heightBox2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widthsection2,
                                            child: Text(
                                              "ANALYSIS DATE",
                                              style: stylesection,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            dataPO43[index]
                                                .analysisDate
                                                .toString(),
                                            style: styledata,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (dataPO43[index]
                              .canEdit) //index = 0 from list build
                            Container(
                              height: heightBox2,
                              //width: 170,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: styledata,
                                    // primary: Colors.green,
                                    /* padding: EdgeInsets.symmetric(
                                                              horizontal: 50,
                                                              vertical: 20), */
                                  ),
                                  child: Text("SAVE"),
                                  onPressed: () {
                                    calculate();
                                    calculate2();
                                    if (dataPO43[0].result_1.toString() != "") {
                                      CoolAlert.show(
                                          width: 200,
                                          context: context,
                                          type: CoolAlertType.confirm,
                                          text: 'CONFIRM SAVE RESULT',
                                          confirmBtnText: 'Yes',
                                          cancelBtnText: 'No',
                                          confirmBtnColor: Colors.green,
                                          onConfirmBtnTap: () {
                                            context
                                                .read<ManageDataPO43Titrate>()
                                                .add(PO43TitrateEvent
                                                    .savePO43Data);
                                            //Navigator.pop(context);
                                          });
                                    } else {
                                      CoolAlert.show(
                                        width: 200,
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: 'RESULT ERROR',
                                        confirmBtnText: 'OK',
                                        confirmBtnColor: Colors.green,
                                      );
                                    }

                                    /* final validationSuccess =
                                  _formKey.currentState?.validate();
                
                              if (validationSuccess) {
                                print("valid true");
                              } else {
                                print("vaild false");
                              } */
                                  }),
                            )
                        ],
                      ),
                    ),
                  ),
                ]);
              }),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
