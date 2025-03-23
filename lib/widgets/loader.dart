import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer when the screen loads
    _timer = Timer(const Duration(seconds: 15), () {
      if (mounted) {
        // Navigate back to the previous screen
        Navigator.of(context).pop();
        // Show a SnackBar with the message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please check your internet connection'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: Colors.red,
              size: 120,
            ),
          ),
        ],
      ),
    );
  }
}