import 'package:fitness_app/features/auth/presentation/widgets/health_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/util/form_validators.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isEmailSent = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSendEmailPressed() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isEmailSent = true;
    });

    // TODO: 비밀번호 재설정 이메일 전송 로직 추가
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('비밀번호 재설정 이메일이 전송되었습니다'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _onResendEmail() {
    // TODO: 재전송 로직 추가
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('이메일이 재전송되었습니다'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '비밀번호 찾기',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSizes.spaceXl),
                  HealthLogoWidget(),
                  const SizedBox(height: AppSizes.spaceXl),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _isEmailSent
                        ? _buildEmailSentView(theme, isDarkMode)
                        : _buildEmailInputView(theme, isDarkMode),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInputView(ThemeData theme, bool isDarkMode) {
    return Column(
      key: const ValueKey('email_input'),
      children: [
        // 안내 아이콘
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            Icons.lock_reset_outlined,
            size: 40,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: AppSizes.spaceLg),

        Text(
          '비밀번호를 잊으셨나요?',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: AppSizes.spaceSm),

        Text(
          '가입하신 이메일 주소를 입력하시면\n비밀번호 재설정 링크를 보내드립니다',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDarkMode ? AppColors.textSecondary : AppColors.grey600,
            height: 1.5,
          ),
        ),

        const SizedBox(height: AppSizes.spaceXl),

        Form(
          key: _formKey,
          child: CustomTextField(
            controller: _emailController,
            labelText: '이메일 주소',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: FormValidators.email,
          ),
        ),

        const SizedBox(height: AppSizes.spaceXl),

        PrimaryButton(text: '재설정 링크 전송', onPressed: _onSendEmailPressed),

        const SizedBox(height: AppSizes.spaceLg),

        // 로그인으로 돌아가기
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '비밀번호가 기억나셨나요? ',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? AppColors.textSecondary : AppColors.grey600,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                '로그인',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSizes.spaceLg),
      ],
    );
  }

  Widget _buildEmailSentView(ThemeData theme, bool isDarkMode) {
    return Column(
      key: const ValueKey('email_sent'),
      children: [
        // 성공 아이콘
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.mark_email_read_outlined,
            size: 50,
            color: AppColors.success,
          ),
        ),

        const SizedBox(height: AppSizes.spaceLg),

        Text(
          '이메일을 확인해주세요',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textWhite : AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: AppSizes.spaceSm),

        Text(
          '${_emailController.text}로\n비밀번호 재설정 링크를 전송했습니다',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDarkMode ? AppColors.textSecondary : AppColors.grey600,
            height: 1.5,
          ),
        ),

        const SizedBox(height: AppSizes.spaceXl),

        // 이메일 재전송 버튼
        OutlinedButton(
          onPressed: _onResendEmail,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLg,
              vertical: AppSizes.paddingMd,
            ),
            side: BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
          ),
          child: Text(
            '이메일 재전송',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: AppSizes.spaceLg),

        PrimaryButton(
          text: '로그인으로 돌아가기',
          onPressed: () => Navigator.of(context).pop(),
        ),

        const SizedBox(height: AppSizes.spaceLg),

        // 이메일 받지 못한 경우 안내
        Text(
          '이메일을 받지 못하셨나요?\n스팸함을 확인하거나 고객센터에 문의해주세요',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDarkMode ? AppColors.textSecondary : AppColors.grey500,
            height: 1.4,
          ),
        ),

        const SizedBox(height: AppSizes.spaceLg),
      ],
    );
  }
}
