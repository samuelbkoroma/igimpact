import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/theme/colors.dart';

class FormButton extends StatefulWidget {
  final String btnText;
  final VoidCallback onPressed;

  const FormButton({
    super.key,
    required this.btnText,
    required this.onPressed,
  });

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 357,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: mainBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // ignore: sort_child_properties_last
        child: Text(
          widget.btnText,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
