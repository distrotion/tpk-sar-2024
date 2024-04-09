import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/3SampleSolutionCount/SubWidget/SampleSolutionCountTable/SampleSolutionCountTable.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/3SampleSolutionCount/SubWidget/SampleSolutionCountTable/data/SampleSolutionCountTableStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/3SampleSolutionCount/SubWidget/SampleSolutionCountTable/data/SampleSolutionCountTable_bloc.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/3SampleSolutionCount/SubWidget/SampleSolutionCountTable/data/SampleSolutionCountTable_event.dart';

late BuildContext SampleSolutionCountContext;

class SampleSolutionCount extends StatelessWidget {
  const SampleSolutionCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataSampleSolutionCount>(
          create: (BuildContext context) => ManageDataSampleSolutionCount(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20),
          child: SampleSolutionCountWidget(),
        ),
      ),
    );
  }
}

class SampleSolutionCountWidget extends StatefulWidget {
  const SampleSolutionCountWidget({Key? key}) : super(key: key);

  @override
  _SampleSolutionCountWidgetState createState() => _SampleSolutionCountWidgetState();
}

class _SampleSolutionCountWidgetState extends State<SampleSolutionCountWidget> {
  void initState() {
    print("InINITIAL");
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
    SampleSolutionCountContext = context;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SearchBar(),
          ),
          BlocBuilder<ManageDataSampleSolutionCount, int>(builder: (context, state) {
            print("SampleSolutionCountWidget rebuild state :$state");
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
                      child: SampleSolutionCountTable(),
                    ),
                  ],
                  SizedBox(height: 30,),
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
    searchOption.add(SearchSolutionCountModel());
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
                  width: 1000,
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
                        width: 100,
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
                                      .read<ManageDataSampleSolutionCount>()
                                      .add(SampleSolutionCountEvent.clearAndSearch);
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
                                        .read<ManageDataSampleSolutionCount>()
                                        .add(SampleSolutionCountEvent.clearAndSearch);
                                    setState(() {});
                                  });
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
