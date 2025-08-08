import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bmw_clone/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _carController;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _carFade;
  late Animation<Offset> _carSlide;

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Car animation (fade + slide in)
    _carController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _carFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _carController, curve: Curves.easeIn));
    _carSlide = Tween<Offset>(
      begin: const Offset(0, 0.5), // start slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _carController, curve: Curves.easeOut));

    _logoController.forward();

    // Start car after logo
    Future.delayed(const Duration(milliseconds: 1500), () {
      _carController.forward();
    });

    // Navigate after animations
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Moving light streak effect
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.blue.withOpacity(0.2),
                  Colors.black,
                ],
                stops: const [0.2, 0.5, 0.8],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Centered content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: Image.asset('assets/images/bmwlogo.png', width: 140),
                ),
              ),
              const SizedBox(height: 50),
              SlideTransition(
                position: _carSlide,
                child: FadeTransition(
                  opacity: _carFade,
                  child: Image.asset('assets/images/bmw-m4.png', height: 180),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
