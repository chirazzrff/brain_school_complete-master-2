import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Pour les graphiques

class ViewDataScreen extends StatelessWidget {
  static const String routeName = '/viewData';

  // Fonction pour récupérer les statistiques
  Map<String, String> getStatistics() {
    return {
      "Élèves": "350",
      "Enseignants": "45",
      "Paiements": "\\ €12,500"
    };
  }

  // Fonction pour récupérer les données du graphique
  List<PieChartSectionData> getChartData() {
    return [
      PieChartSectionData(value: 40, color: Colors.blue, title: "Payé"),
      PieChartSectionData(value: 30, color: Colors.orange, title: "En attente"),
      PieChartSectionData(value: 30, color: Colors.red, title: "En retard"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> stats = getStatistics();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // HEADER BLEU
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Color(0xFF345FB4),
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
                  "Statistiques",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Analyse des données clés 📊",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // STATISTIQUES RAPIDES
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: stats.entries
                  .map((entry) => StatCard(title: entry.key, value: entry.value))
                  .toList(),
            ),
          ),

          SizedBox(height: 20),

          // GRAPHIQUE
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        "Répartition des paiements",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sections: getChartData(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// WIDGET POUR LES STATS RAPIDES
class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
