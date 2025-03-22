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
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Room",
                  style: GoogleFonts.bungee(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[Color(0xFFFFD700), Color(0xFFFFA500)],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(4), // Space for outer border
                  decoration: BoxDecoration(
                    color: Color(0xff28930f), // Outer border color
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff28930f), // Inner background
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(0xffa2f924), // Inner border color
                        width: 8, // Thin inner border
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: SizedBox(
                        width: 200, // Adjusted width
                        child: DropdownButton<String>(
                          alignment: Alignment.center, // Center alignment
                          value: _maxRoundsValue,
                          focusColor: const Color(0xff5f56fa),
                          hint: const Text(
                            'Select Max Rounds',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center, // Center text
                          ),
                          items: <String>["2", "5", "10", "15"]
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem(
                                  value: value,
                                  alignment: Alignment.center, // Center items
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _maxRoundsValue = value;
                            });
                          },
                          dropdownColor: Color(0xff28930f),
                          isExpanded: true,
                          iconEnabledColor: Colors.white,
                          iconSize: 30,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xff28930f),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff28930f),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(0xffa2f924),
                        width: 8,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: SizedBox(
                        width: 200, // Adjusted width
                        child: DropdownButton<String>(
                          alignment: Alignment.center, // Center alignment
                          value: _roomSizeValue,
                          focusColor: const Color(0xff5f56fa),
                          hint: const Text(
                            'Select Room Size',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center, // Center text
                          ),
                          items: <String>["2", "3", "4", "5", "6", "7", "8"]
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem(
                                  value: value,
                                  alignment: Alignment.center, // Center items
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _roomSizeValue = value;
                            });
                          },
                          dropdownColor: Color(0xff28930f),
                          isExpanded: true,
                          iconEnabledColor: Colors.white,
                          iconSize: 30,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: "CREATE",
                  onPressed: createRoom,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
