import 'package:flutter/material.dart';
import 'package:scriclone/paint_screen.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Create Room',
            style: TextStyle(color: Colors.black, fontSize: 30),
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
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(color: Colors.white),
                ),
                minimumSize: WidgetStatePropertyAll(
                  Size(
                    MediaQuery.of(context).size.width / 2.5,
                    50,
                  ),
                ),
              ),
              onPressed: joinRoom,
              child: const Text(
                'Join',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ))
        ],
      ),
    );
  }
}
