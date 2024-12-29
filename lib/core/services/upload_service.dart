import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';

class UploadService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  Future<String> uploadImage(File imageFile) async {
    try {
      final fileName = path.basename(imageFile.path);
      final storageRef = _firebaseStorage.ref().child('uploads/$fileName');

      await storageRef.putFile(imageFile);

      return await storageRef.getDownloadURL();
    } catch (e) {
      throw Exception('Erro ao enviar a imagem: $e');
    }
  }

  Future<void> savePhotoDetails(String imageUrl, String locationId) async {
    try {
      await _firestore.collection('photos').add({
        'userId': _userId,
        'touristAttractionsId': locationId,
        'photoUrl': imageUrl,
        'likes': [],
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao salvar detalhes da foto: $e');
    }
  }
}
