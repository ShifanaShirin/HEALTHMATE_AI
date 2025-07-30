import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.deepPurple.shade100,
            child: Icon(iconData, size: 30, color: Colors.deepPurple),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
