import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/variable.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // createData();
    // readData();
    return Container(
      color: Colors.white,
      child: Center(
        child: StreamBuilder<DatabaseEvent>(
            stream: Variable.dbRealtime.ref("users").onValue,
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                final tmpUserList = List.generate(
                    snapshot.data!.snapshot.children.length,
                    (index) => User.fromJson(snapshot.data!.snapshot.children
                        .elementAt(index)
                        .value as Map<String, dynamic>));
                if (Variable.userList != tmpUserList) {
                  Variable.userList = tmpUserList;
                }
                return LayoutBuilder(builder: (context, constraints) {
                  return snapshot.data!.snapshot.value == null
                      ? Text(
                          'No Users!',
                          style: Theme.of(context).textTheme.headline3,
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(5),
                          controller: Controller.scroll,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: size.width > 1900
                                ? 4
                                : size.width > 1500
                                    ? 3
                                    : size.width > 1100
                                        ? 2
                                        : 1,
                            mainAxisExtent: 125,
                            // size.width > 1500
                            //     ? 3
                            //     : size.width > 1100
                            //         ? 2
                            //         : 1,
                            // childAspectRatio: 4.5
                            // childAspectRatio: size.width > 1500
                            //     ? (constraints.maxWidth / 375)
                            //     : size.width > 1100
                            //         ? (constraints.maxWidth / 215)
                            //         : (constraints.maxWidth / 115),
                          ),
                          itemCount: Variable.userList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(5),
                              child: ListTile(
                                // contentPadding: EdgeInsets.symmetric(
                                //     horizontal: 5, vertical: 5),
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                title: Text(
                                  Variable.userList[index].fullName,
                                  // Constant.userList[index]["fullName"],
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Address: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: Variable
                                                  .userList[index].address,
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Phone: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: Variable
                                                  .userList[index].phone,
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Email: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: Variable
                                                  .userList[index].email,
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'ID: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: Variable.userList[index].id,
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxHeight: 50, maxWidth: 50),
                                  child: CachedNetworkImage(
                                    httpHeaders: const {
                                      "Content-Type": "image/jpeg"
                                    },
                                    imageUrl: Variable.userList[index].image ??
                                        "assets/images/placeholder_user_00.jpg",
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        LinearProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error_outline),
                                  ),
                                ),
                                onTap: null,
                                trailing: IconButton(
                                  icon:
                                      const Icon(Icons.delete_forever_outlined),
                                  onPressed: () async {
                                    // print(snapshot.data == null);
                                    // ? setState(() {})
                                    // :
                                    await Variable.dbRealtime
                                        .ref(
                                            "users/${snapshot.data!.snapshot.children.elementAt(index).key}")
                                        .remove();
                                    await Variable.fbStorage
                                        .ref(
                                            "images/users/${snapshot.data!.snapshot.children.elementAt(index).key}.jpg")
                                        .delete();
                                  },
                                ),
                              ),
                            );
                          },
                        );
                });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator.adaptive();

              //   } else {
              //     return const Center(
              //       child: Text('There is no tasks'),
              //     );
              //   }
              // } else if (snapshot.connectionState ==
              //     ConnectionState.waiting) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              // return const Center(
              //   child: Text(
              //     'Something went wrong',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold, fontSize: 30),
              //   ),
              // );
            }),
      ),
    );
  }
}

// late final Map<String, dynamic> ff;
// StreamSubscription<DatabaseEvent> readData() async {
//   return Variable.dbRealtime.child("users").onValue;
//   // ((DatabaseEvent event) =>

//   // print(User.fromJson(
//   //         event.snapshot.children.first.value as Map<String, dynamic>)
//   //     .email));
// }

void createData() {
  Constant.userList.forEach((element) {
    Variable.dbRealtime.ref("users").push().set(element);
  });
}

void writeData() async {
  Variable.dbRealtime
      .ref("users")
      .onValue
      .listen((DatabaseEvent event) => print(event.snapshot.value));
}
// final event = await Variable.dbRealtime
//     .once(DatabaseEventType.value)
//     .then((value) => print(value.snapshot.value));
// final username = event.snapshot.value ?? 'Anonymous';
// print(event.snapshot.value ?? 'Anonymous');

// await Variable.dbRealtime.once(DatabaseEventType.value).then((DataSnapshot snapshot) {
//   print(snapshot.value??"");
// });
// }
