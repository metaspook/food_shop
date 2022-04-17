import 'package:flutter/material.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'My Orders',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
