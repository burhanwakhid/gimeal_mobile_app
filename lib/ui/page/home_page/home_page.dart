import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gimeal/config/routers.dart';
import 'package:gimeal/core/store/upload_food_store.dart';
import 'package:gimeal/ui/page/bottom_nav/bottom_nav_page.dart';
import 'package:gimeal/ui/widgets/FoodTileBig.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aplikasi Gimeal',
        ),
      ),
      floatingActionButton: FloatingActionButton(
            // onPressed: () => Navigator.pushNamed(context, Routers.unggahMakanan),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TestListPage()),
              );
            },
            child: Icon(Icons.add),
          ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        children: [
          ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return FoodTileBig();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

class TestListPage extends StatefulWidget {
  @override
  _TestListPageState createState() => _TestListPageState();
}

class _TestListPageState extends State<TestListPage> {
  UploadFoodStore uploadFoodStore = UploadFoodStore();
  @override
  void initState() {
    uploadFoodStore.listFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        final future = uploadFoodStore.listFoodFuture;
        switch (future.status) {
          case FutureStatus.pending:
            return Center(child: CircularProgressIndicator());
            break;
          case FutureStatus.fulfilled:
            final items = uploadFoodStore.listFoodFuture.value;
            return Center(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(items[i].foodName),
                        Text(items[i].jarak.toString()),
                        Image.network('https://firebasestorage.googleapis.com/v0/b/gimeal-a56d7.appspot.com/o/foods%2F${items[i].pathFoodPhoto}.png?alt=media&token=8361f53e-acca-4cef-b5fc-024a9c228043'),
                      ],
                    ),
                  );
                },
              ),
            );
            break;
          case FutureStatus.rejected:
            return Center(child: Text('gagal'));
            break;
          default:
            return Text('default');
            break;
        }
      }),
    );
  }
}
