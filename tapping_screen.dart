// import 'dart:async';
// import 'package:flutter/material.dart';

// class TappingScreen extends StatefulWidget {
//   const TappingScreen({super.key});

//   @override
//   State<TappingScreen> createState() => _TappingScreenState();
// }

// enum TappingPhase { instruction, countdown, tapping, result }

// class _TappingScreenState extends State<TappingScreen> {
//   TappingPhase phase = TappingPhase.instruction;
//   int tapCount = 0;
//   int countdown = 3;
//   int gameDuration = 10;

//   String? lastTapped; // 'left' or 'right'
//   Timer? gameTimer;
//   Timer? countdownTimer;

//   void startCountdown() {
//     setState(() {
//       phase = TappingPhase.countdown;
//       countdown = 3;
//       tapCount = 0;
//       lastTapped = null;
//     });

//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         countdown--;
//       });

//       if (countdown == 0) {
//         timer.cancel();
//         startTapping();
//       }
//     });
//   }

//   void startTapping() {
//     setState(() {
//       phase = TappingPhase.tapping;
//     });

//     gameTimer = Timer(Duration(seconds: gameDuration), () {
//       setState(() {
//         phase = TappingPhase.result;
//       });
//     });
//   }

//   void resetGame() {
//     gameTimer?.cancel();
//     countdownTimer?.cancel();
//     setState(() {
//       tapCount = 0;
//       lastTapped = null;
//       phase = TappingPhase.instruction;
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer?.cancel();
//     countdownTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Alternate Tapping Test"),
//         backgroundColor: Colors.black,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: buildContent(),
//         ),
//       ),
//     );
//   }

//   Widget buildContent() {
//     switch (phase) {
//       case TappingPhase.instruction:
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "👆 Alternate Tapping",
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Use both fingers to tap the two buttons back and forth.\n"
//               "Only alternating taps are counted.\n\n"
//               "You have $gameDuration seconds!",
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: startCountdown,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                   vertical: 16,
//                 ),
//                 textStyle: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               child: const Text("Start Game"),
//             ),
//           ],
//         );

//       case TappingPhase.countdown:
//         return Text(
//           countdown.toString(),
//           style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
//         );

//       case TappingPhase.tapping:
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Taps: $tapCount",
//               style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [buildTapButton('left'), buildTapButton('right')],
//             ),
//           ],
//         );

//       case TappingPhase.result:
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "⏱️ Time's Up!",
//               style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "🎯 Total Alternating Taps: $tapCount",
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: resetGame,
//               child: const Text("🔄 Try Again"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Go back to GameHub
//               },
//               child: const Text("✅ Back to Game Hub"),
//             ),
//           ],
//         );
//     }
//   }

//   Widget buildTapButton(String side) {
//     return ElevatedButton(
//       onPressed: () {
//         if (lastTapped != side) {
//           setState(() {
//             tapCount++;
//             lastTapped = side;
//           });
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black87,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(50),
//         elevation: 8,
//       ),
//       child: const SizedBox.shrink(),
//     );
//   }
// }
// import 'dart:async';
// import 'package:flutter/material.dart';

// class TappingScreen extends StatefulWidget {
//   final VoidCallback onTestComplete;

//   const TappingScreen({super.key, required this.onTestComplete});

//   @override
//   State<TappingScreen> createState() => _TappingScreenState();
// }

// enum TappingPhase { instruction, countdown, tapping, result }

// class _TappingScreenState extends State<TappingScreen> {
//   TappingPhase phase = TappingPhase.instruction;
//   int tapCount = 0;
//   int countdown = 3;
//   int gameDuration = 10;

//   String? lastTapped; // 'left' or 'right'
//   Timer? gameTimer;
//   Timer? countdownTimer;

//   void startCountdown() {
//     setState(() {
//       phase = TappingPhase.countdown;
//       countdown = 3;
//       tapCount = 0;
//       lastTapped = null;
//     });

//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         countdown--;
//       });

//       if (countdown == 0) {
//         timer.cancel();
//         startTapping();
//       }
//     });
//   }

//   void startTapping() {
//     setState(() {
//       phase = TappingPhase.tapping;
//     });

//     gameTimer = Timer(Duration(seconds: gameDuration), () {
//       setState(() {
//         phase = TappingPhase.result;
//       });

//       // 🚀 Automatically trigger onTestComplete after small delay
//       Future.delayed(const Duration(seconds: 2), () {
//         if (mounted) {
//           widget.onTestComplete();
//         }
//       });
//     });
//   }

//   void resetGame() {
//     gameTimer?.cancel();
//     countdownTimer?.cancel();
//     setState(() {
//       tapCount = 0;
//       lastTapped = null;
//       phase = TappingPhase.instruction;
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer?.cancel();
//     countdownTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (phase) {
//       case TappingPhase.instruction:
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text("Alternate Tapping Test"),
//             backgroundColor: Colors.deepPurple,
//           ),
//           body: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "👆 Alternate Tapping",
//                     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Use both fingers to tap the two buttons back and forth.\n"
//                     "Only alternating taps are counted.\n\n"
//                     "You have 10 seconds!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 40),
//                   ElevatedButton(
//                     onPressed: startCountdown,
//                     child: const Text("Start Game"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );

//       case TappingPhase.countdown:
//         return Scaffold(
//           body: Center(
//             child: Text(
//               countdown.toString(),
//               style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
//             ),
//           ),
//         );

//       case TappingPhase.tapping:
//         return Scaffold(
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Taps: $tapCount",
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [buildTapButton('left'), buildTapButton('right')],
//               ),
//             ],
//           ),
//         );

//       case TappingPhase.result:
//         return Scaffold(
//           backgroundColor: Colors.deepPurple,
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Test Complete!",
//                   style: TextStyle(fontSize: 30, color: Colors.white),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Total Alternating Taps: $tapCount",
//                   style: const TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         );
//     }
//   }

//   Widget buildTapButton(String side) {
//     return ElevatedButton(
//       onPressed: () {
//         if (lastTapped != side) {
//           setState(() {
//             tapCount++;
//             lastTapped = side;
//           });
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black87,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(50),
//         elevation: 8,
//       ),
//       child: const SizedBox.shrink(),
//     );
//   }
// }
// import 'dart:async';
// import 'package:flutter/material.dart';

// class TappingScreen extends StatefulWidget {
//   final VoidCallback onTestComplete;

//   const TappingScreen({super.key, required this.onTestComplete});

//   @override
//   State<TappingScreen> createState() => _TappingScreenState();
// }

// enum TappingPhase { countdown, tapping, result }

// class _TappingScreenState extends State<TappingScreen> {
//   TappingPhase phase = TappingPhase.countdown;
//   int tapCount = 0;
//   int countdown = 3;
//   int gameDuration = 10;

//   String? lastTapped; // 'left' or 'right'
//   Timer? gameTimer;
//   Timer? countdownTimer;

//   @override
//   void initState() {
//     super.initState();
//     startCountdown(); // 🚀 Start countdown immediately after screen loads
//   }

//   void startCountdown() {
//     setState(() {
//       phase = TappingPhase.countdown;
//       countdown = 3;
//       tapCount = 0;
//       lastTapped = null;
//     });

//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         countdown--;
//       });

//       if (countdown == 0) {
//         timer.cancel();
//         startTapping();
//       }
//     });
//   }

//   void startTapping() {
//     setState(() {
//       phase = TappingPhase.tapping;
//     });

//     gameTimer = Timer(Duration(seconds: gameDuration), () {
//       setState(() {
//         phase = TappingPhase.result;
//       });

//       Future.delayed(const Duration(seconds: 2), () {
//         if (mounted) {
//           widget.onTestComplete();
//         }
//       });
//     });
//   }

//   void resetGame() {
//     gameTimer?.cancel();
//     countdownTimer?.cancel();
//     setState(() {
//       tapCount = 0;
//       lastTapped = null;
//       phase = TappingPhase.countdown;
//     });
//   }

//   @override
//   void dispose() {
//     gameTimer?.cancel();
//     countdownTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (phase) {
//       case TappingPhase.countdown:
//         return Scaffold(
//           backgroundColor: Colors.deepPurple,
//           body: Center(
//             child: Text(
//               countdown.toString(),
//               style: const TextStyle(
//                 fontSize: 80,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         );

//       case TappingPhase.tapping:
//         return Scaffold(
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Taps: $tapCount",
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [buildTapButton('left'), buildTapButton('right')],
//               ),
//             ],
//           ),
//         );

//       case TappingPhase.result:
//         return Scaffold(
//           backgroundColor: Colors.deepPurple,
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Test Complete!",
//                   style: TextStyle(fontSize: 30, color: Colors.white),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Total Alternating Taps: $tapCount",
//                   style: const TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         );
//     }
//   }

//   Widget buildTapButton(String side) {
//     return ElevatedButton(
//       onPressed: () {
//         if (lastTapped != side) {
//           setState(() {
//             tapCount++;
//             lastTapped = side;
//           });
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black87,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(50),
//         elevation: 8,
//       ),
//       child: const SizedBox.shrink(),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';

class TappingScreen extends StatefulWidget {
  final Function(Map<String, int>) onTestComplete;

  const TappingScreen({super.key, required this.onTestComplete});

  @override
  State<TappingScreen> createState() => _TappingScreenState();
}

enum TappingPhase { countdown, tapping, result }

class _TappingScreenState extends State<TappingScreen> {
  TappingPhase phase = TappingPhase.countdown;
  int tapCount = 0;
  int countdown = 3;
  int gameDuration = 10;

  String? lastTapped; // 'left' or 'right'
  Timer? gameTimer;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown(); // 🚀 Start countdown immediately
  }

  void startCountdown() {
    setState(() {
      phase = TappingPhase.countdown;
      countdown = 3;
      tapCount = 0;
      lastTapped = null;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });

      if (countdown == 0) {
        timer.cancel();
        startTapping();
      }
    });
  }

  void startTapping() {
    setState(() {
      phase = TappingPhase.tapping;
    });

    gameTimer = Timer(Duration(seconds: gameDuration), () {
      setState(() {
        phase = TappingPhase.result;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          widget.onTestComplete({
            'totalTaps': tapCount, // ✅ Send total taps result
          });
        }
      });
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (phase) {
      case TappingPhase.countdown:
        return Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Center(
            child: Text(
              countdown.toString(),
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );

      case TappingPhase.tapping:
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Taps: $tapCount",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [buildTapButton('left'), buildTapButton('right')],
              ),
            ],
          ),
        );

      case TappingPhase.result:
        return Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Test Complete!",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  "Total Alternating Taps: $tapCount",
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget buildTapButton(String side) {
    return ElevatedButton(
      onPressed: () {
        if (lastTapped != side) {
          setState(() {
            tapCount++;
            lastTapped = side;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(50),
        elevation: 8,
      ),
      child: const SizedBox.shrink(),
    );
  }
}
