import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:scriclone/views/create_room_screen.dart';
import 'package:scriclone/views/join_room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
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
                  // Animated Title
                  BounceInDown(
                    child: Text(
                      "Scribble Clash!",
                      style: GoogleFonts.pressStart2p(
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeIn(
                    child: Text(
                      "Create/Join a room to play!",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  // Animated Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("CREATE", Icons.add, CreateRoomScreen()),
                      _buildButton("JOIN", Icons.login, JoinRoomScreen()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Widget screen) {
    return ElevatedButton.icon(
      onPressed: () {
        // Use a more stable navigation method
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      icon: Icon(icon, size: 24, color: Colors.white),
      label: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        elevation: 5,
      ),
    );
  }
}
