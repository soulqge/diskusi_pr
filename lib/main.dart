import 'package:diskusi_pr/pages/dashboard.dart';
import 'package:diskusi_pr/pages/forgot.dart';
import 'package:diskusi_pr/pages/diskusipr.dart';
import 'package:diskusi_pr/pages/halaman.dart';
import 'package:diskusi_pr/pages/home.dart';
import 'package:diskusi_pr/pages/login.dart';
import 'package:diskusi_pr/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('savedDataBox');
  runApp(MaterialApp(
    initialRoute: '/dashboard',
    routes: {
      '/homepage': (context) => HomePage(),
      '/dashboard':(context) => Dashboard(),
      '/login':(context) => Login(),
      '/signup':(context) => Signup(),
      '/forgot':(context) => ForgotPage(),
      '/perbaikan':(context) => Perbaikan(),
      '/home':(context) => Home(),
      



    },
  ));
}

 