import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:latlong/latlong.dart';

class FoodServices {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('foods');
  //TODO: add id user and testing
  static Future<void> addFood(
    String pathFoodPhoto,
    String foodName,
    int jmlFood,
    String note,
    String desc,
    DateTime waktuPengambilan,
    DateTime waktuPenayangan,
    String alamatlengkap,
    LatLng currentPosition,
  ) async {
    // Format DateTime to TimeOfDay
    Timestamp waktuPengambilanFormatted = Timestamp.fromDate(waktuPengambilan);

    Timestamp waktuPenayanganFormatted = Timestamp.fromDate(waktuPenayangan);

    _collectionReference.doc().set({
      'idUser': await MainSharedPreferences().getIdUser(),
      'path_food_photo': pathFoodPhoto,
      'food_name': foodName,
      'jumlah_food': jmlFood,
      'note': note,
      'desc': desc,
      'waktu_pengambilan': waktuPengambilanFormatted,
      'waktu_penayangan': waktuPenayanganFormatted,
      'alamat_lengkap': alamatlengkap,
      'currentLocation':
          GeoPoint(currentPosition.latitude, currentPosition.longitude),
      'created_at': Timestamp.now()
    });
  }

  static Future<List<ListFoodModel>> getListFood() async {
    try {
      QuerySnapshot snapshot = await _collectionReference.get();
      var documents = snapshot.docs;

      List<ListFoodModel> listFoodModel = [];
      documents.forEach((doc) {
        Map<String, dynamic> d = doc.data();
        var idUser = d['idUser'];
        var pathFoodPhoto = d['path_food_photo'];
        var foodName = d['food_name'];
        var jumlahFood = d['jumlah_food'];
        var note = d['note'];
        var desc = d['desc'];
        Timestamp waktuPengambilan = d['waktu_pengambilan'];
        Timestamp waktuPenayangan = d['waktu_penayangan'];
        var alamatLengkap = d['alamat_lengkap'];
        GeoPoint latlong = d['currentLocation'];
        double latitude = latlong.latitude;
        double longitude = latlong.longitude;
        Timestamp createdAt = d['created_at'];
        print(d['currentLocation']);
        listFoodModel.add(
          ListFoodModel(
            idUser: idUser,
            pathFoodPhoto: pathFoodPhoto,
            foodName: foodName,
            jumlahFood: jumlahFood,
            note: note,
            desc: desc,
            waktuPenayangan: waktuPenayangan.toDate(),
            waktuPengambilan: waktuPengambilan.toDate(),
            alamatLengkap: alamatLengkap,
            latitude: latitude,
            longitude: longitude,
            createdAt: createdAt.toDate(),
          ),
        );
      });
      return listFoodModel;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}