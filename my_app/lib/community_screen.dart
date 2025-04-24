import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search and Create Group Row
              Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search communities',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Create Group Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Create Group',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', true),
                    const SizedBox(width: 8),
                    _buildFilterChip('Tournaments', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Local Groups', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Training', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Events', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Discussion', false),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Community Posts List
              Expanded(
                child: ListView(
                  children: [
                    ..._buildCommunityPosts(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCommunityPosts() {
    final List<Map<String, dynamic>> communities = [
      {
        'title': 'Nairobi Pool Players',
        'description': 'New practice session scheduled for Friday at Downtown Billiards',
        'timeAgo': '25 min ago',
        'memberCount': '78 members',
        'type': 'Local Groups',
        'icon': '🎱',
      },
      {
        'title': 'Pro Tips & Techniques',
        'description': 'Check out this video on improving your break shot technique',
        'timeAgo': '1 hour ago',
        'memberCount': '156 members',
        'type': 'Training',
        'icon': '🎱',
        'notificationCount': 12,
      },
      {
        'title': 'National Masters Cup Discussion',
        'description': 'Congratulations to all the finalists! What a tournament.',
        'timeAgo': '2 hours ago',
        'memberCount': '203 members',
        'type': 'Tournaments',
        'icon': '🏆',
      },
      {
        'title': 'Mombasa Pool Community',
        'description': 'New venue opening next week near the beach, who\'s joining?',
        'timeAgo': '3 hours ago',
        'memberCount': '64 members',
        'type': 'Local Groups',
        'icon': '🎱',
        'notificationCount': 5,
      },
      {
        'title': 'Beginners Corner',
        'description': 'Weekly tips and tricks for newcomers to the game',
        'timeAgo': '4 hours ago',
        'memberCount': '245 members',
        'type': 'Training',
        'icon': '📚',
      },
      {
        'title': 'Equipment Reviews',
        'description': 'Share your experiences with different cues and accessories',
        'timeAgo': '5 hours ago',
        'memberCount': '189 members',
        'type': 'Discussion',
        'icon': '🔍',
      },
      {
        'title': 'Kisumu Pool League',
        'description': 'League standings and upcoming matches',
        'timeAgo': '6 hours ago',
        'memberCount': '92 members',
        'type': 'Local Groups',
        'icon': '🎱',
      },
      {
        'title': 'Tournament Strategy',
        'description': 'Advanced tactics for competitive play',
        'timeAgo': '7 hours ago',
        'memberCount': '167 members',
        'type': 'Training',
        'icon': '🎯',
      },
      {
        'title': 'Rules & Regulations',
        'description': 'Official rules and tournament regulations',
        'timeAgo': '8 hours ago',
        'memberCount': '312 members',
        'type': 'Discussion',
        'icon': '📋',
      },
      {
        'title': 'East Africa Championship',
        'description': 'Updates and discussions about the upcoming championship',
        'timeAgo': '9 hours ago',
        'memberCount': '423 members',
        'type': 'Tournaments',
        'icon': '🏆',
      },
      {
        'title': 'Pool Hall Owners Network',
        'description': 'Connect with other venue owners and managers',
        'timeAgo': '10 hours ago',
        'memberCount': '56 members',
        'type': 'Discussion',
        'icon': '🏢',
      },
      {
        'title': 'Youth Development Program',
        'description': 'Supporting young talent in pool sports',
        'timeAgo': '11 hours ago',
        'memberCount': '145 members',
        'type': 'Training',
        'icon': '🌟',
      },
      {
        'title': 'Women in Pool',
        'description': 'Empowering female players and promoting inclusivity',
        'timeAgo': '12 hours ago',
        'memberCount': '178 members',
        'type': 'Discussion',
        'icon': '👥',
      },
      {
        'title': 'Referee Community',
        'description': 'Discussion forum for pool referees',
        'timeAgo': '13 hours ago',
        'memberCount': '89 members',
        'type': 'Discussion',
        'icon': '🎯',
      },
      {
        'title': 'Pool Photography',
        'description': 'Share your best shots from tournaments and events',
        'timeAgo': '14 hours ago',
        'memberCount': '134 members',
        'type': 'Events',
        'icon': '📸',
      },
      {
        'title': 'International Updates',
        'description': 'News and updates from international pool scenes',
        'timeAgo': '15 hours ago',
        'memberCount': '267 members',
        'type': 'Discussion',
        'icon': '🌍',
      },
      {
        'title': 'Mental Game Workshop',
        'description': 'Improve your mental approach to the game',
        'timeAgo': '16 hours ago',
        'memberCount': '198 members',
        'type': 'Training',
        'icon': '🧠',
      },
      {
        'title': 'Pool Social Events',
        'description': 'Organize and find social pool events near you',
        'timeAgo': '17 hours ago',
        'memberCount': '245 members',
        'type': 'Events',
        'icon': '🎉',
      },
      {
        'title': 'Trick Shot Community',
        'description': 'Share and learn amazing trick shots',
        'timeAgo': '18 hours ago',
        'memberCount': '167 members',
        'type': 'Training',
        'icon': '✨',
      },
      {
        'title': 'Pool Tech Support',
        'description': 'Technical discussions about equipment and maintenance',
        'timeAgo': '19 hours ago',
        'memberCount': '143 members',
        'type': 'Discussion',
        'icon': '🔧',
      },
    ];

    return communities.map((community) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: CommunityPost(
          title: community['title'],
          description: community['description'],
          timeAgo: community['timeAgo'],
          memberCount: community['memberCount'],
          type: community['type'],
          icon: community['icon'],
          notificationCount: community['notificationCount'],
        ),
      );
    }).toList();
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (bool selected) {},
      backgroundColor: isSelected ? const Color(0xFF0D47A1) : Colors.grey[200],
      selectedColor: const Color(0xFF0D47A1),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      showCheckmark: false,
    );
  }
}

class CommunityPost extends StatelessWidget {
  final String title;
  final String description;
  final String timeAgo;
  final String memberCount;
  final String type;
  final String icon;
  final int? notificationCount;

  const CommunityPost({
    super.key,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.memberCount,
    required this.type,
    required this.icon,
    this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with notification badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                if (notificationCount != null)
                  Positioned(
                    top: -8,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        notificationCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            timeAgo,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.people_outline, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            memberCount,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Join',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
