import 'dart:convert';

import 'package:flutter/material.dart' show Colors, Icon, Icons, Widget;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  Constants._();
  // Shared Preferences.
  static String userId = "";
  static late final SharedPreferences prefs;
  static const List<int> productQuantityList = [
    18,
    34,
    31,
    44,
    37,
    12,
    35,
    32,
    29,
    46,
    12,
    12,
    13,
    37,
    2,
    44,
    39,
    3,
    14,
    26,
    46,
    31,
    46,
    19,
    1,
    39,
    40,
    14,
    32,
    50,
    34,
    42,
    41,
    34,
    1,
    36,
    28,
    1,
    12,
    15,
    7,
    19,
    48,
    20,
    8,
    32,
    39,
    19,
    49,
    41,
    46,
    39,
    37,
    26,
    35,
    6,
    44,
    26,
    22,
    8
  ];
  static const List<num> productPriceList = [
    10.25,
    14.25,
    17.75,
    5,
    13.5,
    13.75,
    20,
    13.5,
    16.75,
    6.75,
    9,
    18.25,
    7.25,
    12.5,
    12.25,
    17.25,
    9.25,
    14.75,
    20.25,
    13.25,
    13.25,
    17,
    19,
    15.75,
    1.25,
    16.25,
    9.5,
    10.5,
    2,
    5,
    12.25,
    19,
    14,
    7.5,
    11.75,
    14.75,
    15.5,
    15,
    18.5,
    10.25,
    5,
    13.75,
    20.5,
    4.25,
    7.75,
    14.5,
    3.25,
    4,
    1.75,
    14.5,
    18,
    10.5,
    19.25,
    15,
    16.5,
    7.5,
    6.5,
    4,
    12,
    5.25
  ];

  static final statusElements = <String, Map<String, dynamic>>{
    "Confirmed": {
      "icon": FontAwesomeIcons.solidHandshake,
      "color": Colors.blue,
      "count": 0,
    },
    "Canceled": {
      "icon": FontAwesomeIcons.solidTimesCircle,
      "color": Colors.red,
      "count": 0,
    },
    "Delivery": {
      "icon": FontAwesomeIcons.shippingFast,
      "color": Colors.purple,
      "count": 0,
    },
    "Pending": {
      "icon": FontAwesomeIcons.infoCircle,
      "color": Colors.orange,
      "count": 0,
    },
    "Received": {
      "icon": FontAwesomeIcons.solidCheckCircle,
      "color": Colors.green,
      "count": 0,
    },
  };

  static final mainBoardElements = <String, Map<String, dynamic>>{
    "Users": {
      "icon": Icons.supervised_user_circle_sharp,
      "color": Colors.pink,
      "count": 0,
    },
    "Orders": {
      "icon": Icons.file_copy,
      "color": Colors.pink,
      "count": 0,
    },
    "Products": {
      "icon": Icons.shopping_bag_rounded,
      "color": Colors.pink,
      "count": 0,
    },
  };

  static List<Map<String, dynamic>> userList = [
    {
      "id": 1,
      "fullName": "Mr. User 1",
      "email": "user1@mail.com",
      "password": "abcd4321",
      "phone": "0131234561",
      "address": "lake city, Khikhet",
    },
    {
      "id": 2,
      "fullName": "Mr. User 2",
      "email": "user2@mail.com",
      "password": "abcd4322",
      "phone": "0131234562",
      "address": "lake city, Khikhet",
    },
    {
      "id": 3,
      "fullName": "Mr. User 3",
      "email": "user3@mail.com",
      "password": "abcd4323",
      "phone": "0131234563",
      "address": "lake city, Khikhet",
    },
    {
      "id": 4,
      "fullName": "Mr. User 4",
      "email": "user4@mail.com",
      "password": "abcd4324",
      "phone": "0131234564",
      "address": "lake city, Khikhet",
    },
    {
      "id": 5,
      "fullName": "Mr. User 5",
      "email": "user1@mail.com",
      "password": "abcd4325",
      "phone": "0131234565",
      "address": "lake city, Khikhet",
    },
    {
      "id": 6,
      "fullName": "Mr. User 6",
      "email": "user6@mail.com",
      "password": "abcd4326",
      "phone": "0131234566",
      "address": "lake city, Khikhet",
    },
    {
      "id": 7,
      "fullName": "Mr. User 7",
      "email": "user7@mail.com",
      "password": "abcd4327",
      "phone": "0131234567",
      "address": "lake city, Khikhet",
    },
    {
      "id": 8,
      "fullName": "Mr. User 8",
      "email": "user8@mail.com",
      "password": "abcd4328",
      "phone": "0131234568",
      "address": "lake city, Khikhet",
    },
  ];
  static const List<Map<String, dynamic>> oderList = [
    {
      "orderId": "JenCvqPWYdf",
      "userId": "-MxVBDVretrevKX6IRjeo",
      "totalPrice": 343,
      "status": "Pending",
      "cart": [
        {"itemIndex": 0, "quantity": 10}
      ]
    },
    {
      "orderId": "JenCvqPWdK",
      "userId": "-MxVBDV0eshhKX6IRjeo",
      "totalPrice": 546,
      "status": "Confirmed",
      "cart": [
        {"itemIndex": 1, "quantity": 25}
      ]
    },
    {
      "orderId": "JenCvqPWsK",
      "userId": "-MxVBDVhjhzvKX6IRjeo",
      "totalPrice": 357,
      "status": "Canceled",
      "cart": [
        {"itemIndex": 2, "quantity": 58}
      ]
    },
    {
      "orderId": "JenCvqPaYK",
      "userId": "-MxVBDV0vCkjkkIRjeo",
      "totalPrice": 456,
      "status": "Confirmed",
      "cart": [
        {"itemIndex": 3, "quantity": 47}
      ]
    },
    {
      "orderId": "JenCvqPwYK",
      "userId": "-MxVBDV0vCkjk6IRjeo",
      "totalPrice": 528,
      "status": "Canceled",
      "cart": [
        {"itemIndex": 4, "quantity": 57}
      ]
    },
    {
      "orderId": "JenCvqrtYK",
      "userId": "-MxVhg0vCzvKX6IRjeo",
      "totalPrice": 756,
      "status": "Confirmed",
      "cart": [
        {"itemIndex": 5, "quantity": 67}
      ]
    },
    {
      "orderId": "JenCvqyyyK",
      "userId": "-MxVBDV0vCzvjjjRjeo",
      "totalPrice": 915,
      "status": "Pending",
      "cart": [
        {"itemIndex": 6, "quantity": 96}
      ]
    },
    {
      "orderId": "JenCrrrriK",
      "userId": "-MxVBjhjgjKX6IRjeo",
      "totalPrice": 524,
      "status": "Pending",
      "cart": [
        {"itemIndex": 7, "quantity": 14}
      ]
    },
  ];
  static const Base64Codec base64 = Base64Codec();
}
