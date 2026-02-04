import 'package:flutter/material.dart';
import 'activity_screen.dart'; // <-- Add this line
import 'main.dart';
import 'login_page.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'TwinVerse',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2), Color(0xFF6A82FB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // Animated Training Readiness Gauge
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 0.76),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 230,
                            width: 230,
                            child: CircularProgressIndicator(
                              value: value,
                              strokeWidth: 20,
                              backgroundColor: Colors.white24,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6A82FB)),
                            ),
                          ),
                          Column(
                            children: [
                              Text("${(value * 100).toInt()}%",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 4),
                              const Text("Training Readiness",
                                  style: TextStyle(color: Colors.white70)),
                              const Text("High", style: TextStyle(color: Colors.lightBlueAccent)),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  // Output Cards
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildStateCard(context, "Mental", Icons.psychology, Colors.red, "Stress: High\nMotivation: Medium"),
                      _buildStateCard(context, "Physical", Icons.fitness_center, Colors.green, "HR: 78 bpm\nStamina: Low"),
                      _buildStateCard(context, "Cognitive", Icons.memory, Colors.orange, "Focus: Medium\nReaction: Slow"),
                      _buildStateCard(context, "Biomech", Icons.accessibility_new, Colors.blueGrey, "Balance: Stable\nDexterity: Good"),
                      _buildStateCard(context, "Social", Icons.group, Colors.pinkAccent, "Engagement: Low\nLeadership: Neutral"),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF823FAE),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: (index) {
          if (index == 1) { // 0 = Dashboard, 1 = Activity, 2 = Settings, etc
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ActivityScreen()),
            );
          }
          // For other tabs (Dashboard, Settings) you can handle later
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          const BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: 'Activity'),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
            icon: PopupMenuButton<String>(
              color: const Color(0xFF441C8E),
              icon: const Icon(Icons.more_horiz, color: Colors.white),
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$value page coming soon!',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFF8E2DE2),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'Progress & Trends',
                  child: Text('📈 Progress & Trends', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: 'Training Planner',
                  child: Text('📅 Personalized Training Planner', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: 'Sensor Input',
                  child: Text('📲 Sensor & Survey Input', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: 'Environment',
                  child: Text('🌍 Environment Context', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: 'Profile & Settings',
                  child: Text('🧑‍⚕️ Profile & Settings', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            label: 'More',
          )
        ],
      ),

    );
  }

  Widget _buildStateCard(BuildContext context, String title, IconData icon, Color color, String info) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E2C),
            title: Text(title, style: const TextStyle(color: Colors.white)),
            content: Text(info, style: const TextStyle(color: Colors.white70)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close", style: TextStyle(color: Colors.lightBlueAccent)),
              )
            ],
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withAlpha(150), color.withAlpha(230)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
