  import 'package:flutter/material.dart';
  import '../models/patients/patient_model.dart';
  import '../services/patient_service.dart';

  class PatientProvider with ChangeNotifier {
    Patient? _patient;
    bool _isLoading = false;

    Patient? get patient => _patient;
    bool get isLoading => _isLoading;

    Future<void> fetchPatientData() async {
      _isLoading = true;
      notifyListeners();

      try {
        PatientService patientService = PatientService();
        _patient = await patientService.getPatientData();

        if (_patient != null) {
          // Jika berhasil mendapatkan data pasien
          notifyListeners();
        } else {
          // Handle jika gagal
          throw Exception('Failed to load patient data');
        }
      } catch (e) {
        // Handle error
        _patient = null;
        throw Exception('Error: $e');
      } finally {
        _isLoading = false;
        notifyListeners(); // Update UI setelah proses selesai
      }
    }
  }
