import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
        Navigator.of(context).pushReplacementNamed('/homepage');
      },
      ),
      title: Text(" History Diskusi PR"),
      backgroundColor: Colors.white10,
    ),
    );
  }
}