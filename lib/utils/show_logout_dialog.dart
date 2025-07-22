import 'package:flutter/material.dart';
import 'package:pgcard/pages/login/login.dart';
import 'package:pgcard/services/auth_service.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      // Gunakan dialogContext untuk dialog
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Konfirmasi Keluar"),
        content: const Text("Apakah kamu yakin ingin keluar?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext)
                  .pop(); // Tutup dialog menggunakan dialogContext
            },
            child: const Text("Tidak"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop(); // Tutup dialog terlebih dahulu

              final authService = AuthService();
              await authService.logout(); // Hapus token

              // PERBAIKAN DI SINI: Periksa apakah context masih mounted sebelum navigasi
              // Menggunakan context asli yang diteruskan ke fungsi showLogoutDialog
              if (!context.mounted) return;

              // Navigasi ke halaman login
              Navigator.of(context).pushAndRemoveUntil(
                // Gunakan pushAndRemoveUntil
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) =>
                    false, // Ini akan menghapus semua rute sebelumnya
              );
            },
            child: const Text("Ya"),
          ),
        ],
      );
    },
  );
}
