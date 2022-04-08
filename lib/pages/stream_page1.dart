import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_shop/controllers/counter_provider.dart';
import 'package:food_shop/pages/stream_page2.dart';
import 'package:provider/provider.dart';

class StreamPage1 extends StatelessWidget {
  StreamPage1({Key? key}) : super(key: key);
  int counter = 0;
  StreamController<int> counterController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              context.read<Counter>().increment();
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StreamPage2()));
            },
            child: const Icon(Icons.fork_right_sharp),
          ),
        ],
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
