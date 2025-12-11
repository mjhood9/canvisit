import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attraction_model.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> seedFesAttractions() async {
  final List<Attraction> attractions = [
    // ---------------- TOP ATTRACTIONS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Médina de Fès (Fès el Bali)",
      category: "attraction",
      imagePath: "assets/images/fes/medina.jpg",
      details: "La plus grande médina du monde, classée UNESCO, célèbre pour ses souks, artisans et architecture médiévale.",
      googleMapsUrl: "https://maps.app.goo.gl/yQLeWUfeGeJnBfuL8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Université Al Quaraouiyine",
      category: "attraction",
      imagePath: "assets/images/fes/karawiyine.jpg",
      details: "Fondée en 859, considérée comme la plus ancienne université du monde encore en activité.",
      googleMapsUrl: "https://maps.app.goo.gl/nS3rzEAPdD5fopyv5",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Les Tanneries Chouara",
      category: "attraction",
      imagePath: "assets/images/fes/tannerie.jpg",
      details: "Les célèbres tanneries traditionnelles où sont traités et colorés les cuirs.",
      googleMapsUrl: "https://maps.app.goo.gl/PzWuWHeoL7C6g7KP9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Bab Boujloud",
      category: "attraction",
      imagePath: "assets/images/fes/bab_boujloud.jpg",
      details: "La porte bleue emblématique qui marque l'entrée principale de la médina.",
      googleMapsUrl: "https://maps.app.goo.gl/YqQYmdeziMbPMXSZ7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Palais Royal de Fès",
      category: "attraction",
      imagePath: "assets/images/fes/palais_royal.jpg",
      details: "Un palais impressionnant célèbre pour ses immenses portes dorées.",
      googleMapsUrl: "https://maps.app.goo.gl/vLG4E79rM2wA6Qb27",
    ),

    // ---------------- RESTAURANTS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Restaurant Dar Hatim",
      category: "restaurant",
      imagePath: "assets/images/fes/dar_hatim.jpg",
      details: "Un restaurant familial authentique proposant des plats marocains traditionnels.",
      googleMapsUrl: "https://maps.app.goo.gl/GssYJfCKoxi6cvC39",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Cafe Clock Fes",
      category: "restaurant",
      imagePath: "assets/images/fes/clock.jpg",
      details: "Café populaire connu pour son ambiance culturelle et son burger de chameau.",
      googleMapsUrl: "https://maps.app.goo.gl/rWLTM9ygBwgmx2bT9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "La Maison Bleue",
      category: "restaurant",
      imagePath: "assets/images/fes/maison_bleue.jpg",
      details: "Restaurant gastronomique dans un riad historique de Fès.",
      googleMapsUrl: "https://maps.app.goo.gl/BeRTXB3V3nmieLhJ8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Nur Restaurant",
      category: "restaurant",
      imagePath: "assets/images/fes/nur.jpg",
      details: "Cuisine marocaine moderne dans un cadre raffiné.",
      googleMapsUrl: "https://maps.app.goo.gl/ZwEcMTFq9AmbS8jh9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Riad Rcif Restaurant",
      category: "restaurant",
      imagePath: "assets/images/fes/riad_rcif.jpg",
      details: "Restaurant dans un somptueux riad avec gastronomie traditionnelle.",
      googleMapsUrl: "https://maps.app.goo.gl/RhZKZy6XZBExznWX6",
    ),

    // ---------------- ACTIVITIES ----------------
    Attraction(
      id: uuid.v4(),
      name: "Cours de poterie à Fès",
      category: "activity",
      imagePath: "assets/images/fes/poterie.jpg",
      details: "Découvrez l'artisanat traditionnel en créant votre propre poterie.",
      googleMapsUrl: "https://maps.app.goo.gl/WetHx7iNaCVYRCU2A",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Randonnée au Jbel Zalagh",
      category: "activity",
      imagePath: "assets/images/fes/jbel_zalagh.jpg",
      details: "Une randonnée offrant une vue panoramique sur Fès et ses montagnes.",
      googleMapsUrl: "https://maps.app.goo.gl/3DyfnFTy6bJYicqZ9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Visite des ateliers de céramique",
      category: "activity",
      imagePath: "assets/images/fes/ceramique.jpg",
      details: "Explorez les ateliers où sont produits les célèbres carreaux Zellige de Fès.",
      googleMapsUrl: "https://maps.app.goo.gl/Ao2sko17DEK7UjMr5",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Dégustation de pâtisseries marocaines",
      category: "activity",
      imagePath: "assets/images/fes/patisseries.jpg",
      details: "Goûtez les spécialités locales comme cornes de gazelle, briouates et chebakia.",
      googleMapsUrl: "https://maps.app.goo.gl/aonhAhVbiSbcvnk79",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Tour guidé de la médina",
      category: "activity",
      imagePath: "assets/images/fes/tour_guide.jpg",
      details: "Découvrez l’histoire, l’architecture et les lieux cachés avec un guide local.",
      googleMapsUrl: "https://maps.app.goo.gl/r76hd4QGfmSp2eQn8",
    ),
  ];

  for (final attraction in attractions) {
    await firestore
        .collection('fes_attractions')
        .doc(attraction.id)
        .set(attraction.toMap(), SetOptions(merge: true));
  }

  print("Fès attractions seeded successfully!");
}
