import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_c_kelompok4/model/addNews_model.dart';
//import 'package:news_c_kelompok4/database/sql_helper.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:news_c_kelompok4/client/addNews_client.dart';
import 'package:news_c_kelompok4/addNews/yourPost.dart';
import 'dart:io';

class AddItemScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onItemAdded;
  const AddItemScreen({
    Key? key,
    required this.title,
    required this.id,
    required this.judul,
    required this.kategori,
    required this.deskripsi,
    required this.onItemAdded,
  });

  final String? title, judul, kategori;
  final int? id;

  final String? deskripsi;

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerKategori = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  String selectedImagePath = '';
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker object

  Future<void> selectImage() async {
    // Function to select image from gallery or camera
    try {
      final XFile? pickedFile = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.h),
            ),
            child: Container(
              height: 30.h,
              child: Padding(
                padding: EdgeInsets.all(3.h),
                child: Column(
                  children: [
                    Text(
                      'Select Image From',
                      style: TextStyle(
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            Navigator.pop(context, image);
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(3.h),
                              child: const Icon(Icons.photo),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.camera);
                            Navigator.pop(context, image);
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(3.h),
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
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

      if (pickedFile != null) {
        setState(() {
          selectedImagePath = pickedFile.path;
        });
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      controllerJudul.text = widget.judul!;
      controllerKategori.text = widget.kategori!;
      controllerDeskripsi.text = widget.deskripsi!;
      if (selectedImagePath.isNotEmpty) {
        selectedImagePath;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD NEWS"),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.h),
        children: <Widget>[
          TextFormField(
            key: const ValueKey('Judul'),
            controller: controllerJudul,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Judul Berita',
            ),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            key: const ValueKey('Kategori'),
            controller: controllerKategori,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Kategori Berita',
            ),
          ),
          TextFormField(
            key: const ValueKey('Deskripsi'),
            controller: controllerDeskripsi,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Deskripsi Berita',
            ),
          ),
          ElevatedButton(
            child: const Text('Simpan'),
            onPressed: () async {
              onSubmit();
              Navigator.pop(context);
              widget.onItemAdded({
                'judul': controllerJudul.text,
                'kategori': controllerKategori.text,
                'deskripsi': controllerDeskripsi.text,
                'imagePath': selectedImagePath,
              });
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => YourPost(),
              //   ),
              // );
            },
          ),
          SizedBox(height: 4.h),
          ElevatedButton(
            child: const Text('Pilih Gambar'),
            onPressed: () {
              selectImage(); // Trigger the image selection process
            },
          ),
          SizedBox(height: 4.h),
          selectedImagePath.isNotEmpty
              ? Image.file(File(selectedImagePath))
              : const SizedBox(),
        ],
      ),
    );
  }

  void onSubmit() async {
    addNews input = addNews(
      id: widget.id ?? 0,
      judul: controllerJudul.text,
      kategori: controllerKategori.text,
      deskripsi: controllerDeskripsi.text,
      imagePath: selectedImagePath,
      lokasi: "Belum",
    );

    try {
      if (widget.id == null) {
        await addNewsClient.create(input);
      } else {
        addNews input = addNews(
          id: widget.id ?? 0,
          judul: controllerJudul.text,
          kategori: controllerKategori.text,
          deskripsi: controllerDeskripsi.text,
          imagePath: selectedImagePath,
          lokasi: "Belum",
        );
        print(widget.id);
        await addNewsClient.update(input);
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
