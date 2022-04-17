import 'package:flutter/material.dart';

class UserSettingsView extends StatelessWidget {
  const UserSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.replay_outlined),
          label: const Text('Reset App'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout),
          label: const Text('Sign Out'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.info_outlined),
          label: const Text('About'),
        )
      ],
    );
  }
}
