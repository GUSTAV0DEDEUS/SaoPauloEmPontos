import 'package:flutter/material.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';

class BuildProgressIndicator extends StatelessWidget {
  final int step;
  final int remainingSteps;
  const BuildProgressIndicator(
      {super.key, required this.step, required this.remainingSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: step,
          child: Container(
            height: 4,
            color: AppColors.yellow,
          ),
        ),
        Expanded(
          flex: remainingSteps,
          child: Container(
            height: 4,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }
}
