
import 'package:duolingo_ui_clone/core/theme/app_colors.dart';
import 'package:duolingo_ui_clone/core/theme/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _showFace = true;
  bool _showLogo = false;
  bool _moveLogo = false;
  bool _opacityScreen = false;
  String? fakeToken = '123123123123';

  @override
  void initState(){
    super.initState();
    _startAnimation();
  }


  Future<void> _startAnimation() async {

    await Future.delayed(const Duration(milliseconds: 500));
    //start
    if(!mounted) return;
    setState(() {
      _showFace = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if(!mounted) return;
    setState(() {
      _showFace = false;

      _showLogo = true;
      _moveLogo = true;
    });

    // await Future.delayed(const Duration(milliseconds: 1500));
    //
    // if(!mounted) return;
    // setState(() {
    //   _opacityScreen = true;
    // });

    await Future.delayed(const Duration(milliseconds: 1500));
    if(!mounted) return;

    if(fakeToken != null) { // check dang nhap
      // Navigator.of(context).pushReplacementNamed('/home');
      // Nối Splash → Login (hiện tại mock: luôn đi login)
      context.pushReplacement('/login');
    } else {
      // Navigator.of(context).pushReplacementNamed('/home');
      // Nối Splash → Login (hiện tại mock: luôn đi login)
      context.pushReplacement('/login');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.duoGreen,
      body: SizedBox.expand( // ← ép Stack full màn hình
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: _showFace ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Image.asset(
                'assets/images/duolingo.png',
                width: 400,
              ),
            ),

            AnimatedSlide(
                offset: _moveLogo ? const Offset(0, 0) : const Offset(0,0.5),
                duration: const Duration(milliseconds: 300),
              child: AnimatedOpacity(
                  opacity: _showLogo ? 1: 0,
                  duration: const Duration(milliseconds: 500),
                child: SvgPicture.asset(
                  AppIcon.logoTextWhite,
                  width: 200,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}