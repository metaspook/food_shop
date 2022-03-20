import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_shop/utils/extension.dart';
import 'package:food_shop/utils/variable.dart';

class FakeUploader extends StatefulWidget {
  const FakeUploader({Key? key}) : super(key: key);

  @override
  State<FakeUploader> createState() => _FakeUploaderState();
}

class _FakeUploaderState extends State<FakeUploader> {
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
            label: Text('Users'),
          ),
          SizedBox(width: 5),
          ElevatedButton.icon(
            onPressed: () => _uploadOrder(),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: Text('Orders'),
          ),
          SizedBox(width: 5),
          ElevatedButton.icon(
            onPressed: () => _uploadOrder(),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: Text('Products'),
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
    final userRef = Variable.dbRealtime.ref("users").push();
    e.update("id", (value) => userRef.key!);
    userRef.set(e);
  }
}

void _uploadOrder() {
  final oderList = [
    {
      "id": "",
      "userId": "-MxyK3HvT8BYupaS55n7",
      "status": "Pending",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    },
    {
      "id": "",
      "userId": "-MxyK3HtSRQTFBC492uU",
      "status": "Confirmed",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    },
    {
      "id": "",
      "userId": "-MxyK3HtSRQTFBC492uU",
      "status": "Canceled",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    },
    {
      "id": "",
      "userId": "-MxyK3Hxpg5tWHEmCEsO",
      "status": "Delivery",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    },
    {
      "id": "",
      "userId": "-MxyK3HzHbQxEMo8m52E",
      "status": "Received",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    },
    {
      "id": "",
      "userId": "-MxyK3Hxpg5tWHEmCEsO",
      "status": "Confirmed",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    },
    {
      "id": "",
      "userId": "-MxyK3HzHbQxEMo8m52E",
      "status": "Pending",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    },
    {
      "id": "",
      "userId": "-MxyK3Hxpg5tWHEmCEsO",
      "status": "Received",
      "cartList": <Map<String, dynamic>>[
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        },
        {
          "itemIndex": Random().nextInt(60),
          "quantity": Random().nextInt(20) + 1,
          "unitPrice": 0.0
        }
      ]
    }
  ];

  for (Map<String, dynamic> e in oderList) {
    final orderRef = Variable.dbRealtime.ref("orders").push();
    final List<Map<String, dynamic>> cartList = e["cartList"];
    e.update("id", (value) => orderRef.key!);
    for (int i = 0; i < cartList.length; i++) {
      cartList[i].update(
        "unitPrice",
        (value) => Variable.itemPriceList[cartList[i]["itemIndex"]!],
      );
    }
    // print(e["totalPrice"]);
    orderRef.set(e);
  }
  // print(oderList); 19/02/2022 11:46:44
}
