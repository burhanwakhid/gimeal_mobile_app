import 'package:flutter/material.dart';
import 'package:gimeal/ui/shared/styles.dart';

class FoodTileBig extends StatelessWidget {
  const FoodTileBig({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/1200px-RedDot_Burger.jpg',
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
              'Burger Kadal Gurun',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Bambang Ultraviolet, S.Pok',
              style: kCardSubtitleTextStyle,
            ),
            trailing: Text(
              '800 m',
              style: kCardSubtitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
