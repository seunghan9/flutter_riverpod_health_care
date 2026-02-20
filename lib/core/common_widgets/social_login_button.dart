import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

enum SocialProvider { kakao, google, facebook, apple }

class SocialLoginButton extends StatelessWidget {
  final SocialProvider provider;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;

  const SocialLoginButton({
    super.key,
    required this.provider,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final providerData = _getProviderData(provider);

    return Container(
      width: width ?? double.infinity,
      height: height ?? AppSizes.buttonHeightLg,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        color: isEnabled && !isLoading
            ? providerData.backgroundColor
            : AppColors.grey400,
        border: provider == SocialProvider.apple
            ? Border.all(color: AppColors.grey300, width: 1)
            : null,
        boxShadow: isEnabled && !isLoading
            ? [
                BoxShadow(
                  color: providerData.backgroundColor.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          onTap: isEnabled && !isLoading ? onPressed : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd,
              vertical: AppSizes.paddingSm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        providerData.textColor,
                      ),
                    ),
                  )
                else ...[
                  Icon(
                    providerData.icon,
                    color: providerData.iconColor ?? providerData.textColor,
                    size: AppSizes.iconMd,
                  ),
                  const SizedBox(width: AppSizes.spaceMd),
                  Text(
                    providerData.text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: providerData.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  _SocialProviderData _getProviderData(SocialProvider provider) {
    switch (provider) {
      case SocialProvider.kakao:
        return _SocialProviderData(
          backgroundColor: AppColors.kakao,
          textColor: AppColors.black,
          iconColor: AppColors.black,
          icon: Icons.chat_bubble,
          text: '카카오로 시작하기',
        );
      case SocialProvider.google:
        return _SocialProviderData(
          backgroundColor: AppColors.white,
          textColor: AppColors.textPrimary,
          iconColor: AppColors.google,
          icon: Icons.g_mobiledata,
          text: 'Google로 시작하기',
        );
      case SocialProvider.facebook:
        return _SocialProviderData(
          backgroundColor: AppColors.facebook,
          textColor: AppColors.textWhite,
          iconColor: AppColors.textWhite,
          icon: Icons.facebook,
          text: 'Facebook으로 시작하기',
        );
      case SocialProvider.apple:
        return _SocialProviderData(
          backgroundColor: AppColors.black,
          textColor: AppColors.textWhite,
          iconColor: AppColors.textWhite,
          icon: Icons.apple,
          text: 'Apple로 시작하기',
        );
    }
  }
}

class _SocialProviderData {
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final IconData icon;
  final String text;

  _SocialProviderData({
    required this.backgroundColor,
    required this.textColor,
    this.iconColor,
    required this.icon,
    required this.text,
  });
}
