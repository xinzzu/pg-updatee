import 'package:flutter/material.dart';
import 'package:pgcard/pages/main/doctor/scanqr.dart';
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
import 'package:pgcard/services/auth_service.dart';
import 'package:pgcard/providers/medical_record_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // PERUBAHAN DI SINI: Validasi token sebelum menentukan initialRoute
  AuthService authService = AuthService();
  bool isAuthenticated =
      await authService.validateToken(); // Coba validasi token

  String initialRoute;
  if (isAuthenticated) {
    initialRoute = '/home'; // Jika token valid, langsung ke homepage
  } else {
    initialRoute = '/onboarding'; // Jika token tidak valid, ke onboarding/login
  }
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

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
        ChangeNotifierProvider(create: (_) => MedicalRecordProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: initialRoute,
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const MainScreen(),
          '/onboarding': (context) => Onboarding(),
          '/patient_card': (context) => const PatientCardScreen(),
          // '/scan_qr': (context) => const ScanQrScreen(),
        },
      ),
    );
  }
}
