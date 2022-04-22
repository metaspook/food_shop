import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_shop/services/database.dart';
import 'package:food_shop/utils/constants.dart';
import 'package:food_shop/utils/extension.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 5),
          ElevatedButton.icon(
            onPressed: _uploadUser,
            icon: const Icon(Icons.person_add_alt),
            label: const Text('Users'),
          ),
          const SizedBox(width: 5),
          ElevatedButton.icon(
            onPressed: () => _uploadOrder(),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Orders'),
          ),
          const SizedBox(width: 5),
          ElevatedButton.icon(
            onPressed: _uploadProduct,
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Products'),
          ),
        ],
      ),
    );
  }
}

void _uploadUser() {
  final userList = [
    {
      "id": "",
      "fullName": "Samuel Curry",
      "email": "Maryjane_Wehner92@hotmail.com",
      "password": "abcd4321".hashCrypt,
      "phone": "253-699-9396",
      "address": "1215 Burtef Boulevard",
      "image": "https://randomuser.me/api/portraits/men/1.jpg"
    },
    {
      "id": "",
      "fullName": "Lucinda Curry",
      "email": "Eleazar67@yahoo.com",
      "password": "abcd4322".hashCrypt,
      "phone": "518-810-8257",
      "address": "1873 Pasolo Boulevard",
      "image": "https://randomuser.me/api/portraits/men/2.jpg"
    },
    {
      "id": "",
      "fullName": "Jeffrey Ellis",
      "email": "Bernard.Bailey@hotmail.com",
      "password": "abcd4323".hashCrypt,
      "phone": "470-670-2592",
      "address": "300 Pozved Center",
      "image": "https://randomuser.me/api/portraits/men/3.jpg"
    },
    {
      "id": "",
      "fullName": "Olga Montgomery",
      "email": "Elyssa_Bradtke39@hotmail.com",
      "password": "abcd4324".hashCrypt,
      "phone": "660-713-8144",
      "address": "422 Livdoh Street",
      "image": "https://randomuser.me/api/portraits/men/4.jpg"
    },
    {
      "id": "",
      "fullName": "Rhoda Logan",
      "email": "Josiane68@gmail.com",
      "password": "abcd4325".hashCrypt,
      "phone": "533-709-9696",
      "address": "1478 Amzo Parkway",
      "image": "https://randomuser.me/api/portraits/men/5.jpg"
    },
    {
      "id": "",
      "fullName": "Ollie Warren",
      "email": "Lucius_Bahringer@hotmail.com",
      "password": "abcd4326".hashCrypt,
      "phone": "806-659-1453",
      "address": "719 Culcof Boulevard",
      "image": "https://randomuser.me/api/portraits/men/6.jpg"
    },
    {
      "id": "",
      "fullName": "Agnes Hoffman",
      "email": "Hildegard_Okuneva@yahoo.com",
      "password": "abcd4327".hashCrypt,
      "phone": "424-537-4597",
      "address": "448 Gobzug Circle",
      "image": "https://randomuser.me/api/portraits/men/7.jpg"
    },
    {
      "id": "",
      "fullName": "Miguel Rodgers",
      "email": "Jewell91@yahoo.com",
      "password": "abcd4328".hashCrypt,
      "phone": "993-579-3459",
      "address": "1555 Genigi Loop",
      "image": "https://randomuser.me/api/portraits/men/8.jpg"
    },
  ];

  for (Map<String, String> e in userList) {
    final userRef = Database.dbRealtime.ref("users").push();
    e.update("id", (value) => userRef.key!);
    userRef.set(e);
  }
}

void _uploadOrder() {
  final oderList = [
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wHLGHpsFkmPUHn",
      "customerFullName": "Lucinda Curry",
      "customerPhone": "518-810-8257",
      "deliveryAddress": "1873 Pasolo Boulevard",
      "status": "Pending",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8Fk8ClEgux7f1O-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        }
      ]
    },
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wIMUPYTrICbxRY",
      "customerFullName": "Jeffrey Ellis",
      "customerPhone": "470-670-2592",
      "deliveryAddress": "300 Pozved Center",
      "status": "Confirmed",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8Fk8ClEgux7f1O-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        }
      ]
    },
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wIMUPYTrICbxRZ",
      "customerFullName": "Olga Montgomery",
      "customerPhone": "660-713-8144",
      "deliveryAddress": "422 Livdoh Street",
      "status": "Canceled",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8Fk8ClEgux7f1O-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
      ]
    },
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wKVbvZYMxqL-u9",
      "customerFullName": "Rhoda Logan",
      "customerPhone": "533-709-9696",
      "deliveryAddress": "1478 Amzo Parkway",
      "status": "Delivery",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8Fk8ClEgux7f1O-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
      ]
    },
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wLCIIRGxE4oSHt",
      "customerFullName": "Ollie Warren",
      "customerPhone": "806-659-1453",
      "deliveryAddress": "719 Culcof Boulevard",
      "status": "Received",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
      ]
    },
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wLCIIRGxE4oSHu",
      "customerFullName": "Agnes Hoffman",
      "customerPhone": "424-537-4597",
      "deliveryAddress": "448 Gobzug Circle",
      "status": "Confirmed",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8Fk8ClEgux7f1O-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png",
          "productName": "Biscuit",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8Fk8ClEgux7f1O-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
      ]
    },
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wMBoVFx-P0aI8d",
      "customerFullName": "Miguel Rodgers",
      "customerPhone": "993-579-3459",
      "deliveryAddress": "1555 Genigi Loop",
      "status": "Pending",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png",
          "productName": "Apple",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        }
      ]
    },
    {
      "id": "",
      "total": 0.0,
      "customerId": "-My3v8wMBoVFx-P0aI8d",
      "customerFullName": "Miguel Rodgers",
      "customerPhone": "993-579-3459",
      "deliveryAddress": "1555 Genigi Loop",
      "status": "Received",
      "cartProductList": <Map<String, dynamic>>[
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FjxUyXLU4ADepk",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8Fk8ClEgux7f1O-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        },
        {
          "productId": "-MygM8FiMclKR6Q0dLM-",
          "productImage":
              "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png",
          "productName": "Boiled Egg",
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0,
          "subTotal": 0.0
        }
      ]
    }
  ];
  for (Map<String, dynamic> e in oderList) {
    final orderRef = Database.dbRealtime.ref("orders").push();
    // final List<Map<String, dynamic>> cartProductList = e["cartProductList"];

    final unitPrice = num.tryParse((Random().nextInt(20) + 1).toString() +
        "." +
        (25 * Random().nextInt(4)).toString());

    for (int i = 0; i < e["cartProductList"].length; i++) {
      e["cartProductList"][i]["unitPrice"] = unitPrice;
      e["cartProductList"][i]["subTotal"] = e["cartProductList"][i]
              ["quantity"] *
          e["cartProductList"][i]["unitPrice"];
    }

    e["total"] = [
      for (Map<String, dynamic> e in e["cartProductList"]) e["subTotal"]
    ].reduce((v, e) => v + e);
    e["id"] = orderRef.key!;
    orderRef.set(e);
  }
}

void _uploadProduct() {
  final productList = <Map<String, dynamic>>[
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Apple",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/apple.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Biscuit",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/biscuit.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Boiled Egg",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/boiled-egg.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Bread",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/bread.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Breadsticks",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/breadsticks.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Breakfast Sandwich",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/breakfast-sandwich.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Burger",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/burger.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Butter",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/butter.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Candies",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/candies.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Cheese",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/cheese.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Cheeseburger",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/cheeseburger.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Chips",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/chips.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Chocolate Milk",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/chocolate-milk.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Chocolate",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/chocolate.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Coconut Milk",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/coconut-milk.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Coffee",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/coffee.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Cookies",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/cookies.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Croissant",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/croissant.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Donut",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/donut.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Fish",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/fish.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "French Bread",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/french-bread.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Fried Chicken",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/fried-chicken.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Fries",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/fries.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Fruit Juice",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/fruit-juice.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Fruits",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/fruits.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Grapes",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/grapes.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Green Tea",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/green-tea.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Honey",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/honey.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Hot Chocolate",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/hot-chocolate.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Hot Dog",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/hot-dog.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Ice Cream",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/ice-cream.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Jam",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/jam.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Kebab",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/kebab.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Lemonade",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/lemonade.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Meat",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/meat.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Milk",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/milk.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Milkshake",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/milkshake.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Muffins",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/muffins.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Noodle",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/noodle.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Omelet",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/omelet.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Orange Juice",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/orange-juice.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Pancakes",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/pancakes.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Pasta",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/pasta.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Pizza",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/pizza.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Rice",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/rice.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Roast Chicken",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/roast-chicken.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Roll",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/roll.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Salad",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/salad.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Sandwich",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/sandwich.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Sausages",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/sausages.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Seafood",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/seafood.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Soft Drink",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/soft-drink.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Soup",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/soup.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Steak",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/steak.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Taco",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/taco.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Tea",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/tea.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Vegetables",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/vegetables.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Water",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/water.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Watermelon",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/watermelon.png"
    },
    {
      "id": "",
      "price": 0.0,
      "stock": 0,
      "name": "Yogurt",
      "image":
          "https://raw.githubusercontent.com/metaspook/json_api/main/images/foods/yogurt.png"
    }
  ];

  for (Map<String, dynamic> e in productList) {
    final productRef = Database.dbRealtime.ref("products").push();
    // final List<Map<String, dynamic>> cartItemList = e["cartItemList"];
    e.update("id", (value) => productRef.key);
    e.update(
        "price", (value) => Constants.productPriceList[productList.indexOf(e)]);
    e.update("stock",
        (value) => Constants.productQuantityList[productList.indexOf(e)]);
    // for (int i = 0; i < cartItemList.length; i++) {
    //   cartItemList[i].update(
    //     "unitPrice",
    //     (value) => Variable.itemPriceList[cartItemList[i]["itemIndex"]!],
    //   );
    // }
    // print(e["totalPrice"]);
    productRef.set(e);
  }
  // print(oderList); 19/02/2022 11:46:44
}
