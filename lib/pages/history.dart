import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'jawaban.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Box box; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    box = Hive.box('savedDataBox'); 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to confirm delete
  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus item ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              hapusSoal(index);  // Perform delete
              Navigator.pop(context);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // Function to delete the question/answer
  void hapusSoal(int index) {
    setState(() {
      box.deleteAt(index); // Delete from Hive
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item berhasil dihapus')),
    );
  }

  // Function to build the question list with delete buttons
  Widget buildSoalList() {
    if (box.isEmpty) {
      return Center(
        child: Text('Belum ada soal yang diunggah'),
      );
    }

    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (context, index) {
        final soalData = box.getAt(index) as Map;

        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(soalData['text'] ?? 'No Text Available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                soalData['imagePath'] != null
                    ? Image.file(
                        File(soalData['imagePath']),
                        height: 150,
                        width: 110,
                        fit: BoxFit.cover,
                      )
                    : Text('No Image Available'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => confirmDelete(index),
                      child: Text('Hapus'),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    index: index,
                    questionData: soalData,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Function to build the answered question list with delete buttons
  Widget buildAnsweredSoalList() {
    final List<Map> answeredSoals = [];

    for (int i = 0; i < box.length; i++) {
      final soalData = box.getAt(i) as Map;
      if (soalData['answers'] != null && (soalData['answers'] as List).isNotEmpty) {
        answeredSoals.add(soalData);
      }
    }

    if (answeredSoals.isEmpty) {
      return Center(
        child: Text('Belum ada jawaban'),
      );
    }

    return ListView.builder(
      itemCount: answeredSoals.length,
      itemBuilder: (context, index) {
        final soalData = answeredSoals[index];

        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(soalData['text'] ?? 'No Text Available'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jumlah Jawaban: ${(soalData['answers'] as List).length}'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => confirmDelete(box.values.toList().indexOf(soalData)),
                      child: Text('Hapus'),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    index: box.values.toList().indexOf(soalData),
                    questionData: soalData,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("History Diskusi PR"),
        backgroundColor: Colors.white,
        elevation: 1, 
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black, 
          tabs: [
            Tab(text: 'Pertanyaan'),
            Tab(text: 'Jawaban'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box box, _) {
              return buildSoalList(); 
            },
          ),
          ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box box, _) {
              return buildAnsweredSoalList(); 
            },
          ),
        ],
      ),
    );
  }
}
