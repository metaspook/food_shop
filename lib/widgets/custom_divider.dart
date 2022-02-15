import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, color: Colors.grey, thickness: 1);
}
