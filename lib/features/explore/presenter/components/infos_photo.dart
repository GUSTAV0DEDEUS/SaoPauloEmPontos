import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sp_pontos/core/components/text_app.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';

class InfosPhoto extends StatelessWidget {
  final String title;
  const InfosPhoto({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(
          label: title,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(999),
            ),
            border: Border.all(
              color: AppColors.white,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              999,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.2),
                borderRadius: BorderRadius.circular(999),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 12,
                  sigmaY: 12,
                ),
                child: TextApp(
                  label: 'Muitas pessoas curtiram esse lugar!',
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        // Row(
        //   children: [
        //     Row(
        //       children: [
        //         Icon(
        //           Icons.location_on_outlined,
        //           color: AppColors.white,
        //           size: 16,
        //         ),
        //         SizedBox(width: 4),
        //         TextApp(
        //           label: title,
        //           fontSize: 16,
        //           color: AppColors.white,
        //         ),
        //       ],
        //     ),

        //   ],
        // ),
      ],
    );
  }
}
