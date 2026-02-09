import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const FormHeader({super.key, required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF0A0A0A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onClose,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: const Center(
              child: Icon(Icons.close, size: 20, color: Color(0xFF0A0A0A)),
            ),
          ),
        ),
      ],
    );
  }
}
