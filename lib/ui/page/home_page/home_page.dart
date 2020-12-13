import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gimeal/core/models/list_food_model.dart';
import 'package:gimeal/core/services/firebase_firestore/testing_service.dart';
import 'package:gimeal/core/store/upload_food_store.dart';
import 'package:gimeal/ui/widgets/FoodTileBig.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UploadFoodStore uploadFoodStore = UploadFoodStore();
  // ObservableFuture<List<ListFoodModel>> listFood;

  _getListFood() {
    uploadFoodStore.listFood();
    // listFood = uploadFoodStore.listFoodFuture;
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
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      //  floatingActionButton: FloatingActionButton(
      //   //  onPressed: () => Navigator.pushNamed(context, Routers.unggahMakanan),
      //    onPressed: () {
      //      Navigator.push(
      //        context,
      //        MaterialPageRoute(builder: (_) => TestListPage()),
      //      );
      //    },
      //    child: Icon(Icons.add),
      //  ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        children: [
          Observer(
            builder: (context) {
              final future = uploadFoodStore.listFoodFuture;
              final item = uploadFoodStore.listFoodFuture.value;
              switch (future.status) {
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
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return FoodTileBig(
                        foodData: item[index],
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
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Center(
        child: Text(
          'gimeal',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class TestListPage extends StatefulWidget {
  @override
  _TestListPageState createState() => _TestListPageState();
}

class _TestListPageState extends State<TestListPage> {
  List<TestModel> testModel = [];

  // get() async {
  //   await TestingService.getListFoodKedua();
  // }
  UploadFoodStore uploadFoodStore = UploadFoodStore();

  @override
  void initState() {
//    this.get();
    uploadFoodStore.listFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('coba'),
        onPressed: () {
          // this.get();
        },
      ),
      //  body: ListView.builder(
      //    itemCount: this.testModel.length,
      //    itemBuilder: (context, index) {
      //      return Column(
      //        children: [
      //          Text(this.testModel[index].namaUser),
      //          Text(this.testModel[index].namaMakanan),
      //        ],
      //      );
      //    },
      //  ),
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
