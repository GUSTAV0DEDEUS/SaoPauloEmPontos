import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileComponent extends StatelessWidget {
  final String imageUrl;
  final String name;
  const ProfileComponent({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          999,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4,
              right: 10,
              top: 4,
              bottom: 4,
            ),
            child: Row(children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(imageUrl),
              ),
              SizedBox(width: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
