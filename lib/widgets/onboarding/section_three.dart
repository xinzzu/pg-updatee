import 'package:flutter/material.dart';
import 'package:pgcard/pages/main/navigation/home/home.dart';
import 'package:pgcard/pages/login/login.dart';
import '../../utils/responsive.dart'; // Import kelas Responsive

class SectionThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Inisialisasi Responsive

    return Column(
      children: [
        // Jarak tambahan sebelum tombol "Get Started"
        SizedBox(height: responsive.hp(1)),

        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => (LoginScreen())));
            // Aksi ketika tombol ditekan
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: responsive.hp(3), // Padding vertikal dinamis
              horizontal: responsive.wp(36), // Padding horizontal dinamis
            ),
            backgroundColor: Color(0xFF4C4DDC), // Warna tombol biru
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: TextStyle(
              fontSize: responsive.hp(2), // Ukuran teks dinamis
              fontWeight: FontWeight.w600,
              color: Colors.white, // Warna teks putih
            ),
          ),
          child: Text(
            'Mulai',
            style: TextStyle(
              color: Colors.white, // Teks tombol berwarna putih
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Jarak tambahan antara tombol dan rectangle bawah
        // SizedBox(height: responsive.hp(0)),
      ],
    );
  }
}
