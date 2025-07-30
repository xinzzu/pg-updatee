import 'package:flutter/material.dart';
import 'package:pgcard/widgets/onboarding/section_three.dart';
import 'package:pgcard/widgets/onboarding/section_two.dart';
import '../utils/responsive.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF4C4DDC),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                'assets/images/texture.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/doctor.png'),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: responsive.hp(2)),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: responsive.hp(60)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: responsive.hp(3),
                        horizontal: responsive.wp(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SectionTwo(),
                          SectionThree(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
