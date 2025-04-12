import 'package:flutter/material.dart';

class StudentResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> results;
  final double average;

  const StudentResultsScreen({
    Key? key,
    required this.results,
    required this.average,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Moyenne Générale : ${average.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: results.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final item = results[index];
                  return ListTile(
                    leading: Icon(Icons.book),
                    title: Text(item['course']),
                    trailing: Text(
                      '${item['grade']}/20',
                      style: TextStyle(
                        color: item['grade'] >= 10 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
