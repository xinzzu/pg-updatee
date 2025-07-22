import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String image;

  const HeaderSection({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Teks yang ditengahkan tanpa ikon back
        const Center(
          child: Text(
            'PgCard Digital',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: Color(0xFF101010),
              fontFamily: 'Inter',
            ),
          ),
        ),
        const SizedBox(height: 40), // Jarak antara teks dan QR code
        Container(
          width: 278, // Ukuran QR code
          height: 278,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
