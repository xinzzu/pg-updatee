import 'package:flutter/material.dart';

class VoiceCallButton extends StatelessWidget {
  const VoiceCallButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // Agar tombol berada di tengah
      child: TextButton(
        onPressed: () {
          // Trigger function will go here
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
          backgroundColor: const Color(0xFF4C4DDC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Supaya row hanya selebar kontennya
          children: [
            Row(
              // Grouping Icon & Text
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12), // Spacer antara ikon & teks
                const Text(
                  'Voice Call (14.30 - 15.00 PM)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
