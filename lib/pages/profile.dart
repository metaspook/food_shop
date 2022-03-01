import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/utils/constant.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final List<User> userList =
      User.fromJsonStringList(Constant.prefs.getStringList("userList")!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fullname: ' + userList[1].fullName,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'E-mail: ' + userList[1].email,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'Password: ' + userList[1].password,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'Phone: ' + userList[1].phone,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'Address: ' + userList[1].address,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
