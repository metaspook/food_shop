import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/users_controller.dart';
import 'package:food_shop/controllers/x_controller.dart';
import 'package:food_shop/models/app_user.dart';
import 'package:provider/provider.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final users = context.watch<List<AppUser>?>();

    return users == null
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Container(
            color: Colors.white,
            child: Center(
              child: LayoutBuilder(builder: (context, constraints) {
                return users.isEmpty
                    ? Text(
                        'No Users!',
                        style: Theme.of(context).textTheme.headline3,
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(5),
                        controller: XController.scroll,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 1900
                              ? 4
                              : size.width > 1500
                                  ? 3
                                  : size.width > 1100
                                      ? 2
                                      : 1,
                          mainAxisExtent: 125,
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(5),
                            child: ListTile(
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              title: Text(
                                users[index].fullName,
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
                                            text: users[index].address,
                                            style: DefaultTextStyle.of(context)
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
                                            text: users[index].phone,
                                            style: DefaultTextStyle.of(context)
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
                                            text: users[index].email,
                                            style: DefaultTextStyle.of(context)
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
                                            text: users[index].id,
                                            style: DefaultTextStyle.of(context)
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
                                  imageUrl: users[index].image ??
                                      "assets/images/placeholder_user_00.jpg",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          LinearProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error_outline),
                                ),
                              ),
                              onTap: null,
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_forever_outlined),
                                onPressed: () async =>
                                    UsersController.remove(users[index].id),
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
          );
  }
}
