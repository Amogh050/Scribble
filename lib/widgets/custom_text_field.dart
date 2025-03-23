import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4), // Space for outer border
      decoration: BoxDecoration(
        color: Colors.brown, // Outer border color
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(
              255, 154, 238, 53), // Inner background (light green)
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white, // Inner border color (white)
            width: 4, // Thick inner border
          ),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          textAlign: TextAlign.center, // Center text inside
        ),
      ),
    );
  }
}
