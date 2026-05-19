import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, 0.00),
            end: Alignment(0.50, 1.00),
            colors: [
              Color(0xFFE0F2FE),
              Color(0xFFEDF8FF),
              Color(0xFFF3FAFF),
              Color(0xFFFAFDFF),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // Header gradient biru
            _buildHeader(context),
            // Konten scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats card
                    _buildStatsCard(),
                    const SizedBox(height: 12),
                    // Badge card
                    _buildBadgeCard(),
                    const SizedBox(height: 16),
                    // Pengaturan section
                    _buildSectionLabel('PENGATURAN'),
                    _buildSettingsCard([
                      _SettingItem(
                        icon: Icons.notifications_outlined,
                        label: 'Notifikasi Peringatan',
                        trailing: _buildTrailingText(
                            'Aktif', const Color(0xFF22C55E)),
                      ),
                      _SettingItem(
                        icon: Icons.contacts_outlined,
                        label: 'Kontak Darurat',
                        trailing: _buildTrailingText(
                            '3 kontak', const Color(0xFF99A1AF)),
                      ),
                      _SettingItem(
                        icon: Icons.verified_user_outlined,
                        label: 'Verifikasi Akun',
                        trailing: _buildTrailingText(
                            'Terverifikasi', const Color(0xFF22C55E)),
                      ),
                      _SettingItem(
                        icon: Icons.dark_mode_outlined,
                        label: 'Mode Gelap',
                        trailing: _buildTrailingText(
                            'Otomatis', const Color(0xFF99A1AF)),
                      ),
                      _SettingItem(
                        icon: Icons.language_outlined,
                        label: 'Bahasa',
                        trailing: _buildTrailingText(
                            'Indonesia', const Color(0xFF99A1AF)),
                        isLast: true,
                      ),
                    ]),
                    const SizedBox(height: 16),
                    // Dukungan section
                    _buildSectionLabel('DUKUNGAN'),
                    _buildSettingsCard([
                      _SettingItem(
                        icon: Icons.help_outline,
                        label: 'Pusat Bantuan',
                      ),
                      _SettingItem(
                        icon: Icons.volunteer_activism_outlined,
                        label: 'Donasi untuk Korban Banjir',
                        isLast: true,
                      ),
                    ]),
                    const SizedBox(height: 16),
                    // Footer
                    const Center(
                      child: Text(
                        'SiagaBanjir v2.4.1 · Made in Indonesia 🇮🇩',
                        style: TextStyle(
                          color: Color(0xFF99A1AF),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── HEADER ──────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF003087), Color(0xFF00D4FF)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            children: [
              // Title
              const Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFB923C), Color(0xFFEF4444)],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.30),
                        width: 3,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 8,
                          offset: Offset(0, 6),
                          spreadRadius: -4,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'L',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  // Online indicator
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF003087),
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Nama
              const Text(
                'Lukman',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Relawan Terverifikasi · RW 04',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.80),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── STATS CARD ──────────────────────────────────────────────────────────────
  Widget _buildStatsCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66BEDBFF),
              blurRadius: 8,
              offset: Offset(0, 6),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0x66BEDBFF),
              blurRadius: 20,
              offset: Offset(0, 15),
              spreadRadius: -4,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              _buildStatItem('47', 'Laporan', const Color(0xFF003087)),
              _buildDivider(),
              _buildStatItem('12', 'Bantu Warga', const Color(0xFFFB923C)),
              _buildDivider(),
              _buildStatItem('98%', 'Akurasi', const Color(0xFF22C55E)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Expanded(
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
              color: Color(0xFF6A7282),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      color: const Color(0xFFF3F4F6),
    );
  }

  // ─── BADGE CARD ──────────────────────────────────────────────────────────────
  Widget _buildBadgeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFEF3C7), Color(0xFFFED7AA)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFF59E0B), Color(0xFFFB923C)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child:
                  const Icon(Icons.emoji_events, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            // Text
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penyelamat Komunitas',
                    style: TextStyle(
                      color: Color(0xFF003087),
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
            const Icon(Icons.chevron_right, color: Color(0xFF4A5565), size: 16),
          ],
        ),
      ),
    );
  }

  // ─── SECTION LABEL ───────────────────────────────────────────────────────────
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 16, 6),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF99A1AF),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ─── SETTINGS CARD ───────────────────────────────────────────────────────────
  Widget _buildSettingsCard(List<_SettingItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 2,
              offset: Offset(0, 1),
              spreadRadius: -1,
            ),
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: items.map((item) => _buildSettingRow(item)).toList(),
        ),
      ),
    );
  }

  Widget _buildSettingRow(_SettingItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        border: item.isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1),
              ),
      ),
      child: Row(
        children: [
          // Icon box
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, color: const Color(0xFF003087), size: 16),
          ),
          const SizedBox(width: 12),
          // Label
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(
                color: Color(0xFF003087),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Trailing
          if (item.trailing != null) item.trailing!,
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, color: Color(0xFF99A1AF), size: 16),
        ],
      ),
    );
  }

  Widget _buildTrailingText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// Helper class untuk item setting
class _SettingItem {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final bool isLast;

  _SettingItem({
    required this.icon,
    required this.label,
    this.trailing,
    this.isLast = false,
  });
}
