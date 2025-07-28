  bmiChecker(double berat, double tinggi, String gender) {
  double imt = berat / ((tinggi / 100) * (tinggi / 100));
  String keterangan;

  if (imt < 18.5) {
    keterangan = "Kurus";
  } else if (imt >= 18.5 && imt < 24.9) {
    keterangan = "Normal";
  } else if (imt >= 24.9 && imt < 29.9) {
    keterangan = "Kelebihan Berat Badan";
  } else {
    keterangan = "Obesitas";
  }

  return keterangan;
}
