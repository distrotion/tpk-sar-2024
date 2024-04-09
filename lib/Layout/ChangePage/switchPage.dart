import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/pagecon.dart';
import 'package:tpk_login_arsa_01/Layout/MainLayout/AppBar.dart';
import 'package:tpk_login_arsa_01/Layout/MainLayout/mainmenu.dart';
import 'package:tpk_login_arsa_01/page/1LoginPage/Data/login_bloc.dart';
import 'package:tpk_login_arsa_01/page/1LoginPage/Data/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_login_arsa_01/page/1LoginPage/loginpage.dart';
import 'Data/BlocChagpage.dart';

class MainCenter extends StatelessWidget {
  const MainCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreLogin();
  }
}

class PreLogin extends StatefulWidget {
  const PreLogin({Key? key}) : super(key: key);

  @override
  State<PreLogin> createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(LoginEvent.inintlogin);
  }

  @override
  Widget build(BuildContext context) {
    contextBG = context;
    /* context.read<LoginBloc>().add(LoginEvent.inintlogin); */
    return BlocBuilder<LoginBloc, int>(builder: (context, state) {
      //Alway check token['Status']
      //Auto change page to login when token destroyed
      print("userName$userName");
      print(state);
      if (state >= 1) {
        //EasyLoading.dismiss();
        if (userName != '') {
          print("BodyBuffer(status: 'ok');");
          return BodyBuffer(status: 'ok');
        } else {
          print("BodyBuffer(status: '');");
          return BodyBuffer(status: '');
        }
      } else {
        //EasyLoading.showError("aasd");
        return Container(
          child: Text("11111111"),
        );
      }
    });
  }
}

/* class PreLogin extends StatelessWidget {
  const PreLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    contextBG = context;
    context.read<LoginBloc>().add(LoginEvent.inintlogin);
    return BlocProvider(
        create: (_) => LoginBloc(),
        child: BlocBuilder<LoginBloc, String>(builder: (_, state) {
          //Alway check token['Status']
          //Auto change page to login when token destroyed
          print("userName$userName");
          if (userName != '') {
            print("BodyBuffer(status: 'ok');");
            return BodyBuffer(status: 'ok');
          } else {print("BodyBuffer(status: '');");
            return BodyBuffer(status: '');
          }
        }));
  }
} */

// ignore: must_be_immutable
class BodyBuffer extends StatelessWidget {
  BodyBuffer({Key? key, this.status}) : super(key: key);
  String? status;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    String _status = status ?? '';

    return BlocProvider(
        create: (_) => SwPageCubit(),
        //Main change and check page when bloc SWPageCubit toggle return page
        child: BlocBuilder<SwPageCubit, String>(builder: (_, page) {
          /*  print("Bodybuffer Page : $page");
          print("_Status : ${_status}");
          print("CurrentPage : $currentPage"); */
          if (initialized == false) {
            page = currentPage;
            initialized = true;
          }
          print("Page to go $page");
          if (_status == 'ok') {
            if (page == "LoginPage" || page == "") {
              page = "RoutineRequestPage";
              //print("1");
            } else {
              page = page;
              //print("2");
            }
          } else if (page == 'error') {
          }
          //go to login page when no token
          else {
            print("No token go login");
            page = "LoginPage";
          }

          Widget output = MainBody(selectpage(page));
          //Login only have center body
          if (page == "LoginPage") {
            //print("pageOut1 : $page");
            output = selectpage(page);
          }
          //Other page have mainbody cover
          else {
            //print("pageOut2 : $page");
            output = MainBody(selectpage(page));
          }
          //print("123 : " + page);
          return output;
        }));
  }
}

// ignore: must_be_immutable
class MainBody extends StatelessWidget {
  // const MainBody({Key? key}) : super(key: key);
  Widget page;
  MainBody(this.page);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0b1327),
        actions: <Widget>[App_Bar()],
      ),
      drawer: MainMenu(),
      body: page,
    );
  }
}

class Loginbody extends StatelessWidget {
  const Loginbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
