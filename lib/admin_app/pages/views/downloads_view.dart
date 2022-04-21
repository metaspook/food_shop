import 'package:flutter/material.dart';

class DownloadsView extends StatelessWidget {
  const DownloadsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variable.decoy = "hey boy";
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: const [
        // Container(
        //   color: Colors.white,
        //   child: Center(
        //     child: ValueListenableBuilder(
        //       valueListenable: Variables.decoy,
        //       builder: (BuildContext context, int value, Widget? child) {
        //         return Text(
        //           'Downloads: ' + value.toString(),
        //           style: const TextStyle(fontSize: 35),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        // Padding(
        //     padding: const EdgeInsets.only(bottom: 75, right: 75),
        //     child: FloatingActionButton(
        //         child: Icon(
        //           Icons.add,
        //           color: Theme.of(context).scaffoldBackgroundColor,
        //         ),
        //         onPressed: () => Variables.decoy.value++)),
      ],
    );
  }
}
