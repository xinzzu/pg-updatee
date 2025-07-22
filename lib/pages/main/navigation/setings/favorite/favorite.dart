import 'package:flutter/material.dart';
import 'package:pgcard/providers/doctor_provider.dart';
import 'package:pgcard/widgets/home/doctor_card.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

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
                    'Dokter Favorit',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // TEMPORARY Placeholder: Ganti nanti dengan list dokter favorit
              Consumer<DoctorProvider>(
                builder: (context, provider, _) {
                  final favorites = provider.favoriteDoctors;

                  if (favorites.isEmpty) {
                    return const Center(
                      child: Text(
                        'Belum ada dokter favorit.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final doctor = favorites[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: DoctorCard(
                            doctor: doctor,
                            onTap: () {
                              // Navigasi ke detail (kalau kamu mau)
                            },
                            onFavoriteTap: () {
                              Provider.of<DoctorProvider>(context,
                                      listen: false)
                                  .toggleFavorite(doctor);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
