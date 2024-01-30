import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // Background color
          onPrimary: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Button border radius
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 16.0, // Text size
          ),
        ),
      ),
    );
  }
}
