import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pgcard/pages/main/navigation/profile/edit%20profile/profile_information_screen.dart';
import 'package:pgcard/providers/patient_provider.dart';
import 'package:pgcard/utils/bmi_checker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false).fetchPatientData();
    });
  }

  String _translateMaritalStatus(String status) {
    debugPrint('Translating marital status: $status');
    switch (status.toLowerCase()) {
      case 'single':
        return 'Belum Menikah';
      case 'married':
        return 'Menikah';
      case 'divorced':
        return 'Cerai';
      default:
        return status;
    }
  }

  String _translateGender(String gender) {
    debugPrint('Translating gender: $gender');
    switch (gender.toLowerCase()) {
      case 'male':
        return 'Laki-laki';
      case 'female':
        return 'Perempuan';
      default:
        return gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<PatientProvider>(
              builder: (context, patientProvider, child) {
                final patient = patientProvider.patient;

                if (patientProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (patient != null) {
                  return Container(
                    constraints: const BoxConstraints(maxWidth: 480),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            const Center(
                              child: Text(
                                'Informasi Profil',
                                style: TextStyle(
                                  color: Color(0xFF101010),
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            child: ProfilePicture(
                              name: patient.fullName,
                              radius: 53,
                              fontsize: 40,
                              random: true,
                            ),
                          ),
                        ),
                        _buildProfileItem('Nama', patient.fullName),
                        _buildProfileItem('NIK', patient.nationalId),
                        _buildProfileItem('Tanggal Lahir', patient.dateOfBirth),
                        _buildProfileItem(
                            'Jenis Kelamin', _translateGender(patient.gender)),
                        _buildProfileItem('Alamat', patient.address),
                        _buildProfileItem('Nomor Telepon', patient.phoneNumber),
                        _buildProfileItem('Agama', patient.religion),
                        _buildProfileItem('Pekerjaan', patient.occupation),
                        _buildProfileItem('Pendidikan', patient.education),
                        _buildProfileItem('Status Pernikahan',
                            _translateMaritalStatus(patient.maritalStatus)),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Data pasien tidak tersedia'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF101010),
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF101010),
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
