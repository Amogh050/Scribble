import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriclone/views/paint_screen.dart';
import 'package:scriclone/widgets/custom_button.dart';
import 'package:scriclone/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  String? _maxRoundsValue;
  String? _roomSizeValue;

  void createRoom() {
    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty &&
        _maxRoundsValue != null &&
        _roomSizeValue != null) {
      Map<String, String> data = {
        "nickname": _nameController.text,
        "name": _roomNameController.text,
        "occupancy": _roomSizeValue!,
        "maxRounds": _maxRoundsValue!
      };
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PaintScreen(data: data, screenFrom: 'createRoom')));
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
          "NEW ROOM",
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
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
                            const SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: IntrinsicWidth(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 154, 238, 53),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        alignment: Alignment.center,
                                        value: _maxRoundsValue,
                                        focusColor: const Color(0xff5f56fa),
                                        hint: const Text(
                                          'Select Max Rounds',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        items: <String>["2", "5", "10", "15"]
                                            .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem(
                                                value: value,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _maxRoundsValue = value;
                                          });
                                        },
                                        dropdownColor:
                                            Color.fromARGB(255, 154, 238, 53),
                                        isDense: true,
                                        iconEnabledColor: Colors.black,
                                        iconSize: 30,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: IntrinsicWidth(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 154, 238, 53),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        alignment: Alignment.center,
                                        value: _roomSizeValue,
                                        focusColor: const Color(0xff5f56fa),
                                        hint: const Text(
                                          'Select Room Size',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        items: <String>[
                                          "2",
                                          "3",
                                          "4",
                                          "5",
                                          "6",
                                          "7",
                                          "8"
                                        ]
                                            .map<DropdownMenuItem<String>>(
                                              (String value) =>
                                                  DropdownMenuItem(
                                                value: value,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _roomSizeValue = value;
                                          });
                                        },
                                        dropdownColor:
                                            Color.fromARGB(255, 154, 238, 53),
                                        isDense: true,
                                        iconEnabledColor: Colors.black,
                                        iconSize: 30,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Create button at bottom
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: CustomButton(
                    text: "CREATE",
                    onPressed: createRoom,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
