import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart'; // Import the package

class ProfileHeader extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePicture(
          // PERUBAHAN DI SINI
          name: name, // Menggunakan nama yang diteruskan
          radius: 53,
          fontsize: 40,
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          phoneNumber,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
