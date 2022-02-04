import 'package:flutter/material.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Column(
              children: [
                Flexible(
                  child: Image.network(
                    'https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'item $index',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
