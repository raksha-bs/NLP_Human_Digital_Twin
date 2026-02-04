// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class ReactionTimeScreen extends StatefulWidget {
//   const ReactionTimeScreen({super.key});

//   @override
//   State<ReactionTimeScreen> createState() => _ReactionTimeScreenState();
// }

// class _ReactionTimeScreenState extends State<ReactionTimeScreen> {
//   Color _backgroundColor = Colors.blueGrey;
//   bool _waitingForGreen = false;
//   bool _showInstruction = true;
//   bool _gameEnded = false;
//   Timer? _timer;
//   DateTime? _greenShownTime;

//   final int _maxRounds = 5;
//   int _currentRound = 0;
//   List<int> _reactionTimes = [];

//   void _startGame() {
//     setState(() {
//       _backgroundColor = Colors.blueGrey;
//       _waitingForGreen = false;
//       _showInstruction = false;
//       _gameEnded = false;
//       _currentRound = 0;
//       _reactionTimes.clear();
//     });

//     _startNextRound();
//   }

//   void _startNextRound() {
//     final randomDelay = Random().nextInt(3000) + 2000; // 2–5 seconds
//     _timer = Timer(Duration(milliseconds: randomDelay), () {
//       setState(() {
//         _backgroundColor = Colors.green;
//         _waitingForGreen = true;
//         _greenShownTime = DateTime.now();
//       });
//     });
//   }

//   void _handleTap() {
//     if (_showInstruction) return;

//     if (_waitingForGreen && _greenShownTime != null) {
//       final now = DateTime.now();
//       final reactionMs = now.difference(_greenShownTime!).inMilliseconds;

//       setState(() {
//         _reactionTimes.add(reactionMs);
//         _currentRound += 1;
//         _waitingForGreen = false;
//       });

//       if (_currentRound >= _maxRounds) {
//         setState(() {
//           _gameEnded = true;
//         });
//       } else {
//         _backgroundColor = Colors.blueGrey;
//         _startNextRound();
//       }
//     } else if (!_waitingForGreen && !_gameEnded) {
//       _timer?.cancel();
//       setState(() {
//         _backgroundColor = Colors.red;
//         _gameEnded = true;
//       });
//     }
//   }

//   void _resetGame() {
//     setState(() {
//       _backgroundColor = Colors.blueGrey;
//       _waitingForGreen = false;
//       _showInstruction = true;
//       _gameEnded = false;
//       _currentRound = 0;
//       _reactionTimes.clear();
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   double _averageReactionTime() {
//     if (_reactionTimes.isEmpty) return 0;
//     final total = _reactionTimes.reduce((a, b) => a + b);
//     return total / _reactionTimes.length;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       body: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: _handleTap,
//         child: Center(
//           child:
//               _showInstruction
//                   ? _buildInstructionScreen()
//                   : _gameEnded
//                   ? _buildResultScreen()
//                   : _buildWaitingScreen(),
//         ),
//       ),
//     );
//   }

//   Widget _buildInstructionScreen() {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             "Reaction Time Test",
//             style: TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Rules:",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "• Tap the screen as soon as it turns GREEN.\n\n"
//             "• 5 rounds total.\n\n"
//             "• Your average reaction time will be shown at the end.",
//             style: TextStyle(fontSize: 18, color: Colors.white),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 40),
//           ElevatedButton(
//             onPressed: _startGame,
//             child: const Text("Start Test"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildWaitingScreen() {
//     return const Text(
//       "Wait for GREEN...",
//       style: TextStyle(
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//     );
//   }

//   Widget _buildResultScreen() {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             "Test Complete!",
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             "Average Reaction Time:\n${_averageReactionTime().toStringAsFixed(2)} ms",
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 30),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _reactionTimes.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     "Round ${index + 1}: ${_reactionTimes[index]} ms",
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _resetGame,
//             child: const Text("Play Again"),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class ReactionTimeScreen extends StatefulWidget {
//   const ReactionTimeScreen({super.key});

//   @override
//   State<ReactionTimeScreen> createState() => _ReactionTimeScreenState();
// }

// enum ReactionGamePhase { instruction, test, result }

// class _ReactionTimeScreenState extends State<ReactionTimeScreen> {
//   ReactionGamePhase phase = ReactionGamePhase.instruction;

//   final Random _random = Random();
//   final Stopwatch _stopwatch = Stopwatch();
//   List<int> reactionTimes = [];

//   bool isYellow = false;
//   bool allowTap = true;
//   String message = '';
//   int wrongTaps = 0;
//   int correctTaps = 0;
//   int testDurationSeconds = 15;
//   Timer? testTimer;
//   Timer? colorChangeTimer;

//   void startTest() {
//     setState(() {
//       phase = ReactionGamePhase.test;
//       message = '';
//       isYellow = false;
//       reactionTimes.clear();
//       correctTaps = 0;
//       wrongTaps = 0;
//       allowTap = true;
//     });

//     scheduleColorChange();
//     testTimer = Timer(Duration(seconds: testDurationSeconds), endTest);
//   }

//   void scheduleColorChange() {
//     final delayMs = _random.nextInt(2000) + 1000; // 1–3 seconds
//     colorChangeTimer = Timer(Duration(milliseconds: delayMs), () {
//       if (!mounted || !allowTap) return;
//       setState(() {
//         isYellow = true;
//         message = '';
//       });
//       _stopwatch.reset();
//       _stopwatch.start();
//     });
//   }

//   void handleTap() {
//     if (!allowTap) return;

//     if (isYellow) {
//       _stopwatch.stop();
//       final reactionTime = _stopwatch.elapsedMilliseconds;
//       reactionTimes.add(reactionTime);
//       correctTaps++;

//       setState(() {
//         message = "✔️ $reactionTime ms";
//         isYellow = false;
//         allowTap = false;
//       });

//       Timer(const Duration(milliseconds: 500), () {
//         if (!mounted) return;
//         setState(() {
//           message = '';
//           allowTap = true;
//         });
//         scheduleColorChange();
//       });
//     } else {
//       wrongTaps++;
//       setState(() {
//         message = "❌ Too early!";
//         allowTap = false;
//       });

//       Timer(const Duration(seconds: 1), () {
//         if (!mounted) return;
//         setState(() {
//           message = '';
//           allowTap = true;
//         });
//         scheduleColorChange();
//       });
//     }
//   }

//   void endTest() {
//     colorChangeTimer?.cancel();
//     setState(() {
//       phase = ReactionGamePhase.result;
//     });
//   }

//   void restart() {
//     testTimer?.cancel();
//     colorChangeTimer?.cancel();
//     setState(() {
//       phase = ReactionGamePhase.instruction;
//     });
//   }

//   @override
//   void dispose() {
//     testTimer?.cancel();
//     colorChangeTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (phase) {
//       case ReactionGamePhase.instruction:
//         return Scaffold(
//           appBar: AppBar(title: const Text("Reaction Time Test")),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     "Tap the screen ONLY when it turns YELLOW.\n\n"
//                     "Don't tap too early!\n"
//                     "Try to be as fast as possible!",
//                     style: TextStyle(fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: startTest,
//                   child: const Text("Start Test"),
//                 ),
//               ],
//             ),
//           ),
//         );

//       case ReactionGamePhase.test:
//         return GestureDetector(
//           onTap: handleTap,
//           child: Scaffold(
//             body: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               color: isYellow ? Colors.yellow : Colors.blue,
//               child: Center(
//                 child: Text(
//                   message,
//                   style: const TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );

//       case ReactionGamePhase.result:
//         final avg =
//             reactionTimes.isEmpty
//                 ? 0
//                 : (reactionTimes.reduce((a, b) => a + b) ~/
//                     reactionTimes.length);
//         return Scaffold(
//           appBar: AppBar(title: const Text("Results")),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Average Reaction Time: $avg ms",
//                   style: const TextStyle(fontSize: 22),
//                 ),
//                 Text(
//                   "Correct Taps: $correctTaps",
//                   style: const TextStyle(fontSize: 22),
//                 ),
//                 Text(
//                   "Wrong Taps: $wrongTaps",
//                   style: const TextStyle(fontSize: 22),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: restart,
//                   child: const Text("🔄 Try Again"),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context); // Go back to GameHub
//                   },
//                   child: const Text("✅ Back to Game Hub"),
//                 ),
//               ],
//             ),
//           ),
//         );
//     }
//   }
// }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class ReactionTimeScreen extends StatefulWidget {
//   final VoidCallback onTestComplete;

//   const ReactionTimeScreen({super.key, required this.onTestComplete});

//   @override
//   State<ReactionTimeScreen> createState() => _ReactionTimeScreenState();
// }

// enum ReactionGamePhase { instruction, test, result }

// class _ReactionTimeScreenState extends State<ReactionTimeScreen> {
//   ReactionGamePhase phase = ReactionGamePhase.instruction;
//   final Random _random = Random();
//   final Stopwatch _stopwatch = Stopwatch();
//   List<int> reactionTimes = [];

//   bool isYellow = false;
//   bool allowTap = true;
//   String message = '';
//   int wrongTaps = 0;
//   int correctTaps = 0;
//   int testDurationSeconds = 10;
//   Timer? gameTimer;
//   Timer? colorChangeTimer;

//   void startTest() {
//     setState(() {
//       phase = ReactionGamePhase.test;
//       message = '';
//       isYellow = false;
//       reactionTimes.clear();
//       correctTaps = 0;
//       wrongTaps = 0;
//       allowTap = true;
//     });

//     scheduleColorChange();
//     gameTimer = Timer(Duration(seconds: testDurationSeconds), endTest);
//   }

//   void scheduleColorChange() {
//     final delayMs = _random.nextInt(2000) + 1000; // 1–3 seconds
//     colorChangeTimer = Timer(Duration(milliseconds: delayMs), () {
//       if (!mounted || !allowTap) return;
//       setState(() {
//         isYellow = true;
//         message = '';
//       });
//       _stopwatch.reset();
//       _stopwatch.start();
//     });
//   }

//   void handleTap() {
//     if (!allowTap) return;

//     if (isYellow) {
//       _stopwatch.stop();
//       final reactionTime = _stopwatch.elapsedMilliseconds;
//       setState(() {
//         reactionTimes.add(reactionTime);
//         correctTaps++;
//       });

//       setState(() {
//         message = "✔️ $reactionTime ms";
//         isYellow = false;
//         allowTap = false;
//       });

//       Timer(const Duration(milliseconds: 500), () {
//         if (!mounted) return;
//         setState(() {
//           message = '';
//           allowTap = true;
//         });
//         scheduleColorChange();
//       });
//     } else {
//       wrongTaps++;
//       setState(() {
//         message = "❌ Too early!";
//         allowTap = false;
//       });

//       Timer(const Duration(seconds: 1), () {
//         if (!mounted) return;
//         setState(() {
//           message = '';
//           allowTap = true;
//         });
//         scheduleColorChange();
//       });
//     }
//   }

//   void endTest() {
//     colorChangeTimer?.cancel();
//     setState(() {
//       phase = ReactionGamePhase.result;
//     });

//     // 🚀 Call onTestComplete after a small delay to show result
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         widget.onTestComplete();
//       }
//     });
//   }

//   void restart() {
//     gameTimer?.cancel();
//     colorChangeTimer?.cancel();
//     setState(() {
//       phase = ReactionGamePhase.instruction;
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer?.cancel();
//     colorChangeTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (phase) {
//       case ReactionGamePhase.instruction:
//         return Scaffold(
//           appBar: AppBar(title: const Text("Reaction Time Test")),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     "Tap the screen ONLY when it turns YELLOW.\n\nDon't tap too early!",
//                     style: TextStyle(fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: startTest,
//                   child: const Text("Start Test"),
//                 ),
//               ],
//             ),
//           ),
//         );

//       case ReactionGamePhase.test:
//         return GestureDetector(
//           onTap: handleTap,
//           child: Scaffold(
//             body: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               color: isYellow ? Colors.yellow : Colors.blue,
//               child: Center(
//                 child: Text(
//                   message,
//                   style: const TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );

//       case ReactionGamePhase.result:
//         final avg =
//             reactionTimes.isEmpty
//                 ? 0
//                 : (reactionTimes.reduce((a, b) => a + b) ~/
//                     reactionTimes.length);
//         return Scaffold(
//           backgroundColor: Colors.deepPurple,
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Test Complete!",
//                   style: TextStyle(fontSize: 28, color: Colors.white),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Avg Reaction Time: $avg ms",
//                   style: const TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//                 Text(
//                   "Correct Taps: $correctTaps",
//                   style: const TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//                 Text(
//                   "Wrong Taps: $wrongTaps",
//                   style: const TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         );
//     }
//   }
// }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class ReactionTimeScreen extends StatefulWidget {
//   final VoidCallback onTestComplete;

//   const ReactionTimeScreen({super.key, required this.onTestComplete});

//   @override
//   State<ReactionTimeScreen> createState() => _ReactionTimeScreenState();
// }

// enum ReactionGamePhase { test, result }

// class _ReactionTimeScreenState extends State<ReactionTimeScreen> {
//   ReactionGamePhase phase = ReactionGamePhase.test;
//   final Random _random = Random();
//   final Stopwatch _stopwatch = Stopwatch();
//   List<int> reactionTimes = [];

//   bool isYellow = false;
//   bool allowTap = true;
//   String message = '';
//   int wrongTaps = 0;
//   int correctTaps = 0;
//   int testDurationSeconds = 10;
//   Timer? gameTimer;
//   Timer? colorChangeTimer;

//   @override
//   void initState() {
//     super.initState();
//     startTest(); // 🚀 Start test immediately after screen loads
//   }

//   void startTest() {
//     setState(() {
//       message = '';
//       isYellow = false;
//       reactionTimes.clear();
//       correctTaps = 0;
//       wrongTaps = 0;
//       allowTap = true;
//     });

//     scheduleColorChange();
//     gameTimer = Timer(Duration(seconds: testDurationSeconds), endTest);
//   }

//   void scheduleColorChange() {
//     final delayMs = _random.nextInt(2000) + 1000; // 1–3 seconds
//     colorChangeTimer = Timer(Duration(milliseconds: delayMs), () {
//       if (!mounted || !allowTap) return;
//       setState(() {
//         isYellow = true;
//         message = '';
//       });
//       _stopwatch.reset();
//       _stopwatch.start();
//     });
//   }

//   void handleTap() {
//     if (!allowTap) return;

//     if (isYellow) {
//       _stopwatch.stop();
//       final reactionTime = _stopwatch.elapsedMilliseconds;
//       setState(() {
//         reactionTimes.add(reactionTime);
//         correctTaps++;
//       });

//       setState(() {
//         message = "✔️ $reactionTime ms";
//         isYellow = false;
//         allowTap = false;
//       });

//       Timer(const Duration(milliseconds: 500), () {
//         if (!mounted) return;
//         setState(() {
//           message = '';
//           allowTap = true;
//         });
//         scheduleColorChange();
//       });
//     } else {
//       wrongTaps++;
//       setState(() {
//         message = "❌ Too early!";
//         allowTap = false;
//       });

//       Timer(const Duration(seconds: 1), () {
//         if (!mounted) return;
//         setState(() {
//           message = '';
//           allowTap = true;
//         });
//         scheduleColorChange();
//       });
//     }
//   }

//   void endTest() {
//     colorChangeTimer?.cancel();
//     setState(() {
//       phase = ReactionGamePhase.result;
//     });

//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         widget.onTestComplete();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer?.cancel();
//     colorChangeTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (phase) {
//       case ReactionGamePhase.test:
//         return GestureDetector(
//           onTap: handleTap,
//           child: Scaffold(
//             body: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               color: isYellow ? Colors.yellow : Colors.blue,
//               child: Center(
//                 child: Text(
//                   message,
//                   style: const TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );

//       case ReactionGamePhase.result:
//         final avg =
//             reactionTimes.isEmpty
//                 ? 0
//                 : (reactionTimes.reduce((a, b) => a + b) ~/
//                     reactionTimes.length);
//         return Scaffold(
//           backgroundColor: Colors.deepPurple,
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Test Complete!",
//                   style: TextStyle(fontSize: 28, color: Colors.white),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Avg Reaction Time: $avg ms",
//                   style: const TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//                 Text(
//                   "Correct Taps: $correctTaps",
//                   style: const TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//                 Text(
//                   "Wrong Taps: $wrongTaps",
//                   style: const TextStyle(fontSize: 22, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         );
//     }
//   }
// }
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ReactionTimeScreen extends StatefulWidget {
  final Function(Map<String, int>) onTestComplete;

  const ReactionTimeScreen({super.key, required this.onTestComplete});

  @override
  State<ReactionTimeScreen> createState() => _ReactionTimeScreenState();
}

enum ReactionGamePhase { test, result }

class _ReactionTimeScreenState extends State<ReactionTimeScreen> {
  ReactionGamePhase phase = ReactionGamePhase.test;
  final Random _random = Random();
  final Stopwatch _stopwatch = Stopwatch();
  List<int> reactionTimes = [];

  bool isYellow = false;
  bool allowTap = true;
  String message = '';
  int wrongTaps = 0;
  int correctTaps = 0;
  int testDurationSeconds = 10;
  Timer? gameTimer;
  Timer? colorChangeTimer;

  @override
  void initState() {
    super.initState();
    startTest(); // 🚀 Start test immediately
  }

  void startTest() {
    setState(() {
      message = '';
      isYellow = false;
      reactionTimes.clear();
      correctTaps = 0;
      wrongTaps = 0;
      allowTap = true;
    });

    scheduleColorChange();
    gameTimer = Timer(Duration(seconds: testDurationSeconds), () {
      endTest();
    });
  }

  void scheduleColorChange() {
    final delayMs = _random.nextInt(2000) + 1000; // 1–3 seconds
    colorChangeTimer = Timer(Duration(milliseconds: delayMs), () {
      if (!mounted || !allowTap) return;
      setState(() {
        isYellow = true;
        message = '';
      });
      _stopwatch.reset();
      _stopwatch.start();
    });
  }

  void handleTap() {
    if (!allowTap) return;

    if (isYellow) {
      _stopwatch.stop();
      final reactionTime = _stopwatch.elapsedMilliseconds;
      setState(() {
        reactionTimes.add(reactionTime);
        correctTaps++;
      });

      setState(() {
        message = "✔️ $reactionTime ms";
        isYellow = false;
        allowTap = false;
      });

      Timer(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        setState(() {
          message = '';
          allowTap = true;
        });
        scheduleColorChange();
      });
    } else {
      wrongTaps++;
      setState(() {
        message = "❌ Too early!";
        allowTap = false;
      });

      Timer(const Duration(seconds: 1), () {
        if (!mounted) return;
        setState(() {
          message = '';
          allowTap = true;
        });
        scheduleColorChange();
      });
    }
  }

  void endTest() {
    colorChangeTimer?.cancel();
    setState(() {
      phase = ReactionGamePhase.result;
    });

    final avgReaction =
        reactionTimes.isEmpty
            ? 0
            : (reactionTimes.reduce((a, b) => a + b) ~/ reactionTimes.length);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        widget.onTestComplete({
          'avgReaction': avgReaction,
          'correct': correctTaps,
          'wrong': wrongTaps,
        });
      }
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    colorChangeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (phase) {
      case ReactionGamePhase.test:
        return GestureDetector(
          onTap: handleTap,
          child: Scaffold(
            body: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: isYellow ? Colors.yellow : Colors.blue,
              child: Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );

      case ReactionGamePhase.result:
        final avg =
            reactionTimes.isEmpty
                ? 0
                : (reactionTimes.reduce((a, b) => a + b) ~/
                    reactionTimes.length);
        return Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Test Complete!",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  "Avg Reaction Time: $avg ms",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
                Text(
                  "Correct Taps: $correctTaps",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
                Text(
                  "Wrong Taps: $wrongTaps",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ],
            ),
          ),
        );
    }
  }
}
