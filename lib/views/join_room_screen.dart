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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Join Room",
          style: GoogleFonts.bungee(
            textStyle: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[Color(0xFFFFD700), Color(0xFFFFA500)],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF9C4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFF8D6E63),
                          width: 4,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              controller: _nameController,
                              hintText: "Enter Your Name",
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              controller: _roomNameController,
                              hintText: "Enter Room Name",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Join button at bottom
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: CustomButton(
                  text: "JOIN",
                  onPressed: joinRoom,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
