import 'package:flutter/material.dart';
import '../../../../core/common_widgets/social_login_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onEmailLoginToggle;

  const SocialLoginSection({
    super.key,
    required this.onGoogleLogin,
    required this.onEmailLoginToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // 구글 로그인 버튼
        SocialLoginButton(
          provider: SocialProvider.google,
          onPressed: onGoogleLogin,
        ),

        const SizedBox(height: AppSizes.spaceLg),

        // 구분선
        Row(
          children: [
            Expanded(
              child: Divider(
                color: isDarkMode ? AppColors.grey700 : AppColors.grey300,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMd,
              ),
              child: Text(
                '또는',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? AppColors.textSecondary
                      : AppColors.grey600,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: isDarkMode ? AppColors.grey700 : AppColors.grey300,
                thickness: 1,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSizes.spaceLg),

        // 이메일로 로그인 버튼
        OutlinedButton(
          onPressed: onEmailLoginToggle,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, AppSizes.buttonHeightLg),
            side: BorderSide(
              color: isDarkMode ? AppColors.grey600 : AppColors.grey400,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_outlined,
                color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
              ),
              const SizedBox(width: AppSizes.spaceSm),
              Text(
                '이메일로 로그인',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isDarkMode
                      ? AppColors.textWhite
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
