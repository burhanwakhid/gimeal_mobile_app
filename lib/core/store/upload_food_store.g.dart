// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_food_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UploadFoodStore on _UploadFoodStore, Store {
  final _$listFoodFutureAtom = Atom(name: '_UploadFoodStore.listFoodFuture');

  @override
  ObservableFuture<List<ListFoodModel>> get listFoodFuture {
    _$listFoodFutureAtom.reportRead();
    return super.listFoodFuture;
  }

  @override
  set listFoodFuture(ObservableFuture<List<ListFoodModel>> value) {
    _$listFoodFutureAtom.reportWrite(value, super.listFoodFuture, () {
      super.listFoodFuture = value;
    });
  }

  final _$listFoodAsyncAction = AsyncAction('_UploadFoodStore.listFood');

  @override
  Future<void> listFood() {
    return _$listFoodAsyncAction.run(() => super.listFood());
  }

  final _$uploadFoodAsyncAction = AsyncAction('_UploadFoodStore.uploadFood');

  @override
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
      File image) {
    return _$uploadFoodAsyncAction.run(() => super.uploadFood(
        pathFoodPhoto,
        foodName,
        jmlFood,
        note,
        desc,
        waktuPengambilan,
        waktuPenayangan,
        alamatlengkap,
        currentPosition,
        image));
  }

  @override
  String toString() {
    return '''
listFoodFuture: ${listFoodFuture}
    ''';
  }
}
