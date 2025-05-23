import 'package:flutter/material.dart';

class GlowUpScreen extends StatelessWidget {
  const GlowUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glow-Up Plan'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Your personalized Glow-Up Plan will appear here!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
