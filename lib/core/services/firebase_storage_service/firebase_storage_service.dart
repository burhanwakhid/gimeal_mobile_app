import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

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
}
