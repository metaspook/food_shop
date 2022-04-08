import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_shop/controllers/counter_provider.dart';
import 'package:provider/provider.dart';

class StreamPage2 extends StatelessWidget {
  StreamPage2({Key? key}) : super(key: key);
  int counter = 0;
  StreamController<int> counterController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Counter>().increment();
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(child: Count()),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<Counter>().count.toString(),
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
