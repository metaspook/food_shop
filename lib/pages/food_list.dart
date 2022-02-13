import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:food_shop/models/food.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  late final Future<List<Food>> futureFood;

  @override
  void initState() {
    super.initState();
    futureFood = _fetchFood();
  }

  @override
  Widget build(BuildContext context) {
    // var rand = Random();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Food>>(
        future: futureFood,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          '${snapshot.data![index].id}. ${snapshot.data![index].name}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Flexible(
                          child: Image.network(
                            snapshot.data![index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // SizedBox(width: 5),
                            Text(
                              '\$${Random().nextInt(100)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            // SizedBox(width: 25),
                            Row(
                              children: [
                                IconButton(
                                  // padding: EdgeInsets.all(1),
                                  onPressed: null,
                                  icon: Icon(CupertinoIcons.cart_badge_plus,
                                      color: Colors.cyan),
                                ),
                                IconButton(
                                  // padding: EdgeInsets.all(1),
                                  onPressed: null,
                                  icon: Icon(
                                    CupertinoIcons.cart_badge_minus,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

// 'https://raw.githubusercontent.com/metaspook/json_api/main/json/foods.json'

Future<List<Food>> _fetchFood() async {
  final response = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/metaspook/json_api/main/json/foods.json'));

  if (response.statusCode == 200) {
    return [
      for (Map<String, dynamic> i in jsonDecode(response.body)) Food.fromJson(i)
    ];
  } else {
    throw Exception('Failed to fetch data!');
  }
}
