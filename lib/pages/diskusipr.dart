import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'jawaban.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();
  final tSoal = TextEditingController();
  late Box box;
  String selectedTag = '';
  String filterTag = '';

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
    if (_image == null || tSoal.text.isEmpty || selectedTag.isEmpty) {
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
        'tag': selectedTag, // Menyimpan tag
        'answers': [],
      };

      setState(() {
        box.add(savedData);
        _image = null;
        tSoal.clear();
        selectedTag = '';
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
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedTag.isEmpty ? null : selectedTag,
                hint: Text('Pilih Tag'),
                onChanged: (newValue) {
                  setState(() {
                    selectedTag = newValue!;
                  });
                },
                items: ['Pelajaran', 'Non-pelajaran', 'Peminatan']
                    .map((tag) => DropdownMenuItem<String>(
                          value: tag,
                          child: Text(tag),
                        ))
                    .toList(),
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

  void applyFilter(String tag) {
    setState(() {
      filterTag = tag == 'Semua' ? '' : tag;
    });
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Diskusi PR"),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.history, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/history');
                  },
                ),
                SizedBox(width: 4),
                IconButton(
                  icon: Icon(Icons.person, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/pertanyaan');
                  },
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/tole.jpg'),
                        radius: 24,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            tanyaSoal();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Soal apa yang ingin kamu tanyain?',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: IconButton(
                          icon: Icon(Icons.photo_camera, color: Colors.grey),
                          onPressed: () {
                            tanyaSoal();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            tanyaSoal();
                          },
                          child: Text('Upload'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft, // Align text to the left
                    child: Text(
                      'Filter berdasarkan:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.bold, // Make it bold for emphasis
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => applyFilter('Semua'),
                          child: Text('Semua'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => applyFilter('Pelajaran'),
                          child: Text('Pelajaran'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => applyFilter('Non-pelajaran'),
                          child: Text('Non-pelajaran'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => applyFilter('Peminatan'),
                          child: Text('Peminatan'),
                        ),
                        SizedBox(width: 10), // Spasi kanan
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box box, _) {
                      final items = box.values.toList();
                      final filteredItems = filterTag.isEmpty
                          ? items
                          : items.where((item) {
                              final data = item as Map;
                              return data['tag'] == filterTag;
                            }).toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final data = filteredItems[index] as Map;
                          return InkWell(
                            onTap: () => navigateToDetailPage(index),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/tole.jpg',
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
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        data['imagePath'] != null
                                            ? Image.file(
                                                File(data['imagePath']),
                                                height: 150,
                                                width: 110,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                height: 150,
                                                width: 110,
                                                color: Colors.grey[300],
                                                child: Center(
                                                    child: Text(
                                                        'No Image Available')),
                                              ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['text'] ??
                                                    'No Text Available',
                                                style: TextStyle(fontSize: 18),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.chat_bubble,
                                              color: Colors.grey),
                                          onPressed: () =>
                                              navigateToDetailPage(index),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6,
                                    ),
                                    Row(
                                      children: [
                                        // Make the TextButton take up all available space using Expanded
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () =>
                                                navigateToDetailPage(index),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 50),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                'Tuliskan Jawabanmu Disini',
                                                style: TextStyle(
                                                    color: Colors.black54,fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width:6), 
                                        IconButton(
                                          icon: Icon(Icons.send,
                                              color: Colors.grey),
                                          onPressed: () =>
                                              navigateToDetailPage(index),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
