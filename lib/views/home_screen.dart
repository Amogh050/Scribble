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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BounceInDown(
                  child: Image.asset(
                    'assets/name.png',
                    width: 350,
                    height: 150,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/character.png',
                  width: 400,
                  height: 200,
                ),
                SizedBox(height: 40),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200,
                      child: _buildGameButton("CREATE", Icons.add, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateRoomScreen()));
                      }),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 200,
                      child: _buildGameButton("JOIN", Icons.group, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoinRoomScreen()));
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      width: 320,
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.bungee(
                  textStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
