import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:siaga_banjir/main.dart';
import 'package:siaga_banjir/widgets/status_bar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedLevel = 2; // 0=Siaga4, 1=Siaga3, 2=Siaga2, 3=Siaga1
  double _waterLevel = 85;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgLight, Color(0xFFF0F9FF), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const StatusBar(),
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      _sectionLabel('FOTO LOKASI'),
                      const SizedBox(height: 8),
                      _buildPhotoRow(),
                      const SizedBox(height: 20),
                      _sectionLabel('TINGKAT SIAGA'),
                      const SizedBox(height: 8),
                      _buildLevelPicker(),
                      const SizedBox(height: 20),
                      _sectionLabel('PERKIRAAN TINGGI AIR'),
                      const SizedBox(height: 8),
                      _buildWaterSlider(),
                      const SizedBox(height: 20),
                      _sectionLabel('LOKASI'),
                      const SizedBox(height: 8),
                      _buildLocationCard(),
                      const SizedBox(height: 20),
                      _sectionLabel('CATATAN TAMBAHAN'),
                      const SizedBox(height: 8),
                      _buildNoteField(),
                      const SizedBox(height: 28),
                      _buildSubmitButton(context),
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

  // ─── TOP BAR ───────────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.08),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  LucideIcons.chevronLeft,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Lapor Banjir',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      );

  // ─── PHOTO ROW ─────────────────────────────────────────────────────────────
  Widget _buildPhotoRow() => Row(
        children: [
          _photoBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(LucideIcons.camera, color: Colors.white, size: 24),
                SizedBox(height: 4),
                Text('Ambil Foto',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.cyan],
            ),
          ),
          const SizedBox(width: 10),
          _photoBox(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF8EC5FF), Color(0xFF2B7FFF)]),
              ),
            ),
            isPreview: true,
          ),
          const SizedBox(width: 10),
          _photoBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(LucideIcons.image, color: AppColors.primary, size: 22),
                SizedBox(height: 4),
                Text('Galeri',
                    style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
            hasBorder: true,
          ),
        ],
      );

  Widget _photoBox({
    required Widget child,
    LinearGradient? gradient,
    bool isPreview = false,
    bool hasBorder = false,
  }) =>
      Expanded(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              color: hasBorder ? Colors.white : null,
              borderRadius: BorderRadius.circular(14),
              border: hasBorder
                  ? Border.all(color: const Color(0xFFBEDBFF), width: 1.5)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: child,
          ),
        ),
      );

  // ─── LEVEL PICKER ──────────────────────────────────────────────────────────
  Widget _buildLevelPicker() {
    final levels = <(String, String, Color)>[
      ('SIAGA 4', 'Aman', AppColors.safe),
      ('SIAGA 3', 'Waspada', AppColors.siaga3),
      ('SIAGA 2', 'Siap', AppColors.siaga2),
      ('SIAGA 1', 'Bahaya', AppColors.danger),
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
              height: 62,
              decoration: BoxDecoration(
                color: isSelected ? l.$3 : Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: l.$3.withOpacity(.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                          spreadRadius: 2,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : l.$3,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l.$1,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF364153),
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    l.$2,
                    style: TextStyle(
                      color: isSelected ? Colors.white70 : Colors.grey,
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

  // ─── WATER SLIDER ──────────────────────────────────────────────────────────
  Widget _buildWaterSlider() => Container(
        padding: const EdgeInsets.all(16),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _waterLevel.toInt().toString(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6, left: 4),
                  child: Text(
                    'cm',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
                thumbColor: Colors.white,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                overlayColor: AppColors.siaga2.withOpacity(.2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.safe, AppColors.siaga3, AppColors.siaga2, AppColors.danger],
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w700)),
                Text('Lutut', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w700)),
                Text('Pinggang', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w700)),
                Text('200+', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      );

  // ─── LOCATION CARD ─────────────────────────────────────────────────────────
  Widget _buildLocationCard() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                  colors: [AppColors.cyan, AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(LucideIcons.mapPin, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jl. Jatinegara Barat No. 142',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Lokasi otomatis terdeteksi (GPS)',
                    style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500),
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
                  color: AppColors.cyan,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );

  // ─── NOTE FIELD ────────────────────────────────────────────────────────────
  Widget _buildNoteField() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                hintText: 'Contoh: air mulai masuk rumah, ada lansia perlu evakuasi...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                counterText: '',
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (_) => setState(() {}),
            ),
            Divider(color: Colors.grey.shade100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(LucideIcons.mic, color: AppColors.cyan, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Rekam suara',
                      style: TextStyle(
                        color: AppColors.cyan,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${_noteController.text.length} / 200',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  // ─── SUBMIT BUTTON ─────────────────────────────────────────────────────────
  Widget _buildSubmitButton(BuildContext context) => GestureDetector(
        onTap: () => _showSuccessDialog(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.cyan],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFBEDBFF),
                blurRadius: 8,
                offset: Offset(0, 4),
                spreadRadius: -2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(LucideIcons.send, color: Colors.white, size: 18),
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.safe,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.checkCircle, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'Laporan Terkirim!',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Laporan Anda akan diverifikasi dalam 5 menit. Terima kasih sudah membantu warga sekitar!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.cyan],
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
