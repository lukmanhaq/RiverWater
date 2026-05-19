import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Data marker lokasi banjir
  final List<_FloodMarker> markers = [
    _FloodMarker(
      left: 53.39,
      top: 203.70,
      color: const Color(0xFFEF4444),
      size: 36,
      label: 'Siaga 1',
    ),
    _FloodMarker(
      left: 167.25,
      top: 261.89,
      color: const Color(0xFFFB923C),
      size: 33,
      label: 'Siaga 2',
    ),
    _FloodMarker(
      left: 93.45,
      top: 320.10,
      color: const Color(0xFF22C55E),
      size: 30,
      label: 'Aman',
    ),
    _FloodMarker(
      left: 196.96,
      top: 349.20,
      color: const Color(0xFFF59E0B),
      size: 30,
      label: 'Siaga 3',
    ),
    _FloodMarker(
      left: 126,
      top: 283.50,
      color: const Color(0xFF00D4FF),
      size: 15,
      label: '',
    ),
  ];

  bool _showBottomSheet = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── PETA BACKGROUND ──────────────────────────────────────────────
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0EA5E9),
                  Color(0xFF0284C7),
                  Color(0xFF003087),
                ],
              ),
            ),
          ),

          // Grid pattern simulasi peta
          CustomPaint(
            size: Size.infinite,
            painter: _MapGridPainter(),
          ),

          // ── MARKER LOKASI ────────────────────────────────────────────────
          SafeArea(
            child: Stack(
              children: [
                // Map area dengan markers
                Positioned.fill(
                  child: Stack(
                    children: markers.map((m) => _buildMarker(m)).toList(),
                  ),
                ),

                // ── SEARCH BAR + FILTER ───────────────────────────────────
                Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: _buildTopBar(),
                ),

                // ── ZOOM CONTROLS ─────────────────────────────────────────
                Positioned(
                  right: 16,
                  top: 100,
                  child: _buildZoomControls(),
                ),

                // ── BOTTOM SHEET INFO ─────────────────────────────────────
                if (_showBottomSheet)
                  Positioned(
                    bottom: 80,
                    left: 12,
                    right: 12,
                    child: _buildBottomInfoCard(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── MARKER ──────────────────────────────────────────────────────────────────
  Widget _buildMarker(_FloodMarker m) {
    if (m.size < 20) {
      // Marker kecil (dot)
      return Positioned(
        left: m.left,
        top: m.top + 60,
        child: Container(
          width: m.size,
          height: m.size,
          decoration: BoxDecoration(
            color: m.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.white.withOpacity(0.6), spreadRadius: 2),
              const BoxShadow(
                color: Color(0x19000000),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      );
    }

    return Positioned(
      left: m.left,
      top: m.top + 60,
      child: GestureDetector(
        onTap: () => setState(() => _showBottomSheet = true),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Glow ring
            Positioned(
              left: -(m.size * 0.28),
              top: -(m.size * 0.28),
              child: Container(
                width: m.size * 1.55,
                height: m.size * 1.55,
                decoration: BoxDecoration(
                  color: m.color.withOpacity(0.30),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Main circle
            Container(
              width: m.size,
              height: m.size,
              decoration: BoxDecoration(
                color: m.color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 11,
                    offset: Offset(0, 8),
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Icon(
                _iconForColor(m.color),
                color: Colors.white,
                size: m.size * 0.42,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForColor(Color color) {
    if (color == const Color(0xFFEF4444)) return Icons.warning_rounded;
    if (color == const Color(0xFFFB923C)) return Icons.water;
    if (color == const Color(0xFF22C55E)) return Icons.check;
    if (color == const Color(0xFFF59E0B)) return Icons.info_outline;
    return Icons.circle;
  }

  // ─── TOP BAR ─────────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // Search bar + filter button
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                        spreadRadius: -3,
                      ),
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 11,
                        offset: Offset(0, 8),
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Color(0xFF99A1AF), size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Cari lokasi atau wilayah...',
                          style: TextStyle(
                            color: Color(0xFF99A1AF),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                      spreadRadius: -3,
                    ),
                  ],
                ),
                child:
                    const Icon(Icons.tune, color: Color(0xFF003087), size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Filter chips legend
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildLegendChip('Siaga 1', const Color(0xFFEF4444)),
                const SizedBox(width: 6),
                _buildLegendChip('Siaga 2', const Color(0xFFFB923C)),
                const SizedBox(width: 6),
                _buildLegendChip('Siaga 3', const Color(0xFFF59E0B)),
                const SizedBox(width: 6),
                _buildLegendChip('Aman', const Color(0xFF22C55E)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF003087),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ─── ZOOM CONTROLS ───────────────────────────────────────────────────────────
  Widget _buildZoomControls() {
    return Column(
      children: [
        _buildMapButton(Icons.add),
        const SizedBox(height: 6),
        _buildMapButton(Icons.my_location, color: const Color(0xFF00D4FF)),
      ],
    );
  }

  Widget _buildMapButton(IconData icon, {Color? color}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 5,
            offset: Offset(0, 3),
            spreadRadius: -3,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 11,
            offset: Offset(0, 8),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Icon(icon, color: color ?? const Color(0xFF003087), size: 18),
    );
  }

  // ─── BOTTOM INFO CARD ────────────────────────────────────────────────────────
  Widget _buildBottomInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 38,
            offset: Offset(0, 19),
            spreadRadius: -9,
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Header lokasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sungai Ciliwung',
                      style: TextStyle(
                        color: Color(0xFF003087),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Pintu Air Manggarai • 0.8 km',
                      style: TextStyle(
                        color: Color(0xFF6A7282),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'SIAGA 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Water level info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFEF3C7), Color(0xFFFED7AA)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.water, color: Color(0xFFF59E0B), size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tinggi Muka Air',
                          style: TextStyle(
                            color: Color(0xFF4A5565),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '240',
                                style: TextStyle(
                                  color: Color(0xFF003087),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: ' cm  ',
                                style: TextStyle(
                                  color: Color(0xFF003087),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: '↑ 12 cm/jam',
                                style: TextStyle(
                                  color: Color(0xFFEF4444),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// ─── MARKER DATA CLASS ────────────────────────────────────────────────────────
class _FloodMarker {
  final double left;
  final double top;
  final Color color;
  final double size;
  final String label;

  _FloodMarker({
    required this.left,
    required this.top,
    required this.color,
    required this.size,
    required this.label,
  });
}

// ─── MAP GRID PAINTER ─────────────────────────────────────────────────────────
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    // Garis horizontal
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Garis vertikal
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Simulasi jalan/sungai
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.10)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Sungai horizontal
    canvas.drawLine(
      Offset(0, size.height * 0.55),
      Offset(size.width, size.height * 0.60),
      roadPaint,
    );

    // Jalan diagonal
    final roadPaint2 = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 4;
    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.4, size.height),
      roadPaint2,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.45),
      roadPaint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
