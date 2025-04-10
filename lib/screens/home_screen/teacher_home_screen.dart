import 'package:flutter/material.dart';
import '../../teacher/CahierDeTexteScreen.dart';
import '../../teacher/ModifierProfilScreen.dart';
import '../../teacher/MyCoursesScreen.dart';
import '../../teacher/StudentsListScreen.dart';
import '../../teacher/ExamResultsScreen.dart';  // Importer l'écran des résultats des examens
import 'CahierDeTexteScreen.dart';
import 'MyCoursesScreen.dart';
import 'MesCoursScreen.dart';
import 'CahierDeTexteScreen.dart';
import 'ModifierProfilScreen.dart';
import 'StudentsListScreen.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);
  static String routeName = 'TeacherHomeScreen';

  @override
  Widget build(BuildContext context) {
    String teacherName = 'Mr. Karim B.';

    // Fonction pour afficher une notification
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

    // Fonction pour changer le mot de passe
    void _changePassword() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Changer le Mot de Passe'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Nouveau mot de passe'),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Confirmer le mot de passe'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  // Ajouter la logique pour changer le mot de passe ici
                  Navigator.pop(context);
                },
                child: Text('Changer'),
              ),
            ],
          );
        },
      );
    }

    // Fonction pour déconnecter l'utilisateur
    void _logout() {
      // Implémenter la logique de déconnexion ici (par exemple, rediriger vers l'écran de connexion)
      Navigator.pushReplacementNamed(context, '/login');  // Exemple de redirection vers un écran de login
    }

    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc pour l'uniformité
      body: Column(
        children: [
          // HEADER BLEU
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFF345FB4), // Bleu profond
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Espace Professeur",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Bienvenue, $teacherName 👋",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),

          // ESPACE ENTRE LE HEADER ET LES BOUTONS
          SizedBox(height: 20),

          // BOUTONS POUR LES FONCTIONS DU PROFESSEUR
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.symmetric(horizontal: 20),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                HomeCard(
                  icon: Icons.account_circle,  // Icône pour le profil
                  title: "Modifier le profil",  // Titre du bouton
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifierProfilScreen()),
                    );
                  },
                ),
                HomeCard(
                  icon: Icons.book,
                  title: "Mes Cours",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MesCoursScreen()),
                    );
                  },
                ),
                HomeCard(
                  icon: Icons.assignment,
                  title: "Cahier de texte",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CahierDeTexteScreen()),
                    );
                  },
                ),
                HomeCard(
                  icon: Icons.schedule,
                  title: "Emploi du temps",
                  onPress: () {
                    // Logique pour l'emploi du temps
                  },
                ),
                HomeCard(
                  icon: Icons.notifications,
                  title: "Notifications",
                  onPress: () {
                    _showNotification('Nouvelle mise à jour dans l\'emploi du temps.');
                  },
                ),
                HomeCard(
                  icon: Icons.lock,
                  title: "Mot de Passe",
                  onPress: _changePassword,
                ),
                HomeCard(
                  icon: Icons.logout,
                  title: "Déconnexion",
                  onPress: _logout,
                ),
                HomeCard(
                  icon: Icons.school,
                  title: "Voir les élèves inscrits",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentsListScreen()),
                    );
                  },
                ),
                HomeCard(
                  icon: Icons.assignment,
                  title: "Consulter les résultats des examens",  // Nouveau bouton
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExamResultsScreen()),  // Naviguer vers l'écran des résultats
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPress;

  const HomeCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fond blanc pour les cartes
          borderRadius: BorderRadius.circular(15), // Coins arrondis
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Color(0xFF345FB4)), // Icône avec la couleur bleu
            SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF345FB4), // Texte en bleu
              ),
            ),
          ],
        ),
      ),
    );
  }
}
