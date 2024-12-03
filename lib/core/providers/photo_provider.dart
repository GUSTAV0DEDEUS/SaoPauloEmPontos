import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sp_pontos/core/models/photo.dart';
import 'package:sp_pontos/core/services/photo_service.dart';

class PhotoProvider with ChangeNotifier {
  final PhotoService _photoService = PhotoService();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  List<Photo> _photos = [];
  List<Photo> _userPhotos = [];
  bool _isLoading = false;

  List<Photo> get userPhotos => _userPhotos;
  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;

  Future<void> fetchPhotos() async {
  _isLoading = true;
  // Notify listeners before the async operation starts
  notifyListeners(); 

  try {
    final fetchedPhotos = await _photoService.fetchPhotos();
    _photos = fetchedPhotos.map((photoData) {
      return Photo(
        photoId: photoData['photoId'] ?? '',
        photoUrl: photoData['photoUrl'] ?? '',
        userId: photoData['userId'] ?? '',
        touristAttractionsId: photoData['touristAttractionsId'] ?? '',
        location: photoData['location'] ?? 'Localização desconhecida',
        date: photoData['date'] ?? '',
        likedBy: List<String>.from(photoData['likes'] ?? []),
      );
    }).toList();
  } catch (e) {
    print('Erro ao buscar fotos: $e');
  } finally {
    _isLoading = false;
    // Notify listeners after the async operation completes
    notifyListeners();
  }
}


  Future<void> toggleLike(String photoId) async {
    final photoIndex = _photos.indexWhere((photo) => photo.photoId == photoId);
    if (photoIndex != -1) {
      await _photoService.toggleLike(photoId);
      await fetchPhotos(); // Recarregar todas as fotos para atualizar o estado
    }
  }

  Future<bool> userLiked(String photoId) async {
    final photo = _photos.firstWhere((photo) => photo.photoId == photoId);
    return photo.isLikedBy(currentUserId);
  }

  Future<int> getLikeCount(String photoId) async {
    final photo = _photos.firstWhere((photo) => photo.photoId == photoId);
    return photo.likeCount;
  }
}
