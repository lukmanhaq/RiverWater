import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'map_screen.dart';
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      _pageController.jumpToPage(0);
    } else if (index == 1) {
      _pageController.jumpToPage(1);
    } else if (index == 4) {
      _pageController.jumpToPage(2);
    }
  }

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
        child: SafeArea(
          child: Stack(
            children: [
              // PageView untuk navigasi antar halaman
              PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Halaman 0: Home
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        _buildLocationBar(),
                        const SizedBox(height: 16),
                        _buildStatusCard(),
                        const SizedBox(height: 16),
                        _buildEmergencyButton(),
                        const SizedBox(height: 16),
                        _buildAlertLevel(),
                        const SizedBox(height: 16),
                        _buildQuickActions(),
                        const SizedBox(height: 16),
                        _buildNearbyReports(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  // Halaman 1: Peta
                  const MapScreen(),
                  // Halaman 2: Profil
                  const ProfileScreen(),
                ],
              ),
              // Bottom nav bar fixed at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomNav(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── HEADER ──────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat pagi,',
                style: TextStyle(
                  color: Color(0xFF6A7282),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Lukman 👋',
                style: TextStyle(
                  color: Color(0xFF003087),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Notification bell
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFF003087),
                        size: 22,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 6,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Avatar
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF003087), Color(0xFF00D4FF)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'L',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── LOCATION BAR ────────────────────────────────────────────────────────────
  Widget _buildLocationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: const Row(
          children: [
            SizedBox(width: 12),
            Icon(Icons.location_on_outlined,
                size: 16, color: Color(0xFF364153)),
            SizedBox(width: 6),
            Text(
              'Kel. Kampung Melayu, Jakarta Timur',
              style: TextStyle(
                color: Color(0xFF364153),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── STATUS CARD ─────────────────────────────────────────────────────────────
  Widget _buildStatusCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFB923C), Color(0xFFEF4444)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFFFD6A8),
              blurRadius: 10,
              offset: Offset(0, 8),
              spreadRadius: -6,
            ),
            BoxShadow(
              color: Color(0xFFFFD6A8),
              blurRadius: 25,
              offset: Offset(0, 20),
              spreadRadius: -5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                right: -20,
                top: -40,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: -32,
                bottom: -20,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status label row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'STATUS SAAT INI',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.90),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.info_outline,
                          color: Colors.white.withOpacity(0.80),
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Big status text
                    const Text(
                      'SIAGA 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      'Waspada — Tinggi air mendekati batas siaga',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Stats row
                    Row(
                      children: [
                        _buildStatCard(
                          icon: Icons.water,
                          label: 'Tinggi Air',
                          value: '240 cm',
                        ),
                        const SizedBox(width: 8),
                        _buildStatCard(
                          icon: Icons.grain,
                          label: 'Curah Hujan',
                          value: '85 mm',
                        ),
                        const SizedBox(width: 8),
                        _buildStatCard(
                          icon: Icons.air,
                          label: 'Angin',
                          value: '18 km/j',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.20),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.80),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── EMERGENCY BUTTON ────────────────────────────────────────────────────────
  Widget _buildEmergencyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFFFC9C9),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0xFFFFC9C9),
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: -3,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.emergency, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DARURAT 24/7',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.80),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.55,
                    ),
                  ),
                  const Text(
                    'Panggil Tim SAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward,
                  color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // ─── ALERT LEVEL ─────────────────────────────────────────────────────────────
  Widget _buildAlertLevel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tingkat Siaga',
                style: TextStyle(
                  color: Color(0xFF003087),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Update 3 menit lalu',
                style: TextStyle(
                  color: Color(0xFF6A7282),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                // Progress bars
                Row(
                  children: [
                    _buildLevelBar(
                        color: const Color(0xFF22C55E),
                        isActive: false,
                        height: 8),
                    const SizedBox(width: 6),
                    _buildLevelBar(
                        color: const Color(0xFFF59E0B),
                        isActive: false,
                        height: 8),
                    const SizedBox(width: 6),
                    _buildLevelBar(
                      color: const Color(0xFFFB923C),
                      isActive: true,
                      height: 10,
                      glowColor: const Color(0xFFFFD6A8),
                    ),
                    const SizedBox(width: 6),
                    _buildLevelBar(
                        color: const Color(0xFFE5E7EB),
                        isActive: false,
                        height: 8),
                  ],
                ),
                const SizedBox(height: 10),
                // Labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLevelLabel('SIAGA 4', const Color(0xFF22C55E)),
                    _buildLevelLabel('SIAGA 3', const Color(0xFFF59E0B)),
                    _buildLevelLabel('SIAGA 2', const Color(0xFFFB923C)),
                    _buildLevelLabel('SIAGA 1', const Color(0xFF99A1AF)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelBar({
    required Color color,
    required bool isActive,
    required double height,
    Color? glowColor,
  }) {
    return Expanded(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
          boxShadow: isActive && glowColor != null
              ? [
                  BoxShadow(
                    color: glowColor,
                    blurRadius: 0,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  Widget _buildLevelLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ─── QUICK ACTIONS ───────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aksi Cepat',
            style: TextStyle(
              color: Color(0xFF003087),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(
                icon: Icons.report_outlined,
                label: 'Lapor',
                gradient: const [Color(0xFF00D4FF), Color(0xFF003087)],
              ),
              _buildActionButton(
                icon: Icons.directions_run,
                label: 'Evakuasi',
                gradient: const [Color(0xFF22C55E), Color(0xFF16A34A)],
              ),
              _buildActionButton(
                icon: Icons.people_outline,
                label: 'Komunitas',
                gradient: const [Color(0xFFF59E0B), Color(0xFFFB923C)],
              ),
              _buildActionButton(
                icon: Icons.lightbulb_outline,
                label: 'Tips',
                gradient: const [Color(0xFF003087), Color(0xFF1E40AF)],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required List<Color> gradient,
  }) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: -1,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF364153),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ─── NEARBY REPORTS ──────────────────────────────────────────────────────────
  Widget _buildNearbyReports() {
    final reports = [
      {
        'location': 'Bukit Duri',
        'status': 'SIAGA 2',
        'statusColor': const Color(0xFFFB923C),
        'reporter': 'Ibu Sari',
        'time': '5 mnt lalu',
        'level': '230 cm',
      },
      {
        'location': 'Cawang',
        'status': 'SIAGA 3',
        'statusColor': const Color(0xFFF59E0B),
        'reporter': 'Pak Joko',
        'time': '12 mnt lalu',
        'level': '150 cm',
      },
      {
        'location': 'Kebon Pala',
        'status': 'SIAGA 2',
        'statusColor': const Color(0xFFFB923C),
        'reporter': 'Tim RW 04',
        'time': '18 mnt lalu',
        'level': '210 cm',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Laporan Sekitar',
                style: TextStyle(
                  color: Color(0xFF003087),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    color: Color(0xFF00D4FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...reports.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildReportItem(
                  location: r['location'] as String,
                  status: r['status'] as String,
                  statusColor: r['statusColor'] as Color,
                  reporter: r['reporter'] as String,
                  time: r['time'] as String,
                  level: r['level'] as String,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildReportItem({
    required String location,
    required String status,
    required Color statusColor,
    required String reporter,
    required String time,
    required String level,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.water_damage_outlined,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0xFF003087),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '$reporter • $time • $level',
                  style: const TextStyle(
                    color: Color(0xFF6A7282),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF99A1AF), size: 18),
        ],
      ),
    );
  }

  // ─── BOTTOM NAV ──────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFDBEAFE), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x14003087),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_outlined,
                label: 'Beranda',
                index: 0,
                isActive: _selectedIndex == 0,
                onTap: () => _onNavTap(0),
              ),
              _buildNavItem(
                icon: Icons.map_outlined,
                label: 'Peta',
                index: 1,
                isActive: _selectedIndex == 1,
                onTap: () => _onNavTap(1),
              ),
              // Center FAB-like report button
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ReportScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFEF4444), Color(0xFFFB923C)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFFA2A2),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                            spreadRadius: -4,
                          ),
                          BoxShadow(
                            color: Color(0xFFFFA2A2),
                            blurRadius: 15,
                            offset: Offset(0, 10),
                            spreadRadius: -3,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.add_alert,
                          color: Colors.white, size: 26),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Lapor',
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              _buildNavItem(
                icon: Icons.directions_run_outlined,
                label: 'Evakuasi',
                index: 3,
                isActive: _selectedIndex == 3,
                onTap: () => _onNavTap(3),
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profil',
                index: 4,
                isActive: _selectedIndex == 4,
                onTap: () => _onNavTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  isActive ? const Color(0xFF003087) : const Color(0xFF99A1AF),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFF003087)
                    : const Color(0xFF99A1AF),
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            if (isActive) ...[
              const SizedBox(height: 2),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF00D4FF),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
