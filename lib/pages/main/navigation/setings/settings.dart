import 'package:flutter/material.dart';
import 'package:pgcard/pages/main/navigation/setings/favorite/favorite.dart';
import 'package:pgcard/pages/main/navigation/setings/terms%20and%20condition/terms.dart';
import 'package:pgcard/widgets/setings/settings.dart';
import 'package:pgcard/widgets/setings/settings_menu_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pgcard/utils/show_logout_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pgcard/providers/patient_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: const Text(
                    'Pengaturan',
                    style: TextStyle(
                      color: Color(0xFF101010),
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<PatientProvider>(
                  builder: (context, patientProvider, child) {
                    final patient = patientProvider.patient;

                    if (patientProvider.isLoading) {
                      return const CircularProgressIndicator();
                    }

                    if (patient != null) {
                      return SettingsHeader(
                        name: patient.fullName,
                        phoneNumber: patient.phoneNumber,
                      );
                    } else {
                      return const Text(
                        'Data pasien tidak tersedia',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }
                  },
                ),
                SettingMenuItem(
                  iconPath: 'assets/icons/profile/favorite.svg',
                  title: 'Favorit',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoriteScreen()),
                    );
                  },
                ),
                SettingMenuItem(
                  iconPath: 'assets/icons/profile/terms.svg',
                  title: 'Syarat dan Ketentuan',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermConditionScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => showLogoutDialog(context),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/profile/logout.svg',
                        width: 34,
                        height: 31,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Keluar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
