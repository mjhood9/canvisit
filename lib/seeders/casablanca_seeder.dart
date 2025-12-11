import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attraction_model.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> seedCasablancaAttractions() async {
  final List<Attraction> attractions = [
    // ---------------- TOP ATTRACTIONS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Mosquée Hassan II",
      category: "attraction",
      imagePath: "assets/images/casablanca/hassan2.jpg",
      details: "La Mosquée Hassan II est l'un des monuments les plus emblématiques du Maroc, célèbre pour son architecture impressionnante et son emplacement au bord de l’océan.",
      googleMapsUrl: "https://maps.app.goo.gl/s27nnwHHzuwi5Gdo9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Corniche Ain Diab",
      category: "attraction",
      imagePath: "assets/images/casablanca/corniche.jpg",
      details: "La Corniche de Casablanca est un lieu populaire pour se promener, se détendre, profiter de la vue sur la mer et découvrir cafés et restaurants.",
      googleMapsUrl: "https://maps.app.goo.gl/7Qzcveh9CFZSxEkEA",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Place Mohammed V",
      category: "attraction",
      imagePath: "assets/images/casablanca/mohammed_v.jpg",
      details: "Place centrale de Casablanca avec architecture coloniale et espaces publics.",
      googleMapsUrl: "https://maps.app.goo.gl/yTxKZyJBJeNTdpXz7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Quartier Habous",
      category: "attraction",
      imagePath: "assets/images/casablanca/habous.jpg",
      details: "Quartier traditionnel avec marchés, cafés et artisanat marocain.",
      googleMapsUrl: "https://maps.app.goo.gl/FNSBwdRascMckt4g6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Villa des Arts",
      category: "attraction",
      imagePath: "assets/images/casablanca/villa_des_arts.jpg",
      details: "Musée d'art moderne et contemporain, exposant des artistes marocains.",
      googleMapsUrl: "https://maps.app.goo.gl/f9hpaVS8xJBVKypq5",
    ),

    // ---------------- RESTAURANTS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Le Cabestan",
      category: "restaurant",
      imagePath: "assets/images/casablanca/cabestan.jpg",
      details: "Restaurant emblématique face à l'océan, réputé pour ses plats raffinés et son ambiance élégante.",
      googleMapsUrl: "https://maps.app.goo.gl/3n2NarC3xzZfZtTU9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Rick’s Café",
      category: "restaurant",
      imagePath: "assets/images/casablanca/ricks.jpg",
      details: "Inspiré du film Casablanca, ce café célèbre offre une ambiance unique et un menu international.",
      googleMapsUrl: "https://maps.app.goo.gl/55Zkpo8VVUKicxFx7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "La Sqala",
      category: "restaurant",
      imagePath: "assets/images/casablanca/lasqala.jpg",
      details: "Restaurant marocain traditionnel situé dans un fort historique.",
      googleMapsUrl: "https://maps.app.goo.gl/qaZ7nCwf4FeqGmyt5",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Le Relais de Paris",
      category: "restaurant",
      imagePath: "assets/images/casablanca/relais_paris.jpg",
      details: "Cuisine française raffinée dans un cadre élégant.",
      googleMapsUrl: "https://maps.app.goo.gl/Z96vQzno1LExCG7s8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Casa Jose",
      category: "restaurant",
      imagePath: "assets/images/casablanca/casajose.jpg",
      details: "Restaurant espagnol offrant tapas et ambiance chaleureuse.",
      googleMapsUrl: "https://maps.app.goo.gl/UkEdSVZTXorFQKve8",
    ),

    // ---------------- ACTIVITIES ----------------
    Attraction(
      id: uuid.v4(),
      name: "Shopping Morocco Mall",
      category: "activity",
      imagePath: "assets/images/casablanca/morocco_mall.jpg",
      details: "Le plus grand centre commercial d’Afrique, avec des boutiques, restaurants et attractions.",
      googleMapsUrl: "https://maps.app.goo.gl/zcp7DP6TtukwKZtR8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Visite Sky 28",
      category: "activity",
      imagePath: "assets/images/casablanca/sky28.jpg",
      details: "Un bar panoramique situé au 28e étage offrant une vue spectaculaire sur tout Casablanca.",
      googleMapsUrl: "https://maps.app.goo.gl/a6NQZBXTVefPXits8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Parc de la Ligue Arabe",
      category: "activity",
      imagePath: "assets/images/casablanca/parc_ligue_arabe.jpg",
      details: "Grand parc public pour se promener, se détendre et profiter d'espaces verts.",
      googleMapsUrl: "https://maps.app.goo.gl/f9F1vY5Jc7eznCXcA",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Plage Ain Diab",
      category: "activity",
      imagePath: "assets/images/casablanca/ain_diab.jpg",
      details: "Profitez du soleil et des activités nautiques sur la plage de Casablanca.",
      googleMapsUrl: "https://maps.app.goo.gl/f3kiwnaZb1r5NeG5A",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Hassan II Mosque Night Tour",
      category: "activity",
      imagePath: "assets/images/casablanca/hassan2.jpg",
      details: "Visite nocturne de la Mosquée Hassan II pour découvrir son illumination.",
      googleMapsUrl: "https://maps.app.goo.gl/s27nnwHHzuwi5Gdo9",
    ),
  ];

  for (final attraction in attractions) {
    await firestore
        .collection('casablanca_attractions')
        .doc(attraction.id)
        .set(attraction.toMap(), SetOptions(merge: true));
  }

  print("Casablanca attractions seeded successfully!");
}
