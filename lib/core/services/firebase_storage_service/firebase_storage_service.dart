import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class FirebaseStorageService {
  // final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static Future<UploadTask> uploadImageFood(File image, String path) async {
    UploadTask uploadTask;
    Reference ref =
        FirebaseStorage.instance.ref().child('foods').child('/$path.png');

    final metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {'picked-file-path': image.path});

    uploadTask = ref.putFile(image, metadata);

    
    return Future.value(uploadTask);
  }

  static Future<String> getUrlImage(Reference refs) async {
    // print(path);
    // Reference ref =
    //     FirebaseStorage.instance.ref().child('foods').child('food-shshhsjsjs-2020-12-08T21:48:56.841174.png');
      String uri = (await refs.getDownloadURL()).toString();
    return uri;
  }
}
