// Path: lib/pages/main/navigation/appoitment/patient.dart

import 'dart:convert'; // Diperlukan untuk jsonEncode
import 'package:flutter/material.dart';
import 'package:pgcard/models/patients/patient_model.dart'; // Import model Patient Anda
import 'package:pgcard/services/patient_service.dart'; // Import service Patient Anda
import 'package:qr_flutter/qr_flutter.dart'; // Import library qr_flutter

// Import widget custom Anda
import 'package:pgcard/widgets/patient/header_section.dart';
import 'package:pgcard/widgets/patient/patient_info_card.dart';
import 'package:pgcard/widgets/patient/treatment_history_card.dart';

// Opsional: jika Anda memiliki Navbar di sini (biasanya ada di MainScreen)
// import 'package:pgcard/ui/navbar.dart';
// import 'package:pgcard/widgets/patient/contact_button.dart'; // Jika ingin mengaktifkan lagi

class PatientCardScreen extends StatefulWidget {
  const PatientCardScreen({Key? key}) : super(key: key);

  @override
  _PatientCardScreenState createState() => _PatientCardScreenState();
}

class _PatientCardScreenState extends State<PatientCardScreen> {
  // Future untuk mengambil data pasien
  late Future<Patient?> _patientDataFuture;

  @override
  void initState() {
    super.initState();
    // Memanggil service untuk ambil data pasien saat screen dimuat
    _patientDataFuture = PatientService().getPatientData();
  }

  // Fungsi Kunci: Mengonversi objek Patient menjadi string JSON untuk QR Code
  // Anda tinggal memodifikasi bagian ini untuk memilih atribut
  String _generateQrData(Patient patient) {
    // Definisi data yang akan dimasukkan ke QR Code
    // Anda bisa menambah, mengurangi, atau mengubah atribut di sini
    final Map<String, dynamic> qrData = {
      'medical_record_number': patient.medicalRecordNumber, // Mengambil No RM
      'full_name': patient.fullName, // Mengambil Nama Lengkap
      'date_of_birth': patient.dateOfBirth, // Mengambil Tanggal Lahir
      'gender': patient.gender, // Mengambil Jenis Kelamin
      'allergies': patient.allergies?.join(', ') ??
          'Tidak ada alergi', // Mengambil Alergi Obat
      'treatment_history_dmt2': patient.treatmentHistory?.join(', ') ??
          'Tidak ada riwayat', // Mengambil Riwayat Pengobatan DMT2
      // Anda bisa menambahkan atribut lain yang relevan dari patient_model.dart di sini
      // Contoh: 'blood_type': patient.bloodType,
      // Contoh: 'genotype_info': patient.genotypeInfo,
    };
    return jsonEncode(qrData); // Mengonversi Map data menjadi string JSON
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(44), // Lower the height (default is 56)
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(
                top: 20), // Adjust vertical position if needed
            child: Text(
              'PgCard Digital',
              style: const TextStyle(
                color: Color(0xFF101010),
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<Patient?>(
        future: _patientDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final patient = snapshot.data!;
            final qrDataString =
                _generateQrData(patient); // Memanggil fungsi untuk data QR Code

            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                constraints: const BoxConstraints(maxWidth: 480),
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    const SizedBox(height: 4), // Padding atas seperti kode lama

                    // Bagian Header yang kini berisi QR Code Dinamis
                    // Mengganti HeaderSection dengan QrImageView langsung untuk QR Code
                    Center(
                      child: QrImageView(
                        // Widget dari library qr_flutter
                        data:
                            qrDataString, // Menggunakan string JSON dari data pasien
                        version: QrVersions.auto,
                        size: 290.0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        errorStateBuilder: (cxt, err) {
                          return const Center(
                            child: Text('Oops! Gagal membuat QR Code.',
                                textAlign: TextAlign.center),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 4), // Spasi setelah QR Code

                    // Padding dan layout konten utama lainnya tetap dipertahankan
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          // Catatan: HeaderSection yang lama mungkin memiliki elemen lain selain gambar QR.
                          // Jika ada, elemen-elemen tersebut perlu dipindahkan ke sini atau diatur ulang.
                          // Saat ini, QrImageView menggantikan lokasi gambar statis.

                          // Penting: PatientInfoCard dan TreatmentHistory perlu diupdate
                          // agar menerima dan menampilkan data dari objek 'patient'.
                          // Contoh: PatientInfoCard(patient: patient)
                          PatientInfoCard(
                              patient:
                                  patient), // Perlu modifikasi PatientInfoCard untuk menerima 'patient'
                          const SizedBox(height: 20),
                          TreatmentHistory(
                              patient:
                                  patient), // Perlu modifikasi TreatmentHistory untuk menerima 'patient'
                          const SizedBox(height: 20),
                          // const ContactButton(), // Tetap dikomentari seperti kode lama
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Tidak ada data pasien tersedia.'));
          }
        },
      ),
      // bottomNavigationBar: const BottomNav(), // Diasumsikan BottomNav diatur di MainScreen
    );
  }
}
