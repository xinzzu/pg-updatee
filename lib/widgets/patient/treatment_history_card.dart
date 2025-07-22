import 'package:flutter/material.dart';
import 'package:pgcard/models/patients/patient_model.dart';

class TreatmentHistory extends StatelessWidget {
  const TreatmentHistory({Key? key, required Patient patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Riwayat Pengobatan DMT2',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF101010),
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Metformin, Sulfonilurea, Pioglitazone, Gliptin',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF646464),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
