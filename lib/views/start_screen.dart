import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriclone/views/home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _showButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.purple.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: DefaultTextStyle(
                      style: GoogleFonts.pressStart2p(
                        textStyle: TextStyle(
                          fontSize: 8,
                          fontFamily: 'Bobbers',
                          color: Colors.black,
                        ),
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'SKRIBBLE',
                            textStyle: GoogleFonts.pressStart2p(
                              textStyle: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Bobbers',
                                color: Colors.black,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            speed: Duration(milliseconds: 400),
                          ),
                        ],
                        isRepeatingAnimation: false, // Play only once
                        onFinished: () {
                          setState(() {
                            _showButton = true;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.3), // Space between text and button
                  AnimatedOpacity(
                    opacity: _showButton ? 1.0 : 0.0,
                    duration: Duration(seconds: 1), // Fade-in effect
                    child: _showButton
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const HomeScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return ScaleTransition(
                                      scale: Tween<double>(begin: 0.0, end: 1.0)
                                          .animate(
                                        CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.bounceIn),
                                      ),
                                      child: FadeTransition(
                                        opacity:
                                            Tween(begin: 0.5, end: 1.0).animate(
                                          CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.bounceIn),
                                        ),
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              elevation: 5,
                            ),
                            child: const Text(
                              "PLAY",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          )
                        : SizedBox(), // Placeholder to maintain layout
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
