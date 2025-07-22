import 'package:flutter/material.dart';
import 'package:pgcard/models/patients/patient_model.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:pgcard/providers/patient_provider.dart'; // Import your PatientProvider

class PatientInfoCard extends StatelessWidget {
  const PatientInfoCard({Key? key, required Patient patient}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
          Consumer<PatientProvider>(
            builder: (context, patientProvider, child) {
              final patient = patientProvider.patient;

              if (patientProvider.isLoading) {
                return const CircularProgressIndicator(); // Show loading state
              }

              if (patient != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.fullName, // Dynamically show full name
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF101010),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '${patient.birthPlace ?? '-'}, ${calculateAge(patient.dateOfBirth)}', // Show birthPlace and calculated age
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF646464),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                );
              } else {
                return const Text(
                  'Data pasien tidak tersedia',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }
            },
          ),
          // Spacer(),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Alergi Obat:\n',
                  style: TextStyle(
                    color: Color(0xFF646464),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Amoxycilin,\nAntikonvulsan', // Static allergy info
                  style: TextStyle(
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
  