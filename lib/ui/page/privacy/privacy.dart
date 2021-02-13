import 'package:flutter/material.dart';
import 'package:gimeal/ui/shared/styles.dart';

class PrivacyPage extends StatelessWidget {
  final List<Map<String, dynamic>> content = [
    {
      "title":
          "Panduan Lengkap untuk Menjaga Keamanan Pengguna Aplikasi Donasi Yuk",
      "content":
          "Pengguna, keamanan dan keselamatan Anda merupakan prioritas utama kami. Dalam menanggulangi upaya tindakan penyalahgunaan aplikasi, berikut ini merupakan hal - hal yang perlu diketahui :",
    },
    {
      "title": "Donatur Individu",
      "content":
          "Bagi pengguna yang merupakan Donatur Individu, untuk mengurangi laporan tidak enak dari penerima donasi. Harap menyiapkan peralatan atau wadah makanan yang layak untuk donasi. Pelajari makanan yang layak untuk diletakkan pada wadah berbahan dasar plastik, kertas, dan lain - lain.",
    },
    {
      "title": "Pemilik Restoran/Warung",
      "content":
          "Untuk pemilik usaha industri makanan, perhatikan makanan yang masih layak untuk didonasikan kepada penerima donasi. Dalam pengunggahan makanan, pengguna harus mengutamakan waktu donasi, minimal satu jam sebelum restoran/warung tutup agar penerima donasi mudah mengambil makanan tersebut",
    },
    {
      "title": "Petani Sayur/Buah",
      "content":
          "Sayur dan Buah hasil panen yang tidak sesuai dengan standar pasar dapat digunakan sebagai bahan donasi kepada penerima yang membutuhkan. Petani harus memilah mana sayur dan buah yang masih layak untuk dikonsumsi dan tidak memberikan sayur atau buah yang busuk.",
    },
    {
      "title": "Pemilik Toko ",
      "content":
          "Pemilik Toko dapat memberikan produk - produk makanan yang tidak terjual kepada konsumen, namun tetap memperhatikan tanggal kadaluarsa dari produk tersebut. Produk yang dapat didonasikan maksimal memiliki tanggal kadaluarsa sebulan sebelum masa tenggang.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: BackButton(
          color: Colors.grey,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Keamanan Privasi",
          style: TextStyling(color: Colors.grey)
            ..bold()
            ..big(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.transparent,
            );
          },
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: content.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                content[index]["title"],
                style: TextStyling()..bold(),
              ),
              subtitle: Text(
                content[index]["content"],
                style: TextStyling(color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}
