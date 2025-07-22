import 'package:flutter/material.dart';
import 'package:pgcard/pages/main/navigation/home/detail_doctor.dart';
import 'package:pgcard/pages/main/navigation/home/home.dart';
import 'package:pgcard/pages/login/login.dart';
import 'package:pgcard/pages/main/main.dart';
import 'package:pgcard/pages/onboarding.dart';
import 'package:pgcard/pages/main/navigation/appoitment/patient.dart';
import 'package:pgcard/pages/main/navigation/setings/settings.dart';
import 'package:pgcard/providers/login_provider.dart';
import 'package:pgcard/providers/patient_provider.dart';
import 'package:provider/provider.dart';
import 'package:pgcard/utils/app_style.dart';
import 'package:pgcard/providers/doctor_provider.dart';
import 'package:pgcard/services/auth_service.dart'; // Pastikan ini sudah diimpor

void main() async {
  // PERUBAHAN DI SINI: Inisialisasi binding dan periksa token
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await AuthService()
      .getAuthToken(); // Asumsi AuthService memiliki metode getAuthToken()
  String initialRoute;
  if (token != null) {
    initialRoute = '/home'; // Jika token ada, langsung ke homepage
  } else {
    initialRoute = '/onboarding'; // Jika tidak, ke onboarding
  }
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute; // Tambahkan properti initialRoute

  // PERUBAHAN DI SINI: Konstruktor baru untuk menerima initialRoute
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    AppStyle(screenSize: screenSize);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: initialRoute, // Gunakan initialRoute yang ditentukan
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const MainScreen(),
          '/onboarding': (context) => Onboarding(),
        },
      ),
    );
  }
}
