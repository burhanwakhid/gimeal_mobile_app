import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gimeal/core/models/list_food_transaction_model.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_service.dart';
import 'package:latlong/latlong.dart';

class FireFoodTransactionService {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('food_transactions');

  static Future<String> saveTransactions(
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
    int rating,
    // int jumlahMakananDiPesan,
  ) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      DocumentReference docReference = _collectionReference.doc();
      docReference.set({
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
        'rating': rating,
        // DATA YANG MESAN MAKANAN
        'nama_pemesan': await MainSharedPreferences().getUserName(),
        'foto_pemesan': await MainSharedPreferences().getUserFoto(),
        'hp_pemesan': await MainSharedPreferences().getHpUser(),

        // DATA YANG MEMBUAT MAKANAN
        'nama_pembuat': namaPembuat,
        'foto_pembuat': fotoPembuat,
        'hp_pembuat': hpPembuat,

        'created_at': Timestamp.now()
      });

      await FoodServices.changeStatusFood(idFood, 'taken');
      print('test lur : bikin simpen transaksi');
      print(docReference.id);
      return docReference.id;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future changeStatusFoodTransaction(
      String idFoodTransaction, String status) async {
    try {
      _collectionReference.doc(idFoodTransaction).update({
        'statusPemesanan': status,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future batalkanPesanan(String idFoodTransaction, String idFood) async {
    try {
      await changeStatusFoodTransaction(idFoodTransaction, 'rejected');
      await FoodServices.changeStatusFood(idFood, 'available');
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<ListFoodTransactionModel>> getRiwayatTransaction(
      String idUser) async {
    try {
      var a = await getListFoodTransactionByPembuatMakanan(idUser);
      var b = await getListFoodTransactionByPemesan(
          idUser, ['waiting', 'available', 'accepted', 'done']);

      List<ListFoodTransactionModel> allData = [];
      allData.addAll(a);
      allData.addAll(b);

      allData.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      allData.removeWhere((element) => element.statusPemesanan != 'done');
      print(allData);
      return allData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<ListFoodTransactionModel>> getUserOrderOnProgress(
      String idUser) async {
    try {
      var a = await getListFoodTransactionByPembuatMakanan(idUser);

      List<ListFoodTransactionModel> allData = [];
      allData.addAll(a);
      print(allData.first.toString());
      allData.removeWhere((element) =>
          ['rejected', 'done', 'deleted'].contains(element.statusPemesanan));

      return allData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<ListFoodTransactionModel>> getListFoodTransactionByPemesan(
      String idUser, List<String> filter) async {
    try {
      QuerySnapshot snapshot = await _collectionReference
          .where('idUserPemesan', isEqualTo: idUser)
          .where('statusPemesanan', whereIn: filter)
          .get();
      var documents = snapshot.docs;
      List<ListFoodTransactionModel> list = [];
      documents.forEach((doc) {
        Map<String, dynamic> d = doc.data();
        list.add(
          ListFoodTransactionModel(
            idTransaction: doc.id,
            idFood: d['idFood'],
            idUserPemesan: d['idUserPemesan'],
            idPembuatMakanan: d['idPembuatMakanan'],
            statusPemesanan: d['statusPemesanan'],
            pathfoodphoto: d['path_food_photo'],
            foodName: d['food_name'],
            jumlahFood: d['jumlah_food'],
            note: d['note'],
            desc: d['desc'],
            waktuPengambilan: (d['waktu_pengambilan'] as Timestamp).toDate(),
            waktuPenayangan: (d['waktu_penayangan'] as Timestamp).toDate(),
            alamatLengkap: d['alamat_lengkap'],
            lokasiPengambil: LatLng(
                (d['lokasi_pengambil'] as GeoPoint).latitude,
                (d['lokasi_pengambil'] as GeoPoint).longitude),
            lokasiMakanan: LatLng((d['lokasi_makanan'] as GeoPoint).latitude,
                (d['lokasi_makanan'] as GeoPoint).longitude),
            namaPemesan: d['nama_pemesan'],
            fotoPemesan: d['foto_pemesan'],
            hpPemesan: d['hp_pemesan'],
            namaPembuat: d['nama_pembuat'],
            fotoPembuat: d['foto_pembuat'],
            hpPembuat: d['hp_pembuat'],
            createdAt: (d['created_at'] as Timestamp).toDate(),
            rating: d['rating'],
          ),
        );
      });
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<ListFoodTransactionModel>>
      getListFoodTransactionByPembuatMakanan(String idPembuatMakanan) async {
    try {
      QuerySnapshot snapshot = await _collectionReference
          .where('idPembuatMakanan', isEqualTo: idPembuatMakanan)
          .get();
      var documents = snapshot.docs;
      List<ListFoodTransactionModel> list = [];
      final Distance distance = new Distance();
      documents.forEach((doc) {
        Map<String, dynamic> d = doc.data();
        double jrk = distance(
            new LatLng((d['lokasi_pengambil'] as GeoPoint).latitude,
                (d['lokasi_pengambil'] as GeoPoint).longitude),
            new LatLng((d['lokasi_makanan'] as GeoPoint).latitude,
                (d['lokasi_makanan'] as GeoPoint).longitude));

        String jarakFormatted = '';

        if (jrk < 1000) {
          jarakFormatted = '${jrk.toString()} m';
        } else {
          jarakFormatted = '${jrk.toString().substring(0, 3)} km';
        }
        list.add(
          ListFoodTransactionModel(
            idTransaction: doc.id,
            idFood: d['idFood'],
            idUserPemesan: d['idUserPemesan'],
            idPembuatMakanan: d['idPembuatMakanan'],
            statusPemesanan: d['statusPemesanan'],
            pathfoodphoto: d['path_food_photo'],
            foodName: d['food_name'],
            jumlahFood: d['jumlah_food'],
            note: d['note'],
            desc: d['desc'],
            waktuPengambilan: (d['waktu_pengambilan'] as Timestamp).toDate(),
            waktuPenayangan: (d['waktu_penayangan'] as Timestamp).toDate(),
            alamatLengkap: d['alamat_lengkap'],
            lokasiPengambil: LatLng(
                (d['lokasi_pengambil'] as GeoPoint).latitude,
                (d['lokasi_pengambil'] as GeoPoint).longitude),
            lokasiMakanan: LatLng((d['lokasi_makanan'] as GeoPoint).latitude,
                (d['lokasi_makanan'] as GeoPoint).longitude),
            namaPemesan: d['nama_pemesan'],
            fotoPemesan: d['foto_pemesan'],
            hpPemesan: d['hp_pemesan'],
            namaPembuat: d['nama_pembuat'],
            fotoPembuat: d['foto_pembuat'],
            hpPembuat: d['hp_pembuat'],
            createdAt: (d['created_at'] as Timestamp).toDate(),
            rating: d['rating'],
            jarak: jarakFormatted,
          ),
        );
      });
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<ListFoodTransactionModel>> getListNotification(
      String idPembuatMakanan) async {
    try {
      QuerySnapshot snapshot = await _collectionReference
          .where('idPembuatMakanan', isEqualTo: idPembuatMakanan)
          .where('statusPemesanan', isEqualTo: 'waiting')
          .get();
      var documents = snapshot.docs;
      final Distance distance = new Distance();
      List<ListFoodTransactionModel> list = [];

      documents.forEach((doc) {
        Map<String, dynamic> d = doc.data();
        double jrk = distance(
            new LatLng((d['lokasi_pengambil'] as GeoPoint).latitude,
                (d['lokasi_pengambil'] as GeoPoint).longitude),
            new LatLng((d['lokasi_makanan'] as GeoPoint).latitude,
                (d['lokasi_makanan'] as GeoPoint).longitude));

        String jarakFormatted = '';

        if (jrk < 1000) {
          jarakFormatted = '${jrk.toString()} m';
        } else {
          jarakFormatted = '${jrk.toString().substring(0, 3)} km';
        }
        list.add(
          ListFoodTransactionModel(
            idTransaction: doc.id,
            idFood: d['idFood'],
            idUserPemesan: d['idUserPemesan'],
            idPembuatMakanan: d['idPembuatMakanan'],
            statusPemesanan: d['statusPemesanan'],
            pathfoodphoto: d['path_food_photo'],
            foodName: d['food_name'],
            jumlahFood: d['jumlah_food'],
            note: d['note'],
            desc: d['desc'],
            waktuPengambilan: (d['waktu_pengambilan'] as Timestamp).toDate(),
            waktuPenayangan: (d['waktu_penayangan'] as Timestamp).toDate(),
            alamatLengkap: d['alamat_lengkap'],
            lokasiPengambil: LatLng(
                (d['lokasi_pengambil'] as GeoPoint).latitude,
                (d['lokasi_pengambil'] as GeoPoint).longitude),
            lokasiMakanan: LatLng((d['lokasi_makanan'] as GeoPoint).latitude,
                (d['lokasi_makanan'] as GeoPoint).longitude),
            namaPemesan: d['nama_pemesan'],
            fotoPemesan: d['foto_pemesan'],
            hpPemesan: d['hp_pemesan'],
            namaPembuat: d['nama_pembuat'],
            fotoPembuat: d['foto_pembuat'],
            hpPembuat: d['hp_pembuat'],
            createdAt: (d['created_at'] as Timestamp).toDate(),
            jarak: jarakFormatted,
            rating: d['rating'],
          ),
        );
      });
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<ListFoodTransactionModel> getDetailTransaction(
      String idTransaction) async {
    DocumentSnapshot snapshot =
        await _collectionReference.doc(idTransaction).get();
    var d = snapshot.data();
    var data = ListFoodTransactionModel(
      idTransaction: idTransaction,
      idFood: d['idFood'],
      idUserPemesan: d['idUserPemesan'],
      idPembuatMakanan: d['idPembuatMakanan'],
      statusPemesanan: d['statusPemesanan'],
      pathfoodphoto: d['path_food_photo'],
      foodName: d['food_name'],
      jumlahFood: d['jumlah_food'],
      note: d['note'],
      desc: d['desc'],
      waktuPengambilan: (d['waktu_pengambilan'] as Timestamp).toDate(),
      waktuPenayangan: (d['waktu_penayangan'] as Timestamp).toDate(),
      alamatLengkap: d['alamat_lengkap'],
      lokasiPengambil: LatLng((d['lokasi_pengambil'] as GeoPoint).latitude,
          (d['lokasi_pengambil'] as GeoPoint).longitude),
      lokasiMakanan: LatLng((d['lokasi_makanan'] as GeoPoint).latitude,
          (d['lokasi_makanan'] as GeoPoint).longitude),
      namaPemesan: d['nama_pemesan'],
      fotoPemesan: d['foto_pemesan'],
      hpPemesan: d['hp_pemesan'],
      namaPembuat: d['nama_pembuat'],
      fotoPembuat: d['foto_pembuat'],
      hpPembuat: d['hp_pembuat'],
      createdAt: (d['created_at'] as Timestamp).toDate(),
      rating: d['rating'],
    );
    return data;
  }
}
