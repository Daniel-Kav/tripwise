import 'package:flutter/material.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tournaments')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.emoji_events_outlined, size: 80, color: Colors.orange),
            SizedBox(height: 24),
            Text('Tournament Listings Coming Soon!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
