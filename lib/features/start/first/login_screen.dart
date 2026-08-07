import 'dart:math';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:duolingo_ui_clone/core/widgets/app_text_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/app_group_input_field.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // cotrooler để lấy vào gán dữ liệu
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  // Tương đương việc gán giá trị mới cho state -> Compose tự recompose (Bài 4)
  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    //handle event here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đăng nhập...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.S16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(),
              const SizedBox(height: 28),
              _buildInputCard(),
              const SizedBox(height: 16),
              _buildSubmitted(),

              const Spacer(), // Đẩy cụm nút xuống đáy màn hình
              _buildPhoneButton(),
              const SizedBox(height: 12),
              // _buildSocialRow(),
              const SizedBox(height: 16),
              _buildFooter(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            // child: Padding(
              // padding: const EdgeInsets.all(10), // tự mở rộng vùng chạm
              child: SvgPicture.asset(AppIcon.back, width: 20),
            // ),
          ),
        ),

        Text(
          'Đăng nhập',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInputCard() {
    return  AppGroupInputField(
      children: [
        InGroupTextField(hint: 'Tên đăng nhập hoặc Email', controller: _usernameController, ),
        InGroupTextField(hint: 'Mật khẩu', controller: _passwordController,isPassword: true, ),
      ],
    );
  }

  Widget _buildSubmitted() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty)
            AppButton(
              label: 'ĐĂNG NHẬP',
              onPressed: () {},
              variant: ButtonVariant.secondary,
            )
          else
            AppButton(
              label: 'ĐĂNG NHẬP',
              onPressed: () {},
              variant: ButtonVariant.ghost,
            ),

          const SizedBox(height: 20),

          AppTextButton(
            text: 'QUÊN MẬT KHẨU',
            onPressed: () => {}
          ),

      ]
    );
  }

  Widget _buildPhoneButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          label: 'ĐĂNG NHẬP ĐIỆN THOẠI',
          iconPath: AppIcon.phone ,
          variant: ButtonVariant.neutral,
          onPressed: () => {},
        ),

        const SizedBox(height: AppSpacing.S16),

        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'FACEBOOK',
                iconPath: AppIcon.facebook,
                variant: ButtonVariant.neutral,
                  onPressed: () => {}
              ),
            ),
            const SizedBox(width: AppSpacing.S16),
            Expanded(
              child: AppButton(
                label: 'GOOGLE',
                iconPath: AppIcon.google,
                variant: ButtonVariant.neutral,
                  onPressed: () => {}
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFooter() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.5),
        children: [
          TextSpan(text: 'Khi đăng ký trên Duolingo, bạn đã đồng ý với '),
          TextSpan(
              text: 'Các chính sách',
              style: TextStyle(fontWeight: FontWeight.w700)),
          TextSpan(text: ' và '),
          TextSpan(
              text: 'Chính sách bảo mật',
              style: TextStyle(fontWeight: FontWeight.w700)),
          TextSpan(text: ' của chúng tôi.'),
        ],
      ),
    );
  }
}
