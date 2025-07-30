import 'package:flutter/material.dart';
import 'package:pgcard/providers/patient_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pgcard/providers/medical_record_provider.dart';
import 'package:pgcard/models/medical_record/medical_record_model.dart';
import 'package:pgcard/widgets/patient/patient_info_card.dart';
import 'package:pgcard/widgets/patient/treatment_history_card.dart';

class PatientCardScreen extends StatefulWidget {
  const PatientCardScreen({super.key});

  @override
  _PatientCardScreenState createState() => _PatientCardScreenState();
}

class _PatientCardScreenState extends State<PatientCardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MedicalRecordProvider>(context, listen: false)
          .fetchMedicalRecordData();

      Provider.of<PatientProvider>(context, listen: false).fetchPatientData();
    });
  }

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
        builder: (context, medicalRecordProvider, child) {
          if (medicalRecordProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (medicalRecordProvider.medicalRecord != null) {
            final medicalRecord = medicalRecordProvider.medicalRecord!;
            final qrDataString = _generateQrData(medicalRecord);

            return Center(
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
                    Column(
                      children: [
                        Consumer<PatientProvider>(
                          builder: (context, patientProvider, patientChild) {
                            if (patientProvider.isLoading) {
                              return const CircularProgressIndicator();
                            } else if (patientProvider.patient != null) {
                              final patient = patientProvider.patient!;
                              return Center(
                                child: SizedBox(
                                  width: 350,
                                  child: PatientInfoCard(
                                      patient: patient,
                                      medicalRecord: medicalRecord),
                                ),
                              );
                            } else {
                              return const Text('Data pasien tidak tersedia.');
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 350,
                            child:
                                TreatmentHistory(medicalRecord: medicalRecord),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
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
