import 'package:flutter/material.dart';
import 'assessment_result.dart';

class AssessmentCompleteScreen extends StatelessWidget {
  final AssessmentResult assessmentResult;

  const AssessmentCompleteScreen({super.key, required this.assessmentResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A00E0),
              Color(0xFF8E2DE2),
              Color(0xFF6A82FB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 100, color: Colors.white),
                    const SizedBox(height: 30),
                    const Text(
                      "Assessment Complete!",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    buildResultRow("Avg Reaction Time", "${assessmentResult.avgReactionTimeMs} ms"),
                    buildResultRow("Correct Reactions", "${assessmentResult.correctReactions}"),
                    buildResultRow("Wrong Reactions", "${assessmentResult.wrongReactions}"),
                    buildResultRow("Total Taps", "${assessmentResult.totalTaps}"),
                    buildResultRow("Color Confusion Score", "${assessmentResult.colorConfusionScore}/${assessmentResult.colorConfusionTotal}"),
                    buildResultRow("Color Confusion Avg Reaction", "${assessmentResult.colorConfusionAvgReactionMs} ms"),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'games_completed'); // ✅ Correct way to return
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      child: const Text("Go to Home"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 20, color: Colors.white70)),
          Text(value, style: const TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }
}
