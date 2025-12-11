import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attraction_model.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> seedTangierAttractions() async {
  final List<Attraction> attractions = [
    // ---------------- TOP ATTRACTIONS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Cap Spartel",
      category: "attraction",
      imagePath: "assets/images/tangier/cap_spartel.jpg",
      details:
      "Vue panoramique où l’océan Atlantique rencontre la mer Méditerranée.",
      googleMapsUrl: "https://maps.app.goo.gl/aoiTFLWSu1uQLSL66",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Grottes d’Hercule",
      category: "attraction",
      imagePath: "assets/images/tangier/grottes_hercule.jpg",
      details:
      "Site mythique célèbre pour sa grotte en forme de carte d’Afrique.",
      googleMapsUrl: "https://maps.app.goo.gl/nAcv7pg7KAeL66zr5",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Kasbah de Tanger",
      category: "attraction",
      imagePath: "assets/images/tangier/kasbah.jpg",
      details:
      "Ancienne forteresse avec vues imprenables et musées traditionnels.",
      googleMapsUrl: "https://maps.app.goo.gl/jCSC7mTko6HvZWJM9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Medina de Tanger",
      category: "attraction",
      imagePath: "assets/images/tangier/medina.jpg",
      details:
      "Vieille ville historique remplie de ruelles, cafés et artisanat.",
      googleMapsUrl: "https://maps.app.goo.gl/HmUDJKrgXqaQQdG47",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Phoenician Tombs",
      category: "attraction",
      imagePath: "assets/images/tangier/phoenician_tombs.jpg",
      details:
      "Tombes antiques creusées dans la roche avec vue spectaculaire sur la mer.",
      googleMapsUrl: "https://maps.app.goo.gl/q4yjP9SNqCvze8Rg6",
    ),

    // ---------------- RESTAURANTS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Le Saveur de Poisson",
      category: "restaurant",
      imagePath: "assets/images/tangier/saveur_poisson.jpg",
      details:
      "Restaurant mythique de Tanger, réputé pour ses plats de poisson uniques.",
      googleMapsUrl: "https://maps.app.goo.gl/TJXSfS8QtyMyPHfu8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "El Morocco Club",
      category: "restaurant",
      imagePath: "assets/images/tangier/morocco_club.jpg",
      details:
      "Restaurant chic situé dans la Kasbah, cuisine fusion d’exception.",
      googleMapsUrl: "https://maps.app.goo.gl/TKj83YX3XdJWDCa97",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Anna & Paolo",
      category: "restaurant",
      imagePath: "assets/images/tangier/anaynada.jpg",
      details:
      "Cuisine méditerranéenne moderne dans un décor raffiné.",
      googleMapsUrl: "https://maps.app.goo.gl/dFboshb6DWgeWgsY9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Restaurant Rif Kebdani",
      category: "restaurant",
      imagePath: "assets/images/tangier/rif_kebdani.jpg",
      details:
      "Cuisine marocaine authentique au cœur de la Médina.",
      googleMapsUrl: "https://maps.app.goo.gl/TkDtjUqP1hmgYg939",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Café Hafa",
      category: "restaurant",
      imagePath: "assets/images/tangier/cafe_hafa.jpg",
      details:
      "Café mythique surplombant la mer depuis 1921.",
      googleMapsUrl: "https://maps.app.goo.gl/bLQCiaFWH1uW4f7j7",
    ),

    // ---------------- ACTIVITIES ----------------
    Attraction(
      id: uuid.v4(),
      name: "Camel Ride Achakar Beach",
      category: "activity",
      imagePath: "assets/images/tangier/camel_ride.jpg",
      details:
      "Balades à dos de chameau au bord de l’océan.",
      googleMapsUrl: "https://maps.app.goo.gl/mkKPAZsYb5UofU2k9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Téléphérique de Tanger",
      category: "activity",
      imagePath: "assets/images/tangier/telepherique.jpg",
      details:
      "Téléphérique offrant une vue panoramique exceptionnelle sur la ville.",
      googleMapsUrl: "https://maps.app.goo.gl/DS8jzEDKKtJxUxzz6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Port Marina Bay",
      category: "activity",
      imagePath: "assets/images/tangier/marina_bay.jpg",
      details:
      "Promenade moderne avec restaurants, boutiques et vue sur les yachts.",
      googleMapsUrl: "https://maps.app.goo.gl/DS8jzEDKKtJxUxzz6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Surf at Plage Sol",
      category: "activity",
      imagePath: "assets/images/tangier/plage_sol.jpg",
      details:
      "Plage idéale pour le surf et les activités aquatiques.",
      googleMapsUrl: "https://maps.app.goo.gl/JYLLk5p8KeuPfvjd9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Kasbah Museum Visit",
      category: "activity",
      imagePath: "assets/images/tangier/kasbah_museum.jpg",
      details:
      "Découverte culturelle de l'histoire de Tanger à travers ses expositions.",
      googleMapsUrl: "https://maps.app.goo.gl/4TVgxEE3Gcri4XZWA",
    ),
  ];

  for (final attraction in attractions) {
    await firestore
        .collection('tangier_attractions')
        .doc(attraction.id)
        .set(attraction.toMap(), SetOptions(merge: true));
  }

  print("Tangier attractions seeded successfully!");
}
