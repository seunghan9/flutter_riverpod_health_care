import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common_widgets/primary_button.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(authProvider.notifier)
        .login(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    // ViewModel의 상태를 구독
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // 에러 발생 시
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: AppColors.error,
          ),
        ),
        data: (_) {
          // 성공 시 로직
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('환영합니다!'),
              backgroundColor: AppColors.success,
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.darkBackground
          : AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: AppSizes.spaceXxl),
                // 폼 영역
                CustomTextField(
                  controller: _emailController,
                  labelText: '이메일',
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (v) => v!.isEmpty ? '이메일을 입력해주세요' : null,
                ),
                const SizedBox(height: AppSizes.spaceMd),
                CustomTextField(
                  controller: _passwordController,
                  labelText: '비밀번호',
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (v) => v!.length < 6 ? '6자 이상 입력해주세요' : null,
                ),

                const SizedBox(height: AppSizes.spaceLg),
                PrimaryButton(
                  text: '로그인',
                  onPressed: _onLoginPressed,
                  isLoading: authState.isLoading, // Notifier가 로딩 중인지 알려줌
                  isEnabled: !authState.isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
