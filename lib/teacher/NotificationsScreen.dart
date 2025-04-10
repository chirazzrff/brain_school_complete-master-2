import 'package:flutter/material.dart';

class NotificationModel {
  String title;
  String message;
  bool isRead;
  bool isEnabled; // Pour activer ou désactiver la notification

  NotificationModel({
    required this.title,
    required this.message,
    this.isRead = false,
    this.isEnabled = true, // Par défaut, la notification est activée
  });
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Liste des notifications
  List<NotificationModel> notifications = [
    NotificationModel(title: 'Réunion importante', message: 'Il y a une réunion ce vendredi à 10h.', isRead: false),
    NotificationModel(title: 'Changement de planning', message: 'Votre emploi du temps a été modifié.', isRead: true),
    NotificationModel(title: 'Examen', message: 'L\'examen de mathématiques est prévu pour lundi.', isRead: false),
    NotificationModel(title: 'Devoir à rendre', message: 'Vous devez rendre le devoir de physique avant vendredi.', isRead: false),
  ];

  // Marquer la notification comme lue ou non lue
  void _toggleReadStatus(int index) {
    setState(() {
      notifications[index].isRead = !notifications[index].isRead;
    });
  }

  // Supprimer une notification
  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  // Activer ou désactiver une notification
  void _toggleNotificationStatus(int index) {
    setState(() {
      notifications[index].isEnabled = !notifications[index].isEnabled;
    });
  }

  // Afficher les détails de la notification
  void _showNotificationDetails(BuildContext context, NotificationModel notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notification.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Message: ${notification.message}'),
              SizedBox(height: 10),
              Text('Statut: ${notification.isRead ? "Lu" : "Non lu"}'),
              Text('Notification activée: ${notification.isEnabled ? "Oui" : "Non"}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme la mise à jour
              },
              child: Text('Fermer'),
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
        title: Text('Gérer les Notifications'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                notification.isRead ? Icons.done : Icons.markunread,
                color: notification.isRead ? Colors.green : Colors.blue,
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: notification.isRead ? Colors.grey : Colors.black,
                ),
              ),
              subtitle: Text(
                notification.message,
                style: TextStyle(
                  color: notification.isRead ? Colors.grey : Colors.black,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bouton pour activer/désactiver la notification
                  IconButton(
                    icon: Icon(
                      notification.isEnabled ? Icons.notifications : Icons.notifications_off,
                      color: notification.isEnabled ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () => _toggleNotificationStatus(index),
                  ),
                  // Bouton pour supprimer la notification
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteNotification(index),
                  ),
                ],
              ),
              onTap: () {
                _toggleReadStatus(index); // Marquer comme lue/non lue
                _showNotificationDetails(context, notification); // Afficher les détails de la notification
              },
            ),
          );
        },
      ),
    );
  }
}

class TeacherHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espace Professeur'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Titre de l'écran
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigation vers l'écran des notifications
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
            child: Text("Gérer les Notifications"),
          ),
        ],
      ),
    );
  }
}
