import 'package:flutter/material.dart';

class DashGrid extends StatelessWidget {
  const DashGrid(this.title, {Key? key, required this.items}) : super(key: key);

  ///* Takes key as item's title and key must contain count, icon and color.
  final Map<String, Map<String, dynamic>> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
        elevation: 10,
        color: Theme.of(context).colorScheme.secondary,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " $title",
                // textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
              ),
              GridView.builder(
                // padding: const EdgeInsets.all(8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // controller: Controller.scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 2100
                      ? 5
                      : size.width > 1900
                          ? 4
                          : size.width > 1500
                              ? 3
                              : size.width > 1100
                                  ? 2
                                  : 1,
                  mainAxisExtent: 110,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                      margin: const EdgeInsets.all(8),
                      color: Colors.grey.shade800,
                      elevation: 5,
                      child: ListTile(
                        title: Text(' ' + items.keys.elementAt(index),
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: size.width > 1900
                                  ? constraints.maxWidth / 45
                                  : size.width > 1500
                                      ? constraints.maxWidth / 40
                                      : size.width > 1100
                                          ? constraints.maxWidth / 30
                                          : constraints.maxWidth / 20,
                            )),
                        leading: Icon(
                          items[items.keys.elementAt(index)]!["icon"],
                          color: items[items.keys.elementAt(index)]!["color"],
                          size: size.width > 1900
                              ? constraints.maxWidth / 45
                              : size.width > 1500
                                  ? constraints.maxWidth / 40
                                  : size.width > 1100
                                      ? constraints.maxWidth / 30
                                      : constraints.maxWidth / 20,
                        ),
                        onTap: null,
                        trailing: FittedBox(
                          child: Text(
                            items[items.keys.elementAt(index)]!["count"]
                                .toString(),
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: size.width > 1900
                                  ? constraints.maxWidth / 45
                                  : size.width > 1500
                                      ? constraints.maxWidth / 40
                                      : size.width > 1100
                                          ? constraints.maxWidth / 30
                                          : constraints.maxWidth / 20,
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
