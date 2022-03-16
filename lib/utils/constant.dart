import 'dart:convert';
import 'package:flutter/material.dart' show Colors, Icon, Widget;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constant {
  static const statusIcons = <String, Widget>{
    "Confirmed": Icon(FontAwesomeIcons.solidHandshake, color: Colors.blue),
    "Canceled": Icon(FontAwesomeIcons.solidTimesCircle, color: Colors.red),
    "Delivery": Icon(FontAwesomeIcons.shippingFast, color: Colors.purple),
    "Pending": Icon(FontAwesomeIcons.infoCircle, color: Colors.orange),
    "Received": Icon(FontAwesomeIcons.solidCheckCircle, color: Colors.green),
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
