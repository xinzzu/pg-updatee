// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pgcard/models/doctor/doctor_model.dart';

class DoctorExperience extends StatelessWidget {
  final String label;
  final String value;
  final String iconPath;

  const DoctorExperience({
    Key? key,
    required this.label,
    required this.value,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor:
              const Color.fromARGB(255, 239, 244, 255), // Background for icon
          child: SvgPicture.asset(
            iconPath,
            width: 28,
            height: 28,
            color: const Color(0xFF4C4DDC), // Icon color
          ),
        ),
        const SizedBox(height: 8), // Space between icon and value
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4), // Space between value and label
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class DoctorExperienceRow extends StatelessWidget {
  const DoctorExperienceRow({Key? key, required Doctor doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          DoctorExperience(
            label: 'Pasien',
            value: '120+',
            iconPath:
                'assets/icons/appoitment/patient.svg', // Path for Patients icon
          ),
          DoctorExperience(
            label: 'Tahun',
            value: '7+',
            iconPath:
                'assets/icons/appoitment/year.svg', // Path for Experience icon
          ),
          DoctorExperience(
            label: 'Penilaian',
            value: '4.9',
            iconPath:
                'assets/icons/appoitment/rating.svg', // Path for Rating icon
          ),
          DoctorExperience(
            label: 'Ulasan',
            value: '100+',
            iconPath:
                'assets/icons/appoitment/review.svg', // Path for Reviews icon
          ),
        ],
      ),
    );
  }
}
