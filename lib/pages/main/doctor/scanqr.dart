import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pgcard/utils/responsive.dart';
import 'package:image_picker/image_picker.dart'; // Pastikan sudah ada di pubspec.yaml

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final MobileScannerController scannerController = MobileScannerController();
  bool _showScanner = false; // State untuk mengontrol visibilitas scanner

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  void _handleQrScanResult(String qrData) {
    scannerController.stop(); // Hentikan pemindaian setelah hasil didapat

    // Di sini Anda bisa mengolah data dari QR Code
    print('QR Code berhasil discan: $qrData');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data Pasien Ditemukan'),
          content: Text('Isi QR Code: $qrData'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
                // Setelah menutup dialog, reset tampilan ke tombol awal
                setState(() {
                  _showScanner = false; // Sembunyikan scanner
                });
                // Tidak perlu memanggil scannerController.start() di sini
                // karena kita akan menyembunyikan area scanner
              },
            ),
          ],
        );
      },
    );
  }

  void _scanFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Implementasi untuk memproses gambar dari galeri
      // Package mobile_scanner memiliki fitur analyzeImage
      final BarcodeCapture? barcodeCapture =
          await scannerController.analyzeImage(image.path);
      if (barcodeCapture != null && barcodeCapture.barcodes.isNotEmpty) {
        final barcode = barcodeCapture.barcodes.first;
        if (barcode.rawValue != null) {
          _handleQrScanResult(barcode.rawValue!);
        }
      } else {
        // Jika tidak ada QR Code terdeteksi di gambar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Tidak ada QR Code ditemukan di gambar.')),
        );
      }
    }
    // Setelah mencoba scan dari galeri, reset tampilan ke tombol awal
    setState(() {
      _showScanner = false; // Sembunyikan scanner
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: Stack(
        children: [
          // Bagian UI latar belakang (Header, Ilustrasi, Teks Instruksi)
          Container(
            padding: EdgeInsets.fromLTRB(
                responsive.wp(6), responsive.hp(8), responsive.wp(6), 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selamat Datang!',
                      style: TextStyle(
                        fontSize: responsive.wp(5.5),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(height: responsive.hp(2)),
                Text(
                  'Akses data pasien dengan scan QR',
                  style: TextStyle(
                    fontSize: responsive.wp(4.5),
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: responsive.hp(1)),
                Text(
                  'Arahkan kamera ke QR Code pasien atau pilih dari galeri untuk mendapatkan informasinya.',
                  style: TextStyle(
                    fontSize: responsive.wp(3.5),
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/dr_yeny.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bagian Tombol Aksi Utama (Scan Langsung / Pilih dari Galeri)
          // Ini akan muncul di bagian bawah jika _showScanner adalah false
          if (!_showScanner)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(responsive.wp(6)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showScanner = true; // Tampilkan scanner
                        });
                        scannerController.start(); // Mulai kamera
                      },
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text('Scan QR Langsung',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C4DDC),
                        padding: EdgeInsets.symmetric(
                            vertical: responsive.hp(2),
                            horizontal: responsive.wp(8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: responsive.hp(2)),
                    ElevatedButton.icon(
                      onPressed: _scanFromGallery,
                      icon: const Icon(Icons.photo, color: Colors.black),
                      label: const Text('Pilih dari Galeri',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.grey[200], // Warna abu-abu terang
                        padding: EdgeInsets.symmetric(
                            vertical: responsive.hp(2),
                            horizontal: responsive.wp(8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bagian QR Scanner dan Tombol Reset (hanya muncul jika _showScanner adalah true)
          if (_showScanner)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(responsive.wp(6)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text('Arahkan kamera ke QR Code',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: responsive.hp(2)),
                    SizedBox(
                      height: responsive.wp(70),
                      width: responsive.wp(70),
                      child: MobileScanner(
                        controller: scannerController,
                        onDetect: (barcodeCapture) {
                          final barcode = barcodeCapture.barcodes.first;
                          if (barcode.rawValue != null) {
                            _handleQrScanResult(barcode.rawValue!);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: responsive.hp(2)),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Kembali ke tampilan awal (tombol Scan Langsung/Galeri)
                        setState(() {
                          _showScanner = false;
                        });
                        scannerController.stop(); // Hentikan kamera
                      },
                      icon: const Icon(Icons.close, color: Colors.white),
                      label: const Text('Batalkan',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
