
import 'package:brain_school/parent/parent_home_screen.dart';
import 'package:brain_school/screens/home_screen/parent_home_screen.dart';
import 'package:flutter/material.dart';

class ParentProfileScreen extends StatefulWidget {
  static String routeName = 'ParentProfileScreen';

  const ParentProfileScreen({super.key});

  @override
  _ParentProfileScreenState createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String parentName = "";
  String parentEmail = "";
  String parentPhone = "";

  int numberOfChildren = 1;

  List<String> childNames = [];
  List<String> studyYears = [];

  @override
  void initState() {
    super.initState();
    childNames = List.filled(numberOfChildren, '');
    studyYears = List.filled(numberOfChildren, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Profil du Parent",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField("Nom du Parent", Icons.person, (value) => parentName = value),
                _buildTextField("Email", Icons.email, (value) => parentEmail = value),
                _buildTextField("Téléphone", Icons.phone, (value) => parentPhone = value, isNumber: true),
                const SizedBox(height: 20),

                // Nombre d'enfants
                _buildTextField(
                  "Nombre d'enfants",
                  Icons.numbers,
                      (value) {
                    final int? newCount = int.tryParse(value);
                    if (newCount != null && newCount > 0) {
                      setState(() {
                        numberOfChildren = newCount;
                        childNames = List.filled(numberOfChildren, '');
                        studyYears = List.filled(numberOfChildren, '');
                      });
                    }
                  },
                  isNumber: true,
                ),

                const SizedBox(height: 10),
                const Text(
                  "Informations des enfants",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),

                // Boucle pour afficher les champs dynamiques des enfants
                for (int i = 0; i < numberOfChildren; i++) ...[
                  const SizedBox(height: 10),
                  Text(
                    "Enfant ${i + 1}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _buildTextField("Nom de l'enfant", Icons.child_care, (value) => childNames[i] = value),
                  _buildTextField("Année d'étude", Icons.school, (value) => studyYears[i] = value, isNumber: true),
                ],

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, ParentHomeScreen.routeName);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, Function(String) onChanged, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.indigo),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
        onChanged: onChanged,
      ),
    );
  }
}