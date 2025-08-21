import 'package:flutter/material.dart';
import 'package:pgcard/models/doctor/doctor_model.dart';
import 'package:pgcard/providers/doctor_provider.dart';
import 'package:provider/provider.dart'; // import model Doctor kamu

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap; // <--- Tambahan

  const DoctorCard({
    Key? key,
    required this.doctor,
    required this.onTap,
    required this.onFavoriteTap, // <--- Tambahan
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // agar seluruh card bisa ditekan
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 30,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Doctor Image
            Container(
              width: 92, // responsive.wp(15),
              height: 92, // responsive.wp(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(doctor.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Doctor Info (Expanded untuk menggunakan space yang tersedia)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2, // Maksimal 2 baris
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialization,
                    style: const TextStyle(
                      color: Color(0xFF939393),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${doctor.practiceLocation}',
                    style: const TextStyle(
                      color: Color(0xFF939393),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        ' (${doctor.reviews} reviews)',
                        style: const TextStyle(
                          color: Color(0xFF939393),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Favorite Button
            IconButton(
              onPressed: onFavoriteTap,
              icon: const Icon(Icons.favorite_border),
            ),
          ],
        ),
      ),
    );
  }
}
