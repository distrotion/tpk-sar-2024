import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/1ItemAnalysisDue/SubWidget/ItemAnalysisGraph/ItemAnalysisDueGraph.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/KPIItemCount.dart';

late BuildContext contextItemAnalysisDue;

class ItemAnalysisDue extends StatelessWidget {
  const ItemAnalysisDue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 1100,
                          child: ItemAnalysisDueGrpah(branch: "BANGPOO")),
                      Container(
                          width: 1100,
                          child: ItemAnalysisDueGrpah(branch: "RAYONG")),
                    ],
                  ),
                ))));
  }
}
