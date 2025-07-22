// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pgcard/main.dart'; // Pastikan ini mengacu pada file main.dart yang sudah diperbarui

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // PERUBAHAN DI SINI: Tambahkan argumen initialRoute
    await tester.pumpWidget(const MyApp(initialRoute: '/onboarding'));

    // Verify that our counter starts at 0.
    // Catatan: Tes ini mungkin tidak relevan lagi dengan struktur aplikasi Anda
    // yang tidak memiliki "counter". Anda mungkin perlu menyesuaikan tes ini
    // agar sesuai dengan fungsionalitas aplikasi Anda saat ini.
    // Misalnya, Anda bisa mencari teks atau widget yang ada di layar onboarding.
    expect(find.text('0'),
        findsNothing); // Mengubah ekspektasi karena tidak ada counter
    expect(find.text('1'),
        findsNothing); // Mengubah ekspektasi karena tidak ada counter

    // Contoh tes untuk memastikan layar onboarding muncul
    expect(find.text('Mulai'),
        findsOneWidget); // Cari teks 'Mulai' di tombol onboarding
    expect(find.text('Lebih Presisi dengan Informasi Farmakogenetik'),
        findsOneWidget); // Cari teks heading onboarding

    // Jika Anda ingin melanjutkan tes alur, Anda bisa mensimulasikan tap tombol:
    // await tester.tap(find.text('Mulai'));
    // await tester.pumpAndSettle(); // Tunggu navigasi selesai
    // expect(find.text('Masuk ke Akun'), findsOneWidget); // Pastikan layar login muncul
  });
}
