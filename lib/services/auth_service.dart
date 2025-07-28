// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   final String _baseUrl = 'http://192.168.100.228:8000/api/auth/login';

//   Future<Map<String, dynamic>> login(String rm, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse(_baseUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'medical_record_number': rm,
//           'password': password,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Save token to SharedPreferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString(
//             'token', data['token']); // Adjust token key as per your response

//         return {'success': true, 'data': data};
//       } else {
//         final errorData = jsonDecode(response.body);
//         return {
//           'success': false,
//           'message': errorData['message'] ?? 'Login failed'
//         };
//       }
//     } catch (e) {
//       return {'success': false, 'message': 'An error occurred: $e'};
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:8000/api/auth/login';
  final Logger _logger = Logger();

  Future<Map<String, dynamic>> login(String rm, String password) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: {
          'medical_record_number': rm,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final success = response.data['meta']['success'];
        final message = response.data['meta']['message'] ?? 'Login failed';

        if (success) {
          final accessToken = response.data['data']?['access_token'];

          if (accessToken != null) {
            // Simpan token ke SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', accessToken);

            _logger.i('Login successful, token saved.');
            return {'success': true, 'data': accessToken};
          } else {
            _logger.e('Access token is null');
            return {'success': false, 'message': 'Access token not found'};
          }
        } else {
          _logger.e('Login error: $message');
          return {
            'success': false,
            'message': message
          }; // Mengembalikan pesan dari server
        }
      } else {
        _logger.e('Unexpected status code: ${response.statusCode}');
        return {'success': false, 'message': 'Unexpected error occurred'};
      }
    } catch (e) {
      _logger.e('Error during login: $e');
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // Fungsi logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Hapus token dari SharedPreferences
    _logger.i('Logout successful, token removed.');
  }

  // Metode untuk mengambil token
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Metode baru untuk memvalidasi token
  Future<bool> validateToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return false; // Tidak ada token, berarti tidak valid
    }

    try {
      // Ganti dengan endpoint validasi token yang sebenarnya,
      // atau endpoint ringan yang memerlukan otentikasi.
      // Contoh: endpoint profil pengguna atau endpoint status.
      // Jika endpoint ini mengembalikan 200 OK, token dianggap valid.
      final response = await _dio.get(
        'http://10.0.2.2:8000/api/patient', // Contoh: gunakan endpoint pasien
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Jika status code 200, token valid
      if (response.statusCode == 200 &&
          response.data['meta']['success'] == true) {
        _logger.i('Token is valid.');
        return true;
      } else {
        // Jika status code bukan 200 atau meta.success false, token tidak valid
        _logger.w(
            'Token validation failed: Status ${response.statusCode}, Message: ${response.data['meta']['message']}');
        await logout(); // Hapus token yang tidak valid
        return false;
      }
    } on DioException catch (e) {
      // Tangani error jaringan atau respons non-2xx
      _logger.e('Token validation DioError: ${e.message}');
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        // Jika 401 Unauthorized atau 403 Forbidden, token tidak valid
        _logger.w('Token is unauthorized or forbidden. Logging out.');
        await logout(); // Hapus token yang tidak valid
      }
      return false;
    } catch (e) {
      _logger.e('Unexpected error during token validation: $e');
      return false;
    }
  }
}
