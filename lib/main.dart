import 'package:flutter/material.dart';

import 'screens/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(224, 31, 31, 1.0),
      ),
      home: LoginForm(),
    );
  }
}
