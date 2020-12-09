import 'dart:io';


import 'package:firebase_storage/firebase_storage.dart';

import 'package:gimeal/core/services/firebase_firestore/fire_food_service.dart';
import 'package:gimeal/core/services/firebase_storage_service/firebase_storage_service.dart';
import 'package:latlong/latlong.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:mobx/mobx.dart';
part 'upload_food_store.g.dart';

class UploadFoodStore = _UploadFoodStore with _$UploadFoodStore;

abstract class _UploadFoodStore with Store {
  @observable
  ObservableFuture<List<ListFoodModel>> listFoodFuture;

  @action
  Future<void> listFood() async {
    try {
      listFoodFuture = ObservableFuture(FoodServices.getListFood());
      await listFoodFuture;
      print(listFoodFuture.value[0].foodName);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  @action
  Future<void> uploadFood(
    String pathFoodPhoto,
    String foodName,
    int jmlFood,
    String note,
    String desc,
    DateTime waktuPengambilan,
    DateTime waktuPenayangan,
    String alamatlengkap,
    LatLng currentPosition,
    File image,
  ) async {
    try {
      await _prosesUpload(
          pathFoodPhoto,
          foodName,
          jmlFood,
          note,
          desc,
          waktuPengambilan,
          waktuPenayangan,
          alamatlengkap,
          currentPosition,
          image);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> _prosesUpload(
    String pathFoodPhoto,
    String foodName,
    int jmlFood,
    String note,
    String desc,
    DateTime waktuPengambilan,
    DateTime waktuPenayangan,
    String alamatlengkap,
    LatLng currentPosition,
    File image,
  ) async {
    var uploadtask =
        await FirebaseStorageService.uploadImageFood(image, pathFoodPhoto);
    // print(uploadtask.snapshot.ref);
    await uploadtask.asStream().listen((event) async {
      var state = event.state;
      if (state == TaskState.success) {
        String uri =
            await FirebaseStorageService.getUrlImage(uploadtask.snapshot.ref);
        await FoodServices.addFood(uri, foodName, jmlFood, note, desc,
            waktuPengambilan, waktuPenayangan, alamatlengkap, currentPosition);
      } else {
        print('gagal: ${state.toString()}');
        throw 'gagal upload makanan';
      }
    }).asFuture();

  }
}
