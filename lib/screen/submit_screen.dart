// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sqlite_studio/model/user_model.dart';
import 'package:sqlite_studio/sqlite_database/db_helper.dart';
import 'login_screen.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  List<UserModel> userList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.arrow_back),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  UserModel model = userList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black26),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Id : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    model.id.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await DbHelper().delete(model.id??0);
                                      getData();
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Username : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    model.username.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Email : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    model.email.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Password : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    model.password.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getData() async {
    List<UserModel> model = await DbHelper().getData();
    setState(() {
      userList = model;
    });
  }
}
