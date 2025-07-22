import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import 'package:pgcard/pages/main/navigation/profile/edit%20profile/profile_information_screen.dart';
import 'package:pgcard/providers/patient_provider.dart';
import 'package:pgcard/utils/bmi_checker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch patient data on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false).fetchPatientData();
    });
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
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header dengan Stack untuk membuat teks di tengah
                        Stack(
                          children: [
                            // Teks "Informasi Profil" di tengah
                            Center(
                              child: const Text(
                                'Informasi Profil',
                                style: TextStyle(
                                  color: Color(0xFF101010),
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // Ikon edit di posisi kanan
                            // Positioned(
                            //   right: 0,
                            //   child: InkWell(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) =>
                            //               ProfileInformationScreen(),
                            //         ),
                            //       );
                            //     },
                            //     child: SvgPicture.asset(
                            //       'assets/icons/profile/edit.svg',
                            //       width: 24,
                            //       height: 24,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Profile Image
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            child: CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                            ),
                          ),
                        ),

                        // Profile Details in Text form
                        _buildProfileItem('Nama', patient.fullName),
                        _buildProfileItem('NIK', patient.nationalId),
                        _buildProfileItem('Tanggal Lahir', patient.dateOfBirth),
                        _buildProfileItem('Jenis Kelamin', patient.gender),
                        _buildProfileItem('Alamat', patient.address),
                        _buildProfileItem('Nomor Telepon', patient.phoneNumber),
                        _buildProfileItem('Agama', patient.religion),
                        _buildProfileItem('Pekerjaan', patient.occupation),
                        _buildProfileItem('Pendidikan', patient.education),
                        _buildProfileItem(
                            'Status Pernikahan', patient.maritalStatus),
                        _buildProfileItem(
                            'Tinggi Badan', '${patient.height} cm'),
                        _buildProfileItem(
                            'Berat Badan', '${patient.weight} kg'),
                        _buildProfileItem('Index Masa Tubuh',
                            bmiChecker(70, 172, patient.gender.toString()))
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

  // Widget helper untuk menampilkan item profil
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
