// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_studio/model/user_model.dart';
import 'package:sqlite_studio/screen/sign_up_screen.dart';
import 'package:sqlite_studio/screen/submit_screen.dart';
import 'package:sqlite_studio/sqlite_database/db_helper.dart';
import 'package:sqlite_studio/utils/app_fonts.dart';

import '../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginScreenKey = GlobalKey<FormState>();
  List<UserModel> modelList = [];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 0),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.175,
                ),
                Form(
                  key: loginScreenKey,
                  child: Card(
                    elevation: 7,
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 14, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Welcome,",
                                style: defaultTextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Text(
                                  "Sign",
                                  style: defaultTextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      fontColors: colorGreen),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Sign in to Continue",
                              style: defaultTextStyle(
                                  fontSize: 14.0,
                                  fontColors: colorGrey,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: 40,
                          ),
                          Text("Email",
                              style: defaultTextStyle(
                                  fontColors: colorGrey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 33,
                            child: TextFormField(
                              focusNode: emailFocus,
                              autofocus: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter email';
                                }
                              },
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  color: colorBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorGreen),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorGreen),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 39,
                          ),
                          Text("Password",
                              style: defaultTextStyle(
                                  fontColors: colorGrey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 33,
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  color: colorBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorGreen),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: colorGreen),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              // onTap: () {
                              //   forgotClick();
                              // },
                              child: Text(
                                "Forgot Password?",
                                style: defaultTextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () async {
                              if (loginScreenKey.currentState!.validate()) {
                                logIn();
                              }
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: colorGreen,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "SIGN IN",
                                style: defaultTextStyle(
                                    fontColors: colorWhite,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logIn() async {
    Database db = await DbHelper().database;
    final result = await db.rawQuery(
        "SELECT * FROM user_table WHERE email=?", [_emailController.text]);
    if (result.isNotEmpty) {
      final result = await db.rawQuery(
          "SELECT * FROM user_table WHERE email=? AND password=?",
          [_emailController.text, _passwordController.text]);
      if (result.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SubmitScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Wrong Password",
            backgroundColor: Colors.white54,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please Sign-Up",
          backgroundColor: Colors.white54,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }
}
