import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  // Mendapatkan lebar layar
  double get width => MediaQuery.of(context).size.width;

  // Mendapatkan tinggi layar
  double get height => MediaQuery.of(context).size.height;

  // Mengembalikan ukuran berdasarkan persentase lebar layar
  double wp(double percentage) => width * (percentage / 100);

  // Mengembalikan ukuran berdasarkan persentase tinggi layar
  double hp(double percentage) => height * (percentage / 100);

  // Mengembalikan true jika layar kecil (misalnya untuk ponsel kecil)
  bool isSmallScreen() => width < 600;

  // Mengembalikan true jika layar sedang (misalnya untuk tablet)
  bool isMediumScreen() => width >= 600 && width < 1200;

  // Mengembalikan true jika layar besar (misalnya untuk perangkat desktop)
  bool isLargeScreen() => width >= 1200;
}
