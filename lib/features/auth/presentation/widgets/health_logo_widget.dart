import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HealthLogoWidget extends StatelessWidget {
  final Animation<double>? scaleAnimation;
  final double? width;
  final double? height;

  const HealthLogoWidget({
    super.key,
    this.scaleAnimation,
    this.width = 120,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'health_logo',
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary.withValues(alpha: 0.1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(Icons.health_and_safety_outlined),
      ),
    );

    if (scaleAnimation != null) {
      return ScaleTransition(scale: scaleAnimation!, child: logo);
    }
    return logo;
  }
}
