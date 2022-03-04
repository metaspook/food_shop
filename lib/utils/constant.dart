import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:food_shop/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  static final List<User> userList = [
    User(
      id: 1,
      fullName: "Mr. User 1",
      email: "user1@mail.com",
      password: "abcd4321",
      phone: "0131234561",
      address: "lake city, Khikhet",
    ),
    User(
      id: 2,
      fullName: "Mr. User 2",
      email: "user2@mail.com",
      password: "abcd4322",
      phone: "0131234562",
      address: "lake city, Khikhet",
    ),
    User(
      id: 3,
      fullName: "Mr. User 3",
      email: "user3@mail.com",
      password: "abcd4323",
      phone: "0131234563",
      address: "lake city, Khikhet",
    ),
    User(
      id: 4,
      fullName: "Mr. User 4",
      email: "user4@mail.com",
      password: "abcd4324",
      phone: "0131234564",
      address: "lake city, Khikhet",
    ),
    User(
      id: 5,
      fullName: "Mr. User 5",
      email: "user1@mail.com",
      password: "abcd4325",
      phone: "0131234565",
      address: "lake city, Khikhet",
    ),
    User(
      id: 6,
      fullName: "Mr. User 6",
      email: "user6@mail.com",
      password: "abcd4326",
      phone: "0131234566",
      address: "lake city, Khikhet",
    ),
    User(
      id: 7,
      fullName: "Mr. User 7",
      email: "user7@mail.com",
      password: "abcd4327",
      phone: "0131234567",
      address: "lake city, Khikhet",
    ),
    User(
      id: 8,
      fullName: "Mr. User 8",
      email: "user8@mail.com",
      password: "abcd4328",
      phone: "0131234568",
      address: "lake city, Khikhet",
    ),
  ];
  static const Base64Codec base64 = Base64Codec();
}
