// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:pgcard/api/login_api.dart';
// import 'package:pgcard/models/login_response.dart';

// class LoginProvider extends ChangeNotifier {
//   bool _isLoading = false;
//   String? _errorMessage;
//   LoginResponse? _loginResponse;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   LoginResponse? get loginResponse => _loginResponse;

//   final LoginApi _loginApi = LoginApi(Dio()); // Instance dari Retrofit service

//   Future<void> login(String rm, String password) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       _loginResponse = await _loginApi.login(rm, password);
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class LoginProvider extends ChangeNotifier {
//   bool isLoading = false;
//   String? errorMessage;

//   Future<void> login(String rm, String password) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       // Ganti ini dengan URL endpoint API login Anda
//       var response = await Dio().post(
//         'https://554e-2001-448a-404e-6f07-117f-3561-f8de-3f01.ngrok-free.app',
//         data: {
//           'email': rm,
//           'password': password,
//         },
//       );

//       // Log respons di console
//       print('API response: ${response.data}');

//       if (response.statusCode == 200) {
//         // Log success jika status 200 (OK)
//         print('Login successful: ${response.data}');
//         // TODO: Navigasi ke halaman berikutnya atau simpan data login
//       } else {
//         // Jika status code bukan 200, anggap login gagal
//         errorMessage =
//             'Login gagal. Status: ${response.statusCode}, Body: ${response.data}';
//         print(errorMessage); // Log error
//       }
//     } catch (e) {
//       // Tangkap error dari Dio dan log di console
//       errorMessage = 'Terjadi kesalahan saat login: $e';
//       print(errorMessage);
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart'; // Tambahkan import logger
// import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Tambahkan import untuk secure storage

// class LoginProvider extends ChangeNotifier {
//   bool isLoading = false;
//   String? errorMessage;

//   // Buat instance logger
//   final Logger _logger = Logger();

//   // Buat instance untuk secure storage
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   Future<void> login(String rm, String password) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       // Ganti dengan URL endpoint API login yang baru
//       var response = await Dio().post(
//         'http://192.168.100.228:8000/admin/login',
//         data: {
//           'email': rm, // No RM di-submit sebagai email
//           'password': password, // Password tetap sebagai password
//         },
//       );

//       if (response.statusCode == 200) {
//         // Jika login berhasil
//         _logger.i('Login successful: ${response.data}');

//         // Ambil token dari response di dalam 'data'
//         String accessToken = response.data['data']['access_token'];
//         String refreshToken = response.data['data']['refresh_token'];

//         // Simpan token di local storage
//         await _storage.write(key: 'access_token', value: accessToken);
//         await _storage.write(key: 'refresh_token', value: refreshToken);

//         _logger.i('Access token saved: $accessToken');
//         _logger.i('Refresh token saved: $refreshToken');

//         // Lakukan hal lain, seperti navigasi
//       } else {
//         // Jika status code bukan 200, anggap login gagal
//         errorMessage = 'Login gagal. Cek kembali No RM dan Password.';
//         _logger.e('Error: $errorMessage');
//       }
//     } catch (e) {
//       // Tangkap error dari Dio dan log di console
//       errorMessage = 'Terjadi kesalahan saat login: $e';
//       _logger.e('Error: $errorMessage');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:pgcard/services/auth_service.dart'; // Ganti dengan path sebenarnya

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String rm, String password) async {
    _isLoading = true;
    notifyListeners(); // Update UI to show loading state

    try {
      AuthService authService = AuthService();
      final result = await authService.login(rm, password);

      _isLoading = false; // Make sure loading is stopped after result
      notifyListeners();

      if (result['success']) {
        // Handle successful login
        return true;
      } else {
        // Show error notification if login fails
        throw Exception(result['message'] ?? 'Login failed');
      }
    } catch (e) {
      // Handle error, ensure loading is stopped
      _isLoading = false;
      notifyListeners();
      rethrow; // Allow error to be caught in LoginScreen
    }
  }
}
