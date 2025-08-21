import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:pgcard/models/medical_record/medical_record_model.dart';

class MedicalRecordService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  final String _baseUrl =
      'https://web-production-433dd.up.railway.app/api/medical-record';

  Future<MedicalRecord?> getMedicalRecord() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        _logger.e('No token found for medical record.');
        return null;
      }

      final response = await _dio.get(
        _baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final success = response.data['meta']['success'];
        if (success) {
          _logger.i('Medical record data retrieved successfully');
          return MedicalRecord.fromJson(response.data['data']);
        } else {
          _logger.e(
              'Failed to retrieve medical record data: ${response.data['meta']['message']}');
          return null;
        }
      } else {
        _logger.e(
            'Unexpected status code for medical record: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('Error during fetching medical record data: $e');
      return null;
    }
  }
}
