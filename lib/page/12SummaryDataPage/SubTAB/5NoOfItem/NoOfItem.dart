import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5NoOfItem/SubWidget/ItemAnalysisGraph/NoOfItemGraph.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5NoOfItem/SubWidget/ItemAnalysisGraph/data/NoOfItemGraph_bloc.dart';

late BuildContext contextNoOfItem;

class NoOfItem extends StatelessWidget {
  const NoOfItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /* MultiBlocProvider(
        providers: [
          BlocProvider<ManageDataNoOfItem>(
            create: (BuildContext context) => ManageDataNoOfItem(),
          ),
        ],
        child:  */
        Container(
            child: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 1100,
                              child: NoOfItemGraph(branch: "BANGPOO")),
                          /* Container(
                              width: 1100,
                              child: NoOfItemGraph(branch: "RAYONG")), */
                        ],
                      ),
                    ))));
  }
}
