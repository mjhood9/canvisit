import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_appbar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> cities = [
      "Casablanca",
      "Rabat",
      "Tangier",
      "Marrakech",
      "Agadir",
      "Fes"
    ];

    final List<String> images = [
      "assets/images/cities/casablanca.png",
      "assets/images/cities/rabat.png",
      "assets/images/cities/tangier.png",
      "assets/images/cities/marrakech.png",
      "assets/images/cities/agadir.png",
      "assets/images/cities/fes.png",
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // ----------- TITLE -----------
          Text(
            "SOUHAITEZ EN PLUS SUR NOTRE HÔTE ?",
            textAlign: TextAlign.center,
            style: GoogleFonts.gothicA1(
              color:const Color(0xFF_7A_0C_0F),
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 20),

          // ----------- GRID OF CARDS -----------
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,        // 2 cards per row
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // -------- IMAGE (Fixed size, not zooming) --------
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: SizedBox(
                          width: double.infinity, // ensures full width
                          child: Image.asset(
                            images[index],
                            height: 120,
                            fit: BoxFit.cover, // clean, not stretched
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // -------- CITY NAME --------
                      Text(
                        cities[index].toUpperCase(),
                        style: GoogleFonts.gothicA1(
                          fontSize: 16,
                          fontWeight: FontWeight.w900, // extra bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
