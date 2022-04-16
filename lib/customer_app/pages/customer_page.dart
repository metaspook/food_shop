import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavController = context.watch<BottomNavController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text('Food Shop'),
        actions: const [CartBadge()],
      ),
      body: bottomNavController.currentView,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
