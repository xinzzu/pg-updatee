import 'package:flutter/material.dart';
import '../../utils/responsive.dart'; // Import kelas Responsive

class SectionTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Inisialisasi Responsive

    return Column(
      children: [
        // Jarak tambahan sebelum heading
        SizedBox(height: responsive.hp(0.1)),

        Text(
          'Lebih Presisi dengan Informasi Farmakogenetik',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsive.hp(3), // Ukuran teks dinamis
            fontWeight: FontWeight.w600,
            color: Color(0xFF101010),
          ),
        ),
        SizedBox(
            height: responsive.hp(0.5)), // Jarak antara heading dan deskripsi
        Text(
          'Terapi individu, kejadian inefektivitas pengobatan dan reaksi obat yang tidak diinginkan dapat dihindari.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsive.hp(2), // Ukuran teks deskripsi dinamis
            fontWeight: FontWeight.w300,
            color: Color(0xFF939393),
          ),
        ),
        // Jarak yang lebih besar antara deskripsi dan titik tiga (indicator)
        SizedBox(height: responsive.hp(2)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     DotIndicator(color: Color(0xFFE0E0E3)),
        //     DotIndicator(color: Color(0xFFEDEDFC)),
        //     DotIndicator(
        //         color: Color(0xFF4C4DDC),
        //         width: responsive.wp(6)), // Ukuran indikator halaman dinamis
        //   ],
        // ),
        // Jarak tambahan setelah titik tiga
        SizedBox(height: responsive.hp(2)),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  //garis tiga
  final Color color;
  final double width;
  const DotIndicator({required this.color, this.width = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: width,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
