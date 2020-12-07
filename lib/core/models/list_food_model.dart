class ListFoodModel {
  final String idFood;
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
  final String jarak;
  final String namaUser;
  final String hpUser;
  final String fotoUser;
  final DateTime createdAt;

  ListFoodModel({
    this.idFood,
    this.idUser,
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
    this.namaUser,
    this.fotoUser,
    this.hpUser,
    this.jarak,
    this.createdAt,
  });
}
