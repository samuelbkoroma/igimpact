import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igniteimpact/theme/colors.dart';

class UniveralFormField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconButton? suffixIcon;
  final Function(String)? onChanged;
  final Color borderColor;

  const UniveralFormField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.borderColor = mainGrey,
      this.onChanged,
      this.suffixIcon});

  @override
  State<UniveralFormField> createState() => _UniveralFormFieldState();
}

class _UniveralFormFieldState extends State<UniveralFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: mainGrey,
        hintStyle: GoogleFonts.poppins(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.borderColor)),
        focusColor: widget.borderColor,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.borderColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.borderColor)),
        hintText: widget.hintText,
      ),
    );
  }
}
