import 'package:flutter/material.dart';
import 'package:pgcard/models/medical_record/medical_record_model.dart'; // Import MedicalRecord model

class TreatmentHistory extends StatelessWidget {
  final MedicalRecord medicalRecord; // Tambahkan properti medicalRecord

  // Modifikasi konstruktor untuk menerima objek MedicalRecord
  const TreatmentHistory({Key? key, required this.medicalRecord})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Obat Yang Dikonsumsi', // Label baru
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF101010),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          // Menampilkan drugs_consumed dari MedicalRecord
          medicalRecord.drugsConsumed.isNotEmpty
              ? medicalRecord.drugsConsumed.join(', ')
              : 'Tidak ada obat yang dikonsumsi',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF646464),
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center, // Tambahkan ini jika teks bisa panjang
        ),
      ],
    );
  }
}
