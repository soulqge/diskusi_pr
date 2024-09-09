import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DetailPage extends StatefulWidget {
  final int index;
  final Map questionData;

  const DetailPage({
    Key? key,
    required this.index,
    required this.questionData,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final jSoal = TextEditingController();
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('savedDataBox');
  }

  void simpanJawab() async {
    if (jSoal.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jawaban Tidak Boleh Kosong!')),
      );
      return;
    }

    final soalJawab = jSoal.text;
    final newAnswer = {'jawab': soalJawab};

    setState(() {
      final updatedQuestion = widget.questionData;
      List answers = updatedQuestion['answers'] ?? [];
      answers.add(newAnswer);
      updatedQuestion['answers'] = answers;
      box.putAt(widget.index, updatedQuestion);
      jSoal.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Berhasil Menjawab')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final answers = widget.questionData['answers'] as List;

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
    icon: Icon(Icons.chevron_left),
    onPressed: () {
        Navigator.of(context).pushReplacementNamed('/homepage');
      },
      ),
        title: Text('Diskusi PR'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  'images/tole.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 6,
                ),
                Text("User1"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Image.file(File(widget.questionData['imagePath']),
                height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(widget.questionData['text'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.chat_bubble, color: Colors.grey),
                  onPressed: () => {},
                ),
              ],
            ),
            Expanded(
              child: answers.isEmpty
                  ? Center(child: Text('Belum ada jawaban.'))
                  : ListView.builder(
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        final data = answers[index];
                        return Card(
                          child: ListTile(
                            title: Text(data['jawab'] ?? ''),
                          ),
                        );
                      },
                    ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jSoal,
                    decoration:
                        InputDecoration(hintText: 'Ketik Jawaban Kamu...'),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.camera, color: Colors.grey),
                  onPressed: () {},
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: simpanJawab,
                  child: Text('Jawab'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
