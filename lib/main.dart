import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const SiagaBanjirApp());
}

class SiagaBanjirApp extends StatelessWidget {
  const SiagaBanjirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siaga Banjir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003087)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
