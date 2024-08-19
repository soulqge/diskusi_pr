import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();
  final tSoal = TextEditingController();

  // List to store saved data
  final List<Map<String, String>> savedDataList = [];

  void pilihFoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Tidak Ada Foto Yang Dipilih');
      }
    });
  }

  void simpanFoto() async {
    if (_image == null || tSoal.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto dan teks harus diisi!')),
      );
      return;
    }

    try {
      // Save the image to local storage
      final directory = await getApplicationDocumentsDirectory();
      final fileNama = path.basename(_image!.path);
      final localImage = await _image!.copy('${directory.path}/$fileNama');

      // Save the text input and image path
      final soalText = tSoal.text;
      final savedData = {
        'imagePath': localImage.path,
        'text': soalText,
      };

      // Add the saved data to the list
      setState(() {
        savedDataList.add(savedData);
        _image = null;
        tSoal.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto dan teks berhasil disimpan!')),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Gagal menyimpan foto dan teks: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan foto dan teks!')),
      );
    }
  }

  void tanyaSoal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Tanya Soal"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tSoal,
                decoration: InputDecoration(hintText: 'Mau Tanya Apa?'),
              ),
              _image == null
                  ? Text("Tidak Ada Foto Yang Dipilih")
                  : Image.file(_image!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: pilihFoto,
                child: Text("Pilih Foto"),
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              tSoal.clear();
            },
            child: Text("Batal"),
          ),
          MaterialButton(
            onPressed: simpanFoto,
            child: Text("Tanya"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diskusi PR"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: savedDataList.length,
          itemBuilder: (context, index) {
            final data = savedDataList[index];
            return Card(
              child: ListTile(
                leading: data['imagePath'] != null
                    ? Image.file(File(data['imagePath']!))
                    : null,
                title: Text(data['text'] ?? ''),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tanyaSoal,
        child: Icon(Icons.add),
      ),
    );
  }
}
