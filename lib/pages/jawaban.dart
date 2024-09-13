import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    box = Hive.box('savedDataBox');
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void simpanJawab() async {
    if (jSoal.text.isEmpty && _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Jawaban tidak boleh kosong, masukkan teks atau gambar!')),
      );
      return;
    }

    final soalJawab = jSoal.text;
    final newAnswer = {
      'jawab': soalJawab.isNotEmpty ? soalJawab : null,
      'imagePath': _imageFile != null ? _imageFile!.path : null,
      'tanggal': DateTime.now().toString(),  
    };

    setState(() {
      final updatedQuestion = widget.questionData;
      List answers = updatedQuestion['answers'] ?? [];
      answers.add(newAnswer);
      updatedQuestion['answers'] = answers;
      box.putAt(widget.index, updatedQuestion);
      jSoal.clear();
      _imageFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Berhasil mengirim jawaban')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final answers = widget.questionData['answers'] as List;
    final imagePath = widget.questionData['imagePath'];

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/tole.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 6),
                      Text("User1"),
                    ],
                  ),
                  SizedBox(height: 10),
                  imagePath != null
                      ? Image.file(File(imagePath), height: 150, width: 150, fit: BoxFit.cover)
                      : Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text('No Image Available'),
                          ),
                        ),
                  SizedBox(height: 20),
                  Text(
                    widget.questionData['text'] ?? 'No Text Available',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.chat_bubble, color: Colors.grey),
                        onPressed: () => {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [Text("Jawaban : ")],
                  ),
                  SizedBox(height: 10),
                  answers.isEmpty
                      ? Center(child: Text('Belum ada jawaban.'))
                      : Column(
                          children: List.generate(answers.length, (index) {
                            final data = answers[index];
                            return Card(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/tole.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(width: 6),
                                        Text("User 1"),
                                        SizedBox(width: 6),
                                        Text(
                                          data['tanggal'] != null
                                              ? '(${DateTime.parse(data['tanggal']).toLocal().toString().split(' ')[0]})'
                                              : '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    if (data['jawab'] != null && data['jawab'].isNotEmpty)
                                      Text(data['jawab'] ?? ''),
                                    if (data['imagePath'] != null)
                                      Image.file(
                                        File(data['imagePath']),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                  SizedBox(height: 80), // Space to avoid overlap with the bottom row
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: jSoal,
                      decoration: InputDecoration(hintText: 'Ketik Jawaban Kamu...'),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.camera, color: Colors.grey),
                    onPressed: _pickImage,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: simpanJawab,
                    child: Text('Jawab'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
