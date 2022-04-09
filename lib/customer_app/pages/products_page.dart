import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/utils/variable.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);
  int count = 0;
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        title = (count++).toString();
        // print('Increment++');
      }),
      body: StreamBuilder<DatabaseEvent>(
          stream: Variable.dbRealtime.ref("products").onValue,
          builder: (context, snapshot) {
            final ff =
                snapshot.data!.snapshot.children.elementAt(0).value as Map;
            final Map<String, dynamic> gg = {};
            for (var item in ff.entries) {
              gg[item.key] = item.value;
            }
            print(gg.runtimeType);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Column(
                  children: [
                    Text('data'),
                    Flexible(
                        child: Image.asset(
                            "assets/images/placeholder_user_00.jpg")),
                    // CachedNetworkImage(
                    //     imageUrl: "assets/images/placeholder_user_00.jpg"),
                    Text('Price'),
                  ],
                ));
              },
            );
          }),
    );
  }
}
