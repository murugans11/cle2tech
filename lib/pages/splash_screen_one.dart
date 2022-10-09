import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../constants/constants.dart';
import 'initial_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({Key? key}) : super(key: key);

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height / 3),
            SizedBox(
              height: 210,
              width: 210,
              /*child:  Image(
                image: AssetImage(AppTheme.of(context)?.assets.logo2 ?? '',),
              ),*/
              child: AnimatedSplashScreen(
                duration: 3000,
                splash: AppTheme.of(context)?.assets.logo2 ?? '',
                splashTransition: SplashTransition.rotationTransition,
                backgroundColor: primaryColor,
                nextScreen: const InitialPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
