import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/services/firebase_storage_service/firebase_storage_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:latlong/latlong.dart';

class TestingService {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('datas');

  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //TODO: add id user and testing

  static getListFoodKedua() async {
    try {
      var datas = _firebaseFirestore.collection('coba_2');
      await datas.get().then((value) {
        value.docs.forEach((element) {
          print(element.data());
        });
      });
    } catch (e) {
      print('catch erro $e');
    }
  }

  static Future<List<TestModel>> getListFood() async {
    try {
//      Position position = await Geolocator.getCurrentPosition(
//          desiredAccuracy: LocationAccuracy.best);
      final Distance distance = new Distance();
      QuerySnapshot snapshot = await _collectionReference.get();

      var documents = snapshot.docs;

      print('test executed : ');
//      print(documents.first);
      List<TestModel> testModel = [];
      documents.forEach((doc) async {
        Map<String, dynamic> d = doc.data();
        QuerySnapshot _temp =
            await _collectionReference.doc(doc.id).collection('foods').get();

//        print('result test :');
//        print(doc.id);
//        print(d);
        _temp.docs.forEach((element) {
          print(element.data());
          testModel.add(TestModel(
            namaMakanan: element.data()['nama'],
            namaUser: d['nama'],
          ));
        });

//        var foodName = d['food_name'];
//        listFoodModel.add(
//          ListFoodModel(
//            foodName: foodName,
//          ),
//        );
      });
      return testModel;
//      return listFoodModel;`1
    } catch (e) {
      print('error on test : $e');
      throw Exception(e);
    }
  }
}

class TestModel {
  final String namaUser;
  final String namaMakanan;

  TestModel({
    this.namaMakanan,
    this.namaUser,
  });
}
