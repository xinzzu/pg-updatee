import 'package:flutter/material.dart';

class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({Key? key}) : super(key: key);

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
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
                    onPressed: () => _onBackPressed(context),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Syarat Ketentuan',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Added terms and conditions text
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(
                    child: Text(
                      'Kami sangat menghargai privasi Anda. Dengan menyetujui Syarat & Ketentuan ini, Anda memahami dan menyetujui bahwa kami dapat mengumpulkan, menyimpan, dan menggunakan data pribadi yang Anda berikan untuk tujuan berikut:\n'
                      '• Menyediakan dan meningkatkan layanan aplikasi.\n'
                      '• Memfasilitasi komunikasi yang relevan dengan penggunaan Anda.\n'
                      '• Melakukan analisis anonim untuk riset dan pengembangan.\n'
                      '• Mematuhi kewajiban hukum yang berlaku.\n\n'
                      'Penting: Data Anda akan dijaga kerahasiaannya sesuai dengan Kebijakan Privasi kami yang dapat diakses melalui link yang tersedia dalam aplikasi. Kami tidak akan membagikan data pribadi Anda kepada pihak ketiga tanpa persetujuan Anda, kecuali diwajibkan oleh hukum.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
