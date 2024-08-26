import 'package:flutter/material.dart';

class Perbaikan extends StatelessWidget {
  const Perbaikan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
              elevation: 0,
       title: Text("Mejakita.com"),
      ),
      body: Center(
        child: Text("Oops Halaman dalam pengembangan silahkan kembali"),
      ),
    );
  }
}