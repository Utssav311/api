import 'package:flutter/material.dart';
import 'package:sqlite_studio/screen/login_screen.dart';

import 'api/demo.dart';

void main() {
  runApp(const MaterialApp(
    home: ApiDemoScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
