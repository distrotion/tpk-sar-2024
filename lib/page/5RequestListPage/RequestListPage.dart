import 'package:dropdown_search/dropdown_search.dart' as dropdown_search;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/SubWidget/TableRequestList.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/data/RequestListPageStructure.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/data/RequestListPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/5RequestListPage/data/RequestListPage_event.dart';

late BuildContext contextRequestListPage;

class RequestListPage extends StatelessWidget {
  const RequestListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ManageDataRequestListPage>(
            create: (BuildContext context) => ManageDataRequestListPage(),
          ),
        ],
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: 20),
              child: SampleData()),
        ));
  }
}

class SampleData extends StatefulWidget {
  const SampleData({Key? key}) : super(key: key);

  @override
  _SampleDataState createState() => _SampleDataState();
}

class _SampleDataState extends State<SampleData> {
  void initState() {
    print("InINITIAL");
    /* context
        .read<ManageDataRequestListPage>()
        .add(RequestListPageEvent.fetchSampleData); */
    /* if (searchOption.isEmpty) {
      clearSearch();
    }
    context
        .read<ManageDataRequestListPage>()
        .add(RequestListPageEvent.clearAndSearch); */
    super.initState();
  }

  void clearSearch() {
    searchOption.clear();
    searchOption.add(SearchRequestModel());
    var now = DateTime.now();
    searchOption[0].receiveDateS = now.toString();
    searchOption[0].receiveDateE = now.toString();
    searchOption[0].dueDateS = now.toString();
    searchOption[0].dueDateE = now.toString();
    setState(() {});
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
    contextRequestListPage = context;
    return Form(
      key: _formKey,
      child: BlocBuilder<ManageDataRequestListPage, int>(
          builder: (context, state) {
        DateTime now = DateTime.now();
        print("Approve rebuild state :$state");
        if (state >= 0 && state < 3)
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SearchRequestBar(),
              ),
/*               Center(
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
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: widthsection1,
                          child: Text(
                            "REQUEST NO",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                          child: FormBuilderTextField(
                              name: "requestNo",
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
                                if (value != null) {}
                              }),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: widthsection1,
                          child: Text(
                            "CUSTOMER NAME",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                            child: FormBuilderTextField(
                                name: "customerName",
                                style: styledata,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                    bottom: heightBox2 / 2,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                enabled: true,
                                onChanged: (value) {})),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: widthsection1,
                          child: Text(
                            "INCHARGE",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                            child: FormBuilderTextField(
                                name: "incharge",
                                style: styledata,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                    bottom: heightBox2 / 2,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                enabled: true,
                                onChanged: (value) {})),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: widthsection1,
                          child: Text(
                            "BRANCH",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomSearchableDropDown(
                            primaryColor: Colors.black,
                            menuMode: true,
                            labelStyle: styledata,
                            items: ["BANGPOO", "RAYONG"],
                            label: 'SELECT INSTRUMENT NAME',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(Icons.search),
                            ),
                            dropDownMenuItems:
                                ["BANGPOO", "RAYONG"].map((item) {
                              return item;
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                print("111${value.toString()}");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: widthsection1,
                          child: Text(
                            "RECEVICE DATE START",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            style: styledata,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder()),
                            inputType: InputType.date,
                            name: 'receiveDateStart',
                            initialValue: now,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: widthsection1,
                          child: Text(
                            "RECEVICE DATE END",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            style: styledata,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder()),
                            inputType: InputType.date,
                            name: 'receiveDateEnd',
                            initialValue: now,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: widthsection1,
                          child: Text(
                            "DUE DATE START",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            style: styledata,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder()),
                            inputType: InputType.date,
                            name: 'dueDateStart',
                            initialValue: now,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: widthsection1,
                          child: Text(
                            "DUE DATE END",
                            style: stylesection,
                          ),
                        ),
                        Expanded(
                          child: FormBuilderDateTimePicker(
                            style: styledata,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder()),
                            inputType: InputType.date,
                            name: 'dueDateEnd',
                            initialValue: now,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text(
                        "SEARCH",
                        style: styledata,
                      ),
                      onPressed: () {},
                    ),
                  ]),
                ),
              ), */
              if (state == 2) ...[
                Container(
                  height: 450,
                  margin: EdgeInsets.only(top: 10),
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
                  child: Container(
                    child: TableRequestList(),
                  ),
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
        else
          print("in else");
        return Container();
      }),
    );
  }
}

class SearchRequestBar extends StatefulWidget {
  const SearchRequestBar({Key? key}) : super(key: key);

  @override
  _SearchRequestBarState createState() => _SearchRequestBarState();
}

final _formKey = GlobalKey<FormBuilderState>();
TextStyle styleHeaderTable = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontFamily: 'Mitr',
    color: Colors.black);
TextStyle styleDataInTable =
    TextStyle(fontSize: 10, fontFamily: 'Mitr', color: Colors.black);

class _SearchRequestBarState extends State<SearchRequestBar> {
  void initState() {
    /* context
        .read<ManageDataRequestListPage>()
        .add(RequestListPageEvent.fetchSampleData); */
    print('in initsearchbar');
    if (searchOption.isEmpty) {
      print('in initsearchbar clear');
      clearSearch();
    }
    context
        .read<ManageDataRequestListPage>()
        .add(RequestListPageEvent.clearAndSearch);
    super.initState();
    //clearSearch();
  }

  void clearSearch() {
    searchOption.clear();
    searchOption.add(SearchRequestModel());
    var now = DateTime.now();
    searchOption[0].receiveDateS = now.toString();
    searchOption[0].receiveDateE = now.toString();
    searchOption[0].dueDateS = now.toString();
    searchOption[0].dueDateE = now.toString();
    print(searchRequestModelToJson(searchOption));
    setState(() {});
  }

  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: FutureBuilder(
            future: searchMasterCustomer(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData)
                return ExpansionPanelList(
                  animationDuration: Duration(milliseconds: 1000),
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        return Container(
                          height: 10,
                          child: Center(
                            child: Text(
                              'SEARCH',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        );
                      },
                      body: Container(
                        width: 1000,
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 0,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 50,
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: 60,
                                      child: Text(
                                        "REQUEST NO",
                                        style: styleHeaderTable,
                                      )),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 100,
                                    height: 30,
                                    child: FormBuilderTextField(
                                      style: styleDataInTable,
                                      decoration: formField(),
                                      name: 'request',
                                      key: Key(searchOption[0].requestNo),
                                      initialValue: searchOption[0].requestNo,
                                      onChanged: (value) {
                                        searchOption[0].requestNo =
                                            value.toString();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: 60,
                                      child: Text(
                                        "CUSTOMER NAME",
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
                                          searchDelay:
                                              Duration(microseconds: 1),
                                          disabledItemFn: (String s) =>
                                              s.startsWith('zzz'),
                                        ),
                                        //searchDelay: Duration(milliseconds: 10),
                                        //mode: dropdown_search.Mode.DIALOG,
                                        dropdownSearchTextStyle:
                                            styleDataInTable,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelStyle: styleHeaderTable,
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                border: InputBorder.none),
                                        name: 'masterCustomer',
                                        key: Key(searchOption[0]
                                            .customerName
                                            .toString()),
                                        items: masterCustomerSearch,
                                        initialValue: searchOption[0]
                                            .customerName
                                            .toString(),
                                        decoration: formField(),
                                        onChanged: (value) {
                                          var buff =
                                              value.toString().split('|');
                                          searchOption[0].customerName =
                                              buff[0];
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: 60,
                                      child: Text(
                                        "REQ STATUS",
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
                                          searchDelay:
                                              Duration(microseconds: 1),
                                          disabledItemFn: (String s) =>
                                              s.startsWith('zzz'),
                                        ),
                                        //searchDelay: Duration(milliseconds: 1),
                                        //mode: dropdown_search.Mode.DIALOG,
                                        dropdownSearchTextStyle:
                                            styleDataInTable,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelStyle: styleHeaderTable,
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                border: InputBorder.none),
                                        name: 'requestStatus',
                                        key: Key(searchOption[0]
                                            .requestStatus
                                            .toString()),
                                        initialValue: searchOption[0]
                                            .requestStatus
                                            .toString(),
                                        items: listStatusRequest,
                                        decoration: formField(),
                                        onChanged: (value) {
                                          searchOption[0].requestStatus = value;
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 50,
                              child: Row(
                                //mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 100,
                                    child: FormBuilderCheckbox(
                                      title: Text("BANGPOO",
                                          style: styleHeaderTable),
                                      name: 'BANGPOO',
                                      key: Key(
                                          searchOption[0].bangpoo.toString()),
                                      initialValue: searchOption[0].bangpoo,
                                      onChanged: (value) {
                                        searchOption[0].bangpoo = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: FormBuilderCheckbox(
                                      title: Text("RAYONG",
                                          style: styleHeaderTable),
                                      name: 'RAYONG',
                                      key: Key(
                                          searchOption[0].rayong.toString()),
                                      initialValue: searchOption[0].rayong,
                                      onChanged: (value) {
                                        searchOption[0].rayong = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 450,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    child: FormBuilderCheckbox(
                                      key: Key(searchOption[0]
                                          .enableReceiveDate
                                          .toString()),
                                      title: Text("", style: styleHeaderTable),
                                      name: 'enableReceiveDate',
                                      initialValue:
                                          searchOption[0].enableReceiveDate,
                                      onChanged: (value) {
                                        searchOption[0].enableReceiveDate =
                                            value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: 60,
                                            child: Text(
                                              "RECEIVE DATE START",
                                              style: styleHeaderTable,
                                            )),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 100,
                                          height: 30,
                                          child: FormBuilderDateTimePicker(
                                            style: styleDataInTable,
                                            decoration: formField(),
                                            initialValue: DateTime.parse(
                                                searchOption[0].receiveDateS),
                                            inputType: InputType.date,
                                            name: 'receiveDateS',
                                            key: Key(searchOption[0]
                                                .receiveDateS
                                                .toString()),
                                            onChanged: (value) {
                                              searchOption[0].receiveDateS =
                                                  value.toString();
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: 60,
                                            child: Text(
                                              "RECEIVE DATE END",
                                              style: styleHeaderTable,
                                            )),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 100,
                                          height: 30,
                                          child: FormBuilderDateTimePicker(
                                            style: styleDataInTable,
                                            decoration: formField(),
                                            initialValue: DateTime.parse(
                                                searchOption[0].receiveDateE),
                                            inputType: InputType.date,
                                            name: 'receiveDateE',
                                            key: Key(searchOption[0]
                                                .receiveDateE
                                                .toString()),
                                            onChanged: (value) {
                                              searchOption[0].receiveDateE =
                                                  value.toString();
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 450,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    child: FormBuilderCheckbox(
                                      key: Key(searchOption[0]
                                          .enableDueDate
                                          .toString()),
                                      title: Text("", style: styleHeaderTable),
                                      name: 'enableDueDate',
                                      initialValue:
                                          searchOption[0].enableDueDate,
                                      onChanged: (value) {
                                        searchOption[0].enableDueDate = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: 60,
                                            child: Text(
                                              "DUE DATE START",
                                              style: styleHeaderTable,
                                            )),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 100,
                                          height: 30,
                                          child: FormBuilderDateTimePicker(
                                            style: styleDataInTable,
                                            decoration: formField(),
                                            initialValue: DateTime.parse(
                                                searchOption[0].dueDateS),
                                            inputType: InputType.date,
                                            key: Key(searchOption[0]
                                                .dueDateS
                                                .toString()),
                                            name: 'dueDateS',
                                            onChanged: (value) {
                                              searchOption[0].dueDateS =
                                                  value.toString();
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            width: 60,
                                            child: Text(
                                              "DUE DATE END",
                                              style: styleHeaderTable,
                                            )),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 100,
                                          height: 30,
                                          child: FormBuilderDateTimePicker(
                                            style: styleDataInTable,
                                            decoration: formField(),
                                            initialValue: DateTime.parse(
                                                searchOption[0].dueDateE),
                                            inputType: InputType.date,
                                            name: 'dueDateE',
                                            key: Key(searchOption[0]
                                                .dueDateE
                                                .toString()),
                                            onChanged: (value) {
                                              searchOption[0].dueDateE =
                                                  value.toString();
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
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
                                            .read<ManageDataRequestListPage>()
                                            .add(RequestListPageEvent
                                                .clearAndSearch);
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
                                          /* _formKey.currentState?.reset(); */
                                          context
                                              .read<ManageDataRequestListPage>()
                                              .add(RequestListPageEvent
                                                  .clearAndSearch);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      isExpanded: _expanded,
                      canTapOnHeader: true,
                    ),
                  ],
                  dividerColor: Colors.grey,
                  expansionCallback: (panelIndex, isExpanded) {
                    _expanded = !_expanded;
                    setState(() {});
                  },
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
