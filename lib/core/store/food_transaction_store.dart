import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:latlong/latlong.dart';
import 'package:mobx/mobx.dart';
part 'food_transaction_store.g.dart';

/// HOW TO USE
/// FoodTransactionStore foodTransactionStore = FoodTransactionStore();
/// await foodTransactionStore.saveTransaction(listFoodModel);

class FoodTransactionStore = _FoodTransactionStore with _$FoodTransactionStore;

abstract class _FoodTransactionStore with Store {
  @observable
  String idTransaction = '';
  // SAVE FOOD TRANSACTION
  @action
  Future<void> saveTransaction(ListFoodModel listFoodModel) async {
    try {
      idTransaction = await FireFoodTransactionService.saveTransactions(
        listFoodModel.idFood,
        listFoodModel.idUser,
        listFoodModel.pathFoodPhoto,
        listFoodModel.foodName,
        listFoodModel.jumlahFood.toString(),
        listFoodModel.note,
        listFoodModel.desc,
        listFoodModel.waktuPengambilan,
        listFoodModel.waktuPenayangan,
        listFoodModel.alamatLengkap,
        LatLng(listFoodModel.latitude, listFoodModel.longitude),
        listFoodModel.namaUser,
        listFoodModel.fotoUser,
        listFoodModel.hpUser,
        listFoodModel.rating,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
