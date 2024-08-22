import 'package:diskusi_pr/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('savedDataBox');
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => HomePage(),
    },
  ));
}

