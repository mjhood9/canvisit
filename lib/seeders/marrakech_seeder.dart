import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attraction_model.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> seedMarrakechAttractions() async {
  final List<Attraction> attractions = [
    // ---------------- TOP ATTRACTIONS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Jemaa el-Fna",
      category: "attraction",
      imagePath: "assets/images/marrakech/jemaa.jpg",
      details:
      "La place Jemaa el-Fna est le cœur historique de Marrakech, animée jour et nuit par musiciens, charmeurs de serpents et stands traditionnels.",
      googleMapsUrl: "https://maps.app.goo.gl/CymAm1P5HTzy59zc6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Jardin Majorelle",
      category: "attraction",
      imagePath: "assets/images/marrakech/majorelle.jpg",
      details:
      "Un jardin botanique mythique restauré par Yves Saint Laurent, célèbre pour son bleu Majorelle et sa végétation exotique.",
      googleMapsUrl: "https://maps.app.goo.gl/6K5jFDNi9Pu1ny4CA",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Palais Bahia",
      category: "attraction",
      imagePath: "assets/images/marrakech/bahia.jpg",
      details:
      "Chef-d’œuvre de l’architecture marocaine, décoré de zelliges, jardins et salons historiques.",
      googleMapsUrl: "https://maps.app.goo.gl/DeQZkWhrU52eUvqC8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Koutoubia",
      category: "attraction",
      imagePath: "assets/images/marrakech/koutoubia.jpg",
      details:
      "La mosquée Koutoubia est le monument le plus emblématique de Marrakech, construite au XIIe siècle.",
      googleMapsUrl: "https://maps.app.goo.gl/sYp3DSWAxeWt6C1s6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "El Badi Palace",
      category: "attraction",
      imagePath: "assets/images/marrakech/badi.jpg",
      details:
      " Ruine somptueuse à Marrakech, construite au XVIe siècle par le sultan saadien Ahmed al-Mansour pour célébrer sa victoire sur les Portugais, mêlant marbre, or, céramique et bois précieux pour exprimer sa puissance avec des centaines de pièces et un immense patio central entouré de bassins.",
      googleMapsUrl: "https://maps.app.goo.gl/wJDxpvN9QoNqq15j8",
    ),

    // ---------------- RESTAURANTS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Le Jardin",
      category: "restaurant",
      imagePath: "assets/images/marrakech/le_jardin.jpg",
      details:
      "Restaurant traditionnel marocain dans un cadre vert et relaxant au cœur de la médina.",
      googleMapsUrl: "https://maps.app.goo.gl/ysViGZ4cUHsA3z7V6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Café de France",
      category: "restaurant",
      imagePath: "assets/images/marrakech/cafe_france.jpg",
      details:
      "Institution historique sur Jemaa el-Fna offrant une vue unique sur la place.",
      googleMapsUrl: "https://maps.app.goo.gl/NntP7rfv5TDo7FMZ6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Naranj",
      category: "restaurant",
      imagePath: "assets/images/marrakech/naranj.jpg",
      details:
      "Cuisine levantine moderne dans un décor chaleureux situé près de la médina.",
      googleMapsUrl: "https://maps.app.goo.gl/Pf5Epm7duuwhpPWh8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Al Fassia",
      category: "restaurant",
      imagePath: "assets/images/marrakech/al_fassia.jpg",
      details:
      "Restaurant tenu par des femmes, réputé pour son authenticité et sa gastronomie marocaine.",
      googleMapsUrl: "https://maps.app.goo.gl/MTdbyMsrAMvhuVja8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Nomad",
      category: "restaurant",
      imagePath: "assets/images/marrakech/nomad.jpg",
      details:
      "Restaurant contemporain avec terrasse panoramique donnant sur les souks.",
      googleMapsUrl: "https://maps.app.goo.gl/hzwueHAaCWkdPGPs7",
    ),

    // ---------------- ACTIVITIES ----------------
    Attraction(
      id: uuid.v4(),
      name: "Quad dans le désert d’Agafay",
      category: "activity",
      imagePath: "assets/images/marrakech/agafay.jpg",
      details:
      "Excursion en quad dans le désert rocheux d’Agafay avec vues spectaculaires.",
      googleMapsUrl: "https://maps.app.goo.gl/DgjH42bKoQeVq1uU6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Balade en montgolfière",
      category: "activity",
      imagePath: "assets/images/marrakech/montgolfiere.jpg",
      details:
      "Survol de Marrakech au lever du soleil, expérience unique dans les airs.",
      googleMapsUrl: "https://maps.app.goo.gl/8pvKnwdVkiBfb6EC8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Hammam traditionnel",
      category: "activity",
      imagePath: "assets/images/marrakech/hammam.jpg",
      details:
      "Détente dans un hammam marocain avec soins et massages traditionnels.",
      googleMapsUrl: "https://maps.app.goo.gl/rT2SjNikEz2isUPB9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Souks de la Médina",
      category: "activity",
      imagePath: "assets/images/marrakech/souk.jpg",
      details:
      "Explorez les souks artisanaux : cuir, épices, lanternes, tapis et bijoux.",
      googleMapsUrl: "https://maps.app.goo.gl/qCcjvvTAkLwP54xs5",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Cascade d’Ouzoud (excursion)",
      category: "activity",
      imagePath: "assets/images/marrakech/ouzoud.jpg",
      details:
      "Excursion populaire vers les plus belles cascades du Maroc.",
      googleMapsUrl: "https://maps.app.goo.gl/oaRVWsjGi49zkyXY9",
    ),
  ];

  for (final attraction in attractions) {
    await firestore
        .collection('marrakech_attractions')
        .doc(attraction.id)
        .set(attraction.toMap(), SetOptions(merge: true));
  }

  print("Marrakech attractions seeded successfully!");
}
