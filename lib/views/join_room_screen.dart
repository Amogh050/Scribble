import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriclone/views/paint_screen.dart';
import 'package:scriclone/widgets/custom_button.dart';
import 'package:scriclone/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  void joinRoom() {
    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty) {
      Map<String, String> data = {
        "nickname": _nameController.text,
        "name": _roomNameController.text
      };

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PaintScreen(data: data, screenFrom: 'joinRoom')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Join Room",
                style: GoogleFonts.pressStart2p(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: _nameController,
                  hintText: "Enter Your Name",
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: _roomNameController,
                  hintText: "Enter Room Name",
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                text: "JOIN",
                onPressed: joinRoom,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
