import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/Data/BlocChagpage.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPageStructure.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/SubWidget/TableMainInputData.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_Event.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/InputAnalysisDataPage/data/InputAnalysisDataPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/10_Surfacant/10_Surfactant.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/11_pH/11_pH.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/12_EC/12_EC.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/13_TiUV/13_TiUV.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/14_Cwt3Layer/14_Cwt3Layer.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/15_Viscosity_NoxRust/15_Viscosity_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/16_SolidContent_NoxRust/16_SolidContent_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/17_SG_NoxRust/17_SG_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/18_Moisture_NoxRust/18_Moisture_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/19_FlashPoint_NoxRust/19_FlashPoint_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/1_PO43Titrate/1_PO43Titrate.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/20_AcidNumber_NoxRust/20_AcidNumber_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/21_NV_NoxRust/21_NV_NoxRust.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/22_XRF/22_XRF.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/23_Sludge/23_Sludge.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/24_CWT/24_CWT.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/25_SSM/25_SSM.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/27_Brix/27_Brix.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/28_NV_WAX/28_NV_WAX.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/29_Viscosity_WAX/29_Viscosity_WAX.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/2_OCA/2_OCA.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/31_FlashPoint_WAX/31_FlashPoint_WAX.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/32_Density_WAX/32_Density_WAX.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/33_ClAUTO/33_ClAUTO.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/35_Dsmut/35_Dsmut.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/36_Lvalue/36_Lvalue.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/37_ContactAngle/37_ContactAngle.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/38_LECO/38_LECO.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/39_CO32/39_CO32.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/3_SEM/3_SEM.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/40_CN/40_CN.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/41_CrystalSize/41_CrystalSize.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/49_XRD_PRatio/49_XRD_PRatio.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/4_ICP/4_ICP.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/50_XRD_020Ratio/50_XRD_020Ratio.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/51_Filter/51_Filter.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/52_CnUV/52_CnUV.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/5_IC/5_IC.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/6_TOC/6_TOC.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/7_FF/7_FF.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/8_NV/8_NV.dart';
import 'package:tpk_login_arsa_01/page/32InputAnalysisDataPage/Instrument/9_PULS/9_PULS.dart';

late BuildContext contextAnalysisDataPage;

class InputAnalysisDataPage extends StatelessWidget {
  const InputAnalysisDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataInputAnalysisDataPage>(
          create: (BuildContext context) => ManageDataInputAnalysisDataPage(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              InputAnalysysData(),
              //HistoryData(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputAnalysysData extends StatefulWidget {
  const InputAnalysysData({Key? key}) : super(key: key);

  @override
  _InputAnalysysDataState createState() => _InputAnalysysDataState();
}

class _InputAnalysysDataState extends State<InputAnalysysData> {
  late LinkedScrollControllerGroup _controllers;
  late LinkedScrollControllerGroup _controllers2;
  late ScrollController _setx1;
  late ScrollController _setx2;
  late ScrollController _sety1;
  late ScrollController _sety2;

  @override
  void initState() {
    context
        .read<ManageDataInputAnalysisDataPage>()
        .add(InputAnalysisDataPageEvent.searchInstrumentListData);
    super.initState();
    //searchOption = SearchItemModel();
    _controllers = LinkedScrollControllerGroup();
    _setx1 = _controllers.addAndGet();
    _setx2 = _controllers.addAndGet();
    _controllers2 = LinkedScrollControllerGroup();
    _sety1 = _controllers2.addAndGet();
    _sety2 = _controllers2.addAndGet();
    getInstrumentName();
  }

  @override
  void dispose() {
    _setx1.dispose();
    _setx2.dispose();
    _sety1.dispose();
    _sety2.dispose();
    super.dispose();
  }

  void getInstrumentName() async {
    final SharedPreferences prefs = await _prefs;
    instrumentName =
        prefs.getString('InputAnalysisDataPage_InstrumentName') ?? "";
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String instrumentName = "";
  double mainDataWidth = 578;
  double mainDataHeight = 450;

  @override
  Widget build(BuildContext context) {
    contextAnalysisDataPage = context;
    return BlocBuilder<ManageDataInputAnalysisDataPage, int>(
        builder: (context, state) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      if (state >= 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Container(child: Text("Width : $width Heigth : $height")),
            Center(
              child: Container(
                  //height: 30,
                  child: Text("INSTRUMENT $instrumentName")),
            ),
            Center(child: SearchSampleBar()),
            if (state == 1) ...[
              Container(
                decoration: outterDec(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      width: mainDataWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: TableMainInputData(
                              headHeight: 60,
                              dataHeight: 0,
                            ),
                          ),
                          Container(
                              width: mainDataWidth,
                              height: mainDataHeight,
                              child: SingleChildScrollView(
                                controller: _sety1,
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                child: TableMainInputData(
                                  headHeight: 0,
                                  dataHeight: 100,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: SingleChildScrollView(
                                controller: _setx1,
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: SelectInstrument(
                                  headHeight: 60,
                                  dataHeight: 0,
                                  instrumentName: instrumentName,
                                ),
                              ),
                            ),
                            Container(
                              height: mainDataHeight,
                              child: SingleChildScrollView(
                                controller: _setx2,
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  controller: _sety2,
                                  child: SelectInstrument(
                                    headHeight: 0,
                                    dataHeight: 100,
                                    instrumentName: instrumentName,
                                  ), /* Instrument_PO43Titrate(
                                    headHeight: 0,
                                    dataHeight: 100,
                                  ), */
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]
          ],
        );
      } else {
        return RefreshIndicator(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                height: 1000,
                width: 1000,
              ),
            ),
            onRefresh: onrefresh);
      }
    });
  }
}

Future onrefresh() async {
  BlocProvider.of<SwPageCubit>(contextBG).togglePage("InputAnalysisDataPage");
  //Navigator.pop(contextBG);
}

BoxDecoration outterDec() {
  return BoxDecoration(
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
  );
}

class SearchSampleBar extends StatefulWidget {
  const SearchSampleBar({Key? key}) : super(key: key);

  @override
  _SearchSampleBarState createState() => _SearchSampleBarState();
}

final _formKey = GlobalKey<FormBuilderState>();
TextStyle styleHeaderTable = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontFamily: 'Mitr',
    color: Colors.black);
TextStyle styleDataInTable =
    TextStyle(fontSize: 10, fontFamily: 'Mitr', color: Colors.black);

class _SearchSampleBarState extends State<SearchSampleBar> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 100,
                child: Text(
                  "SAMPLE CODE",
                  style: styleHeaderTable,
                )),
            Container(
              width: 100,
              height: 30,
              child: FormBuilderTextField(
                //textInputAction: TextInputAction.next,
                style: styleDataInTable,
                decoration: formField(),
                name: 'sample',
                key: Key(searchOption.sampleCode),
                initialValue: searchOption.sampleCode,
                onChanged: (value) {
                  searchOption.sampleCode = value.toString();
                },
              ),
            ),
            Container(
                width: 100,
                child: Text(
                  "REMARK NO",
                  style: styleHeaderTable,
                )),
            Container(
              width: 100,
              height: 30,
              child: FormBuilderTextField(
                //textInputAction: TextInputAction.next,
                style: styleDataInTable,
                decoration: formField(),
                name: 'remark',
                key: Key(searchOption.remarkNo),
                initialValue: searchOption.remarkNo,
                onChanged: (value) {
                  searchOption.remarkNo = value.toString();
                },
              ),
            ),
            Container(
              width: 100,
              child: FormBuilderCheckbox(
                title: Text("LIST", style: styleHeaderTable),
                name: 'List',
                initialValue: searchOption.list,
                onChanged: (value) {
                  searchOption.list = value;
                },
              ),
            ),
            Container(
              width: 100,
              child: FormBuilderCheckbox(
                title: Text("FINISH", style: styleHeaderTable),
                name: 'Finish',
                initialValue: searchOption.finish,
                onChanged: (value) {
                  searchOption.finish = value;
                },
              ),
            ),
            Container(
              width: 50,
              child: IconButton(
                tooltip: "SEARCH",
                icon: Icon(
                  Icons.search,
                  color: Colors.green,
                ),
                onPressed: () {
                  contextAnalysisDataPage
                      .read<ManageDataInputAnalysisDataPage>()
                      .add(InputAnalysisDataPageEvent.reloadData);
                },
              ),
            ),
            Container(
              width: 50,
              child: IconButton(
                tooltip: "CLEAR",
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    searchOption = SearchItemModel();
                    _formKey.currentState?.reset();
                  });
                },
              ),
            ),
            Container(
              width: 50,
              child: IconButton(
                tooltip: "BACK",
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _formKey.currentState?.reset();
                    BlocProvider.of<SwPageCubit>(context)
                        .togglePage("AnalysisPage");
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration formField() {
  return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(gapPadding: 8));
}

// ignore: must_be_immutable
class SelectInstrument extends StatefulWidget {
  double headHeight = 0;
  double dataHeight = 0;
  String instrumentName = "";
  SelectInstrument({
    required this.headHeight,
    required this.dataHeight,
    required this.instrumentName,
  });
  @override
  _SelectInstrumentState createState() => _SelectInstrumentState();
}

class _SelectInstrumentState extends State<SelectInstrument> {
  @override
  Widget build(BuildContext context) {
    switch (widget.instrumentName) {
      //1
      case "PO43-(Titration)":
        return Instrument_PO43Titrate(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'OCA':
        return Instrument_OCA(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'SEM':
        return Instrument_SEM(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'ICP':
        return Instrument_ICP(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'IC':
        return Instrument_IC(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'TOC':
        return Instrument_TOC(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'F-F':
        return Instrument_FF(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case '%NV':
        return Instrument_NV(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Cwt. PULS':
        return Instrument_PULS(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      //10
      case 'Surfactant':
        return Instrument_Surfactant(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'pH':
        return Instrument_PH(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'EC':
        return Instrument_EC(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Ti(UV)':
        return Instrument_TiUV(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Cwt.3 layers':
        return Instrument_Cwt3layers(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Viscosity(NOX-RUST)':
        return Instrument_Viscosity_NoxRust(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Solid Content(Nox Rust)':
        return Instrument_SolidContent_NoxRust(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'S.G(Nox Rust)':
        return Instrument_SG_NoxRust(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Moisture(Nox Rust)':
        return Instrument_Moisture_NoxRust(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Flash Point (NOX-RUST)':
        return Instrument_FlashPoint_NoxRust(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Acid Number(Nox Rust)':
        return Instrument_AcidNumber_NoxRust(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      //20
      case '%NV(Nox Rust)':
        return Instrument_NV_NoxRust(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'XRF':
        return Instrument_XRF(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Sludge':
        return Instrument_Sludge(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Cwt':
        return Instrument_CWT(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'SSM':
        return Instrument_SSM(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case '%Brix':
        return Instrument_Brix(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
//27
      case '%NV(WAX)':
        return Instrument_NV_WAX(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Viscosity(WAX)':
        return Instrument_Viscosity_WAX(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
//31
      case 'Flash Point(WAX)':
        return Instrument_FlashPoint_WAX(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Density(WAX)':
        return Instrument_Density_WAX(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Cl(AUTO)':
        return Instrument_ClAUTO(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
/////////////////////
      /* case 'XRD':
        return Instrument_ClAUTO(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight); */
      case 'D-Smut':
        return Instrument_Dsmut(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'L-Value':
        return Instrument_Lvalue(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Contact angle':
        return Instrument_ContactAngle(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
///////////////////
      case 'LECO':
        return LECO(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'CO32-':
        return Instrument_CO32(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'CN-':
        return Instrument_CN(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'CN-(UV)':
        return Instrument_CnUV(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      // case 'CN-(UV)':
      //   return Instrument_CN(
      //       headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Crystal size':
        return Instrument_CrystalSize(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'XRD P Ratio(%)':
        return Instrument_XRD_PRatio(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'XRD 020 Ratio':
        return Instrument_XRD_020Ratio(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      case 'Filter Image':
        return Instrument_Filter(
            headHeight: widget.headHeight, dataHeight: widget.dataHeight);
      default:
        Container();
    }
    return Container();
  }
}
