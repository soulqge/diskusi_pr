import 'package:diskusi_pr/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomePage(),
    },
  ));
}

