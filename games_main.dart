// import 'package:flutter/material.dart';
// import 'screens/today_workout_tab.dart';
// import 'screens/upcoming_workout_tab.dart';
// import 'screens/completed_workout_tab.dart';
// import 'screens/adjust_workout_tab.dart';

// void main() => runApp(const TrainingPlannerApp());

// class TrainingPlannerApp extends StatelessWidget {
//   const TrainingPlannerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Personalized Training Planner',
//       theme: ThemeData(
//         fontFamily: 'SFPro',
//         scaffoldBackgroundColor: Colors.transparent,
//         appBarTheme: const AppBarTheme(
//           color: Color.fromARGB(255, 245, 233, 248),
//           elevation: 0,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         tabBarTheme: const TabBarTheme(
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.blueAccent,
//         ),
//       ),
//       home: const TrainingPlannerHomePage(),
//     );
//   }
// }

// class TrainingPlannerHomePage extends StatelessWidget {
//   const TrainingPlannerHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Training Planner'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.today), text: 'Today'),
//               Tab(icon: Icon(Icons.calendar_view_week), text: 'Upcoming'),
//               Tab(icon: Icon(Icons.history), text: 'Completed'),
//               Tab(icon: Icon(Icons.settings), text: 'Adjust'),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             TodayWorkoutTab(),
//             UpcomingWorkoutTab(),
//             CompletedWorkoutTab(),
//             AdjustWorkoutTab(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// uguhhkjjkjn
// import 'package:flutter/material.dart';
// import 'games/reaction_time/reaction_time_screen.dart'; // <-- Import this

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Cognitive Games',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const ReactionTimeScreen(), // <-- Just point here for now
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'games/games_hub_screen.dart'; // This will be our new starting page

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Digital Twin Cognitive Games',
//       theme: ThemeData(
//         fontFamily: 'SFPro',
//         scaffoldBackgroundColor: const Color(0xFFF5F6FA),
//         appBarTheme: const AppBarTheme(
//           color: Colors.white,
//           elevation: 0,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       home: const GameHubScreen(), // Start at Game Hub
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'test_controller_screen.dart'; // NEW file we built

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TwinVerse Cognitive Assessment',
      home: const TestControllerScreen(), // 🎯 Start full assessment flow
    );
  }
}
