import 'package:flutter/material.dart';
import '../models/destination.dart';
import 'package:google_fonts/google_fonts.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;
  final bool isActive;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(
          horizontal: isActive ? 12 : 8,
          vertical: isActive ? 8 : 18,
        ),
        width: isActive ? 200 : 180,
        height: isActive ? 270 : 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? Colors.black.withOpacity(0.25)
                  : Colors.black.withOpacity(0.1),
              blurRadius: isActive ? 18 : 8,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// === GAMBAR DESTINASI TAJAM ===
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                destination.imageUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                height: double.infinity,
                width: double.infinity,
              ),
            ),

            /// Overlay gelap lembut di bawah teks
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            /// Nama destinasi
            Positioned(
              left: 14,
              bottom: 16,
              right: 14,
              child: Text(
                destination.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
