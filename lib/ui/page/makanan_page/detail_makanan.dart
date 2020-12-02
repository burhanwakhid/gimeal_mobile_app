import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gimeal/ui/shared/styles.dart';

class DetailMakanan extends StatefulWidget {
  @override
  _DetailMakananState createState() => _DetailMakananState();
}

class _DetailMakananState extends State<DetailMakanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Burger Kadal Gurun',
          overflow: TextOverflow.ellipsis,
          style: TextStyling()
            ..big()
            ..bold(),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Material(
            elevation: 2,
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/1200px-RedDot_Burger.jpg',
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  'https://i.pinimg.com/474x/9c/e5/7f/9ce57f4e94275efb3a4a39c69297a9e4.jpg',
                ),
              ),
              title: Text(
                'Salsabila Deanya R',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '16.00 - 18.00 pm',
                style: kCardSubtitleTextStyle,
              ),
              trailing: Text(
                '800 m',
                style: kCardSubtitleTextStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _foodInfoTile(name: 'Jumlah Makanan', value: '5 buah'),
                _foodInfoTile(
                    name: 'Deskripsi',
                    value:
                        'Olahan telur tersebut merupakan sisa makanan dari katering '
                        'di salah satu acara pernikahan. Makanan tersebut baru dimasak tadi pagi jam 5'),
                _foodInfoTile(
                    name: 'Alamat lengkap',
                    value: 'Jl. Bhaskara Barat Blok A No 6.'),
                _foodInfoTile(name: 'Lokasi Penjemputan', value: ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _foodInfoTile({
    @required String name,
    @required String value,
  }) {
    return ListTile(
      title: Text(
        '$name :',
        style: TextStyling()..bold(),
      ),
      subtitle: Text(
        value,
        style: kCardSubtitleTextStyle,
      ),
    );
  }
}
