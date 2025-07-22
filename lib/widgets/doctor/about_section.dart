import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pgcard/models/doctor/doctor_model.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key, required Doctor doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About Me',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF101010),
          ),
        ),
        const SizedBox(height: 8),
        // Justified Text
        Text(
          'Dr. Carly Angel is the top most immunologists specialist in Crist Hospital in London, UK. Dr. Carly Angel is the top most immunologists specialist in Crist Hospital in London, UK. Dr. Carly Angel is the top most immunologists specialist in Crist Hospital in London, UK. Dr. Carly Angel is the top most immunologists specialist in Crist Hospital in London, UK. Dr. Carly Angel is the top most immunologists specialist in Crist Hospital in London, UK. Dr. Carly Angel is the top most immunologists specialist in Crist Hospital in London, UK.',
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xFF5D5D5D),
            fontSize: 12,
          ),
          textAlign: TextAlign.justify, // Justify the text
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text:
                    '', // Empty span to leave space between justified text and 'Read More'
              ),
              TextSpan(
                text: 'Read More. . . ',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF4C4DDC),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Add your action when "Read More" is tapped
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Read More tapped')),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
