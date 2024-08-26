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
      body: Container(
  child: Center( 
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(left: 30, right: 30),
        child:Text(
          "Oops! Halaman dalam pengembangan silahkan kembali",
          style: TextStyle(fontSize: 19,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,),
        ),),
        SizedBox(height: 60),  
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/dashboard');
          },
          style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent, 
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), 
                ),
              ),
          child: Text('Kembali',
          style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  ),
),

    );
  }
}