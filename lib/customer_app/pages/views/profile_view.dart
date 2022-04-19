import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/models/models.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUser?>();
    if (user != null) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // shrinkWrap: true,
          // padding: const EdgeInsets.all(8),
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.75),
                    blurRadius: 5,
                    spreadRadius: 5,
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 80,
                child: CachedNetworkImage(
                  httpHeaders: const {"Content-Type": "image/jpeg"},
                  imageUrl: user.image ?? '',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: double.infinity,
                    backgroundImage: imageProvider,
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => ClipOval(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/placeholder_user_00.jpg"),
                        const Icon(
                          Icons.error_outline,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            for (var e in {
              "Full Name: ": user.fullName,
              "Email: ": user.email,
              "Phone: ": user.phone,
              "Address: ": user.address,
            }.entries) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: e.key,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                          children: <TextSpan>[
                            TextSpan(
                              text: e.value,
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.edit, color: Colors.cyan),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ]
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
