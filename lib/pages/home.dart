import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();
  final tSoal = TextEditingController();
  String? selectedTag;
  String? filterTag;
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('savedDataBox');
  }

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
    if (_image == null || tSoal.text.isEmpty || selectedTag == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto, teks, dan tag harus diisi!')),
      );
      return;
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileNama = path.basename(_image!.path);
      final localImage = await _image!.copy('${directory.path}/$fileNama');

      final soalText = tSoal.text;
      final savedData = {
        'imagePath': localImage.path,
        'text': soalText,
        'tag': selectedTag,
        'answers': [],
      };

      setState(() {
        box.add(savedData);
        _image = null;
        tSoal.clear();
        selectedTag = null;
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
              DropdownButton<String>(
                hint: Text("Pilih Tag"),
                value: selectedTag,
                items: ['Pelajaran', 'Non-Pelajaran']
                    .map((tag) => DropdownMenuItem(
                          value: tag,
                          child: Text(tag),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTag = value!;
                  });
                },
              ),
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
              selectedTag = null;
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

  void navigateToDetailPage(int index) async {
    final questionData = box.getAt(index) as Map;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailPage(index: index, questionData: questionData),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diskusi PR"),
        backgroundColor: Colors.blue,
        actions: [
          DropdownButton<String>(
            hint: Text("Filter"),
            value: filterTag,
            items: ['Semua', 'Pelajaran', 'Non-Pelajaran']
                .map((tag) => DropdownMenuItem(
                      value: tag == 'Semua' ? null : tag,
                      child: Text(tag),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                filterTag = value;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box box, _) {
            final filteredItems = box.values.where((item) {
              if (filterTag == null) return true;
              return item['tag'] == filterTag;
            }).toList();

            return ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final data = filteredItems[index] as Map;
                return InkWell(
                  onTap: () => navigateToDetailPage(index),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          data['imagePath'] != null
                              ? Image.file(
                                  File(data['imagePath']),
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: Center(child: Text('No Image Available')),
                                ),
                          SizedBox(height: 10),
                          Text(
                            data['text'] ?? 'No Text Available',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
