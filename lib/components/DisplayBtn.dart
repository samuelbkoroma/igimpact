import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayBtn extends StatefulWidget {
  final String btnText;
  final VoidCallback onPressed;
  final Color btnColor;
  final double width;
  final double height;
  final Color textColor;

  const DisplayBtn(
      {super.key,
      required this.btnText,
      required this.onPressed,
      required this.btnColor,
      required this.width,
      required this.height,
      required this.textColor});

  @override
  State<DisplayBtn> createState() => _DisplayBtnState();
}

class _DisplayBtnState extends State<DisplayBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: widget.btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // ignore: sort_child_properties_last
        child: Text(
          widget.btnText,
          style: GoogleFonts.poppins(
            color: widget.textColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
