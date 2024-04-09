import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5NoOfItem/SubWidget/ItemAnalysisGraph/data/NoOfItemGraphStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/5NoOfItem/SubWidget/ItemAnalysisGraph/data/NoOfItemGraph_bloc.dart';

class NoOfItemGraph extends StatefulWidget {
  String branch = "";
  NoOfItemGraph({Key? key, required this.branch}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NoOfItemGraphState();
}

class NoOfItemGraphState extends State {
  int touchedIndex = 0;

  @override
  void initState() {
    //print('initial ${widget.branch}');
    super.initState();
  }

  List<ModelNoOfItemGraph> NoOfItemGraph = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      /* BlocBuilder<ManageDataNoOfItemGraph, int>(builder: (context, state) { */
      FutureBuilder(
          /* future: fetchNoOfItemGraph(widget.branch), */
          future: fetchNoOfItemGraph("BANGPOO"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != 2) {
              return Container();
            } else {
              /* if (widget.branch == "BANGPOO") {
                  NoOfItemGraph = NoOfItemGraphBuffBP;
                } else {
                  NoOfItemGraph = NoOfItemGraphBuffRY;
                } */
              NoOfItemGraph = NoOfItemGraphBuff;
              return Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SUMMARY ITEM DATA (By CUSTOMER)',
                              style: TextStyle(
                                color: Color(0xff171547),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 14),
                            AspectRatio(
                              aspectRatio: 1,
                              child: Card(
                                color: Colors.white,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                        pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {
                                          /* setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
                                          }); */
                                        }),
                                        borderData: FlBorderData(
                                          show: true,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 0,
                                        sections: showingSections()),
                                  ),
                                ),
                              ),
                            )
                          ])));
            }
          })
    ]);
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 600.0 : 500.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: NoOfItemGraph[0].TAW,
            title: 'TAW (${NoOfItemGraph[0].TAW})',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: NoOfItemGraph[0].HONDA,
            title: 'HONDA (${NoOfItemGraph[0].HONDA})',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/librarian-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: NoOfItemGraph[0].IMCT,
            title: 'IMCT (${NoOfItemGraph[0].IMCT})',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: NoOfItemGraph[0].BCM,
            title: 'BCM (${NoOfItemGraph[0].BCM})',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Color.fromARGB(255, 117, 44, 88),
            value: NoOfItemGraph[0].OTHER,
            title: 'OTHER (${NoOfItemGraph[0].OTHER})',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Text(""),
      ),
    );
  }
}
