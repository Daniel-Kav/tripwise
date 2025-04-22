import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      // TODO: Replace with real auth check. For now, always go to login.
      Navigator.of(context).pushReplacementNamed('/login');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Center(
                child: Icon(Icons.sports_esports, size: 80, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'BILLIARD',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Clash',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
