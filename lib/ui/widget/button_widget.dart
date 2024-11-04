import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 60), // Tamanho do botão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordas retangulares
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}
