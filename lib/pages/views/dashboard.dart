import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final List<Map<String, dynamic>> gridInfoList;
  @override
  void initState() {
    super.initState();
    gridInfoList = [
      {
        "title": "Users",
        "count": Constant.userList.length,
        "icon": Icons.supervised_user_circle_sharp
      },
      {"title": "Orders", "count": 20, "icon": Icons.file_copy},
      {"title": "Pending", "count": 45, "icon": Icons.access_alarms_sharp},
      {"title": "Confirmed", "count": 36, "icon": Icons.done_outline_rounded}
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: GridView.builder(
        controller: Controller.scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width > 600 ? 4 : 2,
          childAspectRatio: 2,
        ),
        itemCount: gridInfoList.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 5,
              // shadowColor: Colors.black,
              // color: Colors.white54,
              child: ListTile(
                // contentPadding: EdgeInsetsGeometry.infinity,
                // visualDensity:
                //     VisualDensity.adaptivePlatformDensity,
                title: Text(
                  gridInfoList[index]["title"],
                  style: Theme.of(context).textTheme.headline4,
                ),

                leading: Icon(
                  gridInfoList[index]["icon"],
                  color: Theme.of(context).colorScheme.secondary,
                  size: size.width * 0.05,
                ),
                onTap: null,
                trailing: Text(
                  gridInfoList[index]["count"].toString(),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: size.width > 600 ? 50 : 25,
                      ),
                ),
              ));
        },
      ),
    );
  }
}
