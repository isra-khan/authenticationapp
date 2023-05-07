import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  final picker = ImagePicker();
  Future<void> getImageData() async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          InkWell(
            onTap: () {
              getImageData();
            },
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: _image != null
                    ? Image.file(_image!.absolute)
                    : Icon(Icons.image),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername' + '123');
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(_image!.absolute);
                await Future.value(uploadTask);
                var newUrl = ref.getDownloadURL();
              },
              child: Text('upload')),
        ]),
      ),
    );
  }
}
