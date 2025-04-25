import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fake user info for demonstration
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white, size: 48),
            ),
            SizedBox(height: 20),
            Text('Anthony', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Downtown Sharks', style: TextStyle(fontSize: 16, color: Colors.black54)),
            SizedBox(height: 32),
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
