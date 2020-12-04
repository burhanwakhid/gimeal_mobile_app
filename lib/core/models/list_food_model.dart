class ListFoodModel {
  final String idUser;
  final String pathFoodPhoto;
  final String foodName;
  final int jumlahFood;
  final String note;
  final String desc;
  final DateTime waktuPengambilan;
  final DateTime waktuPenayangan;
  final String alamatLengkap;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  ListFoodModel(
      {this.idUser,
      this.pathFoodPhoto,
      this.foodName,
      this.jumlahFood,
      this.note,
      this.desc,
      this.waktuPengambilan,
      this.waktuPenayangan,
      this.alamatLengkap,
      this.latitude,
      this.longitude,
      this.createdAt});
}
