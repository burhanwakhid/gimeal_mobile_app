import 'package:cloud_firestore/cloud_firestore.dart';
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
      LatLng currentPosition) async {
    // Format DateTime to TimeOfDay
    Timestamp waktuPengambilanFormatted =
        Timestamp.fromDate(waktuPengambilan);

    Timestamp waktuPenayanganFormatted =
        Timestamp.fromDate(waktuPenayangan);

    _collectionReference.doc('id user').set({
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
}
