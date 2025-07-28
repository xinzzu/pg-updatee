import 'package:flutter/material.dart';
import 'package:pgcard/utils/responsive.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart'; // Import the package

class CustomHeader extends StatelessWidget {
  final String userName;
  final String? profileImageUrl;
  final Widget? bottomChild;

  const CustomHeader({
    Key? key,
    required this.userName,
    this.profileImageUrl,
    this.bottomChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4C4DDC),
        image: DecorationImage(
          image: AssetImage('assets/images/texture.png'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        responsive.wp(3),
        responsive.hp(2),
        responsive.wp(6),
        responsive.hp(3),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: responsive.wp(3),
                top: responsive.hp(5),
              ),
              child: Row(
                children: [
                  // PERUBAHAN DI SINI: Mengganti CircleAvatar dengan ProfilePicture
                  ProfilePicture(
                    name:
                        userName, // Menggunakan userName sebagai sumber inisial
                    radius: responsive.wp(
                        7), // Sesuaikan radius aFgar mirip dengan CircleAvatar sebelumnya
                    fontsize: responsive.wp(5), // Sesuaikan ukuran font inisial
                    // Untuk warna latar belakang acak
                    // Anda bisa menambahkan properti lain seperti backgroundColor, textColor, dll.
                  ),
                  SizedBox(width: responsive.wp(4)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Selamat datang 🎉',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: responsive.wp(3.5),
                          ),
                        ),
                        SizedBox(height: responsive.hp(1)),
                        Text(
                          userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: responsive.wp(5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (bottomChild != null) ...[
              SizedBox(height: responsive.hp(4)),
              bottomChild!,
            ]
          ],
        ),
      ),
    );
  }
}
