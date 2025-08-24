import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/dashboard'); // Adjust route as needed
    });

    return Scaffold(
      body: Container(
        color: const Color(0xFF06161E),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.security,
                size: 100,
                color: Color(0xFF41C1BA),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to the SecuraEntry',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
