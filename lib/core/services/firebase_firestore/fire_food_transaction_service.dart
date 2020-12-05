import 'package:cloud_firestore/cloud_firestore.dart';

class FireFoodTransactionService {
  static CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('food_transactions');

  static Future<void> saveTransactions(
    String idFood,
    String idUserPemesan,
    String status,
    // int jumlahMakananDiPesan,
  ) async {
    try {
      _collectionReference.doc().set({
        // MAIN ID
        'idFood': idFood,
        'idUserPemesan': idUserPemesan,
        'statusPemesanan': status,
        // 'jumlahMakananDiPesan': jumlahMakananDiPesan,
        'created_at': Timestamp.now()
      });
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
