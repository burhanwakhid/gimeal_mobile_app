import 'package:latlong/latlong.dart';

class ListFoodTransactionModel {
  final String idTransaction;
  final String idFood;
  final String idUserPemesan;
  final String idPembuatMakanan;
  final String statusPemesanan;
  final String pathfoodphoto;
  final String foodName;
  final String jumlahFood;
  final String note;
  final String desc;
  final DateTime waktuPengambilan;
  final DateTime waktuPenayangan;
  final String alamatLengkap;
  final LatLng lokasiPengambil;
  final LatLng lokasiMakanan;
  final String namaPemesan;
  final String fotoPemesan;
  final String hpPemesan;
  final String namaPembuat;
  final String fotoPembuat;
  final String hpPembuat;
  final DateTime createdAt;

  ListFoodTransactionModel({
    this.idTransaction,
    this.idFood,
    this.idUserPemesan,
    this.idPembuatMakanan,
    this.statusPemesanan,
    this.pathfoodphoto,
    this.foodName,
    this.jumlahFood,
    this.note,
    this.desc,
    this.waktuPengambilan,
    this.waktuPenayangan,
    this.alamatLengkap,
    this.lokasiPengambil,
    this.lokasiMakanan,
    this.namaPemesan,
    this.fotoPemesan,
    this.hpPemesan,
    this.namaPembuat,
    this.fotoPembuat,
    this.hpPembuat,
    this.createdAt,
  });
}
