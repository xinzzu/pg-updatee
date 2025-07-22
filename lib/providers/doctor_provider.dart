// // providers/doctor_provider.dart

// import 'package:flutter/material.dart';
// import '../models/doctor/doctor_model.dart';
// import '../services/doctor_service.dart';

// class DoctorProvider with ChangeNotifier {
//   List<Doctor> _doctors = [];
//   bool _isLoading = false;

//   final List<Doctor> _favoriteDoctors = []; // ⬅️ Tambahan

//   List<Doctor> get doctors => _doctors;
//   bool get isLoading => _isLoading;

//   List<Doctor> get favoriteDoctors => _favoriteDoctors; // ⬅️ Tambahan

//   Future<void> fetchDoctors() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       DoctorService doctorService = DoctorService();
//       _doctors = await doctorService.fetchDoctors();
//     } catch (e) {
//       _doctors = [];
//       throw Exception('Error: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void toggleFavorite(Doctor doctor) {
//     // ⬅️ Tambahan
//     if (_favoriteDoctors.contains(doctor)) {
//       _favoriteDoctors.remove(doctor);
//     } else {
//       _favoriteDoctors.add(doctor);
//     }
//     notifyListeners();
//   }

//   bool isFavorite(Doctor doctor) {
//     // ⬅️ Tambahan
//     return _favoriteDoctors.contains(doctor);
//   }
// }
import 'package:flutter/material.dart';
import '../models/doctor/doctor_model.dart';
import '../services/doctor_service.dart';

class DoctorProvider with ChangeNotifier {
  List<Doctor> _doctors = [];
  final Set<int> _favoriteDoctorIds = {}; // ✅ Ubah ke Set<int>
  bool _isLoading = false;
  bool _hasFetched = false;

  List<Doctor> get doctors => _doctors;

  List<Doctor> get favoriteDoctors =>
      _doctors.where((doc) => _favoriteDoctorIds.contains(doc.id)).toList();

  bool get isLoading => _isLoading;

  Future<void> fetchDoctors() async {
    if (_hasFetched) return;

    _isLoading = true;
    notifyListeners();

    try {
      final service = DoctorService();
      final fetched = await service.fetchDoctors();
      _doctors = fetched;
      _hasFetched = true;
    } catch (e) {
      _doctors = [];
      debugPrint("Error fetching doctors: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(Doctor doctor) {
    if (_favoriteDoctorIds.contains(doctor.id)) {
      _favoriteDoctorIds.remove(doctor.id);
    } else {
      _favoriteDoctorIds.add(doctor.id);
    }
    notifyListeners();
  }

  bool isFavorite(Doctor doctor) {
    return _favoriteDoctorIds.contains(doctor.id);
  }
}
