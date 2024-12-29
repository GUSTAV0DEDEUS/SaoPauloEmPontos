// lib/core/models/photo_model.dart
class Photo {
  final String photoId;
  final String photoUrl;
  final String touristAttractionsId;
  final String userId;
  final String? location;
  final String date;
  final List<String> likedBy;

  Photo({
    required this.photoId,
    required this.photoUrl,
    required this.touristAttractionsId,
    required this.date,
    required this.userId,
    this.location,
    List<String>? likedBy,
  }) : likedBy = likedBy ?? [];

  int get likeCount => likedBy.length;

  bool isLikedBy(String userId) {
    return likedBy.contains(userId);
  }

  Photo copyWith({
    String? photoId,
    String? photoUrl,
    String? touristAttractionsId,
    String? userId,
    String? location,
    String? date,
    List<String>? likedBy,
  }) {
    return Photo(
      userId: userId ?? this.userId,
      photoId: photoId ?? this.photoId,
      photoUrl: photoUrl ?? this.photoUrl,
      touristAttractionsId: touristAttractionsId ?? this.touristAttractionsId,
      location: location ?? this.location,
      date: date ?? this.date,
      likedBy: likedBy ?? this.likedBy,
    );
  }
}
