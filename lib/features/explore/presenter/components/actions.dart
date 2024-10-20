import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';

class ActionsComponent extends StatelessWidget {
  const ActionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Center(
              child: Icon(
                Icons.favorite_border,
                color: AppColors.white,
                size: 30,
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        GestureDetector(
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(999), // Garante que o blur não "vaze"
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 12,
                    sigmaY: 12,
                  ),
                  child: Icon(
                    Icons.send,
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
