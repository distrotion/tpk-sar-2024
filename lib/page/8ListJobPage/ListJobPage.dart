//import 'package:dropdown_search/dropdown_search.dart' as dropdown_search;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/8ListJobPage/Data/ListJobPageStructure.dart';
import 'package:tpk_login_arsa_01/page/8ListJobPage/SubWidget/TableWaitList.dart';
import 'Data/ListJobPage_bloc.dart';
import 'Data/ListJobPage_event.dart';
import 'SubWidget/TableListJob.dart';

class ListJobPage extends StatelessWidget {
  const ListJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataListJob>(
          create: (BuildContext context) => ManageDataListJob(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20),
          child: ListJob(),
        ),
      ),
    );
  }
}

class ListJob extends StatefulWidget {
  const ListJob({Key? key}) : super(key: key);

  @override
  _ListJobState createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> {
  void initState() {
    print("InINITIAL");
    searchOption.clear();
    clearSearch();
    context.read<ManageDataListJob>().add(ListJobEvent.fetchItemdata);
    context.read<ManageDataListJob>().add(ListJobEvent.fetchInstrumnetData);
    super.initState();
  }

  void clearSearch() {
    searchOption.clear();
    searchOption.add(SearchItemModel());
    if (userBranch == "BANGPOO") {
      searchOption[0].bangpoo = true;
      searchOption[0].rayong = false;
    } else {
      searchOption[0].bangpoo = false;
      searchOption[0].rayong = true;
    }
  }

  bool _expanded = false;
  final _formKey = GlobalKey<FormBuilderState>();
  double heightBox1 = 30;
  double widthsection1 = 130;
  double heightBox2 = 30;
  double widthsection2 = 130;
  TextStyle styleHeaderTable = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);
  TextStyle styleDataInTable =
      TextStyle(fontSize: 10, fontFamily: 'Mitr', color: Colors.black);
  TextStyle stylesection =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  TextStyle styledata = TextStyle(fontSize: 13, fontFamily: 'Mitr');
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<ManageDataListJob, int>(builder: (context, state) {
        print("rebuild state :$state");
        if (state >= 0)
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                /* child: Container(
                  //width: 1500,
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
                  ), */
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
                              width: 70,
                              child: Text(
                                "INSTRUMENT",
                                style: styleHeaderTable,
                              )),
                          SizedBox(width: 10),
                          Container(
                            width: 100,
                            height: 30,
                            child: FormBuilderSearchableDropdown(
                                //shouldRequestFocus: true,
                                popupProps: PopupProps.dialog(
                                  showSearchBox: true,
                                  showSelectedItems: true,
                                  searchDelay: Duration(microseconds: 1),
                                  disabledItemFn: (String s) =>
                                      s.startsWith('zzz'),
                                ),
                                //searchDelay: Duration(milliseconds: 10),
                                //mode: dropdown_search.Mode.DIALOG,
                                dropdownSearchTextStyle: styleDataInTable,
                                dropdownSearchDecoration: InputDecoration(
                                    labelStyle: styleHeaderTable,
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none),
                                name: 'masterInstrumnetSearch',
                                items: masterInstrumnetSearch,
                                decoration: formField(),
                                onChanged: (value) {
                                  searchOption[0].instrumentName = value;
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
                              title: Text("BANGPOO", style: styleHeaderTable),
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
                              title: Text("RAYONG", style: styleHeaderTable),
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
                                if (searchOption[0].instrumentName == '') {
                                  context
                                      .read<ManageDataListJob>()
                                      .add(ListJobEvent.clearState);
                                  context
                                      .read<ManageDataListJob>()
                                      .add(ListJobEvent.fetchItemdata);
                                } else {
                                  instrumentName =
                                      searchOption[0].instrumentName;
                                  context
                                      .read<ManageDataListJob>()
                                      .add(ListJobEvent.clearState);
                                  context
                                      .read<ManageDataListJob>()
                                      .add(ListJobEvent.searchItemData);
                                }
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
                                      .read<ManageDataListJob>()
                                      .add(ListJobEvent.clearState);
                                  context
                                      .read<ManageDataListJob>()
                                      .add(ListJobEvent.fetchItemdata);
                                  _formKey.currentState?.reset();
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

/*                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      Expanded(
                        child: FormBuilderCheckbox(
                          name: 'barnchBangpoo',
                          initialValue: selectBP,
                          title: Text('BANGPOO'),
                          onChanged: (value) {
                            selectBP = value!;
                          },
                        ),
                      ),
                      Expanded(
                        child: FormBuilderCheckbox(
                          name: 'barnchRayong',
                          initialValue: selectRY,
                          title: Text('RAYONG'),
                          onChanged: (value) {
                            selectRY = value!;
                          },
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          "SEARCH",
                          style: styledata,
                        ),
                        onPressed: () {
                          context
                              .read<ManageDataListJob>()
                              .add(ListJobEvent.clearState);
                          context
                              .read<ManageDataListJob>()
                              .add(ListJobEvent.searchItemData);
                        },
                      ),
                    ],
                  ),
                ),
              ), */
              if (state == 1 || state == 2) ...[
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
                  child: Container(
                    child: TableWaitList(),
                  ),
                ),
              ],
              if (state == 3) ...[
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
                  child: Container(
                    child: TableListJob(),
                  ),
                ),
              ],
            ],
          );
        else
          return Container();
      }),
    );
  }
}

InputDecoration formField() {
  return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(gapPadding: 8));
}
