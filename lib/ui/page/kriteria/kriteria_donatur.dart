import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/ui/shared/styles.dart';

class DonaturPage extends StatelessWidget {
  final List<Map<String, dynamic>> content = [
    {
      "title": "Donatur individu",
      "content":
          "Pengguna yang memiliki sisa makanan setelah menyelenggarakan acara besar seperti penikahan, syukuran, hajatan, dan lail-lain. Serta pengguna yang memiliki kelebihan makanan dan bahan makanan.",
      "image": "assets/Illustrasi/illu_donatur_1.png",
    },
    {
      "title": "Pemilik Restoran",
      "content":
          "Pengguna yang merupakan pemilik restoran atau warung makan dapat menjadi donatur untuk mengurangi sampah makanan yang tidak terjual pada hari itu.",
      "image": "assets/Illustrasi/illu_donatur_2.png",
    },
    {
      "title": "Petani Sayur / Buah",
      "content":
          "Petani buah atau sayur yang memiliki hasil panen yang tidak sesuai dengan standar pasar atau supermarket.",
      "image": "assets/Illustrasi/illu_donatur_3.png",
    },
    {
      "title": "Pemilik Toko",
      "content":
          "Pengguna yang memiliki toko serba ada dan memiliki banyak produk - produk yang belum terjual serta produk tersebut hampir mendekati tanggal kadaluarsa.",
      "image": "assets/Illustrasi/illu_donatur_4.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kMainColor,
        leading: BackButton(
          color: Colors.white70,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: kMainColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Text(
                    "Kriteria Donatur",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kMainColor,
                    ),
                  ),
                  subtitle: Text(
                    "Sebelum melakukan donasi, pengguna yang ingin menjadi donatur harus memiliki   salah satu kriteria donatur aplikasi sebagai berikut :",
                    style: TextStyling()..small(),
                  ),
                  trailing: SizedBox(
                    width: MediaQuery.of(context).size.width * .10,
                  ),
                ),
                _buildDivider(),
                _buildDonaturCard(
                  title: content[0]["title"],
                  content: content[0]["content"],
                  image: content[0]["image"],
                  context: context,
                ),
                _buildDivider(),
                _buildDonaturCard(
                  title: content[1]["title"],
                  content: content[1]["content"],
                  image: content[1]["image"],
                  context: context,
                ),
                _buildDivider(),
                _buildDonaturCard(
                  title: content[2]["title"],
                  content: content[2]["content"],
                  image: content[2]["image"],
                  context: context,
                ),
                _buildDivider(),
                _buildDonaturCard(
                  title: content[3]["title"],
                  content: content[3]["content"],
                  image: content[3]["image"],
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      height: 50,
      color: Colors.transparent,
    );
  }

  Widget _buildDonaturCard(
      {String title, String content, String image, BuildContext context}) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.width * .4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: kMainColor.withOpacity(0.2)),
          child: Center(
            child: ListTile(
              title: Text(
                title,
                style: TextStyling(color: kMainColor)
                  ..bold()
                  ..big(),
              ),
              subtitle: Text(
                content,
                style: TextStyling()..tiny(),
              ),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * .25,
              ),
            ),
          ),
        ),
        Positioned(
          right: 2,
          child: Image.asset(
            image,
            height: MediaQuery.of(context).size.width * .45,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
