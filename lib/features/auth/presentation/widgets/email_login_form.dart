import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/common_widgets/custom_text_field.dart';
import '../../../../core/common_widgets/primary_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/util/form_validators.dart';

class EmailLoginForm extends ConsumerStatefulWidget {
  final Function(String email, String password) onLogin;
  final VoidCallback onBackToSocial;
  final bool isLoading;

  const EmailLoginForm({
    super.key,
    required this.onLogin,
    required this.onBackToSocial,
    this.isLoading = false,
  });

  @override
  ConsumerState<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends ConsumerState<EmailLoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // 이메일 입력
          CustomTextField(
            controller: _emailController,
            labelText: '이메일',
            prefixIcon: const Icon(Icons.email_outlined),
            keyboardType: TextInputType.emailAddress,
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
            validator: FormValidators.password,
          ),

          const SizedBox(height: AppSizes.spaceLg),

          // 로그인 버튼
          PrimaryButton(
            text: '로그인',
            onPressed: _onLoginPressed,
            isLoading: widget.isLoading,
            isEnabled: !widget.isLoading,
          ),

          const SizedBox(height: AppSizes.spaceLg),

          // 뒤로 가기 버튼
          TextButton(
            onPressed: widget.onBackToSocial,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios, size: 16, color: AppColors.primary),
                const SizedBox(width: AppSizes.spaceSm),
                Text(
                  '다른 방법으로 로그인',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
