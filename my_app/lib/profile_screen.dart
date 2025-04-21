import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fake user info for demonstration
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 48,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 20),
            const Text('Anthony', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Downtown Sharks', style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('+254 700 000 000'),
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text('Community Rank'),
              subtitle: Text('8'),
            ),
            ListTile(
              leading: Icon(Icons.emoji_events_outlined),
              title: Text('Tournament Rank'),
              subtitle: Text('8'),
            ),
          ],
        ),
      ),
    );
  }
}
