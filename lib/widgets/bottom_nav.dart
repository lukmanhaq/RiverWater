import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:siaga_banjir/main.dart';

class BottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onChange;
  final VoidCallback onReport;

  const BottomNav({
    super.key,
    required this.activeIndex,
    required this.onChange,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.blue.shade100)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14003087),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _NavItem(
            icon: LucideIcons.home,
            label: 'Beranda',
            isActive: activeIndex == 0,
            onTap: () => onChange(0),
          ),
          _NavItem(
            icon: LucideIcons.clock,
            label: 'Riwayat',
            isActive: activeIndex == 1,
            onTap: () => onChange(1),
          ),
          // FAB Lapor button (center)
          _ReportFab(onTap: onReport),
          _NavItem(
            icon: LucideIcons.user,
            label: 'Profil',
            isActive: activeIndex == 2,
            onTap: () => onChange(2),
          ),
          // Placeholder untuk balance layout
          const SizedBox(width: 56),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.primary : Colors.grey,
              ),
            ),
            const SizedBox(height: 2),
            if (isActive)
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.cyan,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class _ReportFab extends StatelessWidget {
  final VoidCallback onTap;
  const _ReportFab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.danger, AppColors.siaga2],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.danger.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 0,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: const Icon(LucideIcons.alertTriangle, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 4),
          const Text(
            'Lapor',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.danger,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
