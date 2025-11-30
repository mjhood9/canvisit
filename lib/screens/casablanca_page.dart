import 'package:flutter/material.dart';
import '../widgets/attraction_card.dart';
import '../widgets/custom_back_appbar.dart';

class CasablancaPage extends StatefulWidget {
  const CasablancaPage({super.key});

  @override
  State<CasablancaPage> createState() => _CasablancaPageState();
}

class _CasablancaPageState extends State<CasablancaPage> {
  int selectedTab = 0; // 0 = Info (default), 1 = Stade, 2 = Activité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Casablanca"),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// ------- BUTTON ROW -------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTabButton("Info", 0),
                const SizedBox(width: 10),
                _buildTabButton("Stade", 1),
                const SizedBox(width: 10),
                _buildTabButton("Activité", 2),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// -------- TAB CONTENT --------
          Expanded(
            child: _buildTabContent(), // removed Center widget
          ),
        ],
      ),
    );
  }

  /// ---------------- TAB BUTTON BUILDER ----------------
  Widget _buildTabButton(String text, int index) {
    final bool isActive = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index);
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF7A0C0F) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive
                ? null
                : Border.all(color: Colors.black54, width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  /// ---------------- TAB CONTENT AREA ----------------
  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------- IMAGE ----------
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/casablanca/info.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- TEXT ----------
              const Text(
                "Casablanca est la plus grande ville du Maroc et son centre économique. "
                    "Située sur la côte atlantique, elle abrite le plus grand port du pays. "
                    "La ville est connue pour son architecture art déco, mélangeant styles français et marocains, "
                    "et pour la célèbre Mosquée Hassan II, l'une des plus grandes au monde, située au bord de l'océan. "
                    "Casablanca est une ville moderne et cosmopolite, offrant une vie urbaine dynamique, "
                    "des centres commerciaux, des cafés, et une scène culturelle et musicale animée.",
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 24),

              // ---------- TABLE ----------
              Table(
                border: TableBorder.all(color: Colors.black26),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: const [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Pays", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Maroc"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Population", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("≈ 3,7 millions"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Superficie", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("≈ 220 km²"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Langue", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Arabe, Français"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Fuseau horaire", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("GMT+1"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      case 1:
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------- IMAGE ----------
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/casablanca/stade.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- TEXT ----------
              const Text(
                "Le Complexe Sportif Mohammed V est le stade principal de Casablanca. "
                    "Inauguré en 1955 et rénové à plusieurs reprises, il accueille les "
                    "grands matchs du Wydad AC et du Raja CA ainsi que de nombreux événements sportifs.",
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 24),

              // ---------- TABLE ----------
              Table(
                border: TableBorder.all(color: Colors.black26),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: const [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Nom", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Complexe Sportif Mohammed V"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Ville", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Casablanca"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Capacité", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("≈ 45 000 places"),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Inauguration", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("1955"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- TOP ATTRACTIONS ----------------
              const Text(
                "Top Attractions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    AttractionCard(
                      name: "Mosquée Hassan II",
                      imagePath: "assets/images/casablanca/hassan2.jpg",
                      details:
                      "La Mosquée Hassan II est l'un des monuments les plus emblématiques du Maroc, célèbre pour son architecture impressionnante et son emplacement au bord de l’océan.",
                    ),
                    SizedBox(width: 12),
                    AttractionCard(
                      name: "Corniche Ain Diab",
                      imagePath: "assets/images/casa/corniche.jpg",
                      details:
                      "La Corniche de Casablanca est un lieu populaire pour se promener, se détendre, profiter de la vue sur la mer et découvrir cafés et restaurants.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- RESTAURANTS ----------------
              const Text(
                "Restaurants",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    AttractionCard(
                      name: "Le Cabestan",
                      imagePath: "assets/images/casa/cabestan.jpg",
                      details:
                      "Restaurant emblématique face à l'océan, réputé pour ses plats raffinés et son ambiance élégante.",
                    ),
                    SizedBox(width: 12),
                    AttractionCard(
                      name: "Rick’s Café",
                      imagePath: "assets/images/casa/ricks.jpg",
                      details:
                      "Inspiré du film Casablanca, ce café célèbre offre une ambiance unique et un menu international.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- ACTIVITIES ----------------
              const Text(
                "Activities",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    AttractionCard(
                      name: "Shopping Morocco Mall",
                      imagePath: "assets/images/casa/morocco_mall.jpg",
                      details:
                      "Le plus grand centre commercial d’Afrique, avec des boutiques, restaurants et attractions.",
                    ),
                    SizedBox(width: 12),
                    AttractionCard(
                      name: "Visite Sky 28",
                      imagePath: "assets/images/casa/sky28.jpg",
                      details:
                      "Un bar panoramique situé au 28e étage offrant une vue spectaculaire sur tout Casablanca.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      default:
        return const SizedBox();
    }
  }
}
