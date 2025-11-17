import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/destination_data.dart';
import '../widgets/destination_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.28);
  int _currentPage = 0;

  void _goToNextPage() {
    if (_currentPage < destinations.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDestination = destinations[_currentPage];

    return Scaffold(
      body: Stack(
        children: [
          /// === BACKGROUND TAJAM (anti blur) ===
          RepaintBoundary(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: Image.asset(
                selectedDestination.imageUrl,
                key: ValueKey(selectedDestination.imageUrl),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
              ),
            ),
          ),

          /// Overlay gelap
          Container(color: Colors.black.withOpacity(0.55)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// === TOP BAR RESPONSIF ===
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile = constraints.maxWidth < 800;

                      if (isMobile) {
                        // === MOBILE APPBAR ===
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Destinations Bisma',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.menu,
                                  color: Colors.white, size: 28),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.black87,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _menuItem('Home'),
                                        const SizedBox(height: 12),
                                        _menuItem('Holidays'),
                                        const SizedBox(height: 12),
                                        _menuItem('Destinations'),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.search,
                                                  color: Colors.white),
                                              onPressed: () {},
                                            ),
                                            const SizedBox(width: 16),
                                            const CircleAvatar(
                                              radius: 18,
                                              backgroundImage: NetworkImage(
                                                'https://cdn-icons-png.flaticon.com/512/847/847969.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        // === DESKTOP APPBAR ===
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Destinations Bisma',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                _menuItem('Home'),
                                const SizedBox(width: 20),
                                _menuItem('Holidays'),
                                const SizedBox(width: 20),
                                _menuItem('Destinations'),
                                const SizedBox(width: 20),
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.white),
                                  onPressed: () {},
                                ),
                                const CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/847/847969.png',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 60),

                  /// === KONTEN UTAMA (responsif) ===
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isMobile = constraints.maxWidth < 800;

                        if (isMobile) {
                          /// === MOBILE VIEW ===
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 800),
                                  child: Column(
                                    key: ValueKey(selectedDestination.name),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        selectedDestination.name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        selectedDestination.location,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          selectedDestination.description,
                                          style: GoogleFonts.poppins(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orangeAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 14),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Discover Location',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                _buildCardSection(context),
                              ],
                            ),
                          );
                        } else {
                          /// === DESKTOP VIEW ===
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 800),
                                  child: Column(
                                    key: ValueKey(selectedDestination.name),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        selectedDestination.name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        selectedDestination.location,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: 350,
                                        child: Text(
                                          selectedDestination.description,
                                          style: GoogleFonts.poppins(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orangeAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 14),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Discover Location',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: _buildCardSection(context),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// === CARD SECTION ===
  Widget _buildCardSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 230,
          child: PageView.builder(
            controller: _pageController,
            itemCount: destinations.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final isActive = _currentPage == index;
              final scale = isActive ? 1.0 : 0.85;

              return TweenAnimationBuilder(
                tween: Tween<double>(begin: scale, end: scale),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: DestinationCard(
                      destination: destinations[index],
                      isActive: isActive,
                      onTap: () {
                        setState(() {
                          _currentPage = index;
                        });
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            destinations.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              width: _currentPage == index ? 32 : 12,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.orangeAccent
                    : Colors.white38,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _goToPreviousPage,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: _goToNextPage,
            ),
          ],
        ),
      ],
    );
  }

  /// === MENU ITEM TEXT ===
  Widget _menuItem(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
