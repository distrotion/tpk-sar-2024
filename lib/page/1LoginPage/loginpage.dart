import 'package:flutter/material.dart';
//--------------------------------------------- Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tpk_login_arsa_01/Global/global_var.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/Data/BlocChagpage.dart';
import 'Data/login_bloc.dart';
import 'Data/login_event.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("InLogInPage");
    final _formKey = GlobalKey<FormBuilderState>();
    //context.read<LoginBloc>().add(LoginEvent.inintlogin);
    //BlocProvider.of<SwPageCubit>(context).togglePage("LoginPage");
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Container(
            height: 400,
            width: 350,
            child: SingleChildScrollView(
                child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 50, end: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 100,
                      // width: 300,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo_tpk.png"),
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: FormBuilderTextField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        name: 'user',
                        initialValue: "",
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'USER NAME',
                          hintStyle: TextStyle(
                            fontFamily: 'Mitr',
                            color: Color(0xffb2b2b2),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // suffixIcon: Icon(
                          //   Icons.search,
                          // ),
                        ),
                        onChanged: (value) {
                          GloUserID = value.toString();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: FormBuilderTextField(
                        textInputAction: TextInputAction.done,
                        name: 'password',
                        obscureText: true,
                        initialValue: "",
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'PASSWORD',
                          hintStyle: TextStyle(
                            fontFamily: 'Mitr',
                            color: Color(0xffb2b2b2),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          // suffixIcon: Icon(
                          //   Icons.search,
                          // ),
                        ),
                        onChanged: (value) {
                          GloPassword = value.toString();
                        },
                        onSubmitted: (value) {
                          GloPassword = value.toString();
                          context.read<LoginBloc>().add(LoginEvent.login);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _LoginSignin(),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class _LoginSignin extends StatelessWidget {
  const _LoginSignin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.read<LoginBloc>().add(LoginEvent.login);
      BlocProvider.of<SwPageCubit>(context).togglePage("MainPage");
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Sign IN",
              style: TextStyle(
                fontFamily: 'Mitr',
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              ),
            ),
          ),
        ));
  }
}
