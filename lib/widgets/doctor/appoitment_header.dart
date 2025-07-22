import 'package:flutter/material.dart';

class AppointmentHeader extends StatelessWidget {
  final VoidCallback onBackPressed; // To handle the back button press

  const AppointmentHeader({Key? key, required this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 30), // Menambahkan jarak vertikal untuk menurunkan header
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF101010)),
              onPressed:
                  onBackPressed, // Triggered when the back arrow is pressed
            ),
            const SizedBox(width: 90), // Space between back icon and text
            const Text(
              'Dokter Detail',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Color(0xFF101010),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        // Space between text and content below
      ],
    );
  }
}
