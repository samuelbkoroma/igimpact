import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/theme/colors.dart' show mainBlue;

class Heading extends StatelessWidget {
  final String text;
  const Heading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: mainBlue,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
