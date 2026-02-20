import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class AuthBottomLinks extends StatelessWidget {
  final VoidCallback onSignUp;
  final VoidCallback onForgotPassword;
  final VoidCallback? onHelp;

  const AuthBottomLinks({
    super.key,
    required this.onSignUp,
    required this.onForgotPassword,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // 회원가입 / 비밀번호 찾기
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: onSignUp,
              child: Text(
                '회원가입',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            Container(
              width: 1,
              height: 16,
              color: isDarkMode ? AppColors.grey600 : AppColors.grey400,
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.spaceSm),
            ),

            TextButton(
              onPressed: onForgotPassword,
              child: Text(
                '비밀번호 찾기',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        // 고객센터 문의
        if (onHelp != null)
          TextButton(
            onPressed: onHelp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.help_outline,
                  size: 16,
                  color: isDarkMode
                      ? AppColors.textSecondary
                      : AppColors.grey600,
                ),
                const SizedBox(width: AppSizes.spaceSm),
                Text(
                  '아이디를 잊으셨나요? 고객센터 문의',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDarkMode
                        ? AppColors.textSecondary
                        : AppColors.grey600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
