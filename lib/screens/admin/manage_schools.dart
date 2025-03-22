import 'package:flutter/material.dart';

class ManageSchoolsScreen extends StatefulWidget {
  static const String routeName = '/manageSchools';

  @override
  _ManageSchoolsScreenState createState() => _ManageSchoolsScreenState();
}

class _ManageSchoolsScreenState extends State<ManageSchoolsScreen> {
  List<Map<String, String>> schools = [
    {'name': 'Ecole Alpha', 'address': '123 Rue Principale', 'director': 'Mr. Ahmed'},
    {'name': 'Ecole Beta', 'address': '456 Avenue Centrale', 'director': 'Mme. Sarah'},
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredSchools = [];

  @override
  void initState() {
    super.initState();
    filteredSchools = List.from(schools);
  }

  void addSchool(String name, String address, String director) {
    setState(() {
      schools.add({'name': name, 'address': address, 'director': director});
      filteredSchools = List.from(schools);
    });
  }

  void deleteSchool(int index) {
    setState(() {
      schools.removeAt(index);
      filteredSchools = List.from(schools);
    });
  }

  void searchSchool(String query) {
    setState(() {
      filteredSchools = schools
          .where((school) => school['name']!.toLowerCase().contains(query.toLowerCase())
          || school['address']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Color(0xFF345FB4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Gérer les écoles",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Liste des écoles enregistrées",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              onChanged: searchSchool,
              decoration: InputDecoration(
                hintText: "Rechercher une école...",
                hintStyle: TextStyle(fontSize: 14),
                prefixIcon: Icon(Icons.search, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchools.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.school, color: Color(0xFF345FB4), size: 24),
                    title: Text(filteredSchools[index]['name']!, style: TextStyle(fontSize: 16)),
                    subtitle: Text(
                      "${filteredSchools[index]['address']}\nDir: ${filteredSchools[index]['director']}",
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Confirmer la suppression", style: TextStyle(fontSize: 18)),
                            content: Text("Voulez-vous vraiment supprimer cette école ?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: Text("Annuler", style: TextStyle(fontSize: 14)),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteSchool(index);
                                  Navigator.pop(ctx);
                                },
                                child: Text("Supprimer", style: TextStyle(color: Colors.red, fontSize: 14)),
                              ),
                            ],
                          ),
                        );
                      },
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Ajouter une école", style: TextStyle(fontSize: 18)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(decoration: InputDecoration(labelText: "Nom de l'école", labelStyle: TextStyle(fontSize: 14))),
                  TextField(decoration: InputDecoration(labelText: "Adresse", labelStyle: TextStyle(fontSize: 14))),
                  TextField(decoration: InputDecoration(labelText: "Directeur", labelStyle: TextStyle(fontSize: 14))),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("Annuler", style: TextStyle(fontSize: 14)),
                ),
                TextButton(
                  onPressed: () {
                    addSchool("Nouvelle Ecole", "Adresse", "Directeur");
                    Navigator.pop(ctx);
                  },
                  child: Text("Ajouter", style: TextStyle(color: Colors.blue, fontSize: 14)),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
