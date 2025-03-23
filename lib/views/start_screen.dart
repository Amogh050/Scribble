import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriclone/views/home_screen.dart'; // Adjust import as needed
import 'package:scriclone/widgets/custom_button.dart'; // Adjust import as needed

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with TickerProviderStateMixin {
  // Animation controllers and animations for each letter
  late List<AnimationController> _letterControllers;
  late List<Animation<double>> _scaleAnimations;

  // Controller and animation for the image
  late AnimationController _imageController;
  late Animation<double> _imageScaleAnimation;

  // Flag to control "PLAY" button visibility
  bool _showButton = false;

  // Color scheme for each letter in "SCRIBBLE"
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

  // Animation durations and delays
  final letterAnimationDuration = const Duration(milliseconds: 1500);
  late final int staggerDelay = letterAnimationDuration.inMilliseconds ~/ 2; // 750ms

  @override
  void initState() {
    super.initState();

    // Initialize letter animation controllers (8 letters in "SCRIBBLE")
    _letterControllers = List.generate(
      8,
      (index) => AnimationController(
        vsync: this,
        duration: letterAnimationDuration,
      ),
    );

    // Define scale animations for each letter: 0 -> 15 -> 1
    _scaleAnimations = _letterControllers.map((controller) {
      return TweenSequence([
        TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 15.0).chain(CurveTween(curve: Curves.easeOut)),
          weight: 50, // 50% of duration for expansion (750ms)
        ),
        TweenSequenceItem(
          tween: Tween(begin: 15.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
          weight: 50, // 50% of duration for shrinking (750ms)
        ),
      ]).animate(controller);
    }).toList();

    // Initialize image animation controller
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define image scale animation with bounce effect
    _imageScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Curves.bounceOut,
      ),
    );

    // Start the animation sequence
    _startAnimation();
  }

  void _startAnimation() {
    // Start each letter's animation with a 750ms stagger
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: staggerDelay * i), () {
        if (mounted) {
          _letterControllers[i].forward();
        }
      });
    }

    // Start image animation 400ms after the last letter starts
    Future.delayed(Duration(milliseconds: staggerDelay * 7 + 400), () {
      if (mounted) {
        _imageController.forward();
      }
    });

    // Show "PLAY" button when image animation completes
    _imageController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose of all letter controllers
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
          // Background image
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
                  // Spacing
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  // "PLAY" button with fade-in
                  AnimatedOpacity(
                    opacity: _showButton ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: _showButton
                        ? CustomButton(
                            text: 'PLAY',
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                          const HomeScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return ScaleTransition(
                                      scale: Tween<double>(begin: 0.0, end: 1.0)
                                          .animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.bounceIn,
                                        ),
                                      ),
                                      child: FadeTransition(
                                        opacity:
                                            Tween(begin: 0.5, end: 1.0).animate(
                                          CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.bounceIn,
                                          ),
                                        ),
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
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