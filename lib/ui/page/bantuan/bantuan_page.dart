import 'package:flutter/material.dart';
import 'package:gimeal/ui/shared/styles.dart';

class BantuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'Bantuan',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FAQ',
                style: kTitleStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '1. Apakah makanan didapatkan secara gratis?',
                style: kSubtitleStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Ya. Anda akan mendapatkan makanan secara gratis yang ditampilkan pada beranda aplikasi.',
                  style: kCardTextStyle,
                ),
              ),
              Text(
                '2. Bagaimana cara mendapatkan makanan pada aplikasi Gimeal?',
                style: kSubtitleStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Pertama, Anda memilih makanan terlebih dahulu, membaca deskripsi makanan dan alamat lengkap pengguna. Apabila sudah sesuai dengan keinginan Anda, maka Anda dapat memesan makanan tersebut.',
                  style: kCardTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Setelah mendapatkan persetujuan dari pemberi donasi, maka Anda berhak mengambil makanan tersebut pada pemberi donasi.',
                  style: kCardTextStyle,
                ),
              ),
              Text(
                '3. Bagaimana cara melakukan donasi pada aplikasi Gimeal?',
                style: kSubtitleStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Apabila Anda memiliki makanan yang ingin dibagikan kepada orang lain, Anda dapat mengunggah gambar beserta deskripsi makanan yang sesuai dengan kondisi makanan tersebut. Serta, memberikan alamat lengkap sebagai titik penjemputan makanan oleh penerima donasi.',
                  style: kCardTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Setelah Anda selesai mengunggah, Anda akan menunggu penerima untuk mengambil makanan dan menerima notifikasi berupa persetujuan untuk memberikan makanan kepada penerima tersebut. Penerima akan mengambil donasi pada lokasi yang telah Anda cantumkan. Setelah donasi selesai, maka penerima akan memberikan penilaian kepada Anda.',
                  style: kCardTextStyle,
                ),
              ),
              Text(
                '4. Apa yang akan terjadi ketika melaporkan pengguna yang melakukan tindakan diluar donasi?',
                style: kSubtitleStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Apabila telah mendapatkan 5 kali laporan terkait tindakan pelanggaran, maka pengguna akan diberikan sanksi berupa penangguhan akun.  Serta, data dari pengguna akan masuk dalam daftar hitam.',
                  style: kCardTextStyle,
                ),
              ),
              Text(
                '5. Apa yang akan terjadi apabila makanan saya tidak ada yang mau mengambil?',
                style: kSubtitleStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Sebelum mengunggah makanan, Anda mendapatkan formulir yang berisikan deskripsi detail dan waktu penayangan dari unggahan. Unggahan makanan akan ditayangkan sesuai dengan waktu yang ditentukan oleh pengguna.',
                  style: kCardTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Text(
                  'Apabila tidak ada yang mengambil dalam jangka waktu penayangan, maka unggahan akan secara otomatis dihapuskan.',
                  style: kCardTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
