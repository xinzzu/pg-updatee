import 'package:flutter/material.dart';
import 'package:pgcard/pages/main/navigation/home/detail_doctor.dart';
import 'package:provider/provider.dart';
import 'package:pgcard/models/doctor/doctor_model.dart';
import 'package:pgcard/providers/doctor_provider.dart';
import 'package:pgcard/widgets/home/doctor_card.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({Key? key}) : super(key: key);

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  String searchText = '';

  @override
  void initState() {
    super.initState();
    // Fetch doctors dari provider
    Future.microtask(() {
      Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value.toLowerCase();
    });
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onDoctorTap(Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentDetailScreen(doctor: doctor),
      ),
    );
  }

  void _onFavoriteTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ditambahkan ke Favorit')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<DoctorProvider>(
          builder: (context, doctorProvider, _) {
            final allDoctors = doctorProvider.doctors;
            final filteredDoctors = allDoctors.where((doctor) {
              return doctor.fullName.toLowerCase().contains(searchText);
            }).toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Header
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _onBackPressed,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Pencarian Dokter',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search Input
                  TextField(
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Cari Dokter',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Jumlah hasil ditemukan
                  Text(
                    '${filteredDoctors.length} found',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // List dokter hasil pencarian
                  Expanded(
                    child: ListView.separated(
                      itemCount: filteredDoctors.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final doctor = filteredDoctors[index];
                        return DoctorCard(
                          doctor: doctor,
                          onTap: () => _onDoctorTap(doctor),
                          onFavoriteTap: _onFavoriteTap,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
