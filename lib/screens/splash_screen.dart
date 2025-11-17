import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _planeAnimation;
  late Animation<double> _fadeTextAnimation;

  @override
  void initState() {
    super.initState();

    // 🔹 Controller animasi 4 detik
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    // 🔹 Animasi pesawat melengkung
    _planeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    // 🔹 Fade-in teks dan logo
    _fadeTextAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    );

    _controller.forward();

    // 🔹 Pindah ke HomeScreen setelah 5 detik
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _calculatePlanePosition(Size size, double progress) {
    // Membuat lintasan melengkung dari kiri bawah ke kanan atas
    final startX = -50.0;
    final endX = size.width + 50.0;
    final startY = size.height * 0.75;
    final endY = size.height * 0.25;

    final midY = size.height * 0.1; // Lengkungan ke atas
    final x = startX + (endX - startX) * progress;
    final y = (1 - math.pow(2 * progress - 1, 2)) * (midY - startY) + startY;

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // 🔹 Background gambar
              Image.asset(
                'assets/images/kyoto.jpg',
                fit: BoxFit.cover,
              ),
              // 🔹 Overlay hitam transparan agar teks lebih jelas
              Container(color: Colors.black.withOpacity(0.45)),

              // 🔹 Pesawat terbang animasi
              AnimatedBuilder(
                animation: _planeAnimation,
                builder: (context, child) {
                  final pos = _calculatePlanePosition(
                    constraints.biggest,
                    _planeAnimation.value,
                  );
                  return Positioned(
                    left: pos.dx,
                    top: pos.dy,
                    child: Transform.rotate(
                      angle: -0.4, // miring sedikit ke atas
                      child: Icon(
                        Icons.airplanemode_active,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),

              // 🔹 Logo + teks di tengah
              FadeTransition(
                opacity: _fadeTextAnimation,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.travel_explore,
                        color: Colors.white,
                        size: 80,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Destinations Bisma",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
