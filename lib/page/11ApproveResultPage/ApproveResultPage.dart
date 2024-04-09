import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/11ApproveResultPage/data/ApproveResultPageStructure.dart';
import 'SubWidget/TableSampleApprove.dart';
import 'data/ApproveResultPage_bloc.dart';
import 'data/ApproveResultPage_event.dart';

late BuildContext conextApproveResultPage;

class ApproveResultPage extends StatelessWidget {
  const ApproveResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ManageDataApproveResultPage>(
            create: (BuildContext context) => ManageDataApproveResultPage(),
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
    context
        .read<ManageDataApproveResultPage>()
        .add(ApproveResultPageEvent.fetchSampleData);
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
    conextApproveResultPage = context;
    return Form(
      key: _formKey,
      child: BlocBuilder<ManageDataApproveResultPage, int>(
          builder: (context, state) {
        DateTime now = DateTime.now();
        print("Approve rebuild state :$state");
        if (state >= 0 && state < 3)
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SearchItemBar(),
              ),
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
                    child: TableSampleApprove(),
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
  void initState() {
    /* context
        .read<ManageDataApproveResultPage>()
        .add(ApproveResultPageEvent.fetchSampleData); */
    super.initState();
    initSearch();
    context
        .read<ManageDataApproveResultPage>()
        .add(ApproveResultPageEvent.clearState);
  }

  void initSearch() {
    if (searchOption.isEmpty) {
      searchOption.add(SearchApproveModel());
      var now = DateTime.now();
      searchOption[0].receiveDateS = now.toString();
      searchOption[0].receiveDateE = now.toString();
      searchOption[0].dueDateS = now.toString();
      searchOption[0].dueDateE = now.toString();
    }
  }

  void clearSearch() {
    searchOption.clear();
    searchOption.add(SearchApproveModel());
    var now = DateTime.now();
    searchOption[0].receiveDateS = now.toString();
    searchOption[0].receiveDateE = now.toString();
    searchOption[0].dueDateS = now.toString();
    searchOption[0].dueDateE = now.toString();
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
                                        dropdownSearchTextStyle:
                                            styleDataInTable,
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelStyle: styleHeaderTable,
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                border: InputBorder.none),
                                        name: 'masterCustomer',
                                        items: masterCustomerSearch,
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
                                    width: 100,
                                    child: FormBuilderCheckbox(
                                      title: Text("BANGPOO",
                                          style: styleHeaderTable),
                                      name: 'BANGPOO',
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
                                            onChanged: (value) {
                                              searchOption[0].receiveDateS =
                                                  value.toString();
                                              searchOption[0]
                                                  .enableReceiveDate = true;
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
                                            onChanged: (value) {
                                              searchOption[0].receiveDateE =
                                                  value.toString();
                                              searchOption[0]
                                                  .enableReceiveDate = true;
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
                                            name: 'dueDateS',
                                            onChanged: (value) {
                                              searchOption[0].dueDateS =
                                                  value.toString();
                                              searchOption[0].enableDueDate =
                                                  true;
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
                                            onChanged: (value) {
                                              searchOption[0].dueDateE =
                                                  value.toString();
                                              searchOption[0].enableDueDate =
                                                  true;
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
                                            .read<ManageDataApproveResultPage>()
                                            .add(ApproveResultPageEvent
                                                .clearState);
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
                                          _formKey.currentState?.reset();
                                          context
                                              .read<
                                                  ManageDataApproveResultPage>()
                                              .add(ApproveResultPageEvent
                                                  .clearState);
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
