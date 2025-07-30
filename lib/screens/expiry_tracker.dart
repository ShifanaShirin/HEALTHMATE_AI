import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/sqlite_helper.dart';

class ExpiryTrackerPage extends StatefulWidget {
  const ExpiryTrackerPage({super.key});

  @override
  ExpiryTrackerPageState createState() => ExpiryTrackerPageState();
}

class ExpiryTrackerPageState extends State<ExpiryTrackerPage> {
  final _medicineController = TextEditingController();
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _medicines = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await SQLiteHelper.instance.getAllMedicines();
    setState(() {
      _medicines = data;
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _addMedicine() async {
    if (_medicineController.text.isEmpty || _selectedDate == null) return;

    await SQLiteHelper.instance.insertMedicine({
      'name': _medicineController.text,
      'expiryDate': DateFormat('yyyy-MM-dd').format(_selectedDate!)
    });

    _medicineController.clear();
    _selectedDate = null;
    _refreshData();
  }

  Future<void> _deleteMedicine(int id) async {
    await SQLiteHelper.instance.deleteMedicine(id);
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Expiry Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _medicineController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text('Pick Expiry Date'),
                ),
                const SizedBox(width: 10),
                Text(
                  _selectedDate == null
                      ? 'No Date'
                      : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addMedicine,
              child: const Text('Add Medicine'),
            ),
            const Divider(),
            Expanded(
              child: _medicines.isEmpty
                  ? const Center(child: Text('No medicines added yet.'))
                  : ListView.builder(
                      itemCount: _medicines.length,
                      itemBuilder: (context, index) {
                        final item = _medicines[index];
                        return ListTile(
                          title: Text(item['name']),
                          subtitle:
                              Text('Expires on: ${item['expiryDate']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteMedicine(item['id']),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
