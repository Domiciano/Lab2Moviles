import 'package:flutter/material.dart';
import 'package:lab2261/components/profile_view.dart';
import 'package:lab2261/components/stat_label.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileView(
            name: 'Maria Alejandra Zamudio',
            email: '@alejandra.zamudio',
            imageUrl:
                'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatLabel(value: '27', label: 'Playlists'),
              StatLabel(value: '58', label: 'Followers'),
              StatLabel(value: '43', label: 'Following'),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
