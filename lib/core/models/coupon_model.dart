import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  final String id;
  final String title;
  final String discount;
  final String location;
  final Timestamp validDate;
  final List<String> usedBy;
  final String imageUrl; // Novo campo adicionado

  CouponModel({
    required this.id,
    required this.title,
    required this.discount,
    required this.location,
    required this.validDate,
    required this.usedBy,
    required this.imageUrl, // Campo adicionado ao construtor
  });

  // Método factory para mapear dados do Firestore para o modelo
  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      discount: map['discount'] ?? '',
      location: map['location'] ?? '',
      validDate: map['validDate'] ?? Timestamp.now(),
      usedBy: List<String>.from(map['usedBy'] ?? []),
      imageUrl: map['imageUrl'] ?? '', // Mapeando o campo imageUrl
    );
  }

  // Método para converter o modelo em um Map (útil ao salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'discount': discount,
      'location': location,
      'validDate': validDate,
      'usedBy': usedBy,
      'imageUrl': imageUrl, // Incluindo imageUrl no mapa
    };
  }

  // Verifica se o cupom foi usado pelo usuário atual
  bool isUsedByCurrentUser(String currentUserId) {
    return usedBy.contains(currentUserId);
  }

  // Método copyWith para fazer cópias do objeto com modificações opcionais
  CouponModel copyWith({
    String? id,
    String? title,
    String? discount,
    String? location,
    Timestamp? validDate,
    List<String>? usedBy,
    String? imageUrl, // Adicionando o campo imageUrl ao copyWith
  }) {
    return CouponModel(
      id: id ?? this.id,
      title: title ?? this.title,
      discount: discount ?? this.discount,
      location: location ?? this.location,
      validDate: validDate ?? this.validDate,
      usedBy: usedBy ?? this.usedBy,
      imageUrl: imageUrl ?? this.imageUrl, // Copiando o campo imageUrl
    );
  }
}
