import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/store/upload_food_store.dart';
import 'package:gimeal/ui/widgets/FoodTileBig.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UploadFoodStore uploadFoodStore = UploadFoodStore();
  ObservableFuture<List<ListFoodModel>> listFood;

  _getListFood() {
    uploadFoodStore.listFood();
    listFood = uploadFoodStore.listFoodFuture;
  }

  @override
  void initState() {
    this._getListFood();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () => Navigator.pushNamed(context, Routers.unggahMakanan),
//        // onPressed: () {
//        //   Navigator.push(
//        //     context,
//        //     MaterialPageRoute(builder: (_) => TestListPage()),
//        //   );
//        // },
//        child: Icon(Icons.add),
//      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        children: [
          Observer(
            builder: (context) {
              switch (listFood.status) {
                case FutureStatus.pending:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case FutureStatus.rejected:
                  return Center(child: Text('gagal'));
                  break;
                case FutureStatus.fulfilled:
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listFood.value.length,
                    itemBuilder: (context, index) {
                      return FoodTileBig(
                        foodData: listFood.value[index],
                      );
                    },
                  );
                  break;
                default:
                  return Center(child: Text('gagal'));
                  break;
              }
            },
          ),
//          ListView.separated(
//            separatorBuilder: (context, index) {
//              return SizedBox(
//                height: 10,
//              );
//            },
//            physics: NeverScrollableScrollPhysics(),
//            shrinkWrap: true,
//            itemCount: 10,
//            itemBuilder: (context, index) {
//              return FoodTileBig();
//            },
//          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Aplikasi Gimeal',
      ),
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
