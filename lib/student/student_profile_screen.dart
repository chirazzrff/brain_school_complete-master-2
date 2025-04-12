import 'package:flutter/material.dart';
import 'package:brain_school/student/notifications_screen.dart' as student_notif;
import 'package:brain_school/student/student_details_screen.dart';
import 'package:brain_school/student/edit_student_profile_screen.dart';
import 'package:brain_school/student/student_results_screen.dart';
import 'package:brain_school/student/student_contact_screen.dart'; // N'oublie pas d'importer

class StudentProfileScreen extends StatefulWidget {
  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  String name = 'Aya Benali';
  String email = 'aya.benali@gmail.com';
  String phone = '+213 556 12 34 56';
  final String birthDate = '2006-03-22';
  final String academicLevel = '3ème année secondaire';
  final List<String> courses = ['Mathématiques', 'Physique', 'Français'];
  final double average = 15.8;
  final int absences = 3;

  final List<Map<String, dynamic>> results = [
    {'course': 'Mathématiques', 'grade': 17},
    {'course': 'Physique', 'grade': 15},
    {'course': 'Français', 'grade': 15.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Étudiant'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => student_notif.NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StudentDetailsScreen(
                      email: email,
                      phone: phone,
                      birthDate: birthDate,
                      academicLevel: academicLevel,
                      courses: courses,
                      average: average,
                      absences: absences,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('Appuyez sur la photo pour voir les infos',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionBtn(Icons.edit, 'Modifier', _editProfile),
                _buildActionBtn(Icons.grade, 'Résultats', _viewResults),
                _buildActionBtn(Icons.message, 'Contacter', _showContactOptions),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditStudentProfileScreen(
          name: name,
          email: email,
          phone: phone,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        name = updatedData['name'];
        email = updatedData['email'];
        phone = updatedData['phone'];
      });
    }
  }

  void _viewResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentResultsScreen(
          average: average,
          results: results,
        ),
      ),
    );
  }

  void _showContactOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.admin_panel_settings),
                title: Text('Contacter l’administration'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentContactScreen(contactType: 'admin'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Contacter un enseignant'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentContactScreen(contactType: 'teacher'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionBtn(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: label,
          mini: true,
          onPressed: onTap,
          child: Icon(icon),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
