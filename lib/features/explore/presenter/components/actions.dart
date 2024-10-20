// lib/features/explore/presenter/components/actions.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_pontos/core/providers/photo_provider.dart';
import 'package:sp_pontos/features/auth/data/auth_repository.dart'; // Importando AuthRepository

class ActionsComponent extends StatefulWidget {
  final String photoId;

  const ActionsComponent({super.key, required this.photoId});

  @override
  _ActionsComponentState createState() => _ActionsComponentState();
}

class _ActionsComponentState extends State<ActionsComponent> {
  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);
   

    return FutureBuilder<bool>(
      future: photoProvider.userLiked(widget.photoId), // Passar userId
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final userLiked = snapshot.data!;

        return GestureDetector(
          onTap: () {
            photoProvider.toggleLike(widget.photoId); // Passar userId
          },
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: userLiked ? Colors.red : Colors.grey,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Center(
              child: Icon(
                userLiked ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}
