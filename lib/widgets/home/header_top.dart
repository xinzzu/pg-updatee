import 'package:flutter/material.dart';
import 'package:pgcard/utils/responsive.dart';

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
                  CircleAvatar(
                    radius: responsive.wp(7),
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl!)
                        : AssetImage('assets/images/profile.png')
                            as ImageProvider,
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
                  // IconButton(
                  //   icon: Icon(Icons.notifications_none, color: Colors.white),
                  //   iconSize: responsive.wp(6),
                  //   onPressed: () {},
                  // ),
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
