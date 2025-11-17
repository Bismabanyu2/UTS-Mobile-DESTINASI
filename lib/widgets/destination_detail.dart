import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/destination.dart';

class DestinationDetail extends StatelessWidget {
  final Destination destination;

  const DestinationDetail({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: Column(
        key: ValueKey(destination.name),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            destination.location,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            destination.description,
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
