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

  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();

    // Animated background gradient
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Car animation
    _carController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _carFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _carController, curve: Curves.easeIn));
    _carSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _carController, curve: Curves.easeOut));

    _logoController.forward();

    Future.delayed(const Duration(milliseconds: 1500), () {
      _carController.forward();
    });

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
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.blueAccent.withOpacity(
                    0.3 + 0.2 * _bgController.value,
                  ),
                  Colors.black,
                  Colors.blueGrey.withOpacity(0.3 - 0.2 * _bgController.value),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            SizedBox.expand(
              // 🔹 Take full width & height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // 🔹 Center horizontally
                children: [
                  // Glowing BMW Logo
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.6),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/bmwlogo.png',
                          width: 140,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Car entrance with fade + slide
                  SlideTransition(
                    position: _carSlide,
                    child: FadeTransition(
                      opacity: _carFade,
                      child: Image.asset(
                        'assets/images/bmw-m4.png',
                        height: 180,
                        fit:
                            BoxFit.contain, // 🔹 Scales properly on all screens
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
