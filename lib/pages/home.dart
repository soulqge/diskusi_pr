import 'package:flutter/material.dart';
import 'package:diskusi_pr/pages/halaman.dart'; 
import 'package:diskusi_pr/pages/diskusipr.dart';
import 'package:diskusi_pr/pages/cart.dart';
import 'package:diskusi_pr/pages/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _indicatorPosition = 0.0;
  int _selectedIndex = -1;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Container(), 
    Cartpage(), 
    Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              leading: Image.asset('images/tole.png'),
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("User B"),
                        SizedBox(height: 3),
                        Text(
                          "Siswa",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Icon(Icons.money, color: Colors.yellow),
                              SizedBox(width: 4),
                              Text(
                                '0',
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.attach_money, color: Colors.blueAccent),
                              SizedBox(width: 4),
                              Text(
                                '1.175',
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null, 
      body: _currentIndex == 0 
          ? _buildHomeContent() 
          : _pages[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
  Widget _buildHomeContent() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 194, 194, 194)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "-Nilai Min : ",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0), 
              child: Text(
                "Perkembangan UTBK",
                style: TextStyle(fontSize: 24, fontFamily: 'Lato'),
              ),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Jan 1 - Des 31",
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  final barWidth = MediaQuery.of(context).size.width / 7;
                  final tappedIndex = (details.localPosition.dx / barWidth).floor();
                  if (tappedIndex >= 0 && tappedIndex < 7) {
                    _selectedIndex = tappedIndex;
                    _indicatorPosition = (tappedIndex + 0.5) * barWidth;
                  }
                });
              },
              child: Container(
                height: 160,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(7, (index) {
                    return Column(
                      children: [
                        Container(
                          width: 20,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('#'),
                      ],
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: <Widget>[
                  _buildMenuItem(Icons.book, 'UTBK', context, Perbaikan()),
                  _buildMenuItem(Icons.subscriptions, 'Langganan', context, Perbaikan()),
                  _buildMenuItem(Icons.chat, 'Diskusi', context,HomePage() ),
                  _buildMenuItem(Icons.note, 'Catatan', context, Perbaikan()),
                  _buildMenuItem(Icons.library_books, 'Materi', context, Perbaikan()),
                  _buildMenuItem(Icons.calculate, 'Rumus', context, Perbaikan()),
                ],
              ),
            ),
          ],
        ),
        if (_selectedIndex != -1)
          Positioned(
            top: 160,
            left: _indicatorPosition - 20,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: Colors.white,
                    size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Rank #',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          right: 16.0,
          bottom: 60.0, 
          child: FloatingActionButton(
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed('/perbaikan');
            },
            backgroundColor: Colors.transparent,
            elevation: 0, 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0), 
              child: Image.asset(
                'images/wapics.png', 
                fit: BoxFit.cover,
                width: 56.0,
                height: 56.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData iconData, String label, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            iconData,
            size: 50.0,
            color: Colors.blue,
          ),
          SizedBox(height: 8.0),
          Text(label, style: TextStyle(fontSize: 12.0)),
        ],
      ),
    );
  }
}
