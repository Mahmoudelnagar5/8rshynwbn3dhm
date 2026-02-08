import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.21),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // App Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Color(0xFF155DFC),
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              // App Name
              const Text(
                'Monex',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A0A0A),
                ),
              ),
            ],
          ),
          // Notification Button
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined, size: 16),
              onPressed: () {
                // Handle notification
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
