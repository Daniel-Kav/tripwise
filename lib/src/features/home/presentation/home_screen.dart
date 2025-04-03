import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Tournament',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFFFA500), // Orange color from UI
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const HomeTab();
      case 1:
        return const Center(child: Text('Tournament Tab'));
      case 2:
        return const Center(child: Text('Community Tab'));
      case 3:
        return const Center(child: Text('Shop Tab'));
      default:
        return const HomeTab();
    }
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Profile Section
          _buildUserProfileSection(context),
          
          const SizedBox(height: 24),
          
          // Live Tournaments Section
          _buildSectionTitle('live tournaments'),
          const SizedBox(height: 12),
          _buildLiveTournamentCard(context),
          
          const SizedBox(height: 24),
          
          // Top Communities Section
          _buildSectionTitle('top communities'),
          const SizedBox(height: 12),
          _buildCommunitiesGrid(),
          
          const SizedBox(height: 24),
          
          // Top Shooters Section
          _buildSectionTitle('top shooters'),
          const SizedBox(height: 12),
          _buildTopShootersList(),
        ],
      ),
    );
  }

  Widget _buildUserProfileSection(BuildContext context) {
    return Row(
      children: [
        // User Avatar and Name
        Expanded(
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFA500), // Orange color from UI
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anthony',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Downtown Sharks',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Notification Icon
        IconButton(
          icon: const Icon(Icons.notifications_outlined, size: 28),
          onPressed: () {
            // Handle notification tap
          },
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildLiveTournamentCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nairobi Championship',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                Text(
                  'Today, 4:30 PM',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildPlayerAvatar(),
                    const SizedBox(width: 8),
                    const Text('vs'),
                    const SizedBox(width: 8),
                    _buildPlayerAvatar(),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle watch button tap
                  },
                  icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('watch'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE0E0E0),
      ),
    );
  }

  Widget _buildCommunitiesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nairobi East',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text(
                      '156 players',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopShootersList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    '${index + 1}.',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Rankings Widget shown in the UI
class RankingsCard extends StatelessWidget {
  const RankingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFA500), // Orange color from UI
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildRankColumn(context, 'community\nRank', '8'),
          _buildRankColumn(context, 'Tournament\nRank', '8'),
        ],
      ),
    );
  }

  Widget _buildRankColumn(BuildContext context, String title, String rank) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          rank,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
