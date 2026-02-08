import 'package:flutter/material.dart';

class FormActionButtons extends StatelessWidget {
  final String submitLabel;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const FormActionButtons({
    super.key,
    required this.submitLabel,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 1.21,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF0A0A0A),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onSubmit,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF155DFC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    submitLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
