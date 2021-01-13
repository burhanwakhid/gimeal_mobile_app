import 'package:flutter/material.dart';
import 'package:gimeal/ui/shared/styles.dart';

class BantuanPage extends StatefulWidget {
  @override
  _BantuanPageState createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Bantuan',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(40))),
                child: Image.asset('assets/Illustrasi/ilustrasi_1.png'),
              ),
              // buildItem(context, ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return buildItem(
                    context,
                    data[index]['title'],
                    data[index]['desc'],
                    data[index]['width'],
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
      BuildContext context, String title, String desc, double width) {
    return BuildItem(
      title: title,
      desc: desc,
      width: width,
    );
  }

  List data = [
    {
      'title': '1. Bagaimana cara mendapatkan makanan?',
      'width': 1.1,
      'desc':
          'Pertama, Anda memilih makanan terlebih dahulu, membaca deskripsi makanan dan alamat lengkap pengguna. Apabila sudah sesuai dengan keinginan Anda, maka Anda dapat memesan makanan tersebut.\n\nSetelah mendapatkan persetujuan dari pemberi donasi, maka Anda berhak mengambil makanan tersebut pada pemberi donasi.'
    },
    {
      'title': '2. Bagaimana cara mengunggah makanan?',
      'width': 1.15,
      'desc':
          'Anda harus mengisi formulir yang disediakan dan menyiapkan sebuah foto sebelum mengisi formulir. Berikut ini hal yang perlu diisi dalam formulir :\n- Nama makanan \n- Jumlah makanan \nKeterangan jumlah makanan yang akan didonasikan.\n- Deskripsi\nKeterangan yang berupa kondisi makanan yang akan didonasikan.\n- Waktu Pengambilan\nWaktu yang ditentukan donatur untuk penyalur yang akan mengambil makanan.\n- Waktu Penayangan\nSelang waktu unggahan makanan akan ditampilkan pada beranda aplikasi.\n- Alamat Lengkap\nBerisi nama jalan dan nomor rumah dari donatur makanan.'
    },
    {
      'title':
          '3. Apa yang akan terjadi ketika melaporkan pengguna yang melakukan tindakan diluar donasi?',
      'width': 1.2,
      'desc':
          'Apabila telah mendapatkan 5 kali laporan terkait tindakan pelanggaran, maka pengguna akan diberikan sanksi berupa penangguhan akun.  Serta, data dari pengguna akan masuk dalam daftar hitam.'
    },
    {
      'title':
          '4. Apa yang akan terjadi apabila makanan saya tidak ada yang mau mengambil?',
      'width': 1.25,
      'desc':
          'Sebelum mengunggah makanan, Anda mendapatkan formulir yang berisikan deskripsi detail dan waktu penayangan dari unggahan. Unggahan makanan akan ditayangkan sesuai dengan waktu yang ditentukan oleh pengguna.\n\nApabila tidak ada yang mengambil dalam jangka waktu penayangan, maka unggahan akan secara otomatis dihapuskan.'
    },
  ];
}

class BuildItem extends StatefulWidget {
  const BuildItem({
    Key key,
    @required this.width,
    @required this.title,
    @required this.desc,
  }) : super(key: key);
  final double width;
  final String title;
  final String desc;

  @override
  _BuildItemState createState() => _BuildItemState();
}

class _BuildItemState extends State<BuildItem> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.all(7.0),
            width: MediaQuery.of(context).size.width / widget.width,
            // height: 60,
            decoration: BoxDecoration(
              color: Color(0xffF2FFF4),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  offset: Offset(0, 0.5),
                  blurRadius: 1,
                )
              ],
            ),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            '• ' + widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff838683)),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).accentColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                isOpen ? Text(widget.desc) : Container(),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
