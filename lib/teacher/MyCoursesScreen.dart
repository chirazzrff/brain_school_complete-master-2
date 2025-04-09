import 'package:flutter/material.dart';

class MesCoursScreen extends StatelessWidget {
  // Liste des cours simulée pour l'exemple
  final List<Map<String, dynamic>> courses = [
    {
      'nom': 'Mathématiques',
      'niveau': '3ème',
      'nombreEleves': 30,
    },
    {
      'nom': 'Français',
      'niveau': '2ème',
      'nombreEleves': 25,
    },
    {
      'nom': 'Physique',
      'niveau': '1ère',
      'nombreEleves': 28,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Cours',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Taille de titre plus grande
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  course['nom'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Taille de texte plus grande pour le nom du cours
                  ),
                ),
                subtitle: Text(
                  'Niveau: ${course['niveau']} - ${course['nombreEleves']} élèves',
                  style: TextStyle(fontSize: 14), // Taille plus petite pour le sous-titre
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    // Gestion des actions ici (par exemple : Voir Détails, Ajouter un Cours, etc.)
                    switch (value) {
                      case 'Voir Détails':
                        _showCourseDetails(context, course);
                        break;
                      case 'Ajouter un Cours':
                        _addCourse(context);
                        break;
                      case 'Marquer l\'absence':
                        _markAbsence(context, course);
                        break;
                      case 'Consulter les Notes':
                        _viewNotes(context, course);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'Voir Détails',
                      child: Text(
                        'Voir Détails du Cours',
                        style: TextStyle(fontSize: 16), // Taille plus grande pour les options du menu
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Ajouter un Cours',
                      child: Text(
                        'Ajouter un Cours',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Marquer l\'absence',
                      child: Text(
                        'Marquer l\'Absence',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Consulter les Notes',
                      child: Text(
                        'Consulter les Notes',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Fonction pour afficher les détails d'un cours
  void _showCourseDetails(BuildContext context, Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Détails du Cours: ${course['nom']}',
            style: TextStyle(fontSize: 18), // Taille du titre dans le dialogue
          ),
          content: Text(
            'Niveau: ${course['niveau']}\nNombre d\'élèves: ${course['nombreEleves']}',
            style: TextStyle(fontSize: 16), // Taille du contenu dans le dialogue
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fermer', style: TextStyle(fontSize: 16)), // Taille du bouton
            ),
          ],
        );
      },
    );
  }

  // Fonction pour ajouter un nouveau cours
  void _addCourse(BuildContext context) {
    // Ajout de cours - exemple simple
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ajouter un Cours',
            style: TextStyle(fontSize: 18), // Taille du titre
          ),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Nom du Cours',
              hintStyle: TextStyle(fontSize: 16), // Taille de l'indication
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ajouter', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour marquer l'absence des élèves
  void _markAbsence(BuildContext context, Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Marquer l\'absence pour ${course['nom']}',
            style: TextStyle(fontSize: 18), // Taille du titre
          ),
          content: Text(
            'Sélectionnez les élèves absents',
            style: TextStyle(fontSize: 16), // Taille du texte dans le dialogue
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler', style: TextStyle(fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Marquer', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  // Fonction pour consulter les notes des élèves
  void _viewNotes(BuildContext context, Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Notes pour ${course['nom']}',
            style: TextStyle(fontSize: 18), // Taille du titre
          ),
          content: Text(
            'Affichage des notes des élèves pour ce cours',
            style: TextStyle(fontSize: 16), // Taille du texte dans le dialogue
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fermer', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
}
