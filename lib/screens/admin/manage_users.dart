import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  static String routeName = '/manageUsers';

  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<Map<String, String>> users = List.generate(
    10,
        (index) => {
      'name': 'User ${index + 1}',
      'email': 'user${index + 1}@email.com',
      'role': index % 2 == 0 ? 'Parent' : 'Enseignant'
    },
  );

  List<Map<String, String>> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) => user['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addUser(String name, String email, String role) {
    setState(() {
      users.add({'name': name, 'email': email, 'role': role});
      filteredUsers = users;
    });
    Navigator.pop(context);
  }

  void editUser(int index, String name, String email, String role) {
    setState(() {
      users[index] = {'name': name, 'email': email, 'role': role};
      filteredUsers = users;
    });
    Navigator.pop(context);
  }

  void deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmer la suppression', style: TextStyle(fontSize: 18)),
        content: Text('Voulez-vous vraiment supprimer cet utilisateur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler', style: TextStyle(fontSize: 14)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                users.removeAt(index);
                filteredUsers = users;
              });
              Navigator.pop(context);
            },
            child: Text('Supprimer', style: TextStyle(color: Colors.red, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  void showUserForm({int? index}) {
    final nameController = TextEditingController(text: index != null ? users[index]['name'] : '');
    final emailController = TextEditingController(text: index != null ? users[index]['email'] : '');
    String selectedRole = index != null ? users[index]['role']! : 'Parent';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                index == null ? 'Ajouter un utilisateur' : 'Modifier l’utilisateur',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nom', labelStyle: TextStyle(fontSize: 14)),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 14)),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                value: selectedRole,
                items: ['Parent', 'Enseignant']
                    .map((role) => DropdownMenuItem(value: role, child: Text(role, style: TextStyle(fontSize: 14))))
                    .toList(),
                onChanged: (value) => selectedRole = value as String,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (index == null) {
                    addUser(nameController.text, emailController.text, selectedRole);
                  } else {
                    editUser(index, nameController.text, emailController.text, selectedRole);
                  }
                },
                child: Text(index == null ? 'Ajouter' : 'Modifier', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gérer les utilisateurs", style: TextStyle(fontSize: 18)),
        backgroundColor: Color(0xFF345FB4),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Rechercher un utilisateur...",
                hintStyle: TextStyle(fontSize: 14),
                prefixIcon: Icon(Icons.search, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: filterUsers,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Color(0xFF345FB4), size: 24),
                    title: Text(filteredUsers[index]['name']!, style: TextStyle(fontSize: 16)),
                    subtitle: Text(
                      '${filteredUsers[index]['email']}\nRole: ${filteredUsers[index]['role']}',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green, size: 20),
                          onPressed: () => showUserForm(index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red, size: 20),
                          onPressed: () => deleteUser(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF345FB4),
        onPressed: () => showUserForm(),
        child: Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
