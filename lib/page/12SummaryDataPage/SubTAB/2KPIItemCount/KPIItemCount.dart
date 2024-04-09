/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/SubWidget/KPIItemCountTable/KPIItemCountTable.dart';

late BuildContext contextKPIItemCount;

class KPIItemCount extends StatelessWidget {
  const KPIItemCount({Key? key}) : super(key: key);

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
                      Container(width: 1100, child: KPIItemCountTable()),
                    ],
                  ),
                ))));
  }
}
 */
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/SubWidget/KPIItemCountTable/KPIItemCountTable.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/SubWidget/KPIItemCountTable/data/KPIItemCountTableStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/SubWidget/KPIItemCountTable/data/KPIItemCountTable_bloc.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/SubWidget/KPIItemCountTable/data/KPIItemCountTable_event.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/data/KPIItemData.dart';

late BuildContext KPIItemCountContext;

class KPIItemCount extends StatelessWidget {
  const KPIItemCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataKPIItemCount>(
          create: (BuildContext context) => ManageDataKPIItemCount(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20),
          child: KPIItemCountWidget(),
        ),
      ),
    );
  }
}

class KPIItemCountWidget extends StatefulWidget {
  const KPIItemCountWidget({Key? key}) : super(key: key);

  @override
  _KPIItemCountWidgetState createState() => _KPIItemCountWidgetState();
}

class _KPIItemCountWidgetState extends State<KPIItemCountWidget> {
  void initState() {
    print("InINITIAL");
/*     context
        .read<ManageDataKPIItemCount>()
        .add(KPIItemCountEvent.clearAndSearch); */
    super.initState();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  @override
  Widget build(BuildContext context) {
    KPIItemCountContext = context;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SearchBar(),
          ),
          BlocBuilder<ManageDataKPIItemCount, int>(builder: (context, state) {
            print("KPIItemCountWidget rebuild state :$state");
            if (state >= 0 && state < 3)
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  if (state == 2) ...[
                    Container(
                      //width: 1100,
                      //height: 459,
                      decoration: BoxDecoration(
                        color: CustomTheme.colorWhite,
                        /* border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ), */
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
                      child: TableKPIItemCount(),
                    ),
                  ],
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            return CircularProgressIndicator();
          }),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

final _formKey = GlobalKey<FormBuilderState>();
TextStyle styleHeaderTable = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontFamily: 'Mitr',
    color: Colors.black);
TextStyle styleDataInTable =
    TextStyle(fontSize: 10, fontFamily: 'Mitr', color: Colors.black);

class _SearchBarState extends State<SearchBar> {
  void initState() {
    print('in initsearchbar');
    if (searchOption.isEmpty) {
      print('in initsearchbar clear');
      clearSearch();
    }
    super.initState();
  }

  void clearSearch() {
    print('inclear');
    searchOption.clear();
    searchOption.add(SearchItemKPIModel());
    var now = DateTime.now();
    searchOption[0].month = now.month;
    searchOption[0].year = now.year;
  }

  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: FutureBuilder(
            future: searchMasterOption(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return Container(
                  width: 1500,
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 0,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 50,
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 120,
                                child: Text(
                                  "INSTRUMENT NAME",
                                  style: styleHeaderTable,
                                )),
                            SizedBox(width: 10),
                            Container(
                              width: 120,
                              height: 30,
                              child: FormBuilderSearchableDropdown(
                                  popupProps: PopupProps.dialog(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    searchDelay: Duration(microseconds: 1),
                                    disabledItemFn: (String s) =>
                                        s.startsWith('zzz'),
                                  ),
                                  dropdownSearchTextStyle: styleDataInTable,
                                  dropdownSearchDecoration: InputDecoration(
                                      labelStyle: styleHeaderTable,
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none),
                                  name: 'masterInstrument',
                                  key: Key(searchOption[0]
                                      .instrumentName
                                      .toString()),
                                  items: masterInstrumentSearch,
                                  initialValue:
                                      searchOption[0].instrumentName.toString(),
                                  decoration: formField(),
                                  onChanged: (value) {
                                    searchOption[0].instrumentName =
                                        value.toString();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 120,
                                child: Text(
                                  "CUSTOMER NAME",
                                  style: styleHeaderTable,
                                )),
                            SizedBox(width: 10),
                            Container(
                              width: 120,
                              height: 30,
                              child: FormBuilderSearchableDropdown(
                                  popupProps: PopupProps.dialog(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    searchDelay: Duration(microseconds: 1),
                                    disabledItemFn: (String s) =>
                                        s.startsWith('zzz'),
                                  ),
                                  dropdownSearchTextStyle: styleDataInTable,
                                  dropdownSearchDecoration: InputDecoration(
                                      labelStyle: styleHeaderTable,
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none),
                                  name: 'masterCustomer',
                                  key: Key(
                                      searchOption[0].customerName.toString()),
                                  items: masterCustomerSearch,
                                  initialValue:
                                      searchOption[0].customerName.toString(),
                                  decoration: formField(),
                                  onChanged: (value) {
                                    var buff = value.toString().split('|');
                                    searchOption[0].customerName = buff[0];
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 50,
                                child: Text(
                                  "MONTH",
                                  style: styleHeaderTable,
                                )),
                            SizedBox(width: 10),
                            Container(
                              width: 80,
                              height: 30,
                              child: FormBuilderSearchableDropdown(
                                  popupProps: PopupProps.dialog(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    searchDelay: Duration(microseconds: 1),
                                    disabledItemFn: (String s) =>
                                        s.startsWith('zzz'),
                                  ),
                                  dropdownSearchTextStyle: styleDataInTable,
                                  dropdownSearchDecoration: InputDecoration(
                                      labelStyle: styleHeaderTable,
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none),
                                  name: 'monthSearch',
                                  key: Key(searchOption[0].month.toString()),
                                  items: monthSearch,
                                  initialValue:
                                      searchOption[0].month.toString(),
                                  decoration: formField(),
                                  onChanged: (value) {
                                    searchOption[0].month = value.toString();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 50,
                        child: Row(
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: 50,
                                child: Text(
                                  "YEAR",
                                  style: styleHeaderTable,
                                )),
                            SizedBox(width: 10),
                            Container(
                              width: 100,
                              height: 30,
                              child: FormBuilderSearchableDropdown(
                                  popupProps: PopupProps.dialog(
                                    showSearchBox: true,
                                    showSelectedItems: true,
                                    searchDelay: Duration(microseconds: 1),
                                    disabledItemFn: (String s) =>
                                        s.startsWith('zzz'),
                                  ),
                                  dropdownSearchTextStyle: styleDataInTable,
                                  dropdownSearchDecoration: InputDecoration(
                                      labelStyle: styleHeaderTable,
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none),
                                  name: 'yearSearch',
                                  key: Key(searchOption[0].year.toString()),
                                  items: yearSearch,
                                  initialValue: searchOption[0].year.toString(),
                                  decoration: formField(),
                                  onChanged: (value) {
                                    searchOption[0].year = value.toString();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              child: IconButton(
                                tooltip: "SEARCH",
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  context
                                      .read<ManageDataKPIItemCount>()
                                      .add(KPIItemCountEvent.clearAndSearch);
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
                                    clearSearch();
                                    context
                                        .read<ManageDataKPIItemCount>()
                                        .add(KPIItemCountEvent.clearAndSearch);
                                    setState(() {});
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 50,
                              child: IconButton(
                                tooltip: "SAVE",
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  createExcel();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              else
                return CircularProgressIndicator();
            }));
  }
}

InputDecoration formField() {
  return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(gapPadding: 8));
}

//Create new excel file
var fileName =
    'SAR_${searchOption[0].year.toString() + '_' + searchOption[0].month.toString()}.xlsx';
var dataSheetName =
    'DATA_${searchOption[0].year.toString() + '_' + searchOption[0].month.toString()}';
var costSheetName =
    'COST_${searchOption[0].year.toString() + '_' + searchOption[0].month.toString()}';

var excel = Excel.createExcel();
Sheet sheetObject = excel[dataSheetName];
//Create var cell and cellstyle for edit specific cell
var cell = sheetObject.cell(CellIndex.indexByString("A1"));

void createExcel() async {
  var dataExcel = await getDataCreateExcel();
  try {
    excel.rename('Sheet1', dataSheetName);
    //Row1
    addMergeData("A1", "A4", "ITEM", "C", "#000000", "#bcbcbc");
    //sheetObject.setColWidth(100, 50);
    addMergeData("B1", "B4", "INSTRUMENT", "C", "#000000", "#bcbcbc");
    addMergeData("C1", "C4", "GROUP", "C", "#000000", "#bcbcbc");
    addMergeData("D1", "AU1", "BANGPOO", "C", "#000000", "#beddad");
    addMergeData("AV1", "CM1", "ESIE1", "C", "#000000", "#c6e2ff");
    addCellData("CN1", "ALL", "C", "#000000", "#ff0000");

    //Row2
    addMergeData(
        "D2", "Q2", "Item Normal (Result1)", "C", "#000000", "#31dd16");
    addMergeData("R2", "AE2", "Item Confirm (Internal) (Result2)", "C",
        "#000000", "#f6b26b");
    addMergeData("AF2", "AS2", "Item Confirm (External) (Result3-6)", "C",
        "#000000", "#ffd966");
    addMergeData(
        "AT2", "AT3", 'Total Confirm Item(R2-R6)', "C", "#000000", "#e541dc");
    addMergeData("AU2", "AU3", 'Total Item(R1-R6)', "C", "#000000", "#f6b26b");

    //ROW2 ESIE1

    addMergeData(
        "AV2", "BI2", "Item Normal (Result1)", "C", "#000000", "#31dd16");
    addMergeData("BJ2", "BW2", "Item Confirm (Internal) (Result2)", "C",
        "#000000", "#f6b26b");
    addMergeData("BX2", "CK2", "Item Confirm (External) (Result3-6)", "C",
        "#000000", "#ffd966");
    addMergeData(
        "CL2", "CL4", 'Total Confirm Item(R2-R6)', "C", "#000000", "#e541dc");
    addMergeData("CM2", "CM3", 'Total Item(R1-R6)', "C", "#000000", "#f6b26b");
    addMergeData("CN2", "CN3", 'Total Item(R1-R6)', "C", "#000000", "#ff0000");

    //Row3
    addMergeData("D3", "I3", "BP", "C", "#000000", "#50f016");
    addMergeData("J3", "P3", "Support ESIE1", "C", "#000000", "#9fc5e8");
    addCellData("Q3", "Total Normal Item", "C", "#000000", "#31dd16");

    addMergeData("R3", "W3", "BP", "C", "#000000", "#50f016");
    addMergeData("X3", "AD3", "Support ESIE1", "C", "#000000", "#9fc5e8");
    addCellData("AE3", "Total Internal Confirm", "C", "#000000", "#f6b26b");

    addMergeData("AF3", "AK3", "BP", "C", "#000000", "#50f016");
    addMergeData("AL3", "AR3", "Support ESIE1", "C", "#000000", "#9fc5e8");
    addCellData("AS3", "Total External Confirm", "C", "#000000", "#ffd966");

    //Row3 ESIE1

    addMergeData("AV3", "BB3", "ESIE1", "C", "#000000", "#50f016");
    addMergeData("BC3", "BH3", "Support BP", "C", "#000000", "#9fc5e8");
    addCellData("BI3", "Total Normal Item", "C", "#000000", "#31dd16");

    addMergeData("BJ3", "BP3", "ESIE1", "C", "#000000", "#50f016");
    addMergeData("BQ3", "BV3", "Support BP", "C", "#000000", "#9fc5e8");
    addCellData("BW3", "Total Internal Confirm", "C", "#000000", "#f6b26b");

    addMergeData("BX3", "CD3", "ESIE1", "C", "#000000", "#50f016");
    addMergeData("CE3", "CJ3", "Support BP", "C", "#000000", "#9fc5e8");
    addCellData("CK3", "Total External Confirm", "C", "#000000", "#ffd966");

    sheetObject.insertRowIterables(plantBP, 3, startingColumn: 3);
    addCellData("I4", "SUM", "C", "#000000", "#50f016");
    sheetObject.insertRowIterables(plantESIE1, 3, startingColumn: 9);
    addCellData("P4", "SUM", "C", "#000000", "#9fc5e8");
    addCellData("Q4", "SUM", "C", "#000000", "#31dd16");

    sheetObject.insertRowIterables(plantBP, 3, startingColumn: 17);
    addCellData("W4", "SUM", "C", "#000000", "#50f016");
    sheetObject.insertRowIterables(plantESIE1, 3, startingColumn: 23);
    addCellData("AD4", "SUM", "C", "#000000", "#9fc5e8");
    addCellData("AE4", "SUM", "C", "#000000", "#f6b26b");

    sheetObject.insertRowIterables(plantBP, 3, startingColumn: 31);
    addCellData("AK4", "SUM", "C", "#000000", "#50f016");
    sheetObject.insertRowIterables(plantESIE1, 3, startingColumn: 37);
    addCellData("AR4", "SUM", "C", "#000000", "#9fc5e8");
    addCellData("AS4", "SUM", "C", "#000000", "#ffd966");

    addCellData("AT4", "SUM", "C", "#000000", "#e541dc");
    addCellData("AU4", "SUM", "C", "#000000", "#f6b26b");

    //Row4 ESIE1

    sheetObject.insertRowIterables(plantESIE1, 3, startingColumn: 47);
    addCellData("BB4", "SUM", "C", "#000000", "#9fc5e8");
    sheetObject.insertRowIterables(plantBP, 3, startingColumn: 54);
    addCellData("BH4", "SUM", "C", "#000000", "#50f016");
    addCellData("BI4", "SUM", "C", "#000000", "#31dd16");

    sheetObject.insertRowIterables(plantESIE1, 3, startingColumn: 61);
    addCellData("BP4", "SUM", "C", "#000000", "#9fc5e8");
    sheetObject.insertRowIterables(plantBP, 3, startingColumn: 68);
    addCellData("BV4", "SUM", "C", "#000000", "#50f016");
    addCellData("BW4", "SUM", "C", "#000000", "#f6b26b");

    sheetObject.insertRowIterables(plantESIE1, 3, startingColumn: 75);
    addCellData("CD4", "SUM", "C", "#000000", "#9fc5e8");
    sheetObject.insertRowIterables(plantBP, 3, startingColumn: 82);
    addCellData("CJ4", "SUM", "C", "#000000", "#50f016");
    addCellData("CK4", "SUM", "C", "#000000", "#ffd966");

    addCellData("CL4", "SUM", "C", "#000000", "#e541dc");
    addCellData("CM4", "SUM", "C", "#000000", "#f6b26b");
    addCellData("CN4", "SUM", "C", "#000000", "#ff0000");

    //Column 1 Item Name

    for (int i = 0; i < itemName.length; i++) {
      var indexStart = 5;
      var indexBuff = "A";
      indexStart = indexStart + i;
      indexBuff = indexBuff + indexStart.toString();
      if (indexItemnameColor.contains(indexStart)) {
        addCellData(indexBuff, itemName[i], "L", "#f44336", "#ffffff");
      } else {
        addCellData(indexBuff, itemName[i], "L", "#000000", "#ffffff");
      }
    }

    //Column 2 & 3

    for (int i = 0; i < instrumentName.length; i++) {
      var indexStart = 5;
      var indexBuff = "B";
      var indexBuff2 = "C";
      indexStart = indexStart + i;
      indexBuff = indexBuff + indexStart.toString();
      indexBuff2 = indexBuff2 + indexStart.toString();
      if (instrumentName[i] != "") {
        addCellData(indexBuff, instrumentName[i], "C", "#000000", "#ffd966");
        addCellData(indexBuff2, instrumentName[i], "C", "#f44336", "#ffff31");
      }
    }
    addMergeData("C6", "C7", "XRF", "C", "#f44336", "#ffff31");
    addMergeData("C11", "C12", "SEM", "C", "#f44336", "#ffff31");
    addMergeData("C24", "C25", "UV", "C", "#f44336", "#ffff31");
    addMergeData("C27", "C28", "TOC", "C", "#f44336", "#ffff31");
    addMergeData("C34", "C35", "CWT.REMOVE", "C", "#f44336", "#ffff31");
    addMergeData("C37", "C47", "NOXRUST/WAX", "C", "#f44336", "#ffff31");
    addMergeData("C49", "C50", "TITRATE", "C", "#f44336", "#ffff31");
    addMergeData("C56", "C57", "TITRATE", "C", "#f44336", "#ffff31");
    addMergeData("C63", "C79", "WASTE WATER\n(WWT)", "C", "#f44336", "#ffff31");
    addCellData("C90", "CWT.REMOVE", "C", "#f44336", "#ffff31");

    //input data
    for (var i = 0; i < dataItemToExcel.length; i++) {
      var indexRow = instrumentOrder.indexWhere(((instrumentOrder) =>
          instrumentOrder.instrumentName == dataItemToExcel[i][0]));
      if (indexRow != -1) {
        dataItemToExcel[i].removeAt(0);
        sheetObject.insertRowIterables(
            dataItemToExcel[i], instrumentOrder[indexRow].row - 1,
            startingColumn: 3);
      }
    }

    //adjust column
    sheetObject.setColWidth(0, 45);
    sheetObject.setColWidth(1, 30);
    sheetObject.setColWidth(2, 30);
    for (var i = 3; i < 92; i++) {
      //column
      sheetObject.setColWidth(i, 25);
      for (var j = 3; j < 104; j++) //row
      {
        editCellStyle(i, j, "C", "#000000", "#ffffff");
        if (i != 3 && j == 103) {
          var indexCellEdit = indexColumnStr[i] + j.toString();
          var indexSumStart = indexColumnStr[i] + "6";
          var indexSumEnd = indexColumnStr[i] + "103";
          sheetObject.updateCell(CellIndex.indexByString(indexCellEdit),
              Formula.custom('=SUM($indexSumStart,$indexSumEnd)'));
        }
      }

      //sheetObject.setColAutoFit(i);
    }
    createExcelCost();
    excel.save(fileName: fileName);
  } catch (e) {
    print(e);
  }
}

void createExcelCost() async {
  excel.copy(dataSheetName, costSheetName);
  try {
    sheetObject = excel[costSheetName];
    sheetObject.insertColumn(3);
    for (int i = 0; i < itemName.length; i++) {
      var indexStart = 5;
      var indexBuff = "D";
      indexStart = indexStart + i;
      indexBuff = indexBuff + indexStart.toString();
      addCellData(indexBuff, itemCost[i], "L", "#000000", "#ffffff");
    }
    addMergeData("D1", "D4", "COST", "C", "#000000", "#baacac");
    //adjust column
    sheetObject.setColWidth(0, 45);
    sheetObject.setColWidth(1, 30);
    sheetObject.setColWidth(2, 30);
    for (var i = 3; i < 93; i++) {
      //column
      sheetObject.setColWidth(i, 25);
      for (var j = 5; j < 104; j++) //row
      {
        //cell stylr index colunm row
        editCellStyle(i, j, "C", "#000000", "#ffffff");

        //index style string
        if (i != 3 && rowWOData.contains(j) == false && j < 103) {
          var indexCellEdit = indexColumnStr[i] + j.toString();
          var indexCellCost = "D" + j.toString();
          var indexCellData = indexColumnStr[i - 1] + j.toString();
          sheetObject.updateCell(
              CellIndex.indexByString(indexCellEdit),
              Formula.custom(
                  '=$costSheetName!$indexCellCost*$dataSheetName!$indexCellData'));
        } else if (i != 3 && j == 103) {
          var indexCellEdit = indexColumnStr[i] + j.toString();
          var indexSumStart = indexColumnStr[i] + "6";
          var indexSumEnd = indexColumnStr[i] + "103";
          sheetObject.updateCell(CellIndex.indexByString(indexCellEdit),
              Formula.custom('=SUM($indexSumStart:$indexSumEnd)'));
        }
      }
    }
  } catch (e) {
    print(e);
  }
}

CellStyle cellStyleCenter(String colorT, String colorBG) {
  CellStyle cellStyle = CellStyle(
    fontColorHex: colorT,
    backgroundColorHex: colorBG,
    fontFamily: getFontFamily(FontFamily.Calibri),
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
    underline: Underline.Single,
  );
  return cellStyle;
}

CellStyle cellStyleLeft(String colorT, String colorBG) {
  CellStyle cellStyle = CellStyle(
    fontColorHex: colorT,
    backgroundColorHex: colorBG,
    fontFamily: getFontFamily(FontFamily.Calibri),
    horizontalAlign: HorizontalAlign.Left,
    verticalAlign: VerticalAlign.Center,
    underline: Underline.Single,
  );
  return cellStyle;
}

void addMergeData(
  String startIndex,
  String endIndex,
  String text,
  String styleAlign,
  String colorT,
  String colorBG,
) {
  sheetObject.merge(
      CellIndex.indexByString(startIndex), CellIndex.indexByString(endIndex),
      customValue: text);
  cell = sheetObject.cell(CellIndex.indexByString(startIndex));
  if (styleAlign == 'C') {
    cell.cellStyle = cellStyleCenter(colorT, colorBG);
  } else if (styleAlign == 'L') {
    cell.cellStyle = cellStyleLeft(colorT, colorBG);
  }
}

void addCellData(
  String startIndex,
  String text,
  String styleAlign,
  String colorT,
  String colorBG,
) {
  /* sheetObject.updateCell(CellIndex.indexByString(startIndex), text,
      cellStyle: cellStyleCenter(colorT, colorBG)); */
  sheetObject.updateCell(CellIndex.indexByString(startIndex), text);
  cell = sheetObject.cell(CellIndex.indexByString(startIndex));
  if (styleAlign == 'C') {
    cell.cellStyle = cellStyleCenter(colorT, colorBG);
  } else if (styleAlign == 'L') {
    cell.cellStyle = cellStyleLeft(colorT, colorBG);
  }
}

void editCellStyle(
  int columnIndex,
  int rowIndex,
  String styleAlign,
  String colorT,
  String colorBG,
) {
  cell = sheetObject.cell(
      CellIndex.indexByColumnRow(columnIndex: columnIndex, rowIndex: rowIndex));
  if (styleAlign == 'C') {
    cell.cellStyle = cellStyleCenter(colorT, colorBG);
  } else if (styleAlign == 'L') {
    cell.cellStyle = cellStyleLeft(colorT, colorBG);
  }
}

void createExcel2() {
  var excel = Excel.createExcel();
  excel.rename('Sheet1', 'DATA');
  Sheet sheetObject = excel['DATA'];
  CellStyle cellStyle = CellStyle(
    backgroundColorHex: "#1AFF1A",
    fontFamily: getFontFamily(FontFamily.Calibri),
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
  );
  cellStyle.underline = Underline.Single; // or Underline.Double
  sheetObject.updateCell(CellIndex.indexByString('A1'), 'aaaaa');
  var cell = sheetObject.cell(CellIndex.indexByString("A1"));
  //cell.value = 8; // dynamic values support provided;
  cell.cellStyle = cellStyle;
  // printing cell-type
  print("CellType: " + cell.value.toString());
  sheetObject.updateCell(CellIndex.indexByString('A1'), 'aaaaa');
  List<String> dataList = [
    "Google",
    "loves",
    "Flutter",
    "and",
    "Flutter",
    "loves",
    "Excel"
  ];
  sheetObject.insertRowIterables(dataList, 8, startingColumn: 9);
  sheetObject.merge(
      CellIndex.indexByString("A1"), CellIndex.indexByString("E9"),
      customValue: "Put this text after merge");
  cell = sheetObject.cell(CellIndex.indexByString("A1"));
  //cell.value = 8; // dynamic values support provided;
  cell.cellStyle = cellStyle;

  ///
  /// Inserting and removing column and rows
  // insert column at index = 8
  sheetObject.insertColumn(8);
  // remove column at index = 18
  sheetObject.removeColumn(18);
  // insert row at index = 82
  //sheetObject.insertRow(82);
  // remove row at index = 80
  //sheetObject.removeRow(80);
  var fileBytes = excel.save(fileName: "My_Excel_File_Name.xlsx");
}
