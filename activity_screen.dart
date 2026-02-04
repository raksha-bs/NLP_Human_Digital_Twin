import 'package:digital_twin_app/test_controller_screen.dart';
import 'package:flutter/material.dart';
import 'games_main.dart'; // <-- Import your games main file

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String? selectedActivity;
  bool recommendationGenerated = false;
  bool isLoadingRecommendation = false;
  String dummyRecommendation = "Your personalized training recommendation will appear here.";
  bool trainingStarted = false;
  late Stopwatch stopwatch;
  late String timerDisplay;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timerDisplay = "00:00";
  }

  void _startGamesAndGenerateRecommendation() async {
    if (selectedActivity == null) {
      _showSelectActivityMessage();
      return;
    }

    // Navigate to Games Page first
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TestControllerScreen()), // 🎮 Games page
    );

    // After returning from games, show loading animation
    if (result == 'games_completed') {
      _simulateRecommendationLoading(firstRecommendation: true);
    }
  }

  void _refreshRecommendationOnly() {
    if (selectedActivity == null) {
      _showSelectActivityMessage();
      return;
    }

    _simulateRecommendationLoading(firstRecommendation: false);
  }

  void _simulateRecommendationLoading({required bool firstRecommendation}) async {
    setState(() {
      isLoadingRecommendation = true;
      recommendationGenerated = false;
    });

    await Future.delayed(const Duration(seconds: 30)); // Simulate LLM backend delay

    setState(() {
      isLoadingRecommendation = false;
      recommendationGenerated = true;
      dummyRecommendation = firstRecommendation
          ? "🏋️‍♂️ Based on your profile and cognition, today's plan:\n\n30 min Cardio + 10 min Core Strengthening\n\nTip: Stay hydrated and breathe deep."
          : "🏋️‍♂️ Refreshed Plan:\n\n20 min HIIT + 10 min Stretching\n\nTip: Maintain good form.";
    });
  }

  void _startTraining() {
    setState(() {
      trainingStarted = true;
      stopwatch.start();
      _tickTimer();
    });
  }

  void _endTraining() {
    setState(() {
      stopwatch.stop();
      stopwatch.reset();
      timerDisplay = "00:00";
      trainingStarted = false;
    });
  }

  void _tickTimer() async {
    while (stopwatch.isRunning) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        int seconds = stopwatch.elapsed.inSeconds;
        int minutes = seconds ~/ 60;
        seconds = seconds % 60;
        timerDisplay = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
      });
    }
  }

  void _showSelectActivityMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select an activity first!'),
        backgroundColor: Color(0xFF8E2DE2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Activity & Training',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _buildDropdown(),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _startGamesAndGenerateRecommendation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  child: const Text("Generate Recommendation"),
                ),
                const SizedBox(height: 30),
                if (isLoadingRecommendation) ...[
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Fetching personalized plan...",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
                if (recommendationGenerated) ...[
                  _buildRecommendationCard(),
                  const SizedBox(height: 30),
                  _buildTrainingButtons(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedActivity,
          hint: const Text(
            "Select Activity",
            style: TextStyle(color: Colors.white70),
          ),
          dropdownColor: const Color(0xFF8E2DE2),
          iconEnabledColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
          items: [
            "Yoga",
            "Running",
            "Cycling",
            "HIIT",
            "Strength Training",
            "Swimming",
            "Pilates",
            "Dance",
            "Walking",
            "Meditation",
          ].map((activity) => DropdownMenuItem(
            value: activity,
            child: Text(activity),
          )).toList(),
          onChanged: (value) {
            setState(() {
              selectedActivity = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        dummyRecommendation,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTrainingButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _refreshRecommendationOnly, // 🎯 Fixed! No Games, just refresh
          icon: const Icon(Icons.refresh),
          label: const Text("Refresh Recommendation"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          ),
        ),
        const SizedBox(height: 20),
        if (!trainingStarted) ...[
          ElevatedButton.icon(
            onPressed: _startTraining,
            icon: const Icon(Icons.play_arrow),
            label: const Text("Start Activity & Timer"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            ),
          ),
        ],
        if (trainingStarted) ...[
          const SizedBox(height: 20),
          Text(
            "Timer: $timerDisplay",
            style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _endTraining,
            icon: const Icon(Icons.stop),
            label: const Text("End Training"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            ),
          ),
        ]
      ],
    );
  }
}
