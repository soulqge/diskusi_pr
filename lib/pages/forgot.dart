import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: Colors.greenAccent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
              elevation: 0,
            ),
            Center(
              child: Image.asset(
                'images/logos.png',
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Halaman Error 404, Silahkan Kembali"),
      ),
    );
  }
}