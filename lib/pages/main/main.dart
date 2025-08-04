import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pgcard/pages/main/navigation/home/home.dart';
import 'package:pgcard/pages/main/navigation/appoitment/patient.dart';
import 'package:pgcard/pages/main/navigation/profile/profile.dart';
import 'package:pgcard/pages/main/navigation/setings/settings.dart';
import 'package:pgcard/pages/main/doctor/scanqr.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const PatientCardScreen(),
    const ProfileScreen(),
    const SettingScreen(),
    // const ScanQrScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: _selectedIndex == 0 ? Color(0xFF4C4DDC) : Colors.black,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/calender.svg',
              color: _selectedIndex == 1 ? Color(0xFF4C4DDC) : Colors.black,
            ),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              color: _selectedIndex == 2 ? Color(0xFF4C4DDC) : Colors.black,
            ),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              color: _selectedIndex == 3 ? Color(0xFF4C4DDC) : Colors.black,
            ),
            label: 'Pengaturan',
          ),
        ],
        selectedItemColor: Color(0xFF4C4DDC),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
