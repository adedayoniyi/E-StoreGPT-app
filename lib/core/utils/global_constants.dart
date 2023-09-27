import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

const String uri_1 = "https://transfer-dayo-niyi.onrender.com";
const String uri_2 = "http://192.168.186.149:8000";

//image picker
Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        //add all the files to the 'images' File varable
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
