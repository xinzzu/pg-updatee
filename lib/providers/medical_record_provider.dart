import 'package:flutter/material.dart';
import 'package:pgcard/models/medical_record/medical_record_model.dart'; // Import model
import 'package:pgcard/services/medical_record_service.dart'; // Import service

class MedicalRecordProvider with ChangeNotifier {
  MedicalRecord? _medicalRecord;
  bool _isLoading = false;

  MedicalRecord? get medicalRecord => _medicalRecord;
  bool get isLoading => _isLoading;

  Future<void> fetchMedicalRecordData() async {
    _isLoading = true;
    notifyListeners();

    try {
      MedicalRecordService service = MedicalRecordService();
      _medicalRecord = await service.getMedicalRecord();

      if (_medicalRecord == null) {
        throw Exception('Failed to load medical record data');
      }
    } catch (e) {
      _medicalRecord = null;
      debugPrint('Error fetching medical record: $e');
      // Anda bisa menambahkan pesan error ke UI jika diperlukan
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
