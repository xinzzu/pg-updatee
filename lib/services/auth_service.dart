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
  final String _baseUrl = 'http://10.4.52.201:8000/api/auth/login';
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

  // Tambahkan metode ini untuk mengambil token
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('token'); // Mengembalikan token jika ada, null jika tidak
  }
}
