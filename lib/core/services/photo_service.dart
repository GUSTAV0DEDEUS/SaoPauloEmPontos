// lib/core/services/photo_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhotoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> toggleLike(String photoId) async {
    DocumentReference photoRef = _firestore.collection('photos').doc(photoId);

    try {
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot photoSnapshot = await transaction.get(photoRef);
        List<dynamic> likes = List<dynamic>.from(photoSnapshot['likes'] ?? []);

        if (likes.contains(currentUserId)) {
          likes.remove(currentUserId);
        } else {
          likes.add(currentUserId);
        }

        transaction.update(photoRef, {'likes': likes});
      });
    } catch (e) {
      print('Erro ao alternar like: $e');
    }
  }

  Future<int> getLikeCount(String photoId) async {
    DocumentSnapshot photoSnapshot =
        await _firestore.collection('photos').doc(photoId).get();
    List<dynamic> likes = photoSnapshot['likes'] ?? [];
    return likes.length;
  }

  Future<bool> userLiked(String photoId) async {
    DocumentSnapshot photoSnapshot =
        await _firestore.collection('photos').doc(photoId).get();
    List<dynamic> likes = photoSnapshot['likes'] ?? [];
    return likes.contains(currentUserId);
  }

  Future<List<Map<String, dynamic>>> fetchPhotos() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('photos')
          .where('userId', isNotEqualTo: currentUserId)
          .get();

      List<Map<String, dynamic>> photos = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['photoId'] = doc.id; // Adiciona o ID do documento aos dados
        return data;
      }).toList();

      // Buscar as localizações para cada foto
      for (var photo in photos) {
        String location = await fetchLocation(photo['touristAttractionsId']);
        photo['location'] = location;
      }

      return photos;
    } catch (e) {
      print('Erro ao buscar fotos: $e');
      return [];
    }
  }

  Future<String> fetchLocation(String touristAttractionsId) async {
    try {
      DocumentSnapshot locationSnapshot = await _firestore
          .collection('touristAttractions')
          .doc(touristAttractionsId)
          .get();
      return locationSnapshot['name'] ?? 'Localização desconhecida';
    } catch (e) {
      print('Erro ao buscar localização: $e');
      return 'Localização desconhecida';
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserPhotos() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('photos')
          .where('userId', isEqualTo: currentUserId)
          .get();

      List<Map<String, dynamic>> userPhotos = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['photoId'] = doc.id; // Add document ID to the data
        return data;
      }).toList();

      // Fetch the locations for each photo
      for (var photo in userPhotos) {
        String location = await fetchLocation(photo['touristAttractionsId']);
        photo['location'] = location;
      }

      return userPhotos;
    } catch (e) {
      print('Erro ao buscar fotos do usuário: $e');
      return [];
    }
  }
}
