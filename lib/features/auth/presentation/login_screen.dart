import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/util/navigation_helper.dart';
import '../providers/auth_provider.dart';
import 'widgets/auth_animations_mixin.dart';
import 'widgets/welcome_section.dart';
import 'widgets/social_login_section.dart';
import 'widgets/email_login_form.dart';
import 'widgets/auth_bottom_links.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> 
    with SingleTickerProviderStateMixin, AuthAnimationsMixin {
  bool _isEmailLogin = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    _setupAuthListener();

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight - MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Column(
                children: [
                  // 상단 로고 및 환영 메시지 영역 (40%)
                  Expanded(
                    flex: 4,
                    child: WelcomeSection(
                      scaleAnimation: scaleAnimation,
                      slideAnimation: slideAnimation,
                    ),
                  ),
                  
                  // 로그인 영역 (60%)
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: _isEmailLogin
                                ? _buildEmailLoginView(authState)
                                : _buildSocialLoginView(),
                          ),
                        ),
                        
                        // 하단 링크들
                        AuthBottomLinks(
                          onSignUp: _navigateToSignUp,
                          onForgotPassword: _navigateToForgotPassword,
                          onHelp: _showHelpDialog,
                        ),
                        
                        const SizedBox(height: AppSizes.spaceLg),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginView() {
    return SocialLoginSection(
      key: const ValueKey('social_login'),
      onGoogleLogin: _onGoogleLogin,
      onEmailLoginToggle: _toggleLoginMethod,
    );
  }

  Widget _buildEmailLoginView(AsyncValue<void> authState) {
    return EmailLoginForm(
      key: const ValueKey('email_login'),
      onLogin: _onEmailLogin,
      onBackToSocial: _toggleLoginMethod,
      isLoading: authState.isLoading,
    );
  }

  // Event Handlers
  void _setupAuthListener() {
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) => _showSnackBar(error.toString(), AppColors.error),
        data: (_) => _showSnackBar('환영합니다!', AppColors.success),
      );
    });
  }

  void _onGoogleLogin() {
    _showSnackBar('구글 로그인 기능은 곧 추가될 예정입니다', AppColors.success);
  }

  void _onEmailLogin(String email, String password) {
    ref.read(authProvider.notifier).login(email, password);
  }

  void _toggleLoginMethod() {
    setState(() {
      _isEmailLogin = !_isEmailLogin;
    });
  }

  void _navigateToSignUp() {
    NavigationHelper.slideToPage(context, const SignUpScreen());
  }

  void _navigateToForgotPassword() {
    NavigationHelper.slideToPage(context, const ForgotPasswordScreen());
  }

  void _showHelpDialog() {
    _showSnackBar('고객센터 기능은 곧 추가될 예정입니다', AppColors.info);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}