import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: width ?? double.infinity,
      height: height ?? AppSizes.buttonHeightLg,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMd),
        gradient: isEnabled && !isLoading
            ? LinearGradient(
                colors: [
                  backgroundColor ?? AppColors.primary,
                  (backgroundColor ?? AppColors.primary).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: (!isEnabled || isLoading)
            ? AppColors.grey400
            : null,
        boxShadow: isEnabled && !isLoading
            ? [
                BoxShadow(
                  color: (backgroundColor ?? AppColors.primary).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMd),
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
                        textColor ?? AppColors.textWhite,
                      ),
                    ),
                  )
                else ...[
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: AppSizes.spaceSm),
                  ],
                  Text(
                    text,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: textColor ?? AppColors.textWhite,
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
}