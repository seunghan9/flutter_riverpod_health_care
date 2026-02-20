import 'package:fitness_app/features/auth/presentation/widgets/health_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/util/form_validators.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUpPressed() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이용약관에 동의해주세요'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    // TODO: 회원가입 로직 추가
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('회원가입 기능은 곧 추가될 예정입니다'),
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
          '회원가입',
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSizes.spaceLg),
                    // 로고
                    HealthLogoWidget(),
                    const SizedBox(height: AppSizes.spaceLg),
                    Text(
                      '건강한 삶의 시작',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? AppColors.textWhite
                            : AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: AppSizes.spaceSm),

                    Text(
                      '새로운 계정을 만들어보세요',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDarkMode
                            ? AppColors.textSecondary
                            : AppColors.grey600,
                      ),
                    ),

                    const SizedBox(height: AppSizes.spaceXl),

                    // 이름 입력
                    CustomTextField(
                      controller: _nameController,
                      labelText: '이름',
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: FormValidators.name,
                    ),

                    const SizedBox(height: AppSizes.spaceMd),

                    // 이메일 입력
                    CustomTextField(
                      controller: _emailController,
                      labelText: '이메일',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: FormValidators.email,
                    ),

                    const SizedBox(height: AppSizes.spaceMd),

                    // 비밀번호 입력
                    CustomTextField(
                      controller: _passwordController,
                      labelText: '비밀번호',
                      obscureText: _obscurePassword,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: FormValidators.strongPassword,
                    ),

                    const SizedBox(height: AppSizes.spaceMd),

                    // 비밀번호 확인 입력
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: '비밀번호 확인',
                      obscureText: _obscureConfirmPassword,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      validator: FormValidators.confirmPassword(
                        _passwordController.text,
                      ),
                    ),

                    const SizedBox(height: AppSizes.spaceLg),

                    // 이용약관 동의
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value!;
                            });
                          },
                          activeColor: AppColors.primary,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _agreeToTerms = !_agreeToTerms;
                              });
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '이용약관',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const TextSpan(text: '에 동의합니다'),
                                ],
                              ),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDarkMode
                                    ? AppColors.textSecondary
                                    : AppColors.grey600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSizes.spaceXl),

                    // 회원가입 버튼
                    PrimaryButton(text: '회원가입', onPressed: _onSignUpPressed),

                    const SizedBox(height: AppSizes.spaceLg),

                    // 로그인으로 돌아가기
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '이미 계정이 있으신가요? ',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDarkMode
                                ? AppColors.textSecondary
                                : AppColors.grey600,
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
