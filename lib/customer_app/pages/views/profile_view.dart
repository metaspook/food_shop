import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String users = "";
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        // shrinkWrap: true,
        // padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 80,
            child: ClipOval(
              child: CachedNetworkImage(
                // width: 100,
                // height: 100,
                // imageBuilder: (context, imageProvider) =>
                //     Image.asset("assets/images/placeholder_user_00.jpg"),
                imageUrl: users,
                // progressIndicatorBuilder: (context, url, downloadProgress) =>
                //     LinearProgressIndicator(value: downloadProgress.progress),
                // errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/placeholder_user_00.jpg"),
                placeholder: (context, url) =>
                    Image.asset("assets/images/placeholder_user_00.jpg"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          for (var e in {
            "ID: ": "User Name Here",
            "Full Name: ": "User Name Here",
            "Email: ": "User Name Here",
            "Password: ": "User Name Here",
            "Phone: ": "User Name Here",
            "Address: ": "User Name Here",
          }.entries)
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
        ],
      ),
    );
  }
}
