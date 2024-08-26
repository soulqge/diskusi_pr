import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberDevice = false;

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
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Login Ke Mejakita",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Masuk menggunakan akun mejakita",
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                hintText: "Email atau Username",
                prefixIcon: Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                hintText: "Password",
                prefixIcon: Icon(Icons.key, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: _rememberDevice,
                      onChanged: (value) {
                        setState(() {
                          _rememberDevice = value!;
                        });
                      },
                    ),
                    Text("Ingat Perangkat Ini"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  onPressed: () {
                   Navigator.of(context).pushReplacementNamed('/forgot');
                  },
                  child: Text(
                    "Lupa Password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40,),
       Center(
            child: ElevatedButton(
              onPressed: () {
               Navigator.of(context).pushReplacementNamed('/home');

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, 
                padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), 
                ),
              ),
              child: Text(
                "MASUK",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Padding(padding: const EdgeInsets.only(left: 16),
              child: Text("Belum Punya Akun?"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  onPressed: () {
                   Navigator.of(context).pushReplacementNamed('/signup');
                  },
                  child: Text(
                    "Daftar Sekarang",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
