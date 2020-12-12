import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_service.dart';
import 'package:latlong/latlong.dart';

class FireFoodTransactionService {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('food_transactions');

  static Future<void> saveTransactions(
    String idFood,
    String idPembuatMakanan,
    String pathFoodPhoto,
    String foodName,
    String jumlahFood,
    String note,
    String desc,
    DateTime waktuPengambilanFormatted,
    DateTime waktuPenayanganFormatted,
    String alamatlengkap,
    LatLng lokasiMakanan,
    String namaPembuat,
    String fotoPembuat,
    String hpPembuat,
    // int jumlahMakananDiPesan,
  ) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      _collectionReference.doc().set({
        // MAIN ID
        'idFood': idFood,
        'idUserPemesan': await MainSharedPreferences().getIdUser(),
        'idPembuatMakanan': idPembuatMakanan,
        'statusPemesanan': 'waiting',
        // 'jumlahMakananDiPesan': jumlahMakananDiPesan,
        // DATA FOOD
        'path_food_photo': pathFoodPhoto,
        'food_name': foodName,
        'jumlah_food': jumlahFood,
        'note': note,
        'desc': desc,
        'waktu_pengambilan': Timestamp.fromDate(waktuPengambilanFormatted),
        'waktu_penayangan': Timestamp.fromDate(waktuPenayanganFormatted),
        'alamat_lengkap': alamatlengkap,
        'lokasi_pengambil': GeoPoint(position.latitude, position.longitude),
        'lokasi_makanan':
            GeoPoint(lokasiMakanan.latitude, lokasiMakanan.longitude),
        // DATA YANG MESAN MAKANAN
        'nama_pemesan': await MainSharedPreferences().getUserFoto(),
        'foto_pemesan': await MainSharedPreferences().getUserFoto(),
        'hp_pemesan': await MainSharedPreferences().getHpUser(),

        // DATA YANG MEMBUAT MAKANAN
        'nama_pembuat': namaPembuat,
        'foto_pembuat': fotoPembuat,
        'hp_pembuat': hpPembuat,

        'created_at': Timestamp.now()
      });

      await FoodServices.changeStatusFood(idFood);
      print(_collectionReference.doc().id);
      // return _collectionReference.doc().id;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future getListFoodTransactionByPemesan(String idUser) async {
    try {
      _collectionReference
          .doc()
          .collection('users')
          .where('idUserPemesan', isEqualTo: '$idUser')
          .get();
    } catch (e) {}
  }

  static Future getListFoodTransactionByPembuatMakanan(
      String idFood, String idPembuatMakanan) async {
    try {
      _collectionReference
          .doc()
          .collection('users')
          .where('idFood', isEqualTo: '$idFood')
          .where('idUser', isEqualTo: '$idPembuatMakanan')
          .get();
    } catch (e) {}
  }
}
