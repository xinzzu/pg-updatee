import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.4.52.201:8000/api/auth/login';
  final Logger _logger = Logger();

  Future<Map<String, dynamic>> login(String rm, String password) async {
    try {
      print('Payload: $rm, $password');
      final response = await _dio.post(
        'http://10.4.52.201:8000/api/auth/login',
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

      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        final success = response.data['meta']['success'];
        final message = response.data['meta']['message'] ?? 'Login failed';

        if (success) {
          final accessToken = response.data['data']?['access_token'];

          if (accessToken != null) {
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
          return {'success': false, 'message': message};
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

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _logger.i('Logout successful, token removed.');
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> validateToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      return false;
    }

    try {
      final response = await _dio.get(
        'http://10.4.52.201:8000/api/patient',
        // 'http://10.4.52.201:8000/api/auth/login',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 &&
          response.data['meta']['success'] == true) {
        _logger.i('Token is valid.');
        return true;
      } else {
        _logger.w(
            'Token validation failed: Status ${response.statusCode}, Message: ${response.data['meta']['message']}');
        await logout();
        return false;
      }
    } on DioException catch (e) {
      _logger.e('Token validation DioError: ${e.message}');
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        _logger.w('Token is unauthorized or forbidden. Logging out.');
        await logout();
      }
      return false;
    } catch (e) {
      _logger.e('Unexpected error during token validation: $e');
      return false;
    }
  }
}
