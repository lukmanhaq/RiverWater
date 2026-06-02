import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:siaga_banjir/main.dart';

class StatusBar extends StatelessWidget {
  final bool dark;
  const StatusBar({super.key, this.dark = false});

  @override
  Widget build(BuildContext context) {
    final color = dark ? Colors.white : AppColors.primary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Row(
            children: [
              Icon(LucideIcons.signal, size: 14, color: color),
              const SizedBox(width: 4),
              Icon(LucideIcons.wifi, size: 14, color: color),
              const SizedBox(width: 4),
              Icon(LucideIcons.batteryFull, size: 16, color: color),
            ],
          ),
        ],
      ),
    );
  }
}
