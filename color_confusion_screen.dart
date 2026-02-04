// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class ColorGameScreen extends StatefulWidget {
//   const ColorGameScreen({super.key});

//   @override
//   State<ColorGameScreen> createState() => _ColorGameScreenState();
// }

// class _ColorGameScreenState extends State<ColorGameScreen> {
//   final List<String> colorNames = ['Red', 'Blue', 'Green', 'Yellow'];
//   final Map<String, Color> colorMap = {
//     'Red': Colors.red.shade600,
//     'Blue': Colors.blue.shade600,
//     'Green': Colors.green.shade600,
//     'Yellow': Colors.amber.shade700,
//   };

//   late String displayText;
//   late Color displayColor;

//   int score = 0;
//   int total = 0;
//   int gameTime = 30;
//   bool isGameActive = false;
//   bool showRules = true;
//   late Timer gameTimer;

//   DateTime? shownTime;
//   List<int> reactionTimes = [];

//   @override
//   void initState() {
//     super.initState();
//     displayText = '';
//     displayColor = Colors.black;
//   }

//   void startGame() {
//     setState(() {
//       score = 0;
//       total = 0;
//       gameTime = 30;
//       isGameActive = true;
//       showRules = false;
//       reactionTimes.clear();
//     });

//     nextPrompt();

//     gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         gameTime--;
//       });

//       if (gameTime <= 0) {
//         timer.cancel();
//         setState(() {
//           isGameActive = false;
//         });
//       }
//     });
//   }

//   void nextPrompt() {
//     final rand = Random();
//     setState(() {
//       displayText = colorNames[rand.nextInt(colorNames.length)];
//       displayColor = colorMap[colorNames[rand.nextInt(colorNames.length)]]!;
//       shownTime = DateTime.now();
//     });
//   }

//   void handleTap(String tappedColor) {
//     if (!isGameActive) return;

//     final now = DateTime.now();
//     if (shownTime != null) {
//       int reaction = now.difference(shownTime!).inMilliseconds;
//       reactionTimes.add(reaction);
//     }

//     setState(() {
//       total++;
//       if (colorMap[tappedColor] == displayColor) {
//         score++;
//       }
//       nextPrompt();
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final avgReaction =
//         reactionTimes.isNotEmpty
//             ? reactionTimes.reduce((a, b) => a + b) ~/ reactionTimes.length
//             : 0;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Color Confusion"),
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child:
//             showRules
//                 ? _buildInstructionScreen()
//                 : isGameActive
//                 ? _buildGameScreen()
//                 : _buildResultScreen(avgReaction),
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
//             "🎮 How to Play:\n\nTap the button matching the COLOR (not the word)!",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 20, height: 1.6),
//           ),
//           const SizedBox(height: 40),
//           ElevatedButton(onPressed: startGame, child: const Text("Start Game")),
//         ],
//       ),
//     );
//   }

//   Widget _buildGameScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("⏱️ Time Left: $gameTime s", style: const TextStyle(fontSize: 20)),
//         const SizedBox(height: 30),
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 400),
//           child: Text(
//             displayText,
//             key: ValueKey(displayText + displayColor.toString()),
//             style: TextStyle(
//               fontSize: 60,
//               fontWeight: FontWeight.bold,
//               color: displayColor,
//             ),
//           ),
//         ),
//         const SizedBox(height: 40),
//         Wrap(
//           spacing: 20,
//           runSpacing: 20,
//           children:
//               colorNames.map((color) {
//                 return ElevatedButton(
//                   onPressed: () => handleTap(color),
//                   child: Text(color),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: colorMap[color],
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildResultScreen(int avgReaction) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("🎯 Game Over!", style: TextStyle(fontSize: 30)),
//         const SizedBox(height: 20),
//         Text("✅ Score: $score / $total", style: const TextStyle(fontSize: 22)),
//         Text(
//           "⚡ Avg Reaction: ${avgReaction} ms",
//           style: const TextStyle(fontSize: 22),
//         ),
//         const SizedBox(height: 30),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               showRules = true;
//             });
//           },
//           child: const Text("🔄 Try Again"),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context); // Go back to GameHub
//           },
//           child: const Text("✅ Back to Game Hub"),
//         ),
//       ],
//     );
//   }
// }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class ColorGameScreen extends StatefulWidget {
//   final VoidCallback onTestComplete;

//   const ColorGameScreen({super.key, required this.onTestComplete});

//   @override
//   State<ColorGameScreen> createState() => _ColorGameScreenState();
// }

// class _ColorGameScreenState extends State<ColorGameScreen> {
//   final List<String> colorNames = ['Red', 'Blue', 'Green', 'Yellow'];
//   final Map<String, Color> colorMap = {
//     'Red': Colors.red.shade600,
//     'Blue': Colors.blue.shade600,
//     'Green': Colors.green.shade600,
//     'Yellow': Colors.amber.shade700,
//   };

//   late String displayText;
//   late Color displayColor;

//   int score = 0;
//   int total = 0;
//   int gameTime = 30;
//   bool isGameActive = false;
//   bool showRules = true;
//   late Timer gameTimer;

//   DateTime? shownTime;
//   List<int> reactionTimes = [];

//   @override
//   void initState() {
//     super.initState();
//     displayText = '';
//     displayColor = Colors.black;
//   }

//   void startGame() {
//     setState(() {
//       score = 0;
//       total = 0;
//       gameTime = 30;
//       isGameActive = true;
//       showRules = false;
//       reactionTimes.clear();
//     });

//     nextPrompt();

//     gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         gameTime--;
//       });

//       if (gameTime <= 0) {
//         timer.cancel();
//         setState(() {
//           isGameActive = false;
//         });

//         // 🚀 Automatically trigger onTestComplete after short delay
//         Future.delayed(const Duration(seconds: 2), () {
//           if (mounted) {
//             widget.onTestComplete();
//           }
//         });
//       }
//     });
//   }

//   void nextPrompt() {
//     final rand = Random();
//     setState(() {
//       displayText = colorNames[rand.nextInt(colorNames.length)];
//       displayColor = colorMap[colorNames[rand.nextInt(colorNames.length)]]!;
//       shownTime = DateTime.now();
//     });
//   }

//   void handleTap(String tappedColor) {
//     if (!isGameActive) return;

//     final now = DateTime.now();
//     if (shownTime != null) {
//       int reaction = now.difference(shownTime!).inMilliseconds;
//       reactionTimes.add(reaction);
//     }

//     setState(() {
//       total++;
//       if (colorMap[tappedColor] == displayColor) {
//         score++;
//       }
//       nextPrompt();
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Color Confusion Test"),
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child:
//             showRules
//                 ? _buildInstructionScreen()
//                 : isGameActive
//                 ? _buildGameScreen()
//                 : _buildResultScreen(),
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
//             "🎮 How to Play:\n\nTap the button matching the COLOR (not the word)!",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 20, height: 1.6),
//           ),
//           const SizedBox(height: 40),
//           ElevatedButton(onPressed: startGame, child: const Text("Start Game")),
//         ],
//       ),
//     );
//   }

//   Widget _buildGameScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("⏱️ Time Left: $gameTime s", style: const TextStyle(fontSize: 20)),
//         const SizedBox(height: 30),
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 400),
//           child: Text(
//             displayText,
//             key: ValueKey(displayText + displayColor.toString()),
//             style: TextStyle(
//               fontSize: 60,
//               fontWeight: FontWeight.bold,
//               color: displayColor,
//             ),
//           ),
//         ),
//         const SizedBox(height: 40),
//         Wrap(
//           spacing: 20,
//           runSpacing: 20,
//           children:
//               colorNames.map((color) {
//                 return ElevatedButton(
//                   onPressed: () => handleTap(color),
//                   child: Text(color),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: colorMap[color],
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildResultScreen() {
//     final avgReaction =
//         reactionTimes.isNotEmpty
//             ? reactionTimes.reduce((a, b) => a + b) ~/ reactionTimes.length
//             : 0;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("🎯 Game Over!", style: TextStyle(fontSize: 30)),
//         const SizedBox(height: 20),
//         Text("✅ Score: $score / $total", style: const TextStyle(fontSize: 22)),
//         Text(
//           "⚡ Avg Reaction: ${avgReaction} ms",
//           style: const TextStyle(fontSize: 22),
//         ),
//       ],
//     );
//   }
// }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class ColorGameScreen extends StatefulWidget {
//   final VoidCallback onTestComplete;

//   const ColorGameScreen({super.key, required this.onTestComplete});

//   @override
//   State<ColorGameScreen> createState() => _ColorGameScreenState();
// }

// class _ColorGameScreenState extends State<ColorGameScreen> {
//   final List<String> colorNames = ['Red', 'Blue', 'Green', 'Yellow'];
//   final Map<String, Color> colorMap = {
//     'Red': Colors.red.shade600,
//     'Blue': Colors.blue.shade600,
//     'Green': Colors.green.shade600,
//     'Yellow': Colors.amber.shade700,
//   };

//   late String displayText;
//   late Color displayColor;

//   int score = 0;
//   int total = 0;
//   int gameTime = 30;
//   bool isGameActive = false;
//   late Timer gameTimer;

//   DateTime? shownTime;
//   List<int> reactionTimes = [];

//   @override
//   void initState() {
//     super.initState();
//     startGame(); // 🚀 Start game immediately after screen loads
//   }

//   void startGame() {
//     setState(() {
//       score = 0;
//       total = 0;
//       gameTime = 30;
//       isGameActive = true;
//       reactionTimes.clear();
//     });

//     nextPrompt();

//     gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         gameTime--;
//       });

//       if (gameTime <= 0) {
//         timer.cancel();
//         setState(() {
//           isGameActive = false;
//         });

//         Future.delayed(const Duration(seconds: 2), () {
//           if (mounted) {
//             widget.onTestComplete();
//           }
//         });
//       }
//     });
//   }

//   void nextPrompt() {
//     final rand = Random();
//     setState(() {
//       displayText = colorNames[rand.nextInt(colorNames.length)];
//       displayColor = colorMap[colorNames[rand.nextInt(colorNames.length)]]!;
//       shownTime = DateTime.now();
//     });
//   }

//   void handleTap(String tappedColor) {
//     if (!isGameActive) return;

//     final now = DateTime.now();
//     if (shownTime != null) {
//       int reaction = now.difference(shownTime!).inMilliseconds;
//       reactionTimes.add(reaction);
//     }

//     setState(() {
//       total++;
//       if (colorMap[tappedColor] == displayColor) {
//         score++;
//       }
//       nextPrompt();
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Color Confusion Test"),
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//       ),
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: isGameActive ? _buildGameScreen() : _buildResultScreen(),
//       ),
//     );
//   }

//   Widget _buildGameScreen() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("⏱️ Time Left: $gameTime s", style: const TextStyle(fontSize: 20)),
//         const SizedBox(height: 30),
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 400),
//           child: Text(
//             displayText,
//             key: ValueKey(displayText + displayColor.toString()),
//             style: TextStyle(
//               fontSize: 60,
//               fontWeight: FontWeight.bold,
//               color: displayColor,
//             ),
//           ),
//         ),
//         const SizedBox(height: 40),
//         Wrap(
//           spacing: 20,
//           runSpacing: 20,
//           children:
//               colorNames.map((color) {
//                 return ElevatedButton(
//                   onPressed: () => handleTap(color),
//                   child: Text(color),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: colorMap[color],
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildResultScreen() {
//     final avgReaction =
//         reactionTimes.isNotEmpty
//             ? reactionTimes.reduce((a, b) => a + b) ~/ reactionTimes.length
//             : 0;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("🎯 Game Over!", style: TextStyle(fontSize: 30)),
//         const SizedBox(height: 20),
//         Text("✅ Score: $score / $total", style: const TextStyle(fontSize: 22)),
//         Text(
//           "⚡ Avg Reaction: ${avgReaction} ms",
//           style: const TextStyle(fontSize: 22),
//         ),
//       ],
//     );
//   }
// }
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ColorGameScreen extends StatefulWidget {
  final Function(Map<String, int>) onTestComplete;

  const ColorGameScreen({super.key, required this.onTestComplete});

  @override
  State<ColorGameScreen> createState() => _ColorGameScreenState();
}

class _ColorGameScreenState extends State<ColorGameScreen> {
  final List<String> colorNames = ['Red', 'Blue', 'Green', 'Yellow'];
  final Map<String, Color> colorMap = {
    'Red': Colors.red.shade600,
    'Blue': Colors.blue.shade600,
    'Green': Colors.green.shade600,
    'Yellow': Colors.amber.shade700,
  };

  late String displayText;
  late Color displayColor;

  int score = 0;
  int total = 0;
  int gameTime = 30;
  bool isGameActive = false;
  late Timer gameTimer;

  DateTime? shownTime;
  List<int> reactionTimes = [];

  @override
  void initState() {
    super.initState();
    startGame(); // 🚀 Start immediately
  }

  void startGame() {
    setState(() {
      score = 0;
      total = 0;
      gameTime = 30;
      isGameActive = true;
      reactionTimes.clear();
    });

    nextPrompt();

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        gameTime--;
      });

      if (gameTime <= 0) {
        timer.cancel();
        setState(() {
          isGameActive = false;
        });

        final avgReaction =
            reactionTimes.isNotEmpty
                ? reactionTimes.reduce((a, b) => a + b) ~/ reactionTimes.length
                : 0;

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            widget.onTestComplete({
              'score': score,
              'total': total,
              'avgReaction': avgReaction,
            });
          }
        });
      }
    });
  }

  void nextPrompt() {
    final rand = Random();
    setState(() {
      displayText = colorNames[rand.nextInt(colorNames.length)];
      displayColor = colorMap[colorNames[rand.nextInt(colorNames.length)]]!;
      shownTime = DateTime.now();
    });
  }

  void handleTap(String tappedColor) {
    if (!isGameActive) return;

    final now = DateTime.now();
    if (shownTime != null) {
      int reaction = now.difference(shownTime!).inMilliseconds;
      reactionTimes.add(reaction);
    }

    setState(() {
      total++;
      if (colorMap[tappedColor] == displayColor) {
        score++;
      }
      nextPrompt();
    });
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color Confusion Test"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: isGameActive ? _buildGameScreen() : _buildResultScreen(),
      ),
    );
  }

  Widget _buildGameScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("⏱️ Time Left: $gameTime s", style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 30),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            displayText,
            key: ValueKey(displayText + displayColor.toString()),
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: displayColor,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children:
              colorNames.map((color) {
                return ElevatedButton(
                  onPressed: () => handleTap(color),
                  child: Text(color),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorMap[color],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildResultScreen() {
    final avgReaction =
        reactionTimes.isNotEmpty
            ? reactionTimes.reduce((a, b) => a + b) ~/ reactionTimes.length
            : 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("🎯 Game Over!", style: TextStyle(fontSize: 30)),
        const SizedBox(height: 20),
        Text("✅ Score: $score / $total", style: const TextStyle(fontSize: 22)),
        Text(
          "⚡ Avg Reaction: ${avgReaction} ms",
          style: const TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}
