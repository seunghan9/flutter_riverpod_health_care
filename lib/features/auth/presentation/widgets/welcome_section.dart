import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import 'health_logo_widget.dart';

class WelcomeSection extends StatelessWidget {
  final Animation<double>? scaleAnimation;
  final Animation<Offset>? slideAnimation;

  const WelcomeSection({super.key, this.scaleAnimation, this.slideAnimation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HealthLogoWidget(scaleAnimation: scaleAnimation),
        const SizedBox(height: AppSizes.spaceLg),
        Text(
          '건강한 삶의 시작',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.spaceSm),
        Text(
          'HealthCare와 함께 건강을 관리해보세요',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isDarkMode ? AppColors.textSecondary : AppColors.grey600,
          ),
        ),
      ],
    );

    if (slideAnimation != null) {
      return SlideTransition(position: slideAnimation!, child: content);
    }
    return content;
  }
}
