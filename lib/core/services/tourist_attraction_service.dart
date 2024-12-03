import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sp_pontos/core/models/place_carrousel.dart';

class TouristAttractionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlaceCarrousel>> fetchTouristAttractionsLimit() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('touristAttractions').limit(3).get();

      return snapshot.docs.map((doc) {
        return PlaceCarrousel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching tourist attractions: $e");
    }
  }
  Future<List<PlaceCarrousel>> fetchTouristAttractions() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('touristAttractions').get();

      return snapshot.docs.map((doc) {
        return PlaceCarrousel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching tourist attractions: $e");
    }
  }

  Future<List<PlaceCarrousel>> fetchAllTouristAttractions() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('touristAttractions').get();

      return snapshot.docs.map((doc) {
        return PlaceCarrousel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Error fetching tourist attractions: $e");
    }
  }
}
