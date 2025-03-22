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
  // Tracks visibility of each letter in "SCRIBBLE"
  List<bool> _letterVisibilities = List.filled(8, false);
  bool _showButton = false; // Controls visibility of the "PLAY" button
  late AnimationController _imageController; // Controller for image animation
  late Animation<double> _imageScaleAnimation; // Animation for image scaling
  bool _isInitialized = false; // Flag to ensure initialization is complete

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

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for the image pop-up effect
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Image animation duration
    );

    // Define the scale animation (from 0.0 to 1.0) with a bounce effect
    _imageScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: Curves.bounceOut, // Bouncy scaling effect
      ),
    );

    // Mark initialization as complete
    _isInitialized = true;

    // Start the animation sequence
    _startAnimation();
  }

  // Method to handle the animation sequence
  void _startAnimation() {
    // Animate each letter of "SCRIBBLE" sequentially
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: 400 * i), () {
        if (mounted) {
          setState(() {
            _letterVisibilities[i] = true; // Show the letter
          });
          if (i == 7) {
            // After the last letter, start the image animation with a delay
            Future.delayed(Duration(milliseconds: 400), () {
              if (mounted) {
                _imageController.forward(); // Trigger image pop-up
              }
            });
          }
        }
      });
    }

    // Show the "PLAY" button when the image animation completes
    _imageController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() {
          _showButton = true; // Display the button
        });
      }
    });
  }

  @override
  void dispose() {
    _imageController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (optional, adjust as needed)
          Container(
            decoration: BoxDecoration(
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
                  // Animated "SCRIBBLE" title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(8, (index) {
                      String letter = 'SCRIBBLE'[index];
                      Color color = colors[index];
                      return AnimatedOpacity(
                        opacity: _letterVisibilities[index] ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 550),
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
                  // Spacing between title and image
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // "draw_together" image with pop-up animation, only if initialized
                  if (_isInitialized)
                    ScaleTransition(
                      scale: _imageScaleAnimation,
                      child: FadeTransition(
                        opacity: _imageScaleAnimation,
                        child: Image.asset(
                          'assets/draw_together-main.png',
                          width: 400, // Adjust size as needed
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  // Spacing between image and button
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  // "PLAY" button with fade-in effect
                  AnimatedOpacity(
                    opacity: _showButton ? 1.0 : 0.0,
                    duration: Duration(seconds: 1),
                    child: _showButton
                        ? CustomButton(
                            text: 'PLAY',
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const HomeScreen(), // Replace with your HomeScreen
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
                        : SizedBox(), // Placeholder when button is not visible
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