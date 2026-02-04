import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? gender;
  String? fitnessLevel;
  List<String> selectedTrainingTypes = [];
  List<Map<String, dynamic>> injuries = [];

  final List<String> genderOptions = ["Male", "Female", "Prefer not to say"];
  final List<String> fitnessLevels = ["Beginner", "Intermediate", "Advanced"];
  final List<String> trainingOptions = ["Strength", "Endurance", "Mobility", "HIIT", "Yoga", "Cardio"];
  final List<String> injuryTypes = ["ACL Tear", "Shoulder Dislocation", "Ankle Sprain", "Hamstring Pull", "Other"];

  void _submitProfile() {
    if (nameController.text.isEmpty || ageController.text.isEmpty || heightController.text.isEmpty || weightController.text.isEmpty || gender == null || fitnessLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields!")),
      );
      return;
    }

    // Simulate backend save
    print("Submitting Profile:");
    print({
      'name': nameController.text,
      'age': ageController.text,
      'gender': gender,
      'height_cm': heightController.text,
      'weight_kg': weightController.text,
      'fitness_level': fitnessLevel,
      'preferred_training': selectedTrainingTypes,
      'injuries': injuries,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  void _openInjuryDialog() async {
    String? selectedType;
    String otherType = '';
    String? selectedDate;
    bool recovered = false;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: const Color(0xFF441C8E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text("Add Injury", style: TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: _inputDecoration("Injury Type"),
                      dropdownColor: const Color(0xFF6A82FB),
                      value: selectedType,
                      items: injuryTypes.map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type, style: const TextStyle(color: Colors.white)),
                      )).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    if (selectedType == "Other")
                      TextField(
                        onChanged: (value) {
                          otherType = value;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Specify Other"),
                      ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setStateDialog(() {
                            selectedDate = pickedDate.toString().split(' ')[0];
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today, color: Colors.white),
                      label: Text(selectedDate ?? "Select Date", style: const TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Recovered?", style: TextStyle(color: Colors.white70)),
                        Switch(
                          value: recovered,
                          onChanged: (val) {
                            setStateDialog(() {
                              recovered = val;
                            });
                          },
                          activeColor: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'type': selectedType,
                      'other': otherType,
                      'date': selectedDate,
                      'recovered': recovered,
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.deepPurple),
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        injuries.add(result);
      });
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white10,
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 1),
                const Center(
                  child: Text(
                    "Create Profile",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField("Name", nameController),
                const SizedBox(height: 16),
                _buildTextField("Age", ageController, number: true),
                const SizedBox(height: 16),
                _buildDropdownField("Gender", genderOptions, gender, (val) {
                  setState(() => gender = val);
                }),
                const SizedBox(height: 16),
                _buildTextField("Height (cm)", heightController, number: true),
                const SizedBox(height: 16),
                _buildTextField("Weight (kg)", weightController, number: true),
                const SizedBox(height: 16),
                _buildDropdownField("Fitness Level", fitnessLevels, fitnessLevel, (val) {
                  setState(() => fitnessLevel = val);
                }),
                const SizedBox(height: 20),
                const Text("Preferred Training Types", style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: trainingOptions.map((option) {
                    final isSelected = selectedTrainingTypes.contains(option);
                    return FilterChip(
                      label: Text(option),
                      labelStyle: const TextStyle(color: Colors.white),
                      selectedColor: Colors.deepPurple,
                      backgroundColor: Colors.white10,
                      checkmarkColor: Colors.white,
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedTrainingTypes.add(option);
                          } else {
                            selectedTrainingTypes.remove(option);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                const Text("Injury History", style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 10),
                if (injuries.isNotEmpty)
                  ...injuries.map((injury) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "${injury['type'] ?? 'Unknown'} - ${injury['date'] ?? 'No date'}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
                ElevatedButton.icon(
                  onPressed: _openInjuryDialog,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Injury"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitProfile,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text("Save Profile"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool number = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: number ? TextInputType.number : TextInputType.text,
      decoration: _inputDecoration(label),
    );
  }

  Widget _buildDropdownField(String label, List<String> options, String? value, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(label, style: const TextStyle(color: Colors.white70)),
          dropdownColor: const Color(0xFF8E2DE2),
          iconEnabledColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
          isExpanded: true,
          items: options.map((option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
