import 'package:flutter/material.dart';
import 'package:pgcard/models/doctor/doctor_model.dart';
import 'package:pgcard/pages/main/main.dart';
import 'package:pgcard/widgets/doctor/about_section.dart';
import 'package:pgcard/widgets/doctor/appoitment_header.dart';
import 'package:pgcard/widgets/doctor/button_favorite.dart';
import 'package:pgcard/widgets/doctor/doctor_profile_card.dart';
import 'package:pgcard/widgets/doctor/experience.dart';
import 'package:pgcard/widgets/doctor/voice_call_button.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const AppointmentDetailScreen({Key? key, required this.doctor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppointmentHeader tidak ikut scroll
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: AppointmentHeader(
              onBackPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
            ),
          ),
          // const SizedBox(height: 4),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    DoctorProfileCard(doctor: doctor),
                    const SizedBox(height: 24),
                    DoctorExperienceRow(doctor: doctor),
                    const SizedBox(height: 24),
                    AboutSection(doctor: doctor),
                    const SizedBox(height: 24),
                    FavoriteToggleButton(doctor: doctor),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
