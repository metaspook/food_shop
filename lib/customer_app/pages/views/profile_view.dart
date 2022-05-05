import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/customer_app/widgets/profile_field.dart';
import 'package:food_shop/models/models.dart';
import 'package:food_shop/services/services.dart';
import 'package:food_shop/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // StreamBuilder instead of StreamProvider because of required value (userId).
    return StreamBuilder<AppUser>(
      stream: Database.user(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          final profileFields = <String, Map<String, dynamic>>{
            "Name: ": {
              "value": user.fullName,
              "editField": InputForm.fullName(user.fullName)
            },
            "Email: ": {
              "value": user.email,
              "editField": InputForm.email(previousText: user.email)
            },
            "Phone: ": {
              "value": user.phone,
              "editField": InputForm.phone(user.phone)
            },
            "Address: ": {
              "value": user.address,
              "editField": InputForm.address(user.address)
            }
          };
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // shrinkWrap: true,
              // padding: const EdgeInsets.all(8),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: context.watch<ProfileController>().editModePicture
                      ? IconButton(
                          tooltip: 'Done',
                          icon: const Icon(Icons.check_circle_outline_rounded,
                              color: Colors.cyan),
                          onPressed: () => context
                              .read<ProfileController>()
                              .editModePictureOff(user.id),
                        )
                      : IconButton(
                          tooltip: 'Edit',
                          icon: const Icon(Icons.edit, color: Colors.cyan),
                          onPressed: () {
                            Methods.customDialog(
                              context: context,
                              title: const Text('Please choose an option'),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async => context
                                        .read<ProfileController>()
                                        .setImageFile(
                                            await Methods.pickCameraImage(
                                                context)),
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async => context
                                        .read<ProfileController>()
                                        .setImageFile(
                                            await Methods.pickGalleryImage(
                                                context)),
                                    icon: const Icon(Icons.image),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.6),
                        blurRadius: 6,
                        spreadRadius: 5,
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        context.watch<ProfileController>().imageFile == null
                            ? null
                            : FileImage(
                                context.watch<ProfileController>().imageFile!),
                    child: context.watch<ProfileController>().imageFile != null
                        ? null
                        : CachedNetworkImage(
                            // httpHeaders: const {"Content-Type": "image/jpeg"},
                            imageUrl: user.image,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: double.infinity,
                              backgroundImage: imageProvider,
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) => ClipOval(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                      "assets/images/placeholder_user_00.jpg"),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: context.watch<ProfileController>().editModeField
                      ? IconButton(
                          tooltip: 'Done',
                          icon: const Icon(Icons.check_circle_outline_rounded,
                              color: Colors.cyan),
                          onPressed: () => context
                              .read<ProfileController>()
                              .editModeFieldOff(user.id),
                        )
                      : IconButton(
                          tooltip: 'Edit',
                          icon: const Icon(Icons.edit, color: Colors.cyan),
                          onPressed: () => context
                              .read<ProfileController>()
                              .editModeFieldOn(),
                        ),
                ),
                for (int i = 0; i < profileFields.entries.length; i++) ...[
                  context.watch<ProfileController>().editModeField
                      ? profileFields.values.elementAt(i)["editField"]
                      : Card(
                          elevation: 5,
                          child: ProfileField(
                            title: profileFields.keys.elementAt(i),
                            subtitle:
                                profileFields.values.elementAt(i)["value"],
                          ),
                        ),
                  const SizedBox(height: 15),
                ]
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}
