import 'package:flutter/material.dart';
import 'package:pgcard/models/doctor/doctor_model.dart';
import 'package:pgcard/providers/doctor_provider.dart';
import 'package:provider/provider.dart';

class FavoriteToggleButton extends StatelessWidget {
  final Doctor doctor;

  const FavoriteToggleButton({Key? key, required this.doctor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorProvider>(
      builder: (context, provider, _) {
        final isFavorite = provider.isFavorite(doctor);

        return Center(
          child: TextButton(
            onPressed: () {
              provider.toggleFavorite(doctor);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite
                        ? "Dihapus dari Favorit"
                        : "Ditambahkan ke Favorit",
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              backgroundColor:
                  isFavorite ? Colors.redAccent : const Color(0xFF4C4DDC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  isFavorite ? 'Hapus dari Favorit' : 'Tambahkan ke Favorit',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
