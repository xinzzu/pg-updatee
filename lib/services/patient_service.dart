import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/patients/patient_model.dart';
import 'package:logger/logger.dart';

class PatientService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<Patient?> getPatientData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        _logger.e('No token found.');
        return null;
      }

      final response = await _dio.get(
        'http://10.4.52.201:8000/api/patient',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        _logger.i('Patient data retrieved successfully');
        return Patient.fromJson(response.data['data']);
      } else {
        _logger.e('Failed to retrieve patient data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('Error during fetching patient data: $e');
      return null;
    }
  }
}
