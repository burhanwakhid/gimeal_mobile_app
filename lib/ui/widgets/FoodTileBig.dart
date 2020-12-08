import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/ui/page/makanan_page/detail_makanan.dart';
import 'package:gimeal/ui/shared/styles.dart';

class FoodTileBig extends StatelessWidget {
  const FoodTileBig({
    @required this.foodData,
  });

  final ListFoodModel foodData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
//        Navigator.pushNamed(context, '/detailMakanan',
//            arguments: DetailMakananArgs(listFoodModel: foodData));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailMakanan(
                      listFoodModel: foodData,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/foods%2F${foodData.pathFoodPhoto}.png?alt=media&token=8361f53e-acca-4cef-b5fc-024a9c228043',
              fit: BoxFit.cover,
              height: 150,
              width: MediaQuery.of(context).size.width - 20,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  'https://i.pinimg.com/474x/9c/e5/7f/9ce57f4e94275efb3a4a39c69297a9e4.jpg',
                ),
              ),
              title: Text(
                foodData.foodName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                foodData.pathFoodPhoto,
                style: kCardSubtitleTextStyle,
              ),
              trailing: Text(
                '800 m',
                style: kCardSubtitleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
