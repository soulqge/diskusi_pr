import 'package:flutter/material.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
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
                  Navigator.of(context).pushReplacementNamed('/dashboard');
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
        child: Text('Halaman Sign Up'),
      ),
    );
  }
}