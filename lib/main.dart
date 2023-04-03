import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/selected_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      "/": (context) => Home(),
      'selected_page': (context) => const SelectedPage(),
    },
  ));
}
