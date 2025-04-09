import 'package:flutter/material.dart';

class Notification {
  String title;
  String message;
  bool isRead;

  Notification({
    required this.title,
    required this.message,
    this.isRead = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Liste des notifications
  List<Notification> notifications = [
    Notification(title: 'Réunion importante', message: 'Il y a une réunion ce vendredi à 10h.', isRead: false),
    Notification(title: 'Changement de planning', message: 'Votre emploi du temps a été modifié.', isRead: true),
    Notification(title: 'Inspection', message: 'Préparez-vous pour une inspection lundi prochain.', isRead: false),
    // Ajoutez plus de notifications si nécessaire
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
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
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteNotification(index),
              ),
              onTap: () => _toggleReadStatus(index), // Marquer comme lue/non lue
            ),
          );
        },
      ),
    );
  }
}
