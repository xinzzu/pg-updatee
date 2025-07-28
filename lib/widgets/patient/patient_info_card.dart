import 'package:flutter/material.dart';
import 'package:pgcard/models/patients/patient_model.dart'; // Import model Patient Anda
import 'package:pgcard/models/medical_record/medical_record_model.dart'; // Import MedicalRecord model

class PatientInfoCard extends StatelessWidget {
  final Patient patient; // Properti untuk data pasien
  final MedicalRecord medicalRecord; // Properti untuk data medical record

  // Modifikasi konstruktor untuk menerima kedua objek
  const PatientInfoCard(
      {Key? key, required this.patient, required this.medicalRecord})
      : super(key: key);

  // Function to calculate age based on date of birth
  String calculateAge(String dateOfBirth) {
    DateTime birthDate = DateTime.parse(dateOfBirth); // Parse date string
    DateTime today = DateTime.now(); // Get today's date
    int age = today.year - birthDate.year; // Calculate year difference

    // Adjust age if birthday hasn't happened this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return '$age tahun'; // Return age with "tahun"
  }

  // Fungsi baru untuk mendapatkan tahun dari tanggal diagnosa diabetes
  String? getDiabetesDiagnosedYear(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }
    try {
      // Mengasumsikan format tanggal adalah "DD Mon YYYY" (misal: "25 Jul 2025")
      // Kita bisa mencoba parsing langsung atau memecah string
      // Untuk amannya, kita bisa coba parsing DateTime, lalu ambil tahunnya.
      // Jika formatnya hanya tahun, langsung gunakan.
      // Jika format "25 Jul 2025", DateTime.parse mungkin tidak langsung mengenali.
      // Cara yang lebih robust adalah memecah string.
      // Contoh: "25 Jul 2025" -> ambil "2025"
      final parts = dateString.split(' ');
      if (parts.length == 3) {
        return parts[2]; // Ambil bagian tahun
      }
      // Jika formatnya hanya tahun (misal "2020"), langsung kembalikan
      if (int.tryParse(dateString) != null && dateString.length == 4) {
        return dateString;
      }
      // Fallback jika parsing gagal atau format tidak sesuai
      return null;
    } catch (e) {
      debugPrint('Error parsing diabetes diagnosed date: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan tahun diagnosa diabetes
    final diagnosedYear =
        getDiabetesDiagnosedYear(medicalRecord.diabetesDiagnosedSince);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101010).withOpacity(0.17),
            blurRadius: 30,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.fullName, // Menampilkan nama lengkap dari model Patient
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101010),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 1),
              Text(
                '${patient.birthPlace ?? '-'}, ${calculateAge(patient.dateOfBirth)}', // Menampilkan tempat lahir dan usia dari model Patient
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF646464),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                height: 1.5,
              ),
              children: [
                const TextSpan(
                  text: 'Diabetes Sejak:\n', // Label baru
                  style: TextStyle(
                    color: Color(0xFF646464),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  // Menampilkan tahun diagnosa diabetes
                  text: diagnosedYear ?? 'Tidak terdiagnosa',
                  style: const TextStyle(
                    color: Color(0xFF101010),
                    fontWeight: FontWeight.w500,
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
