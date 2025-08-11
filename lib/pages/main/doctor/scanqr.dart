import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pgcard/utils/responsive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgcard/services/auth_service.dart';
import 'package:pgcard/pages/onboarding.dart';
import 'package:pgcard/pages/login/login.dart';
import 'package:url_launcher/url_launcher.dart'; // Tambahkan import ini
import 'package:permission_handler/permission_handler.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen>
    with WidgetsBindingObserver {
  final MobileScannerController scannerController = MobileScannerController();
  bool _showScanner = false;
  bool _isProcessing = false; // Tambahkan flag ini

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scannerController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_showScanner && mounted) {
        scannerController.start();
      }
    } else if (state == AppLifecycleState.paused) {
      scannerController.stop();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _handleQrScanResult(String qrData) async {
    if (_isProcessing) return;
    setState(() {
      _isProcessing = true;
      _showScanner = false; // scanner hilang, tampilan kembali ke awal
    });
    await scannerController.stop();

    // Tampilkan popup
    final uri = Uri.tryParse(qrData);
    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Buka Link Pasien?'),
            content: Text(qrData, style: const TextStyle(color: Colors.blue)),
            actions: <Widget>[
              TextButton(
                child: const Text('Batal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Kunjungi'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Data Pasien Ditemukan'),
            content: Text('$qrData'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tutup'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // Reset flag agar bisa scan lagi jika user menekan tombol scan
    _isProcessing = false;
  }

  void _scanFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final BarcodeCapture? barcodeCapture =
          await scannerController.analyzeImage(image.path);
      if (barcodeCapture != null && barcodeCapture.barcodes.isNotEmpty) {
        final barcode = barcodeCapture.barcodes.first;
        if (barcode.rawValue != null) {
          _handleQrScanResult(barcode.rawValue!);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Tidak ada QR Code ditemukan di gambar.')),
        );
      }
    }
    setState(() {
      _showScanner = false;
    });
  }

  void _logout() async {
    final authService = AuthService();
    await authService.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _goToRiwayat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RiwayatScreen()),
    );
  }

  Future<void> _startScanner() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      scannerController.start();
      setState(() {
        _showScanner = true;
      });
    } else {
      // Tampilkan pesan error
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF4C4DDC),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_rounded,
                      color: Color(0xFF4C4DDC),
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'dr. Andini',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading:
                  Icon(Icons.history_edu, color: Color(0xFF4C4DDC), size: 28),
              title: Text(
                'Riwayat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                _goToRiwayat();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded, color: Colors.red, size: 28),
              title: Text(
                'Logout',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'PGCard v1.0',
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Selamat Datang, dr. Andini!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                responsive.wp(6), responsive.hp(2), responsive.wp(6), 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      'assets/images/icons_medical.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tampilkan scanner hanya jika _showScanner == true
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
                          if (_isProcessing) return; // Cegah callback berulang
                          final barcode = barcodeCapture.barcodes.first;
                          if (barcode.rawValue != null) {
                            _handleQrScanResult(barcode.rawValue!);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: responsive.hp(2)),
                    // Tombol kembali di scanner
                    ElevatedButton.icon(
                      onPressed: () {
                        scannerController.stop();
                        setState(() {
                          _showScanner = false;
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.white),
                      label: const Text('Kembali',
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
            )
          else
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
                    // Tombol untuk mulai scan QR
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isProcessing =
                              false; // Reset flag setiap mulai scan baru
                          _showScanner = true;
                        });
                        // Tunggu satu frame agar MobileScanner sudah muncul di widget tree
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted && _showScanner) {
                            scannerController.start();
                          }
                        });
                      },
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text('Scan QR Langsung',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C4DDC),
                        padding: EdgeInsets.symmetric(
                          vertical: responsive.hp(2),
                          horizontal: responsive.wp(8),
                        ),
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
                        backgroundColor: Colors.grey[200],
                        padding: EdgeInsets.symmetric(
                          vertical: responsive.hp(2),
                          horizontal: responsive.wp(8),
                        ),
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

// Halaman Riwayat Kosong
class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        backgroundColor: const Color(0xFF4C4DDC),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Belum ada riwayat tersedia.'),
      ),
    );
  }
}
