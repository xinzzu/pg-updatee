import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const SettingsHeader({
    Key? key,
    required this.name,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 53,
          backgroundImage:
              AssetImage('assets/images/profile.png'), // Menggunakan PNG lokal
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          phoneNumber,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
