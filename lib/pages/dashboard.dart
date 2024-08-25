import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logos.png',
              height: 100,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Image.asset(
                    'images/dashboard1.jpg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 160), // Ruang untuk Card utama dan jarak ke bawah
                  SizedBox(
                    height: 200, // Tinggi card yang bisa di-swipe
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            color: Colors.lime,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Card Materi',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            color: Colors.lightBlue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Card Materi',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            color: Colors.cyan,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Card UTBK',
                                style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Jarak antara PageView dan tombol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman Login
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple, // Warna teks putih dengan latar biru
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Membuat sisi lebih membulat
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding dalam tombol
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman Sign Up
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple, // Warna teks putih dengan latar biru
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Membuat sisi lebih membulat
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding dalam tombol
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 400), // Tambahan konten untuk memungkinkan scroll
                  Text(
                    'Konten Tambahan untuk Scroll',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Positioned(
                top: 160,
                left: 10,
                right: 10,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Join App Mejakita',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Ikuti Keseruan di aplikasi mejakita',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Image.asset(
                          'images/DB2.png',
                          fit: BoxFit.contain,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
