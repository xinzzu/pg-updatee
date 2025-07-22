import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import '../models/doctor/doctor_model.dart';

class DoctorService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<List<Doctor>> fetchDoctors() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        _logger.e('No token found.');
        throw Exception('Token tidak ditemukan. Harap login ulang.');
      }

      final response = await _dio.get(
        'http://10.4.52.201:8000/api/doctors', // Ganti sesuai environment (10.0.2.2 utk emulator)
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        _logger.i('Berhasil mengambil data dokter');
        return data.map((json) => Doctor.fromJson(json)).toList();
      } else {
        _logger.e('Gagal mengambil data dokter: ${response.statusCode}');
        throw Exception('Gagal mengambil data dokter');
      }
    } catch (e) {
      _logger.e('Error saat mengambil data dokter: $e');
      throw Exception('Error saat mengambil data dokter: $e');
    }
  }
}
