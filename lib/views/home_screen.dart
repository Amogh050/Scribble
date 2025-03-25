import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:scriclone/views/create_room_screen.dart';
import 'package:scriclone/views/join_room_screen.dart';
import 'package:scriclone/widgets/custom_button.dart';

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
                      child: CustomButton(
                        text: "CREATE",
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateRoomScreen()));
                        },
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: 200,
                      child: CustomButton(
                        text: "JOIN",
                        icon: Icons.group,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JoinRoomScreen()));
                        },
                      ),
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
}
