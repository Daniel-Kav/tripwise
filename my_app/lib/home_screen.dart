import 'package:flutter/material.dart';
import 'tournament_screen.dart';
import 'community_screen.dart';
import 'shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    _HomeMain(),
    TournamentScreen(),
    CommunityScreen(),
    ShopScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Tournament',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class _HomeMain extends StatelessWidget {
  const _HomeMain();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Profile section

          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/profile'),
            child: const Row(
              children: [
                // Profile picture
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Anthony', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 18
                      )
                    ),
                    Text('Downtown Sharkss', 
                      style: TextStyle(
                        fontSize: 14, 
                        color: Colors.black54
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Rank statistics card
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Community\nRank', 
                      style: TextStyle(
                        fontSize: 16, 
                        color: Colors.white,
                        height: 1.2,
                      )
                    ),
                    SizedBox(height: 8),
                    Text('8', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 32, 
                        color: Colors.white
                      )
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Tournament\nRank', 
                      style: TextStyle(
                        fontSize: 16, 
                        color: Colors.white,
                        height: 1.2,
                      )
                    ),
                    SizedBox(height: 8),
                    Text('8', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 32, 
                        color: Colors.white
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Main content in Expanded to fill remaining space
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Live tournaments section
                const Text('Live Tournaments', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 18
                  )
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nairobi Championship', 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )
                            ),
                            SizedBox(height: 12),
                            Text('Today, 4:30 PM', 
                              style: TextStyle(
                                color: Colors.black54, 
                                fontSize: 14
                              )
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Icon(Icons.play_circle_outline, 
                            size: 36, 
                            color: Colors.orange
                          ),
                          SizedBox(height: 4),
                          Text('Watch', 
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Top communities section
                const Text('Top Communities', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 18
                  )
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 56,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            Text('Nairobi East', 
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              )
                            ),
                            SizedBox(width: 12),
                            Icon(Icons.people, size: 18, color: Colors.orange),
                            SizedBox(width: 4),
                            Text('156 players', 
                              style: TextStyle(
                                fontSize: 13, 
                                color: Colors.black54
                              )
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Top shooters section
                const Text('Top Shooters', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 18
                  )
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1. John Doe - 2,450 pts',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
                      ),
                      SizedBox(height: 12),
                      Text('2. Jane Smith - 2,380 pts',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
                      ),
                      SizedBox(height: 12),
                      Text('3. Mike Johnson - 2,310 pts',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
                      ),
                      SizedBox(height: 12),
                      Text('4. Sarah Williams - 2,290 pts',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}