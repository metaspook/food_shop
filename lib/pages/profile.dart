import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/utils/constant.dart';
import 'package:food_shop/utils/method.dart';
import 'package:food_shop/utils/variable.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Constant.prefsCrypt.getString("userList").then((value) {
    //   if (value.isNotEmpty)
    //     // ignore: curly_braces_in_flow_control_structures
    //     user_1.addAll({
    //       jsonDecode(value)) User.fromJson(e)
    //     });
    // });
    // Method.loadPrefsData('test1');
  }

  @override
  Widget build(BuildContext context) {
    List<User> userList =
        User.fromJsonListString(Variable.prefsData["userList"]!);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Text(
            """
Id: ${userList[index].id}
Fullname: ${userList[index].fullName}
E-mail: ${userList[index].email}
Password: ${userList[index].password}
Phone: ${userList[index].phone}
Address:  ${userList[index].address}
""",
            style: Theme.of(context).textTheme.headline5,
          );
        },
      ),
    );
  }
}
