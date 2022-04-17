import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: context.watch<BottomNavController>().currentIndex,
      onTap: (newIndex) =>
          context.read<BottomNavController>().setIndex(newIndex),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          label: 'Shop',
          icon: Icon(FontAwesomeIcons.cartArrowDown),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(FontAwesomeIcons.solidUserCircle),
        ),
        BottomNavigationBarItem(
          label: 'My Orders',
          icon: Icon(FontAwesomeIcons.shippingFast),
        ),
        BottomNavigationBarItem(
          label: 'Setiings',
          icon: Icon(FontAwesomeIcons.cog),
        ),
      ],
    );
  }
}
