import 'package:gimeal/core/services/firebase_firestore/fire_food_transaction_service.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:mobx/mobx.dart';
part 'food_transaction_store.g.dart';

class FoodTransactionStore = _FoodTransactionStore with _$FoodTransactionStore;

abstract class _FoodTransactionStore with Store {

  // SAVE FOOD TRANSACTION
  @action
  Future<void> saveTransaction(String idFood) async {
    try {
      await FireFoodTransactionService.saveTransactions(
        idFood,
        await MainSharedPreferences().getIdUser(),
        'Not Accepted',
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
