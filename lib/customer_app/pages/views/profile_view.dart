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
        // shrinkWrap: true,
        // padding: const EdgeInsets.all(8),
        children: [
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
                placeholder: (context, url) => Image.asset(
                  "assets/images/placeholder_user_00.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Name: ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
              children: <TextSpan>[
                TextSpan(
                  text: "User Name Here",
                  style: TextStyle(
                      color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'ID: ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
              children: <TextSpan>[
                TextSpan(
                  text: "User Name Here",
                  style: TextStyle(
                      color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Phone: ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
              children: <TextSpan>[
                TextSpan(
                  text: "User Name Here",
                  style: TextStyle(
                      color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
