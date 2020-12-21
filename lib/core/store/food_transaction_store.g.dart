// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_transaction_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FoodTransactionStore on _FoodTransactionStore, Store {
  final _$idTransactionAtom = Atom(name: '_FoodTransactionStore.idTransaction');

  @override
  String get idTransaction {
    _$idTransactionAtom.reportRead();
    return super.idTransaction;
  }

  @override
  set idTransaction(String value) {
    _$idTransactionAtom.reportWrite(value, super.idTransaction, () {
      super.idTransaction = value;
    });
  }

  final _$saveTransactionAsyncAction =
      AsyncAction('_FoodTransactionStore.saveTransaction');

  @override
  Future<void> saveTransaction(ListFoodModel listFoodModel) {
    return _$saveTransactionAsyncAction
        .run(() => super.saveTransaction(listFoodModel));
  }

  @override
  String toString() {
    return '''
idTransaction: ${idTransaction}
    ''';
  }
}
