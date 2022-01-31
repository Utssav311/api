// ignore_for_file: prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_studio/model/user_model.dart';
import 'package:sqlite_studio/screen/submit_screen.dart';
import 'package:sqlite_studio/sqlite_database/db_helper.dart';
import 'package:sqlite_studio/utils/app_colors.dart';
import 'package:sqlite_studio/utils/app_fonts.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, bottom: 20, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                      width: 20,
                      margin: const EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                      ),
                      alignment: Alignment.centerLeft,
                      child: const Icon(Icons.arrow_back)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Card(
                  elevation: 6.8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 14, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: defaultTextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          "Name",
                          style: defaultTextStyle(
                              fontSize: 14.0,
                              fontColors: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'First Name';
                              }
                            },
                            controller: userName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorLightGrey),
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
                        Text(
                          "Email",
                          style: defaultTextStyle(
                              fontSize: 14.0,
                              fontColors: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return 'Enter email';
                              }
                            },
                            controller: email,
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
                        Text(
                          "Password",
                          style: defaultTextStyle(
                              fontSize: 14.0,
                              fontColors: colorGrey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 33,
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              }
                              if (password.text.length < 8) {
                                return 'Please Enter 8 Digits Password';
                              }
                            },
                            controller: password,
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
                          height: 5,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                             signUp();
                            } else {
                              Fluttertoast.showToast(
                                msg: "Fill Up",
                                backgroundColor: Colors.white54,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.height,
                            color: colorGreen,
                            alignment: Alignment.center,
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(color: colorWhite),
                            ),
                          ),
                        )
                      ],
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

  signUp() async {
    Database db = await DbHelper().database;
    final result = await db.rawQuery(
        "SELECT * FROM user_table WHERE email=?", [email.text]);
      if (result.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Already exist",
            backgroundColor: Colors.white54,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        UserModel user = UserModel();
        user
          ..email = email.text
          ..username = userName.text
          ..password = password.text;
        await DbHelper().insert(user);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const SubmitScreen()));
      }
  }
}
