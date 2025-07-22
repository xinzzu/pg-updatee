import 'package:flutter/material.dart';
import 'package:pgcard/widgets/onboarding/section_three.dart';
import 'package:pgcard/widgets/onboarding/section_two.dart';
// import 'package:provider/provider.dart';
import '../utils/responsive.dart'; // Import kelas Responsive

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Inisialisasi Responsive

    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Warna latar belakang biru
          Container(
            color: Color(0xFF4C4DDC), // Warna latar belakang
          ),
          // Layer 2: Texture PNG di atas warna biru
          Positioned.fill(
            child: Opacity(
              opacity: 0.7, // Atur opacity sesuai kebutuhan
              child: Image.asset(
                'assets/images/texture.png', // Path ke texture PNG
                fit: BoxFit.cover, // Menutup seluruh layar
              ),
            ),
          ),
          // Layer 3: Gambar Dokter
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/doctor.png'), // Gambar dokter
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: responsive.hp(2)), // Padding dinamis
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: responsive.hp(60)), // Margin dinamis
                    decoration: BoxDecoration(
                      color: Colors.white, // Warna rectangle putih
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: responsive.hp(3),
                        horizontal: responsive.wp(6),
                      ), // Padding dinamis berdasarkan ukuran layar
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SectionTwo(), //text
                          SectionThree(), // Tombol "Get Started" ada di sini
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
