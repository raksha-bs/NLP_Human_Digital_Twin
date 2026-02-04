// import 'package:flutter/material.dart';
// import 'pre_assessment_screen.dart';
// import 'assessment_complete_screen.dart';
// import 'countdown_screen.dart';
// import 'rules_screen.dart';
// import 'color_confusion/color_confusion_screen.dart';
// import 'reaction_time/reaction_time_screen.dart';
// import 'tapping/tapping_screen.dart';

// enum AssessmentStep {
//   preAssessment,
//   countdownBeforeReaction,
//   rulesReaction,
//   reactionTest,
//   countdownBeforeTapping,
//   rulesTapping,
//   tappingTest,
//   countdownBeforeColorConfusion,
//   rulesColorConfusion,
//   colorConfusionTest,
//   assessmentComplete,
// }

// class TestControllerScreen extends StatefulWidget {
//   const TestControllerScreen({super.key});

//   @override
//   State<TestControllerScreen> createState() => _TestControllerScreenState();
// }

// class _TestControllerScreenState extends State<TestControllerScreen> {
//   AssessmentStep currentStep = AssessmentStep.preAssessment;

//   @override
//   Widget build(BuildContext context) {
//     switch (currentStep) {
//       case AssessmentStep.preAssessment:
//         return PreAssessmentScreen(
//           onStartAssessment: () {
//             setState(() {
//               currentStep = AssessmentStep.countdownBeforeReaction;
//             });
//           },
//         );

//       case AssessmentStep.rulesReaction:
//         return buildRulesScreen(
//           "Tap the screen ONLY when it turns YELLOW.\n\nBe as fast and accurate as possible!",
//           () {
//             setState(() {
//               currentStep = AssessmentStep.reactionTest;
//             });
//           },
//         );
//       case AssessmentStep.countdownBeforeReaction:
//         return buildCountdownScreen(() {
//           setState(() {
//             currentStep = AssessmentStep.rulesReaction;
//           });
//         });
//       case AssessmentStep.reactionTest:
//         return ReactionTimeScreen(
//           onTestComplete: () {
//             setState(() {
//               currentStep = AssessmentStep.countdownBeforeTapping;
//             });
//           },
//         );

//       case AssessmentStep.rulesTapping:
//         return buildRulesScreen(
//           "Alternate between the left and right buttons as fast as you can for 10 seconds!",
//           () {
//             setState(() {
//               currentStep = AssessmentStep.tappingTest;
//             });
//           },
//         );
//       case AssessmentStep.countdownBeforeTapping:
//         return buildCountdownScreen(() {
//           setState(() {
//             currentStep = AssessmentStep.rulesTapping;
//           });
//         });
//       case AssessmentStep.tappingTest:
//         return TappingScreen(
//           onTestComplete: () {
//             setState(() {
//               currentStep = AssessmentStep.countdownBeforeColorConfusion;
//             });
//           },
//         );

//       case AssessmentStep.rulesColorConfusion:
//         return buildRulesScreen(
//           "Tap the BUTTON that matches the COLOR (not the text)!",
//           () {
//             setState(() {
//               currentStep = AssessmentStep.colorConfusionTest;
//             });
//           },
//         );
//       case AssessmentStep.countdownBeforeColorConfusion:
//         return buildCountdownScreen(() {
//           setState(() {
//             currentStep = AssessmentStep.rulesColorConfusion;
//           });
//         });
//       case AssessmentStep.colorConfusionTest:
//         return ColorGameScreen(
//           onTestComplete: () {
//             setState(() {
//               currentStep = AssessmentStep.assessmentComplete;
//             });
//           },
//         );

//       case AssessmentStep.assessmentComplete:
//         return const AssessmentCompleteScreen();
//     }
//   }

//   // Small Countdown Widget (10 seconds)
//   Widget buildCountdownScreen(VoidCallback onDone) {
//     return CountdownScreen(onCountdownFinished: onDone);
//   }

//   // Small Rules Widget
//   Widget buildRulesScreen(String rulesText, VoidCallback onDone) {
//     return RulesScreen(rulesText: rulesText, onContinue: onDone);
//   }
// }
// import 'package:flutter/material.dart';
// import 'pre_assessment_screen.dart';
// import 'assessment_complete_screen.dart';
// import 'assessment_result.dart';
// import 'countdown_screen.dart';
// import 'rules_screen.dart';
// import 'color_confusion/color_confusion_screen.dart';
// import 'reaction_time/reaction_time_screen.dart';
// import 'tapping/tapping_screen.dart';

// enum AssessmentStep {
//   preAssessment,
//   rulesReaction,
//   countdownBeforeReaction,
//   reactionTest,
//   rulesTapping,
//   countdownBeforeTapping,
//   tappingTest,
//   rulesColorConfusion,
//   countdownBeforeColorConfusion,
//   colorConfusionTest,
//   assessmentComplete,
// }

// class TestControllerScreen extends StatefulWidget {
//   const TestControllerScreen({super.key});

//   @override
//   State<TestControllerScreen> createState() => _TestControllerScreenState();
// }

// class _TestControllerScreenState extends State<TestControllerScreen> {
//   AssessmentStep currentStep = AssessmentStep.preAssessment;

//   @override
//   Widget build(BuildContext context) {
//     switch (currentStep) {
//       case AssessmentStep.preAssessment:
//         return PreAssessmentScreen(
//           onStartAssessment: () {
//             setState(() {
//               currentStep = AssessmentStep.rulesReaction;
//             });
//           },
//         );

//       case AssessmentStep.rulesReaction:
//         return buildRulesScreen(
//           "Tap the screen ONLY when it turns YELLOW.\n\nBe as fast and accurate as possible!",
//           () {
//             setState(() {
//               currentStep = AssessmentStep.countdownBeforeReaction;
//             });
//           },
//         );

//       case AssessmentStep.countdownBeforeReaction:
//         return buildCountdownScreen(() {
//           setState(() {
//             currentStep = AssessmentStep.reactionTest;
//           });
//         });

//       case AssessmentStep.reactionTest:
//         return ReactionTimeScreen(
//           onTestComplete: () {
//             setState(() {
//               currentStep = AssessmentStep.rulesTapping;
//             });
//           },
//         );

//       case AssessmentStep.rulesTapping:
//         return buildRulesScreen(
//           "Alternate between the left and right buttons as fast as you can for 10 seconds!",
//           () {
//             setState(() {
//               currentStep = AssessmentStep.countdownBeforeTapping;
//             });
//           },
//         );

//       case AssessmentStep.countdownBeforeTapping:
//         return buildCountdownScreen(() {
//           setState(() {
//             currentStep = AssessmentStep.tappingTest;
//           });
//         });

//       case AssessmentStep.tappingTest:
//         return TappingScreen(
//           onTestComplete: () {
//             setState(() {
//               currentStep = AssessmentStep.rulesColorConfusion;
//             });
//           },
//         );

//       case AssessmentStep.rulesColorConfusion:
//         return buildRulesScreen(
//           "Tap the BUTTON that matches the COLOR (not the text)!",
//           () {
//             setState(() {
//               currentStep = AssessmentStep.countdownBeforeColorConfusion;
//             });
//           },
//         );

//       case AssessmentStep.countdownBeforeColorConfusion:
//         return buildCountdownScreen(() {
//           setState(() {
//             currentStep = AssessmentStep.colorConfusionTest;
//           });
//         });

//       case AssessmentStep.colorConfusionTest:
//         return ColorGameScreen(
//           onTestComplete: () {
//             setState(() {
//               currentStep = AssessmentStep.assessmentComplete;
//             });
//           },
//         );

//       case AssessmentStep.assessmentComplete:
//         return const AssessmentCompleteScreen();
//     }
//   }

//   Widget buildCountdownScreen(VoidCallback onDone) {
//     return CountdownScreen(onCountdownFinished: onDone);
//   }

//   Widget buildRulesScreen(String rulesText, VoidCallback onDone) {
//     return RulesScreen(rulesText: rulesText, onContinue: onDone);
//   }
//   final AssessmentResult result = AssessmentResult();
// }

import 'package:flutter/material.dart';
import 'pre_assessment_screen.dart';
import 'assessment_complete_screen.dart';
import 'countdown_screen.dart';
import 'rules_screen.dart';
import 'assessment_result.dart'; // Import the result model
import 'color_confusion_screen.dart';
import 'reaction_time_screen.dart';
import 'tapping_screen.dart';

enum AssessmentStep {
  preAssessment,
  rulesReaction,
  countdownBeforeReaction,
  reactionTest,
  rulesTapping,
  countdownBeforeTapping,
  tappingTest,
  rulesColorConfusion,
  countdownBeforeColorConfusion,
  colorConfusionTest,
  assessmentComplete,
}

class TestControllerScreen extends StatefulWidget {
  const TestControllerScreen({super.key});

  @override
  State<TestControllerScreen> createState() => _TestControllerScreenState();
}

class _TestControllerScreenState extends State<TestControllerScreen> {
  AssessmentStep currentStep = AssessmentStep.preAssessment;

  final AssessmentResult result =
      AssessmentResult(); // 🎯 Our central result model

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      case AssessmentStep.preAssessment:
        return PreAssessmentScreen(
          onStartAssessment: () {
            setState(() {
              currentStep = AssessmentStep.rulesReaction;
            });
          },
        );

      case AssessmentStep.rulesReaction:
        return buildRulesScreen(
          "Tap the screen ONLY when it turns YELLOW.\n\nBe as fast and accurate as possible!",
          () {
            setState(() {
              currentStep = AssessmentStep.countdownBeforeReaction;
            });
          },
        );

      case AssessmentStep.countdownBeforeReaction:
        return buildCountdownScreen(() {
          setState(() {
            currentStep = AssessmentStep.reactionTest;
          });
        });

      case AssessmentStep.reactionTest:
        return ReactionTimeScreen(
          onTestComplete: (Map<String, int> reactionData) {
            // ✅ TELL dart that reactionData is Map<String, int>
            result.avgReactionTimeMs = reactionData['avgReaction']!;
            result.correctReactions = reactionData['correct']!;
            result.wrongReactions = reactionData['wrong']!;

            setState(() {
              currentStep = AssessmentStep.rulesTapping;
            });
          },
        );

      case AssessmentStep.rulesTapping:
        return buildRulesScreen(
          "Alternate between the left and right buttons as fast as you can for 10 seconds!",
          () {
            setState(() {
              currentStep = AssessmentStep.countdownBeforeTapping;
            });
          },
        );

      case AssessmentStep.countdownBeforeTapping:
        return buildCountdownScreen(() {
          setState(() {
            currentStep = AssessmentStep.tappingTest;
          });
        });

      case AssessmentStep.tappingTest:
        return TappingScreen(
          onTestComplete: (Map<String, int> tapData) {
            // ✅ Specify Map type here
            result.totalTaps =
                tapData['totalTaps']!; // ✅ Add ! for safe extraction

            setState(() {
              currentStep = AssessmentStep.rulesColorConfusion;
            });
          },
        );

      case AssessmentStep.rulesColorConfusion:
        return buildRulesScreen(
          "Tap the BUTTON that matches the COLOR (not the text)!",
          () {
            setState(() {
              currentStep = AssessmentStep.countdownBeforeColorConfusion;
            });
          },
        );

      case AssessmentStep.countdownBeforeColorConfusion:
        return buildCountdownScreen(() {
          setState(() {
            currentStep = AssessmentStep.colorConfusionTest;
          });
        });

      case AssessmentStep.colorConfusionTest:
        return ColorGameScreen(
          onTestComplete: (Map<String, int> colorData) {
            // ✅ Specify Map type here
            result.colorConfusionScore = colorData['score']!;
            result.colorConfusionTotal = colorData['total']!;
            result.colorConfusionAvgReactionMs = colorData['avgReaction']!;

            setState(() {
              currentStep = AssessmentStep.assessmentComplete;
            });
          },
        );

      case AssessmentStep.assessmentComplete:
        return AssessmentCompleteScreen(
          assessmentResult: result, // 🎯 Pass final result to completion screen
        );
    }
  }

  Widget buildCountdownScreen(VoidCallback onDone) {
    return CountdownScreen(onCountdownFinished: onDone);
  }

  Widget buildRulesScreen(String rulesText, VoidCallback onDone) {
    return RulesScreen(rulesText: rulesText, onContinue: onDone);
  }
}
