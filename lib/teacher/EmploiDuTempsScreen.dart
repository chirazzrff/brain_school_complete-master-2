import 'package:flutter/material.dart';

class EmploiDuTempsScreen extends StatefulWidget {
  @override
  _EmploiDuTempsScreenState createState() => _EmploiDuTempsScreenState();
}

class _EmploiDuTempsScreenState extends State<EmploiDuTempsScreen> {
  // Exemple simple de données d'emploi du temps
  final Map<String, List<Map<String, String>>> emploiDuTemps = {
    'Lundi': [
      {'matière': 'Mathématiques', 'horaire': '8h00 - 9h30', 'classe': '3ème A'},
      {'matière': 'Français', 'horaire': '10h00 - 11h30', 'classe': '4ème B'},
    ],
    'Mardi': [
      {'matière': 'Histoire', 'horaire': '8h00 - 9h30', 'classe': '2ème C'},
      {'matière': 'Anglais', 'horaire': '10h00 - 11h30', 'classe': '3ème A'},
    ],
    'Mercredi': [
      {'matière': 'Sciences', 'horaire': '8h00 - 9h30', 'classe': '5ème D'},
    ],
    'Jeudi': [
      {'matière': 'Informatique', 'horaire': '9h00 - 10h30', 'classe': 'Terminale S'},
    ],
    'Vendredi': [
      {'matière': 'Philosophie', 'horaire': '8h30 - 10h00', 'classe': 'Première L'},
    ],
    // Ajoutez plus de jours et de matières si nécessaire
  };

  // Fonction pour envoyer une notification (pour l'exemple, ici on affiche un message)
  void _showNotification(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Text(message, style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK', style: TextStyle(fontSize: 16, color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emploi du temps', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: emploiDuTemps.keys.map((jour) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre pour chaque jour
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    jour,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                // Liste des cours pour chaque jour
                Column(
                  children: emploiDuTemps[jour]!.map((item) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          '${item['matière']}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'Horaire: ${item['horaire']} - Classe: ${item['classe']}',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.notifications, size: 25, color: Colors.blue),
                          onPressed: () {
                            _showNotification('Le cours de ${item['matière']} a été modifié.');
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Divider(), // Séparateur entre les jours
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
