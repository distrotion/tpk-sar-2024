import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/10AnalysisPage/data/AnalysisPageStructure.dart';
import 'SubWidget/TableJobItemList.dart';
import 'data/AnalysisPage_bloc.dart';
import 'data/AnalysisPage_event.dart';

late BuildContext analysisPageContext;

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataAnalysisPage>(
          create: (BuildContext context) => ManageDataAnalysisPage(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20),
          child: Analysis(),
        ),
      ),
    );
  }
}

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  void initState() {
    print("InINITIAL");
    context
        .read<ManageDataAnalysisPage>()
        .add(AnalysisPageEvent.fetchInstrumnetData);
    /* context
        .read<ManageDataAnalysisPage>()
        .add(AnalysisPageEvent.fetchItemJobdata); */
    context.read<ManageDataAnalysisPage>().add(AnalysisPageEvent.searchjobData);

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
    analysisPageContext = context;
    return Form(
      key: _formKey,
      child:
          BlocBuilder<ManageDataAnalysisPage, int>(builder: (context, state) {
        print("Analysis rebuild state :$state");
        if (state >= 0 && state < 3)
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SearchItemBar(),
              ),
              /* Center(
                child: Container(
                  width: 1500,
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: widthsection1,
                        child: Text(
                          "SAMPLE CODE",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: FormBuilderTextField(
                            name: "sampleCode",
                            style: styledata,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 10,
                                bottom: heightBox2 / 2,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            initialValue: "",
                            enabled: true,
                            onSubmitted: (value) {
                              if (value != null) {
                                print(sampleCode);
                                sampleCode = value;
                                context
                                    .read<ManageDataAnalysisPage>()
                                    .add(AnalysisPageEvent.clearState);
                                context
                                    .read<ManageDataAnalysisPage>()
                                    .add(AnalysisPageEvent.searchjobData);
                              }
                            }),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: widthsection1,
                        child: Text(
                          "REMARK NO.",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                          child: FormBuilderTextField(
                              name: "remarkNo",
                              style: styledata,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: heightBox2 / 2,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              enabled: true,
                              onChanged: (value) {
                                remarkNo = value.toString();
                                print(remarkNo);
                              })),
                      SizedBox(width: 10),
                      Container(
                        width: widthsection1,
                        child: Text(
                          "INSTRUMENT",
                          style: stylesection,
                        ),
                      ),
                      Expanded(
                        child: CustomSearchableDropDown(
                          primaryColor: Colors.black,
                          menuMode: true,
                          labelStyle: styledata,
                          items: instrumentData,
                          label: 'SELECT INSTRUMENT NAME',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(Icons.search),
                          ),
                          dropDownMenuItems: instrumentData.map((item) {
                            return item.instrument;
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              print("111${value.instrument.toString()}");
                              instrumentName = value.instrument.toString();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        child: Text(
                          "SEARCH",
                          style: styledata,
                        ),
                        onPressed: () {
                          context
                              .read<ManageDataAnalysisPage>()
                              .add(AnalysisPageEvent.clearState);
                          context
                              .read<ManageDataAnalysisPage>()
                              .add(AnalysisPageEvent.searchjobData);
                        },
                      ),
                    ],
                  ),
                ),
              ), */
              if (state == 2) ...[
                Container(
                  //width: 1100,
                  height: 459,
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
                  child: TableJobListItem(),
                ),
              ],

              /* if (state == 3) ...[
                Container(
                  height: 500,
                  margin: EdgeInsets.only(top: 30),
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
                  child: Expanded(
                    child: TableListJob(),
                  ),
                ),
              ], */
            ],
          );
        return CircularProgressIndicator();
      }),
    );
  }
}

class SearchItemBar extends StatefulWidget {
  const SearchItemBar({Key? key}) : super(key: key);

  @override
  _SearchItemBarState createState() => _SearchItemBarState();
}

final _formKey = GlobalKey<FormBuilderState>();
TextStyle styleHeaderTable = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontFamily: 'Mitr',
    color: Colors.black);
TextStyle styleDataInTable =
    TextStyle(fontSize: 10, fontFamily: 'Mitr', color: Colors.black);

class _SearchItemBarState extends State<SearchItemBar> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: 800,
        child: Wrap(
          spacing: 20,
          runSpacing: 0,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    child: Text(
                  "SAMPLE CODE",
                  style: styleHeaderTable,
                )),
                SizedBox(width: 10),
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
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    child: Text(
                  "REMARK NO",
                  style: styleHeaderTable,
                )),
                SizedBox(width: 10),
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
              ],
            ),
            /* Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    child: Text(
                  "INSTRUMENT",
                  style: styleHeaderTable,
                )),
                SizedBox(width: 10),
                Container(
                  width: 250,
                  //height: 30,
                  child: CustomSearchableDropDown(
                    primaryColor: Colors.black,
                    menuMode: true,
                    menuPadding: EdgeInsets.zero,
                    labelStyle: styleDataInTable,
                    items: instrumentData,
                    label: 'SELECT INSTRUMENT NAME',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(Icons.search),
                    ),
                    dropDownMenuItems: instrumentData.map((item) {
                      return item.instrument;
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        print("111${value.instrument.toString()}");
                        instrumentName = value.instrument.toString();
                      }
                    },
                  ),
                ),
              ],
            ), */
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  child: Text(
                "INSTRUMENT",
                style: styleHeaderTable,
              )),
              SizedBox(width: 10),
              Container(
                width: 250,
                height: 30,
                child: FormBuilderSearchableDropdown(
                    popupProps: PopupProps.dialog(
                      showSearchBox: true,
                      showSelectedItems: true,
                      searchDelay: Duration(microseconds: 1),
                      disabledItemFn: (String s) => s.startsWith('zzz'),
                    ),
                    //searchDelay: Duration(milliseconds: 10),
                    dropdownSearchTextStyle: styleDataInTable,
                    dropdownSearchDecoration: InputDecoration(
                        labelStyle: styleHeaderTable,
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none),
                    name: 'searchable_dropdown',
                    items: instrumentSearch,
                    decoration: formField(),
                    /* initialValue: searchOption.instrumentName ?? "", */
                    /* InputDecoration(
                        labelStyle: styleDataInTable,
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none), */
                    onChanged: (value) {
                      searchOption.instrumentName = value.toString();
                    }),
              ),
            ]),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
              ],
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
                  analysisPageContext
                      .read<ManageDataAnalysisPage>()
                      .add(AnalysisPageEvent.clearState);
                  context
                      .read<ManageDataAnalysisPage>()
                      .add(AnalysisPageEvent.searchjobData);
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
                    analysisPageContext
                        .read<ManageDataAnalysisPage>()
                        .add(AnalysisPageEvent.clearState);
                    context
                        .read<ManageDataAnalysisPage>()
                        .add(AnalysisPageEvent.searchjobData);
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
