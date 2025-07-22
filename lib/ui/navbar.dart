import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'package:pgcard/pages/main/navigation/home/home.dart';
import 'package:pgcard/pages/main/navigation/appoitment/patient.dart';
import 'package:pgcard/pages/main/navigation/profile/profile.dart'; // Tambahkan halaman Chat
import 'package:pgcard/pages/main/navigation/setings/settings.dart'; // Tambahkan halaman Profile

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0; // Menyimpan indeks item yang dipilih

  // Fungsi untuk mengganti halaman dan warna ikon
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi ke halaman yang sesuai
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PatientCardScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.14),
            blurRadius: 30,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Home
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 30,
              height: 30,
              color: _selectedIndex == 0
                  ? Color(0xFF4C4DDC)
                  : Colors.grey, // Warna berubah saat dipilih
            ),
            onPressed: () {
              _onItemTapped(0);
            },
          ),
          const SizedBox(width: 34),

          // Icon Kalender
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/calender.svg',
              width: 30,
              height: 30,
              color: _selectedIndex == 1
                  ? Color(0xFF4C4DDC)
                  : Colors.grey, // Warna berubah saat dipilih
            ),
            onPressed: () {
              _onItemTapped(1);
            },
          ),
          const SizedBox(width: 34),

          // Icon Chat
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/chat.svg',
              width: 30,
              height: 30,
              color: _selectedIndex == 2
                  ? Color(0xFF4C4DDC)
                  : Colors.grey, // Warna berubah saat dipilih
            ),
            onPressed: () {
              _onItemTapped(2);
            },
          ),
          const SizedBox(width: 34),

          // Icon Profile
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 30,
              height: 30,
              color: _selectedIndex == 3
                  ? Color(0xFF4C4DDC)
                  : Colors.grey, // Warna berubah saat dipilih
            ),
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }
}
