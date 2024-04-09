import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/11ItemPerStaftCount/ItemPerStaftCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/1ItemAnalysisDue/ItemAnalysisDue.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/KPIItemCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/3SampleSolutionCount/SampleSolutionCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/4TestPieceCount/TestPieceCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5NoOfItem/NoOfItem.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5RequestCount/RequestCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/6ItemRecheckCount/ItemRecheckCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/7ItemMistakeCount/ItemMistakeCount.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/9WorkingDateCount/WorkingDateCount.dart';

late BuildContext contextSummaryDataPage;

class SummaryDataPage extends StatefulWidget {
  const SummaryDataPage({Key? key}) : super(key: key);

  @override
  State<SummaryDataPage> createState() => _SummaryDataPageState();
}

class _SummaryDataPageState extends State<SummaryDataPage> {
  @override
  int _index = 0;
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 40,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.black38,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            isScrollable: true,
            tabs: [
              /* Tab(icon: Icon(Icons.directions_car)),  */
              Tab(
                text: (" 1. ITEM BY DUE "),
              ),
              Tab(
                text: (" 2. KPI ITEM COUNT "),
              ),
              Tab(
                text: (" 3. No. of  Solution Sample "),
              ),
              Tab(
                text: (" 4. No. of Test Piece "),
              ),
              Tab(
                text: (" 5. No. of Request "),
              ),
              Tab(
                text: (" 6. No. of Confirm Item "),
              ),
              Tab(
                text: (" 7. No. of Mistake (PDCA Case) "),
              ),
              Tab(
                text: (" 9. Analysis Working Day "),
              ),
              Tab(
                text: (" 11. Item / Man "),
              ),
              Tab(
                text: (" 8. Cost by item "),
              ),
              Tab(
                text: (" 10. KPI "),
              ),
              Tab(
                text: (" 12. Capacity Man "),
              ),
              Tab(
                text: (" 5. No. Request "),
              ),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: const TabBarView(
          children: [
            ItemAnalysisDue(),
            KPIItemCount(),
            //
            SampleSolutionCount(),
            TestPieceCount(),
            RequestCount(),
            ItemRecheckCount(),
            ItemMistakeCount(),
            WorkingDateCount(),
            ItemPerStaftCount(),
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_car)),
            NoOfItem(),
          ],
        ),
      ),
    );
  }
}
