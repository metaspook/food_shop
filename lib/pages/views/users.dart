import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
      child: Constant.userList.isEmpty
          ? Center(
              child: Text(
                'No user!',
                style: Theme.of(context).textTheme.headline3,
              ),
            )
          : Center(
              child: StreamBuilder<DatabaseEvent>(
                  stream: Variable.dbRealtime.ref("users").onValue,
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      Variable.userList = List.generate(
                        snapshot.data!.snapshot.children.length,
                        (index) => User.fromJson(snapshot
                            .data!.snapshot.children
                            .elementAt(index)
                            .value as Map<String, dynamic>),
                      );
                      // print(Variable.userList);
                      return GridView.builder(
                        controller: Controller.scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 600 ? 4 : 2,
                          childAspectRatio: 2,
                        ),
                        itemCount: Variable.userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                              elevation: 2.5,
                              child: ListTile(
                                // contentPadding: EdgeInsetsGeometry.infinity,
                                // visualDensity:
                                //     VisualDensity.adaptivePlatformDensity,
                                title: Text(
                                  Variable.userList[index].fullName,
                                  // Constant.userList[index]["fullName"],
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                subtitle: Text(
                                  Variable.userList[index].email,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                leading: Image.asset(
                                    'assets/images/placeholder_user_00.jpg'),
                                onTap: null,
                                trailing: IconButton(
                                  icon: Icon(Icons.delete_forever_outlined),
                                  onPressed: () => setState(() {
                                    // createData();
                                    Variable.dbRealtime
                                        .ref(
                                            "users/${snapshot.data!.snapshot.children.elementAt(index).key}")
                                        .remove();

                                    // Variable.dbRealtime
                                    //     .ref("users")
                                    //     .get()
                                    //     .then((value) {
                                    //   Variable.dbRealtime
                                    //       .ref(
                                    //           "users/${value.children.elementAt(index).key}")
                                    //       .remove();
                                    //   print(value.children);
                                    // });
                                    // Variable.userList.removeAt(index);
                                  }),
                                ),
                              ));
                        },
                      );
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
