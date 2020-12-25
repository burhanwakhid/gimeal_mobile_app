import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/ui/page/makanan_page/detail_makanan.dart';
import 'package:gimeal/ui/page/people/people_profile_page.dart';
import 'package:gimeal/ui/shared/styles.dart';

class FoodTileBig extends StatefulWidget {
  const FoodTileBig({
    @required this.foodData,
  });

  final ListFoodModel foodData;

  @override
  _FoodTileBigState createState() => _FoodTileBigState();
}

class _FoodTileBigState extends State<FoodTileBig> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.foodData.fotoUser);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailMakanan(
                      listFoodModel: widget.foodData,
                    )));
      },
      splashColor: kMainColor.withOpacity(0.1),
      child: Card(
        elevation: 1.5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  '${widget.foodData.pathFoodPhoto}',
                  fit: BoxFit.cover,
                  height: 150,
                  width: MediaQuery.of(context).size.width - 20,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/user%2${widget.foodData.fotoUser}.png?alt=media',
                    ),
                  ),
                  title: Text(
                    widget.foodData.foodName,
                    style: TextStyling()
                      ..big()
                      ..bold(),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.foodData.namaUser,
                        style: kCardSubtitleTextStyle,
                      ),
                      Text(
                        widget.foodData.jarak,
                        style: kCardSubtitleTextStyle,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      Scaffold.of(context).showBottomSheet<void>(
                        (BuildContext context) {
                          return Material(
                            elevation: 20,
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Divider(
                                      thickness: 4,
                                      indent: 160,
                                      endIndent: 160,
                                    ),
                                    Divider(
                                      thickness: 4,
                                      indent: 160,
                                      endIndent: 160,
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routers.laporkan);
                                      },
                                      title: Text('Laporkan'),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PeopleProfile(
                                                      id: widget
                                                          .foodData.idUser,
                                                    )));
                                      },
                                      title: Text('Lihat Profile'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              right: 10,
              child: IconButton(
                icon: Icon(
                  !isFavorite ? Icons.favorite_outline : Icons.favorite,
                  size: 30,
                  color: !isFavorite ? Colors.black : Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
