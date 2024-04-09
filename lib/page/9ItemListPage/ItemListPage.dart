import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/style.dart';
import 'package:tpk_login_arsa_01/page/9ItemListPage/SubWidget/TableItemList.dart';
import 'data/ItemListPage_bloc.dart';
import 'data/ItemListPage_event.dart';

late BuildContext itemListPageContext;

class ItemListPage extends StatelessWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ManageDataItemListPage>(
          create: (BuildContext context) => ManageDataItemListPage(),
        ),
      ],
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 20),
          child: ItemList(),
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  void initState() {
    print("InINITIAL");
    context
        .read<ManageDataItemListPage>()
        .add(ItemListPageEvent.fetchInstrumnetData);
    context
        .read<ManageDataItemListPage>()
        .add(ItemListPageEvent.fetchItemdata);

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
    itemListPageContext = context;
    return Form(
      key: _formKey,
      child:
          BlocBuilder<ManageDataItemListPage, int>(builder: (context, state) {
        print("ItemList rebuild state :$state");
        if (state >= 0 && state < 3)
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
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
                                    .read<ManageDataItemListPage>()
                                    .add(ItemListPageEvent.clearState);
                                context
                                    .read<ManageDataItemListPage>()
                                    .add(ItemListPageEvent.searchjobData);
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
                              .read<ManageDataItemListPage>()
                              .add(ItemListPageEvent.clearState);
                          context
                              .read<ManageDataItemListPage>()
                              .add(ItemListPageEvent.searchjobData);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (state == 2) ...[
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
                    child: TableListItem(),
                  ),
                ),
              ],
              Container(
                width: 600,
                //child: LineChartSample1(),
              ),
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
