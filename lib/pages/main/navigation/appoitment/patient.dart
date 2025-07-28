import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pgcard/models/patients/patient_model.dart';
import 'package:pgcard/providers/patient_provider.dart';
import 'package:pgcard/services/patient_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:pgcard/providers/medical_record_provider.dart'; // Import MedicalRecordProvider
import 'package:pgcard/models/medical_record/medical_record_model.dart'; // Import MedicalRecord model

// Import widget custom Anda
import 'package:pgcard/widgets/patient/header_section.dart'; // Ini mungkin tidak lagi digunakan untuk QR code
import 'package:pgcard/widgets/patient/patient_info_card.dart';
import 'package:pgcard/widgets/patient/treatment_history_card.dart';

class PatientCardScreen extends StatefulWidget {
  const PatientCardScreen({Key? key}) : super(key: key);

  @override
  _PatientCardScreenState createState() => _PatientCardScreenState();
}

class _PatientCardScreenState extends State<PatientCardScreen> {
  @override
  void initState() {
    super.initState();
    // Panggil fetchMedicalRecordData saat screen dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MedicalRecordProvider>(context, listen: false)
          .fetchMedicalRecordData();
      // PatientProvider juga perlu dipanggil di sini jika PatientInfoCard masih bergantung padanya
      Provider.of<PatientProvider>(context, listen: false).fetchPatientData();
    });
  }

  // Fungsi Kunci: Mengonversi objek MedicalRecord menjadi string teks biasa untuk QR Code
  String _generateQrData(MedicalRecord medicalRecord) {
    return '''
TB: ${medicalRecord.height} cm
BB: ${medicalRecord.weight} kg
BMI: ${medicalRecord.bmi}
Gen IRS1 RS1801278: ${medicalRecord.irs1Rs1801278 ?? 'Tidak tersedia'}
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'PgCard Digital',
              style: TextStyle(
                color: Color(0xFF101010),
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Consumer<MedicalRecordProvider>(
        // Gunakan Consumer untuk MedicalRecordProvider
        builder: (context, medicalRecordProvider, child) {
          if (medicalRecordProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (medicalRecordProvider.medicalRecord != null) {
            final medicalRecord = medicalRecordProvider.medicalRecord!;
            final qrDataString = _generateQrData(medicalRecord);

            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                constraints: const BoxConstraints(maxWidth: 480),
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    Center(
                      child: QrImageView(
                        data: qrDataString,
                        version: QrVersions.auto,
                        size: 290.0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        errorStateBuilder: (cxt, err) {
                          return const Center(
                            child: Text(
                              'Oops! Gagal membuat QR Code.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          // Ambil data pasien terpisah untuk PatientInfoCard
                          Consumer<PatientProvider>(
                            builder: (context, patientProvider, patientChild) {
                              if (patientProvider.isLoading) {
                                return const CircularProgressIndicator();
                              } else if (patientProvider.patient != null) {
                                final patient = patientProvider.patient!;
                                return PatientInfoCard(
                                    patient: patient,
                                    medicalRecord:
                                        medicalRecord); // Meneruskan kedua objek
                              } else {
                                return const Text(
                                    'Data pasien tidak tersedia.');
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          TreatmentHistory(
                              medicalRecord:
                                  medicalRecord), // Meneruskan objek MedicalRecord
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: Text('Tidak ada data medical record tersedia.'));
          }
        },
      ),
    );
  }
}
