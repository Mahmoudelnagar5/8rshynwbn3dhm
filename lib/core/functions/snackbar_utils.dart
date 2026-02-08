import 'package:flutter/material.dart';

/// Shows a  snackbar with customizable message, color, and icon
void showCustomSnackBar(
  BuildContext context, {
  required String message,
  required Color backgroundColor,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 3,
    ),
  );
}

/// Convenience functions for common snackbar types
void showSuccessSnackBar(BuildContext context, String message) {
  showCustomSnackBar(
    context,
    message: message,
    backgroundColor: Colors.green.shade600,
    icon: Icons.check_circle,
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  showCustomSnackBar(
    context,
    message: message,
    backgroundColor: Colors.red.shade600,
    icon: Icons.error,
  );
}

void showInfoSnackBar(BuildContext context, String message) {
  showCustomSnackBar(
    context,
    message: message,
    backgroundColor: Colors.blue.shade600,
    icon: Icons.info,
  );
}

void showWarningSnackBar(BuildContext context, String message) {
  showCustomSnackBar(
    context,
    message: message,
    backgroundColor: Colors.orange.shade600,
    icon: Icons.warning,
  );
}
