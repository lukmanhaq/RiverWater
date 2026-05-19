# 🌊 Siaga Banjir App

Aplikasi peringatan dini banjir berbasis Flutter, dirancang untuk warga Jakarta.

## Struktur File

```
lib/
├── main.dart          → Entry point app
└── home_screen.dart   → Halaman utama (Home)
```

## Cara Menjalankan

### 1. Pastikan Flutter sudah terinstall
```bash
flutter --version
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Jalankan app
```bash
# Di emulator/simulator
flutter run

# Di Chrome (web)
flutter run -d chrome

# Build APK
flutter build apk --release
```

## Menambahkan Font Poppins

1. Download Poppins dari [Google Fonts](https://fonts.google.com/specimen/Poppins)
2. Buat folder `assets/fonts/` di root project
3. Salin file `.ttf` ke folder tersebut
4. Uncomment bagian `fonts:` di `pubspec.yaml`
5. Jalankan `flutter pub get`

## Fitur yang Sudah Diimplementasikan

- ✅ Header dengan nama user & avatar
- ✅ Location bar
- ✅ Status card (SIAGA 2) dengan gradient & statistik
- ✅ Tombol darurat "Panggil Tim SAR"
- ✅ Indicator tingkat siaga (progress bar)
- ✅ Quick actions (Lapor, Evakuasi, Komunitas, Tips)
- ✅ Laporan sekitar (list)
- ✅ Bottom navigation bar dengan FAB report button
- ✅ Scrollable content

## Pengembangan Selanjutnya

- [ ] Halaman Peta (integrasi Google Maps / Mapbox)
- [ ] Halaman Lapor (form laporan)
- [ ] Halaman Evakuasi (daftar titik kumpul)
- [ ] Halaman Profil
- [ ] Notifikasi push
- [ ] Integrasi API data banjir real-time (BPBD Jakarta)
