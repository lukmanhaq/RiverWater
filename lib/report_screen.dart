import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedLevel =
      2; // 0=Siaga4/Aman, 1=Siaga3, 2=Siaga2(selected), 3=Siaga1
  double _waterLevel = 85; // slider value cm
  final TextEditingController _noteController = TextEditingController();
  final bool _submitted = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
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
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subtitle
                      const Text(
                        'Bantu warga lain dengan melaporkan kondisi air di sekitar Anda. Laporan Anda akan diverifikasi dalam 5 menit.',
                        style: TextStyle(
                          color: Color(0xFF4A5565),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Foto Lokasi
                      _buildSectionLabel('FOTO LOKASI'),
                      const SizedBox(height: 8),
                      _buildPhotoRow(),
                      const SizedBox(height: 20),

                      // Tingkat Siaga
                      _buildSectionLabel('TINGKAT SIAGA'),
                      const SizedBox(height: 8),
                      _buildAlertLevelPicker(),
                      const SizedBox(height: 20),

                      // Perkiraan Tinggi Air
                      _buildSectionLabel('PERKIRAAN TINGGI AIR'),
                      const SizedBox(height: 8),
                      _buildWaterLevelSlider(),
                      const SizedBox(height: 20),

                      // Lokasi
                      _buildSectionLabel('LOKASI'),
                      const SizedBox(height: 8),
                      _buildLocationCard(),
                      const SizedBox(height: 20),

                      // Catatan Tambahan
                      _buildSectionLabel('CATATAN TAMBAHAN'),
                      const SizedBox(height: 8),
                      _buildNoteField(),
                      const SizedBox(height: 24),

                      // Tombol Kirim
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── TOP BAR ─────────────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
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
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF003087),
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Lapor Banjir',
            style: TextStyle(
              color: Color(0xFF003087),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ─── SECTION LABEL ───────────────────────────────────────────────────────────
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF003087),
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
  }

  // ─── FOTO ROW ────────────────────────────────────────────────────────────────
  Widget _buildPhotoRow() {
    return Row(
      children: [
        // Ambil Foto
        _buildPhotoBox(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, color: Colors.white, size: 26),
              SizedBox(height: 4),
              Text(
                'Ambil Foto',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF003087), Color(0xFF00D4FF)],
          ),
        ),
        const SizedBox(width: 10),
        // Preview foto (simulasi)
        _buildPhotoBox(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8EC5FF), Color(0xFF2B7FFF)],
              ),
            ),
          ),
          gradient: null,
          isPreview: true,
        ),
        const SizedBox(width: 10),
        // Galeri
        _buildPhotoBox(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_library_outlined,
                  color: Color(0xFF003087), size: 22),
              SizedBox(height: 4),
              Text(
                'Galeri',
                style: TextStyle(
                  color: Color(0xFF003087),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          gradient: null,
          hasBorder: true,
        ),
      ],
    );
  }

  Widget _buildPhotoBox({
    required Widget child,
    LinearGradient? gradient,
    bool isPreview = false,
    bool hasBorder = false,
  }) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: gradient,
        color: hasBorder ? Colors.white : null,
        borderRadius: BorderRadius.circular(14),
        border: hasBorder
            ? Border.all(color: const Color(0xFFBEDBFF), width: 1.5)
            : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  // ─── ALERT LEVEL PICKER ──────────────────────────────────────────────────────
  Widget _buildAlertLevelPicker() {
    final levels = [
      {
        'label': 'SIAGA 4',
        'sub': 'Aman',
        'color': const Color(0xFF22C55E),
        'dot': true
      },
      {
        'label': 'SIAGA 3',
        'sub': 'Waspada',
        'color': const Color(0xFFF59E0B),
        'dot': true
      },
      {
        'label': 'SIAGA 2',
        'sub': 'Siap',
        'color': const Color(0xFFFB923C),
        'dot': false
      },
      {
        'label': 'SIAGA 1',
        'sub': 'Bahaya',
        'color': const Color(0xFFEF4444),
        'dot': true
      },
    ];

    return Row(
      children: List.generate(levels.length, (i) {
        final l = levels[i];
        final isSelected = _selectedLevel == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedLevel = i),
            child: Container(
              margin: EdgeInsets.only(right: i < levels.length - 1 ? 8 : 0),
              height: 60,
              decoration: BoxDecoration(
                color: isSelected ? (l['color'] as Color) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (l['color'] as Color).withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                          spreadRadius: 2,
                        ),
                      ]
                    : [
                        const BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (l['dot'] as bool)
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.white : (l['color'] as Color),
                        shape: BoxShape.circle,
                      ),
                    ),
                  if (!(l['dot'] as bool)) const SizedBox(height: 10),
                  const SizedBox(height: 4),
                  Text(
                    l['label'] as String,
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF364153),
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    l['sub'] as String,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white.withOpacity(0.80)
                          : const Color(0xFF99A1AF),
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // ─── WATER LEVEL SLIDER ──────────────────────────────────────────────────────
  Widget _buildWaterLevelSlider() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Angka besar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _waterLevel.toInt().toString(),
                style: const TextStyle(
                  color: Color(0xFF003087),
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 4, left: 4),
                child: Text(
                  'cm',
                  style: TextStyle(
                    color: Color(0xFF99A1AF),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Slider gradient
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              thumbColor: Colors.white,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Gradient track
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF22C55E),
                        Color(0xFFF59E0B),
                        Color(0xFFFB923C),
                        Color(0xFFEF4444),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Slider(
                  value: _waterLevel,
                  min: 0,
                  max: 250,
                  onChanged: (v) => setState(() => _waterLevel = v),
                ),
              ],
            ),
          ),
          // Labels
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0',
                  style: TextStyle(
                      color: Color(0xFF6A7282),
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
              Text('Lutut',
                  style: TextStyle(
                      color: Color(0xFF6A7282),
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
              Text('Pinggang',
                  style: TextStyle(
                      color: Color(0xFF6A7282),
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
              Text('200+',
                  style: TextStyle(
                      color: Color(0xFF6A7282),
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── LOCATION CARD ───────────────────────────────────────────────────────────
  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF00D4FF), Color(0xFF003087)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.location_on, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jl. Jatinegara Barat No. 142',
                  style: TextStyle(
                    color: Color(0xFF003087),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Lokasi otomatis terdeteksi (GPS)',
                  style: TextStyle(
                    color: Color(0xFF6A7282),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
              'Ubah',
              style: TextStyle(
                color: Color(0xFF00D4FF),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── NOTE FIELD ──────────────────────────────────────────────────────────────
  Widget _buildNoteField() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _noteController,
            maxLines: 3,
            maxLength: 200,
            decoration: const InputDecoration(
              hintText:
                  'Contoh: air mulai masuk rumah, ada lansia perlu evakuasi...',
              hintStyle: TextStyle(
                color: Color(0xFF99A1AF),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(
              color: Color(0xFF003087),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const Divider(color: Color(0xFFF3F4F6)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Icon(Icons.mic_outlined,
                        color: Color(0xFF00D4FF), size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Rekam suara',
                      style: TextStyle(
                        color: Color(0xFF00D4FF),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${_noteController.text.length} / 200',
                style: const TextStyle(
                  color: Color(0xFF99A1AF),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── SUBMIT BUTTON ───────────────────────────────────────────────────────────
  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: _onSubmit,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF003087), Color(0xFF00D4FF)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFBEDBFF),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -3,
            ),
            BoxShadow(
              color: Color(0xFFBEDBFF),
              blurRadius: 14,
              offset: Offset(0, 8),
              spreadRadius: -2,
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'Kirim Laporan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 16),
            const Text(
              'Laporan Terkirim!',
              style: TextStyle(
                color: Color(0xFF003087),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Laporan Anda akan diverifikasi dalam 5 menit. Terima kasih sudah membantu warga sekitar!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6A7282),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.of(context)
                ..pop()
                ..pop(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF003087), Color(0xFF00D4FF)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
