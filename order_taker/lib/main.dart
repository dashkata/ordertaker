import 'package:flutter/material.dart';
import 'package:order_taker/navigation/registerpage/registerpage.dart';
import 'navigation/loginpage/loginpage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/register',
    routes: {
      '/login': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
    },
  ));
}
