import 'package:flutter/material.dart';
import 'package:pgcard/pages/main/navigation/home/search/search_doctor_screen.dart';
import 'package:pgcard/widgets/home/header_top.dart';
import 'package:provider/provider.dart';
import 'package:pgcard/models/doctor/doctor_model.dart';
import 'package:pgcard/providers/doctor_provider.dart';
import 'package:pgcard/widgets/home/doctor_card.dart';
import 'package:pgcard/widgets/home/favorite_doctor_card.dart';
import '../../../../widgets/home/search_bar.dart';
import '../../../../utils/responsive.dart';
import 'detail_doctor.dart';
import 'package:pgcard/services/patient_service.dart';
import 'package:pgcard/models/patients/patient_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Responsive responsive;
  Future<Patient?> _getPatientData() async {
    PatientService patientService = PatientService();
    return await patientService.getPatientData();
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<DoctorProvider>(context, listen: false).fetchDoctors());
  }

  void _onFavoriteDoctorPressed(Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentDetailScreen(doctor: doctor),
      ),
    );
  }

  void _onBestDoctorPressed(Doctor doctor) {
    print('Best doctor pressed: ${doctor.fullName}');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentDetailScreen(doctor: doctor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    responsive = Responsive(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          FutureBuilder<Patient?>(
            future: _getPatientData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomHeader(
                  userName: 'Loading...',
                  bottomChild: const CustomSearchBar(),
                );
              } else if (snapshot.hasError) {
                return CustomHeader(
                  userName: 'Error fetching data',
                  bottomChild: const CustomSearchBar(),
                );
              } else if (snapshot.hasData) {
                final patient = snapshot.data!;
                return CustomHeader(
                  userName: patient.fullName,
                  bottomChild: const CustomSearchBar(),
                );
              } else {
                return CustomHeader(
                  userName: 'No data found',
                  bottomChild: const CustomSearchBar(),
                );
              }
            },
          ),
          Expanded(
            child: Consumer<DoctorProvider>(
              builder: (context, doctorProvider, _) {
                if (doctorProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final doctors = doctorProvider.doctors;

                final favoriteDoctors = doctors.take(3).toList();
                final bestDoctors = doctors.skip(3).take(4).toList();

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    responsive.wp(6),
                    responsive.hp(1),
                    responsive.wp(6),
                    responsive.wp(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dokter Praktek",
                            style: TextStyle(
                              fontSize: responsive.wp(4.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const SearchDoctorScreen()),
                                );
                              },
                              child: Text(
                                "Tampilkan",
                                style: TextStyle(fontSize: responsive.wp(3)),
                              ))
                        ],
                      ),
                      SizedBox(height: responsive.hp(1)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: favoriteDoctors.map((doctor) {
                            return Padding(
                              padding: EdgeInsets.only(right: responsive.wp(3)),
                              child: FavoriteDoctorCard(
                                doctor: doctor,
                                onTap: () => _onFavoriteDoctorPressed(doctor),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: responsive.hp(2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dokter Praktek Terbaik',
                            style: TextStyle(
                              fontSize: responsive.wp(4.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SearchDoctorScreen()),
                              );
                            },
                            child: Text(
                              'Tampilkan',
                              style: TextStyle(fontSize: responsive.wp(3)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsive.hp(1)),
                      ...bestDoctors.map((doctor) {
                        return DoctorCard(
                          doctor: doctor,
                          onTap: () => _onBestDoctorPressed(doctor),
                          onFavoriteTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Ditambahkan Ke Favorit"),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
