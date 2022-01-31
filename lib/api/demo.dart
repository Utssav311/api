import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite_studio/api/model/post_model.dart';

class ApiDemoScreen extends StatefulWidget {
  const ApiDemoScreen({Key? key}) : super(key: key);

  @override
  _ApiDemoScreenState createState() => _ApiDemoScreenState();
}

class _ApiDemoScreenState extends State<ApiDemoScreen> {
  bool isProgress = true;
  PostModel model = PostModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: getApiData(),
            builder: (BuildContext context, data) {
              if (data.hasData) {
                return apiDataLayout();
              } else if (data.hasError) {
                return Text(data.error.toString());
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget apiDataLayout() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(model.title ?? ""),
          const SizedBox(
            height: 10,
          ),
          Text(model.body ?? ""),
        ],
      );

  getApiData() async {
    // getProgress(true);
    Map<String, dynamic> map = {
      "id": "1",
    };
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/1")
        .replace(queryParameters: <String,String>{"id":"1"});
    try {
      final response = await http.get(uri);
      // getProgress(false);

      if (response.statusCode == 200) {
        model = PostModel.fromJson(jsonDecode(response.body));
        return model;
      } else {
        throw Exception("No data found");
      }
    } catch (e) {
      throw Exception("No data found");
    }
  }

  getProgress(bool value) {
    setState(() {
      isProgress = value;
    });
  }
}
