import 'package:flutter/material.dart';
import 'filter_page.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  List<Map<String, String>> filteredTournaments = [];
  Map<String, dynamic> activeFilters = {};

  @override
  void initState() {
    super.initState();
    filteredTournaments = List.from(_tournamentData);
  }

  void _showFilterPage() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: const FilterPage(),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        activeFilters = result;
        _applyFilters();
      });
    }
  }

  void _applyFilters() {
    List<Map<String, String>> results = List.from(_tournamentData);

    // Apply date filter
    if (activeFilters['fromDate'] != null && activeFilters['toDate'] != null) {
      final fromDate = activeFilters['fromDate'] as DateTime;
      final toDate = activeFilters['toDate'] as DateTime;
      results = results.where((tournament) {
        final tournamentDate = _parseDate(tournament['date']!);
        return tournamentDate.isAfter(fromDate.subtract(const Duration(days: 1))) &&
            tournamentDate.isBefore(toDate.add(const Duration(days: 1)));
      }).toList();
    }

    // Apply entry fee filter
    if (activeFilters['entryFee'] != null) {
      final maxFee = activeFilters['entryFee'] as double;
      results = results.where((tournament) {
        final fee = int.parse(tournament['entryFee']!.replaceAll(RegExp(r'[^0-9]'), ''));
        return fee <= maxFee;
      }).toList();
    }

    // Apply skill level filter
    if (activeFilters['skillLevels'] != null && (activeFilters['skillLevels'] as List).isNotEmpty) {
      final levels = activeFilters['skillLevels'] as List<String>;
      results = results.where((tournament) => levels.contains(tournament['level'])).toList();
    }

    // Apply sorting
    if (activeFilters['sortBy'] != null) {
      final sortBy = activeFilters['sortBy'] as String;
      results.sort((a, b) {
        switch (sortBy) {
          case 'Prize Pool':
            final prizeA = int.parse(a['prizePool']!.replaceAll(RegExp(r'[^0-9]'), ''));
            final prizeB = int.parse(b['prizePool']!.replaceAll(RegExp(r'[^0-9]'), ''));
            return prizeB.compareTo(prizeA);
          case 'Entry Fee':
            final feeA = int.parse(a['entryFee']!.replaceAll(RegExp(r'[^0-9]'), ''));
            final feeB = int.parse(b['entryFee']!.replaceAll(RegExp(r'[^0-9]'), ''));
            return feeA.compareTo(feeB);
          default: // Date
            final dateA = _parseDate(a['date']!);
            final dateB = _parseDate(b['date']!);
            return dateA.compareTo(dateB);
        }
      });
    }

    setState(() {
      filteredTournaments = results;
    });
  }

  DateTime _parseDate(String dateStr) {
    final parts = dateStr.split(' ')[0].split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar with Filter
              Container(
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
                          hintText: 'Search tournaments',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: _showFilterPage,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All Tournaments', true),
                    const SizedBox(width: 8),
                    _buildFilterChip('Local', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('National', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Pro', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Amateur', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Youth', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Women\'s', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Senior', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Team', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('Championship', false),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Tournament Cards
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTournaments.length,
                  itemBuilder: (context, index) {
                    final tournament = filteredTournaments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TournamentCard(
                        title: tournament['title'] ?? '',
                        date: tournament['date'] ?? '',
                        location: tournament['location'] ?? '',
                        prizePool: tournament['prizePool'] ?? '',
                        entryFee: tournament['entryFee'] ?? '',
                        participants: tournament['participants'] ?? '',
                        level: tournament['level'] ?? '',
                        levelColor: _getLevelColor(tournament['level'] ?? ''),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'intermediate':
        return Colors.amber;
      case 'advanced':
        return Colors.red;
      case 'pro':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (bool selected) {
        // TODO: Implement filter logic
      },
      backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: 1,
        ),
      ),
      elevation: isSelected ? 2 : 0,
      pressElevation: 4,
      showCheckmark: false,
    );
  }
}

final List<Map<String, String>> _tournamentData = [
  {
    'title': 'Downtown Championship',
    'date': 'April 25-27, 2025',
    'location': 'Downtown Billiards, Nairobi',
    'prizePool': 'KSH 50,000',
    'entryFee': 'KSH 500',
    'participants': '28/32',
    'level': 'Intermediate',
  },
  {
    'title': 'National Masters Cup',
    'date': 'May 10-12, 2025',
    'location': 'Elite Pool Hall, Mombasa',
    'prizePool': 'KSH 150,000',
    'entryFee': 'KSH 1,000',
    'participants': '42/64',
    'level': 'Advanced',
  },
  {
    'title': 'Westlands Open',
    'date': 'June 5-7, 2025',
    'location': 'Westlands Sports Club, Nairobi',
    'prizePool': 'KSH 75,000',
    'entryFee': 'KSH 750',
    'participants': '35/48',
    'level': 'Intermediate',
  },
  {
    'title': 'Coast Regional Championship',
    'date': 'July 15-17, 2025',
    'location': 'Nyali Cue Masters, Mombasa',
    'prizePool': 'KSH 100,000',
    'entryFee': 'KSH 800',
    'participants': '50/64',
    'level': 'Advanced',
  },
  {
    'title': 'Kisumu Lake Basin Open',
    'date': 'August 1-3, 2025',
    'location': 'Lake Basin Club, Kisumu',
    'prizePool': 'KSH 60,000',
    'entryFee': 'KSH 600',
    'participants': '24/32',
    'level': 'Intermediate',
  },
  {
    'title': 'Kenya National Championship',
    'date': 'September 20-22, 2025',
    'location': 'KICC Convention Center, Nairobi',
    'prizePool': 'KSH 250,000',
    'entryFee': 'KSH 2,000',
    'participants': '56/64',
    'level': 'Pro',
  },
];

class TournamentCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String prizePool;
  final String entryFee;
  final String participants;
  final String level;
  final Color levelColor;

  const TournamentCard({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.prizePool,
    required this.entryFee,
    required this.participants,
    required this.level,
    required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage('assets/images/trophy.png'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Open',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Prize Pool', style: TextStyle(color: Colors.grey)),
                        Text(
                          prizePool,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Entry Fee', style: TextStyle(color: Colors.grey)),
                        Text(
                          entryFee,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Participants', style: TextStyle(color: Colors.grey)),
                        Text(
                          participants,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: levelColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: levelColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Register Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
