/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryChart/HistoryChart.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/10_Surfacant/10_Surfacant.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/11_pH/11_pH.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/12_EC/12_EC.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/15_Viscosity_NoxRust/15_Viscosity_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/16_SolidContent_NoxRust/16_SolidContent_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/1_PO43Titrate/1_PO43Titrate.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/2_OCA/2_OCA.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/7_FF/7_FF.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/8_NV/8_NV.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/Instrument/9_PULS/9_PULS.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ItemDetailPage/ItemDetailPage/data/ManageItemDetailData.dart';
import 'package:tpk_login_arsa_01/style/statusText.dart';
import 'package:tpk_login_arsa_01/style/style.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //height: 320,
        margin: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 10),
        child: Center(
          child: ItemDetail(), //graph and raw data item when future complete
        ),
      ),
    );
  }
}

class ItemDetail extends StatefulWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  void initState() {
    print("InINITIAL");
  }

  double heightBox1 = 30;
  double widthsection1 = 150;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchItemDetailData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                  width: 600,
                  //height: 380,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "CUSTOMER NAME",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].custFull.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "REQUEST NO",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].reqNo.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "ITEM NAME",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].itemName.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "SAMPLE GROUP",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].sampleGroup.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "SAMPLE TYPE",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].sampleType.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "SAMPLE TANK",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].sampleTank.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "SAMPLE NAME",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].sampleName.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "SAMPLE STATUS",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].sampleStatus.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "ITEM STATUS",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: statusItem(
                                item_itemData[0].itemStatus.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "POSITION",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].position.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "MAGNIFICATION",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].mag.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightBox1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widthsection1,
                              child: Text(
                                "TEMP",
                                style: stylesection,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item_itemData[0].temp.toString(),
                                style: styledata,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (item_itemData[0].itemStatus == "COMPLETE") ...[
                        Container(
                          height: heightBox1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: widthsection1,
                                child: Text(
                                  "APPROVER",
                                  style: stylesection,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${item_itemData[0].userApprove.toString()}   ${item_itemData[0].resultAproveDate.toString()}",
                                  style: styledata,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 600,
                  child: HistoryChart(
                      custFull: item_itemData[0].custFull.toString(),
                      itemName: item_itemData[0].itemName.toString(),
                      max: item_itemData[0].stdMax.toString(),
                      min: item_itemData[0].stdMin.toString()),
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(
                  builder: (BuildContext context) {
                    switch (item_itemData[0].instrumentName.toString()) {
                      case "PO43-(Titrate)":
                        return Instrument_PO43Titrate();
                      case 'OCA':
                        return Instrument_OCA();
                      case 'F-F':
                        return Instrument_FF();
                      case '%NV':
                        return Instrument_NV();
                      case 'PULS':
                        return Instrument_PULS();
                      case 'Surfactant':
                        return Instrument_Surfactant();
                      case 'pH':
                        return Instrument_pH();
                      case 'EC':
                        return Instrument_EC();
                      case 'Solid Content(Nox Rust)':
                        return Instrument_SolidContent();
                      case 'Viscocity(Nox Rust)':
                        return Instrument_Viscosity();
                      default:
                        Container();
                    }
                    return Container();
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
 */