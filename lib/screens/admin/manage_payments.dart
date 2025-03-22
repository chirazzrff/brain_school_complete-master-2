import 'package:flutter/material.dart';

class ManagePaymentsScreen extends StatefulWidget {
  static const String routeName = '/managePayments';

  @override
  _ManagePaymentsScreenState createState() => _ManagePaymentsScreenState();
}

class _ManagePaymentsScreenState extends State<ManagePaymentsScreen> {
  final List<Map<String, dynamic>> _payments = [
    {'id': 1, 'student': 'Ali', 'amount': 100, 'date': '2025-03-22', 'status': 'Payé'},
    {'id': 2, 'student': 'Sofia', 'amount': 200, 'date': '2025-03-20', 'status': 'En attente'},
  ];

  String _searchQuery = "";
  String _selectedStatus = "Tous";
  final List<String> _statusOptions = ["Tous", "Payé", "En attente", "En retard"];

  void _addOrEditPayment({Map<String, dynamic>? payment}) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController studentController =
        TextEditingController(text: payment?['student'] ?? '');
        TextEditingController amountController =
        TextEditingController(text: payment?['amount']?.toString() ?? '');
        String selectedStatus = payment?['status'] ?? 'Payé';

        return AlertDialog(
          title: Text(payment == null ? 'Ajouter un paiement' : 'Modifier le paiement',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: studentController,
                decoration: InputDecoration(labelText: 'Élève', labelStyle: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Montant', labelStyle: TextStyle(fontSize: 16)),
              ),
              DropdownButtonFormField(
                value: selectedStatus,
                onChanged: (value) => selectedStatus = value as String,
                items: _statusOptions.skip(1).map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status, style: TextStyle(fontSize: 16)),
                )).toList(),
                decoration: InputDecoration(labelText: 'Statut', labelStyle: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Annuler', style: TextStyle(fontSize: 16))),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (payment == null) {
                    _payments.add({
                      'id': _payments.length + 1,
                      'student': studentController.text,
                      'amount': double.parse(amountController.text),
                      'date': DateTime.now().toIso8601String().split('T')[0],
                      'status': selectedStatus,
                    });
                  } else {
                    payment['student'] = studentController.text;
                    payment['amount'] = double.parse(amountController.text);
                    payment['status'] = selectedStatus;
                  }
                });
                Navigator.pop(context);
              },
              child: Text(payment == null ? 'Ajouter' : 'Modifier', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  void _deletePayment(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer ce paiement ?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: Text('Cette action est irréversible.', style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler', style: TextStyle(fontSize: 16))),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _payments.removeWhere((payment) => payment['id'] == id);
              });
              Navigator.pop(context);
            },
            child: Text('Supprimer', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPayments = _payments.where((payment) {
      return (_searchQuery.isEmpty || payment['student'].toLowerCase().contains(_searchQuery.toLowerCase())) &&
          (_selectedStatus == "Tous" || payment['status'] == _selectedStatus);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Gérer les paiements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF345FB4),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey, size: 24), // Icône de recherche
                      contentPadding: EdgeInsets.symmetric(vertical: 8), // Taille ajustée
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF345FB4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _selectedStatus,
                      onChanged: (value) => setState(() => _selectedStatus = value as String),
                      items: _statusOptions.map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status, style: TextStyle(fontSize: 14, color: Colors.white)),
                      )).toList(),
                      dropdownColor: Color(0xFF345FB4),
                      style: TextStyle(color: Colors.white),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: filteredPayments.map((payment) => Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: Icon(Icons.payment, color: Color(0xFF345FB4), size: 28),
                    title: Text('${payment['student']} - ${payment['amount']} DZD',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    subtitle: Text('${payment['date']} - ${payment['status']}',
                        style: TextStyle(fontSize: 14, color: payment['status'] == 'Payé' ? Colors.green : (payment['status'] == 'En retard' ? Colors.red : Colors.orange))),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.edit, color: Colors.blue, size: 22),
                            onPressed: () => _addOrEditPayment(payment: payment)),
                        IconButton(icon: Icon(Icons.delete, color: Colors.red, size: 22),
                            onPressed: () => _deletePayment(payment['id'])),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF345FB4),
        onPressed: () => _addOrEditPayment(),
        child: Icon(Icons.add, size: 26),
      ),
    );
  }
}
