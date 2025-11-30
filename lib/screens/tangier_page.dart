import 'package:flutter/material.dart';
import '../widgets/custom_back_appbar.dart';

class TangierPage extends StatefulWidget {
  const TangierPage({super.key});

  @override
  State<TangierPage> createState() => _TangierPageState();
}

class _TangierPageState extends State<TangierPage> {
  int selectedTab = 0; // 0 = Info (default), 1 = Stade, 2 = Activité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Tanger"),
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
                  'assets/images/tangier/info.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- TEXT ----------
              const Text(
                "Tangier est une ville portuaire située au nord du Maroc, à l'entrée du détroit de Gibraltar. "
                    "Elle a une longue histoire en tant que carrefour culturel, reliant l'Afrique, l'Europe et le Moyen-Orient. "
                    "Tangier est célèbre pour ses plages, sa médina pittoresque, ses marchés animés, et son atmosphère cosmopolite unique.",
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
                        child: Text("≈ 1,050,000"),
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
                        child: Text("≈ 119 km²"),
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
                  'assets/images/tangier/stade.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- DESCRIPTION ----------
              const Text(
                "Le Grand Stade de Tanger, également appelé Stade Ibn Battouta, est "
                    "l’un des stades les plus modernes du Maroc. Construit en 2011, il a "
                    "bénéficié d’importantes rénovations récentes en 2023–2025 afin de "
                    "répondre aux standards internationaux pour les grandes compétitions "
                    "comme la Coupe du Monde des Clubs de la FIFA et la CAN.\n\n"

                    "Aujourd'hui, le stade est considéré comme l’un des plus beaux "
                    "complexes sportifs d’Afrique du Nord.",
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
                        child: Text("Grand Stade de Tanger (Stade Ibn Battouta)"),
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
                        child: Text("Tanger"),
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
                        child: Text("≈ 75 600 places"),
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
                        child: Text("2011"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );


      case 2:
        return const Text(
          "Activités à Tangier",
          style: TextStyle(fontSize: 18),
        );

      default:
        return const SizedBox();
    }
  }
}
