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
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        Padding(padding: const EdgeInsets.only(left: 16),
        child: Text("Buat Akun Mejakita",
        style: TextStyle(fontSize: 18,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w400,),),
        ),
        SizedBox(height: 6,),
        Padding(padding: const EdgeInsets.only(left: 16),
        child: Text("Daftar Menggunakan Email Anda",
        style: TextStyle(fontSize: 12),),
        )
      ],
      )
    );
  }
}