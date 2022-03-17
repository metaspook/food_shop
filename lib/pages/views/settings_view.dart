import 'package:flutter/material.dart';
import 'package:food_shop/utils/variable.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          color: Colors.white,
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: Variable.decoy,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Text(
                  'Settings: ' + Variable.decoy.value.toString(),
                  style: const TextStyle(fontSize: 35),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 75, right: 75),
          child: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              onPressed: () => Variable.decoy.value++),
        )
      ],
    );
  }
}
