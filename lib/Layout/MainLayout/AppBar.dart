import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//--------------------------------------------- Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/Data/BlocChagpage.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/Data/BlocPageRebuild.dart';
import 'package:tpk_login_arsa_01/main.dart';
import 'package:tpk_login_arsa_01/page/1LoginPage/Data/login_bloc.dart';
import 'package:tpk_login_arsa_01/page/1LoginPage/Data/login_event.dart';

//---------------------------------------------

String pageactive = '';

class App_Bar extends StatefulWidget {
  App_Bar({Key? key}) : super(key: key);

  @override
  _App_BarState createState() => _App_BarState();
}

class _App_BarState extends State<App_Bar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      color: Color(0xff0b1327),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Container(
              height: 40,
              width: 40,
              //color: Colors.white,
              child: InkWell(
                child: Icon(
                  Icons.menu,
                  size: 35.0,
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                //BlocProvider.of<SwPageCubit>(context).togglePage("RefreshPage");
                Future.delayed(Duration(milliseconds: 10), () {
                  BlocProvider.of<SwPageCubit>(context).togglePage(lastPage);
                });
              });
            },
            child: Container(
              width: 24,
              height: 24,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            onTap: () {
              setState(() {
                //BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
                String buffPage = currentPage;
                BlocProvider.of<SwPageCubit>(context).togglePage("RefreshPage");
                Future.delayed(Duration(milliseconds: 10), () {
                  BlocProvider.of<SwPageCubit>(context).togglePage(buffPage);
                });
              });
            },
            child: Container(
              width: 24,
              height: 24,
              child: Icon(
                Icons.refresh,
                color: Colors.green,
                size: 30.0,
              ),
            ),
          ),
          Logo2(),
          Logo1(),
          Spacer(),
          //Text(MediaQuery.of(context).size.width.toString()),
          //Text("  |  <--->  |  " + current_page.toString()),
          Spacer(),
          Pack_topright_bar(),
        ],
      ),
    );
  }

  ///###################################################################################

}

class Logo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Container(
        height: 40,
        width: 80,
        color: Colors.white,

        child: Padding(
          padding: const EdgeInsetsDirectional.all(1),
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/logo_tpk.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),

        //color: Colors.white,
      ),
    );
  }
}

//============================================================
class Logo1 extends StatelessWidget {
  Logo1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SwPageCubit(),
      //Main change and check page when bloc SWPageCubit toggle return page
      child: BlocBuilder<SwPageCubit, String>(
        builder: (_, page) {
          print("change : $currentPage");
          if (true) {
            return Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Container(
                color: Color(0xff0b1327),
                child: Text(
                  currentPage,
                  style: TextStyle(
                    fontFamily: 'Mitr',
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class Pack_topright_bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
          //width: 150,
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Time_(), Icon_bell(), Icon_profile()],
      )),
    );
  }
}

class Icon_bell extends StatelessWidget {
  const Icon_bell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 24,
      // height: 24,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(children: [
        SizedBox(
          width: 20,
        ),
        Text(
          userName,
          style: TextStyle(
            fontFamily: 'Mitr',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          onPressed: () {
            BlocProvider.of<SwPageCubit>(context).togglePage("MainPage");
          },
          icon: Image.asset("assets/icons/icon-notifications.png"),
        ),
      ]),
    );
  }
}

class Icon_profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      /* onLongPress: () {
        runApp(MyApp());
        context.read<LoginBloc>().add(LoginEvent.logout);
      }, */
      onTap: () {
        runApp(MyApp());
        context.read<LoginBloc>().add(LoginEvent.logout);
      },
      child: Container(
          width: 24,
          height: 24,
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.brown.shade300)),
    );
  }
}

class Time_ extends StatefulWidget {
  Time_({Key? key}) : super(key: key);

  @override
  _Time_State createState() => _Time_State();
}

class _Time_State extends State<Time_> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Center(
          child: Text(
            DateFormat(' hh:mm a').format(DateTime.now()),
            style: TextStyle(
              fontFamily: 'Mitr',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
        );
      },
    );
  }
}
