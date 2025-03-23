import 'package:flutter/material.dart';

class ManagePaymentsScreen extends StatefulWidget {
  static const String routeName = '/managePayments';
  const ManagePaymentsScreen({super.key});

  @override
  _ManagePaymentsScreenState createState() => _ManagePaymentsScreenState();
}

class _ManagePaymentsScreenState extends State<ManagePaymentsScreen> {
  List<Map<String, dynamic>> payments = [
    {'student': 'Ali', 'amount': 100.0, 'status': 'Payé'},
    {'student': 'Sara', 'amount': 50.0, 'status': 'Non payé'},
    {'student': 'Amine', 'amount': 75.0, 'status': 'Payé'},
    {'student': 'Lina', 'amount': 30.0, 'status': 'Non payé'},
  ];
  List<Map<String, dynamic>> filteredPayments = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredPayments = payments;
  }

  void _filterPayments(String query) {
    setState(() {
      searchQuery = query;
      filteredPayments = payments
          .where((payment) => payment['student'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addPayment(String student, double amount, String status) {
    setState(() {
      payments.add({
        'student': student,
        'amount': amount,
        'status': status,
      });
      _filterPayments(searchQuery); // Re-filter after adding a payment
    });
  }

  void _deletePayment(int index) {
    setState(() {
      payments.removeAt(index);
      _filterPayments(searchQuery); // Re-filter after deleting a payment
    });
  }

  void _updatePayment(int index, String status) {
    setState(() {
      payments[index]['status'] = status;
      _filterPayments(searchQuery); // Re-filter after updating a payment
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("💳 Gestion des paiements"),
        backgroundColor: Color(0xFF345FB4),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddPaymentDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader("💳 Gestion des paiements"),
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: filteredPayments.length,
              itemBuilder: (context, index) {
                final payment = filteredPayments[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text("Élève: ${payment['student']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text("Montant: ${payment['amount']} | Statut: ${payment['status']}",
                        style: TextStyle(color: Colors.grey)),
                    trailing: payment['status'] == 'Payé'
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.cancel, color: Colors.red),
                    onTap: () => _updatePayment(index, payment['status'] == 'Payé' ? 'Non payé' : 'Payé'),
                    onLongPress: () => _deletePayment(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xFF345FB4),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        onChanged: _filterPayments,
        decoration: InputDecoration(
          hintText: 'Rechercher par nom...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  void _showAddPaymentDialog() {
    final studentController = TextEditingController();
    final amountController = TextEditingController();
    String status = 'Non payé';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Ajouter un paiement", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: studentController,
                decoration: InputDecoration(
                  labelText: "Nom de l'élève",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: "Montant",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: status,
                onChanged: (newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
                items: ['Payé', 'Non payé']
                    .map((statusOption) => DropdownMenuItem<String>(
                  value: statusOption,
                  child: Text(statusOption),
                ))
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                if (studentController.text.isNotEmpty && amountController.text.isNotEmpty) {
                  _addPayment(
                    studentController.text,
                    double.parse(amountController.text),
                    status,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }
}
