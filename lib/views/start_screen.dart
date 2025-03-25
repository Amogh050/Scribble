import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriclone/views/home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _letterControllers;
  late List<Animation<double>> _scaleAnimations;

  late AnimationController _imageController;
  late Animation<double> _imageScaleAnimation;

  final List<Color> colors = [
    Color(0xFFFF0000), // Bright Red for 'S'
    Color(0xFFFF8C00), // Vivid Orange for 'C'
    Color(0xFFFFEB00), // Bright Yellow for 'R'
    Color(0xFF32CD32), // Vivid Green for 'I'
    Color(0xFF00CED1), // Bright Cyan for 'B'
    Color(0xFF4169E1), // Vivid Blue for 'B'
    Color(0xFF9400D3), // Bright Purple for 'L'
    Color(0xFFFF1493), // Neon Pink for 'E'
  ];

  final letterAnimationDuration = const Duration(milliseconds: 1500);
  late final int staggerDelay =
      letterAnimationDuration.inMilliseconds ~/ 2; 

  @override
  void initState() {
    super.initState();

    _letterControllers = List.generate(
      8,
      (index) => AnimationController(
        vsync: this,
        duration: letterAnimationDuration,
      ),
    );

    _scaleAnimations = _letterControllers.map((controller) {
      return TweenSequence([
        TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 15.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 15.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50,
        ),
      ]).animate(controller);
    }).toList();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _imageScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Curves.bounceOut,
      ),
    );

    Future.delayed(const Duration(seconds: 1), _startAnimation);
  }

  void _startAnimation() {
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: staggerDelay * i), () {
        if (mounted) {
          _letterControllers[i].forward();
        }
      });
    }

    Future.delayed(Duration(milliseconds: staggerDelay * 7 + 400), () {
      if (mounted) {
        _imageController.forward();
      }
    });

    Future.delayed(Duration(milliseconds: staggerDelay * 7 + 400 + 2000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _letterControllers) {
      controller.dispose();
    }
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated "SCRIBBLE" title with scaling
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(8, (index) {
                      String letter = 'SCRIBBLE'[index];
                      Color color = colors[index];
                      return ScaleTransition(
                        scale: _scaleAnimations[index],
                        child: Text(
                          letter,
                          style: GoogleFonts.bubblegumSans(
                            textStyle: TextStyle(
                              fontSize: 60,
                              color: color,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
