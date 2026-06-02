import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:siaga_banjir/main.dart';
import 'package:siaga_banjir/widgets/status_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.bgLight, Colors.white],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 140),
        children: [
          _buildProfileHeader(),
          _buildStatsCard(),
          const SizedBox(height: 12),
          _buildBadgeCard(),
          const SizedBox(height: 16),
          _buildSettingsGroup('PENGATURAN', [
            (LucideIcons.bell, 'Notifikasi Peringatan', 'Aktif', AppColors.safe),
            (LucideIcons.users, 'Kontak Darurat', '3 kontak', Colors.grey),
            (LucideIcons.shield, 'Verifikasi Akun', 'Terverifikasi', AppColors.safe),
            (LucideIcons.moon, 'Mode Gelap', 'Otomatis', Colors.grey),
            (LucideIcons.globe, 'Bahasa', 'Indonesia', Colors.grey),
          ]),
          const SizedBox(height: 12),
          _buildSettingsGroup('DUKUNGAN', [
            (LucideIcons.helpCircle, 'Pusat Bantuan', '', Colors.grey),
            (LucideIcons.heart, 'Donasi untuk Korban Banjir', '', Colors.grey),
          ]),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'SiagaBanjir v2.4.1 · Made in Indonesia 🇮🇩',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() => Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.cyan],
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        ),
        child: Column(
          children: [
            const StatusBar(dark: true),
            const Text(
              'Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.siaga2, AppColors.danger],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(.3),
                      width: 4,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'B',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.safe,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 3),
                  ),
                  child: const Icon(
                    LucideIcons.checkCircle,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Pak Budi Santoso',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text(
              'Relawan Terverifikasi · RW 04',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget _buildStatsCard() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66BEDBFF),
                blurRadius: 12,
                offset: Offset(0, 6),
                spreadRadius: -4,
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                _statItem('47', 'Laporan', AppColors.primary),
                Container(width: 1, color: Colors.grey.shade100),
                _statItem('12', 'Bantu Warga', AppColors.siaga2),
                Container(width: 1, color: Colors.grey.shade100),
                _statItem('98%', 'Akurasi', AppColors.safe),
              ],
            ),
          ),
        ),
      );

  Widget _statItem(String value, String label, Color color) => Expanded(
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

  Widget _buildBadgeCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFEF3C7), Color(0xFFFED7AA)],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.siaga3, AppColors.siaga2],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(LucideIcons.award, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penyelamat Komunitas',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '3 lencana baru terbuka bulan ini',
                      style: TextStyle(
                        color: Color(0xFF4A5565),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(LucideIcons.chevronRight, color: Color(0xFF4A5565), size: 16),
            ],
          ),
        ),
      );

  Widget _buildSettingsGroup(
    String title,
    List<(IconData, String, String, Color)> rows,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(rows.length, (i) {
                  final r = rows[i];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: i < rows.length - 1
                          ? Border(
                              bottom: BorderSide(color: Colors.grey.shade100),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(r.$1, color: AppColors.primary, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            r.$2,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        if (r.$3.isNotEmpty)
                          Text(
                            r.$3,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: r.$4,
                            ),
                          ),
                        const SizedBox(width: 4),
                        const Icon(LucideIcons.chevronRight, size: 16, color: Colors.grey),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
}
