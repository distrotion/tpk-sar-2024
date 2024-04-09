/* import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/4_ICP/data/4_ICP_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/4_ICP/data/4_ICP_event.dart';

class Instrument_ICP extends StatelessWidget {
  double headHeight = 0;
  double dataHeight = 0;
  Instrument_ICP({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataICP>(
          create: (BuildContext context) => ManageDataICP(),
        ),
      ],
      child: ICP(headHeight: headHeight, dataHeight: dataHeight),
    );
  }
}

class ICP extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  ICP({Key? key, required this.headHeight, required this.dataHeight})
      : super(key: key);

  @override
  _ICPState createState() => _ICPState();
}

class _ICPState extends State<ICP> {
  int countData = 0;
  List setSE1 = [
    "SE-660-0",
    "SE-660-1",
    "SE-660-2",
    "SE-660-3",
    "SE-660-A",
    "SE-660-B",
    "SE-660-1U",
    "SEK-670-0",
    "SEK-670-0U",
    "SEK-670-1",
    "SEK-670-2",
    "SEK-670-3",
    "SEK-670-B",
    "SEK-670-1U",
    "SEK-670-2U",
    "SEK-670-3U",
    "SEK-670-2SH",
    "SEC-93-0",
    "SEC-93-1",
    "SEC-93-2",
    "SEC-93-3",
    "SEKC-990-0",
    "SEKC-990-1",
    "SEKC-990-A",
    "SEKC-990-B",
    "SK-100-B",
    "SK-100-1G",
  ];
  List setCNsalt1 = ["Cu", "Fe", "Mo", "Zn"];
  List setCNsalt2 = ["Na", "K"];
  List setAB1 = ["Zr", "Ti", "Al"];
  List setAB2 = ["Ti", "Zr"];
  List setZnO = ["Pb", "Cd"];
  List setLTrea = ["Ca", "Cu", "Fe", "Mn", "Ni", "P", "Cr", "Zn"];
  void initState() {
    print("InINITIAL ICP");
    if (widget.headHeight == 0) {
      context.read<ManageDataICP>().add(ICPEvent.searchICPForInput);
    } else {
      context.read<ManageDataICP>().add(ICPEvent.dummyHead);
    }
    super.initState();
  }

  void calculate(int index) {
    double buffCurve = 0;
    try {
      if (dataICPInput[index].sampleName == "CN- salt" &&
          setCNsalt1.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].rawData_1) *
                        double.parse(dataICPInput[index].volume_1)) /
                    double.parse(dataICPInput[index].w_1))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "mg/kg";
        buffCurve = 0.1 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "CN- salt" &&
          setCNsalt2.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].volume_1) *
                        double.parse(dataICPInput[index].dilutionTime_1) *
                        double.parse(dataICPInput[index].rawData_1)) /
                    (double.parse(dataICPInput[index].w_1) * 1000))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "g/kg";
        buffCurve = 1 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "CL-342" &&
          dataICPInput[index].itemName == "Fe") {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].volume_1) *
                        double.parse(dataICPInput[index].rawData_1) *
                        100) /
                    (double.parse(dataICPInput[index].w_1) * 1000000))
                .toStringAsFixed(5);
        dataICPInput[index].resultUnit_1 = "%";
        buffCurve = 0.2 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (setSE1.contains(dataICPInput[index].sampleName) &&
          dataICPInput[index].itemName == "Pb") {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].volume_1) *
                        double.parse(dataICPInput[index].rawData_1)) /
                    double.parse(dataICPInput[index].w_1))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "mg/kg";
        buffCurve = 0.5 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300R" &&
          setAB2.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].tW_1) *
                        double.parse(dataICPInput[index].rawData_1)) /
                    double.parse(dataICPInput[index].w_1))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 10 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300R" &&
          dataICPInput[index].itemName == "V") {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].tW_1) *
                        double.parse(dataICPInput[index].rawData_1)) /
                    double.parse(dataICPInput[index].w_1))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 50 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300M" &&
          setAB1.contains(dataICPInput[index].itemName)) {
        print("in");
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].tW_1) *
                        double.parse(dataICPInput[index].rawData_1)) /
                    double.parse(dataICPInput[index].w_1))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 10 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300M" &&
          dataICPInput[index].itemName == "V") {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].tW_1) *
                        double.parse(dataICPInput[index].rawData_1)) /
                    double.parse(dataICPInput[index].w_1))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 50 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-200M" &&
          dataICPInput[index].itemName == "Al") {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].tW_1) *
                        double.parse(dataICPInput[index].rawData_1)) /
                    double.parse(dataICPInput[index].w_1))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 10 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "ZnO" &&
          setZnO.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].dilutionTime_1) *
                    double.parse(dataICPInput[index].rawData_1)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 1 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "L-treament" &&
          setLTrea.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].dilutionTime_1) *
                    double.parse(dataICPInput[index].rawData_1)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 0.2 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].itemName == "Fe" &&
          dataICPInput[index].dilutionTime_1.toString() == "1") {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].dilutionTime_1) *
                    double.parse(dataICPInput[index].rawData_1)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 0.2 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].itemName == "Ca" ||
          dataICPInput[index].itemName == "Mg") {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].dilutionTime_1) *
                    double.parse(dataICPInput[index].rawData_1)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 0.5 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      } else {
        dataICPInput[index].result_1 =
            ((double.parse(dataICPInput[index].dilutionTime_1) *
                    double.parse(dataICPInput[index].rawData_1)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_1 = "ppm";
        buffCurve = 1 * double.parse(dataICPInput[index].dilutionTime_1);
        if (double.parse(dataICPInput[index].result_1) < buffCurve) {
          dataICPInput[index].result_1 = "< " + buffCurve.toString();
        }
      }

      setState(() {});
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  /* void calculate(int index) {
    try {
      if (double.parse(dataICPInput[index].dilutionTime_1) > 0) {
        if (double.parse(dataICPInput[index].rawData_1) > 0) {
          dataICPInput[index].result_1 =
              (double.parse(dataICPInput[index].dilutionTime_1) *
                      double.parse(dataICPInput[index].rawData_1))
                  .toStringAsFixed(2);
          dataICPInput[index].resultUnit_1 = "ppm";
          setState(() {});
        }
      }
    } on Exception catch (e) {
      // TODO
    }
  } */

  void calculate2(int index) {
    double buffCurve = 0;
    try {
      if (dataICPInput[index].sampleName == "CN- salt" &&
          setCNsalt1.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].rawData_2) *
                        double.parse(dataICPInput[index].volume_2)) /
                    double.parse(dataICPInput[index].w_2))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "mg/kg";
        buffCurve = 0.1 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "CN- salt" &&
          setCNsalt2.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].volume_2) *
                        double.parse(dataICPInput[index].dilutionTime_2) *
                        double.parse(dataICPInput[index].rawData_2)) /
                    (double.parse(dataICPInput[index].w_2) * 1000))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "g/kg";
        buffCurve = 1 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "CL-342" &&
          dataICPInput[index].itemName == "Fe") {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].volume_2) *
                        double.parse(dataICPInput[index].rawData_2) *
                        100) /
                    (double.parse(dataICPInput[index].w_2) * 1000000))
                .toStringAsFixed(5);
        dataICPInput[index].resultUnit_2 = "%";
        buffCurve = 0.2 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (setSE1.contains(dataICPInput[index].sampleName) &&
          dataICPInput[index].itemName == "Pb") {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].volume_2) *
                        double.parse(dataICPInput[index].rawData_2)) /
                    double.parse(dataICPInput[index].w_2))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "mg/kg";
        buffCurve = 0.5 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300R" &&
          setAB2.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].tW_2) *
                        double.parse(dataICPInput[index].rawData_2)) /
                    double.parse(dataICPInput[index].w_2))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 10 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300R" &&
          dataICPInput[index].itemName == "V") {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].tW_2) *
                        double.parse(dataICPInput[index].rawData_2)) /
                    double.parse(dataICPInput[index].w_2))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 50 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300M" &&
          setAB1.contains(dataICPInput[index].itemName)) {
        print("in");
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].tW_2) *
                        double.parse(dataICPInput[index].rawData_2)) /
                    double.parse(dataICPInput[index].w_2))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 10 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-300M" &&
          dataICPInput[index].itemName == "V") {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].tW_2) *
                        double.parse(dataICPInput[index].rawData_2)) /
                    double.parse(dataICPInput[index].w_2))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 50 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "AB-200M" &&
          dataICPInput[index].itemName == "Al") {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].tW_2) *
                        double.parse(dataICPInput[index].rawData_2)) /
                    double.parse(dataICPInput[index].w_2))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 10 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "ZnO" &&
          setZnO.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].dilutionTime_2) *
                    double.parse(dataICPInput[index].rawData_2)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 1 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].sampleName == "L-treament" &&
          setLTrea.contains(dataICPInput[index].itemName)) {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].dilutionTime_2) *
                    double.parse(dataICPInput[index].rawData_2)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 0.2 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].itemName == "Fe" &&
          dataICPInput[index].dilutionTime_2.toString() == "1") {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].dilutionTime_2) *
                    double.parse(dataICPInput[index].rawData_2)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 0.2 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else if (dataICPInput[index].itemName == "Ca" ||
          dataICPInput[index].itemName == "Mg") {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].dilutionTime_2) *
                    double.parse(dataICPInput[index].rawData_2)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 0.5 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      } else {
        dataICPInput[index].result_2 =
            ((double.parse(dataICPInput[index].dilutionTime_2) *
                    double.parse(dataICPInput[index].rawData_2)))
                .toStringAsFixed(2);
        dataICPInput[index].resultUnit_2 = "ppm";
        buffCurve = 1 * double.parse(dataICPInput[index].dilutionTime_2);
        if (double.parse(dataICPInput[index].result_2) < buffCurve) {
          dataICPInput[index].result_2 = "< " + buffCurve.toString();
        }
      }

      setState(() {});
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  void tempSave(int index) {
    dataTempICPsave.clear();
    dataTempICPsave.add(dataICPInput[index]);
    context.read<ManageDataICP>().add(ICPEvent.tempSaveICPData);
  }

  void saveResult(int index) {
    if (dataICPInput[index].result_1.toString() != "") {
      CoolAlert.show(
          width: 200,
          context: context,
          type: CoolAlertType.confirm,
          widget: Column(children: [
            Text(
                'STD MIN : ${dataICPInput[index].stdMin.toString()}     STD MAX : ${dataICPInput[index].stdMax.toString()}'),
            Text('RESULT : ${dataICPInput[index].result_1.toString()}'),
            SizedBox(
              height: 10,
            ),
            ((() {
              if (dataICPInput[index].result_2.toString() != "") {
                try {
                  if (double.parse(dataICPInput[index].result_1) >
                          double.parse(dataICPInput[index].stdMax) ||
                      double.parse(dataICPInput[index].result_1) <
                          double.parse(dataICPInput[index].stdMin) ||
                      double.parse(dataICPInput[index].result_2) >
                          double.parse(dataICPInput[index].stdMax) ||
                      double.parse(dataICPInput[index].result_2) <
                          double.parse(dataICPInput[index].stdMin)) {
                    return Text('RESULT OUT OF RANGE',
                        style: TextStyle(color: Colors.red));
                  } else
                    return Text('CONFIRM SAVE RESULT');
                } on Exception catch (e) {
                  return Text(
                    'CONFIRM SAVE RESULT',
                  );
                }
              } else {
                try {
                  if (double.parse(dataICPInput[index].result_1) >
                          double.parse(dataICPInput[index].stdMax) ||
                      double.parse(dataICPInput[index].result_1) <
                          double.parse(dataICPInput[index].stdMin)) {
                    return Text('RESULT OUT OF RANGE',
                        style: TextStyle(color: Colors.red));
                  } else
                    return Text('CONFIRM SAVE RESULT');
                } on Exception catch (e) {
                  return Text('CONFIRM SAVE RESULT');
                }
              }
            }()))
          ]),
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Colors.green,
          onConfirmBtnTap: () {
            dataICPsave.clear();
            dataICPInput[index].userAnalysis = userName;
            dataICPInput[index].userAnalysisBranch = userBranch;
            dataICPsave.add(dataICPInput[index]);
            context.read<ManageDataICP>().add(ICPEvent.saveICPData);
            Navigator.pop(context);
          });
    } else {
      CoolAlert.show(
        width: 200,
        context: context,
        type: CoolAlertType.error,
        text: 'INPUT RESULT',
        confirmBtnText: 'OK',
        confirmBtnColor: Colors.green,
      );
    }
  }

  double widthC1 = 50;
  double widthC2 = 50;
  double widthC3 = 50;
  double widthC4 = 50;
  double widthC5 = 50;
  double widthC6 = 50;
  double widthC7 = 50;
  double widthC8 = 50;
  double widthC9 = 50;
  double widthC10 = 50;
  double widthC11 = 50;
  double widthC12 = 50;
  double widthC13 = 50;
  double widthC14 = 50;
  double widthC15 = 40;
  double fieldHeight = 30;

  TextStyle styleDataInTable =
      TextStyle(fontSize: 9, fontFamily: 'Mitr', color: Colors.black);
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageDataICP, int>(builder: (context, state) {
      if (state == 1) {
        if (widget.headHeight == 0) {
          countData = dataICPInput.length;
        } else {
          countData = 0;
        }
        return Form(
            key: _formKey,
            child: DataTable(
                headingRowHeight: widget.headHeight,
                headingTextStyle: styleHeaderTable,
                dataRowHeight: widget.dataHeight,
                dataTextStyle: styleDataInTable,
                columnSpacing: 5,
                horizontalMargin: 10,
                columns: [
                  DataColumn(
                    label: Container(
                        width: widthC1,
                        child: Text(
                          'REMARK',
                        )),
                    tooltip: "SAMPLE REMARK",
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'HISTORY',
                    'DATA/CHART',
                    widthC2,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn('WEIGHT(g)', 'WEIGHT(g)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                      'TRAGET\nWEIGHT(g)', 'TRAGET WEIGHT(g)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn('VOLUME\n(mL)', 'VOLUME(mL)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn('DILUTION \n TIMES', 'DILUTION TIMES', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA \n (ppm)',
                    'RAW DATA',
                    widthC4,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT',
                    '',
                    widthC5,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'UNIT',
                    'UNIT',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'ERROR',
                    'ERROR RESULT',
                    widthC6,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK',
                    'REMARK RESULT',
                    widthC7,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC13,
                  ),
                  DataColumn(label: _verticalDivider2),
                  headerColumn('WEIGHT(g)(2)', 'WEIGHT(g)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                      'TRAGET\nWEIGHT(g)(2)', 'TRAGET WEIGHT(g)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn('VOLUME\n(mL)(2)', 'VOLUME(mL)', widthC3),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                      'DILUTION \n TIMES', 'DILUTION TIMES(2)', widthC8),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RAW DATA \n (ppm)(2)',
                    'RAW DATA',
                    widthC9,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'RESULT\n(2)',
                    '',
                    widthC10,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'UNIT(2)',
                    'UNIT',
                    widthC3,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'REMARK\n(2)',
                    'REMARK RESULT',
                    widthC11,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'TEMP.S',
                    'TEMPORARY SAVE',
                    widthC12,
                  ),
                  DataColumn(label: _verticalDivider),
                  headerColumn(
                    'SAVE',
                    'SAVE',
                    widthC13,
                  ),
                ],
                rows: List<DataRow>.generate(
                    countData,
                    (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              width: widthC1,
                              child: Text(dataICPInput[index].sampleRemark),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC2,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(Icons.insights),
                                  onPressed: () {
                                    setState(() {
                                      showHistory(
                                          dataICPInput[index]
                                              .custFull
                                              .toString(),
                                          dataICPInput[index]
                                              .itemName
                                              .toString(),
                                          "TTC",
                                          dataICPInput[index].stdMax.toString(),
                                          dataICPInput[index].stdMin.toString(),
                                          context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider2),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue:
                                    dataICPInput[index].w_1.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].w_1 = value.toString();
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue:
                                    dataICPInput[index].tW_1.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].tW_1 = value.toString();
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue:
                                    dataICPInput[index].volume_1.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].volume_1 =
                                      value.toString();
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue: dataICPInput[index]
                                    .dilutionTime_1
                                    .toString(),
                                onChanged: (value) {
                                  dataICPInput[index].dilutionTime_1 =
                                      value.toString();
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC4,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_2',
                                initialValue:
                                    dataICPInput[index].rawData_1.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].rawData_1 =
                                      value.toString();
                                  calculate(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC5,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                //textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                name: '${index}_3',
                                //enabled: false,
                                key: Key(
                                    dataICPInput[index].result_1.toString()),
                                initialValue:
                                    dataICPInput[index].result_1.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].result_1 =
                                      value.toString();
                                },
                              ),
                              //Text(dataICPInput[index].result_1),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                name: '${index}_3',
                                key: Key(dataICPInput[index]
                                    .resultUnit_1
                                    .toString()),
                                initialValue:
                                    dataICPInput[index].resultUnit_1.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].resultUnit_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC6,
                              //height: fieldHeight,
                              child: FormBuilderDropdown(
                                items: errorData
                                    .map((error) => DropdownMenuItem(
                                          value: error,
                                          child: Text('$error'),
                                        ))
                                    .toList(),
                                style: styleDataInTable,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder()),
                                name: '${index}_4',
                                onChanged: (value) {
                                  dataICPInput[index].result_1 = value;
                                  dataICPInput[index].resultUnit_1 = "";
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC8,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_5',
                                initialValue: dataICPInput[index]
                                    .resultRemark_1
                                    .toString(),
                                onChanged: (value) {
                                  dataICPInput[index].resultRemark_1 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC12,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.black12,
                                  ),
                                  onPressed: () {
                                    tempSave(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC13,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    saveResult(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider2),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue:
                                    dataICPInput[index].w_2.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].w_2 = value.toString();
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue:
                                    dataICPInput[index].tW_2.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].tW_2 = value.toString();
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_1',
                                initialValue:
                                    dataICPInput[index].volume_2.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].volume_2 =
                                      value.toString();
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC9,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_6',
                                initialValue: dataICPInput[index]
                                    .dilutionTime_2
                                    .toString(),
                                onChanged: (value) {
                                  dataICPInput[index].dilutionTime_2 =
                                      value.toString();
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_7',
                                initialValue:
                                    dataICPInput[index].rawData_2.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].rawData_2 =
                                      value.toString();
                                  calculate2(index);
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC10,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                //textInputAction: TextInputAction.next,
                                style: styleDataInTable,
                                decoration: formField(),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                name: '${index}_8',
                                //enabled: false,
                                key: Key(
                                    dataICPInput[index].result_2.toString()),
                                initialValue:
                                    dataICPInput[index].result_2.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].result_2 =
                                      value.toString();
                                },
                              ),
                              //Text(dataICPInput[index].result_1),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC3,
                              child: FormBuilderTextField(
                                style: styleDataInTable,
                                decoration: formField(),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                name: '${index}_3',
                                key: Key(dataICPInput[index]
                                    .resultUnit_2
                                    .toString()),
                                initialValue:
                                    dataICPInput[index].resultUnit_2.toString(),
                                onChanged: (value) {
                                  dataICPInput[index].resultUnit_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC11,
                              //height: fieldHeight,
                              child: FormBuilderTextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: styleDataInTable,
                                decoration: formField(),
                                name: '${index}_9',
                                initialValue: dataICPInput[index]
                                    .resultRemark_2
                                    .toString(),
                                onChanged: (value) {
                                  dataICPInput[index].resultRemark_2 =
                                      value.toString();
                                },
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC12,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.black12,
                                  ),
                                  onPressed: () {
                                    tempSave(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                          DataCell(_verticalDivider),
                          DataCell(
                            Container(
                              width: widthC13,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    saveResult(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]))));
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}

Widget _verticalDivider = const VerticalDivider(
  color: Color(0x40000000),
  thickness: 1,
);
Widget _verticalDivider2 = const VerticalDivider(
  color: Colors.black,
  thickness: 1,
);

InputDecoration formField() {
  return InputDecoration(
      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 3),
      border: OutlineInputBorder(gapPadding: 0));
}

headerColumn(
  String textIn,
  String tooltipIn,
  double widthData,
) {
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);
  return DataColumn(
    label: Container(
        width: widthData,
        child: Center(
            child: Text(textIn,
                style: styleHeaderTable, textAlign: TextAlign.center))),
    tooltip: tooltipIn,
  );
}
 */