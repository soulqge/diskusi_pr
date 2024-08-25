import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                height: 200, 
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Halaman Login'),
      ),
    );
  }
}
