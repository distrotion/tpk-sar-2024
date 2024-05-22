import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
//--------------------------------------------- Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_login_arsa_01/page/1LoginPage/Data/login_bloc.dart';
import 'package:tpk_login_arsa_01/page/2Mainapage/Data/MainPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/30RequestDetailTTC/data/RoutineRequestDetailTTCPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/3RoutineRequestPage/Data/RoutineRequestPage_bloc.dart';
import 'Layout/ChangePage/Data/BlocPageRebuild.dart';
import 'Layout/ChangePage/switchPage.dart';
//--------------------------------------------- Bloc

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //contextBG = context;
    return MultiBlocProvider(
        providers: [
          /* BlocProvider<BlocPageRebuild>(
            create: (BuildContext context) =>
                BlocPageRebuild(), //For rebuild only page inside without app bar/left menu
          ), */
          BlocProvider<BlocPageRebuild>(
            create: (BuildContext context) =>
                BlocPageRebuild(), //For rebuild only page inside without app bar/left menu
          ),
          BlocProvider<LoginBloc>(
            create: (BuildContext context) =>
                LoginBloc(), //For rebuild only page inside without app bar/left menu
          ),
          BlocProvider<ManageDataMainPage>(
            create: (BuildContext context) => ManageDataMainPage(),
          ),
          BlocProvider<ManageDataRoutineRequest>(
            create: (BuildContext context) => ManageDataRoutineRequest(),
          ),
          BlocProvider<ManageDataRoutineRequestDetailTTCPage>(
            create: (BuildContext context) =>
                ManageDataRoutineRequestDetailTTCPage(),
          ),
        ],
        child: BlocBuilder<BlocPageRebuild, bool>(builder: (_, e) {
          return WillPopScope(
            onWillPop: () async => blockBack(),
            child: MaterialApp(
              builder: EasyLoading.init(),
              scrollBehavior: MyCustomScrollBehavior(),
              title: 'TPK SAR',
              theme: ThemeData(
                fontFamily: 'Mitr',
                primarySwatch: Colors.blueGrey,
              ),
              debugShowCheckedModeBanner: false,
              home: MainCenter(),
            ),
          );
        }));
  }
}

// BlocPageRebuild blocPageRebuild = BlocProvider.of<BlocPageRebuild>(context).rebuildPage();

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

Future<bool> blockBack() async {
  /* Navigator.pop(contextBG);
        BlocProvider.of<SwPageCubit>(contextBG).togglePage(lastPage); */
  return true;
}
