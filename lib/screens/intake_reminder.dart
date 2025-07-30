import 'package:flutter/material.dart';
import '../database/sqlite_helper.dart';

class IntakeReminderPage extends StatefulWidget {
  const IntakeReminderPage({super.key});

  @override
  State<IntakeReminderPage> createState() => _IntakeReminderPageState();
}

class _IntakeReminderPageState extends State<IntakeReminderPage> {
  final _medicineController = TextEditingController();
  TimeOfDay? _selectedTime;
  List<Map<String, dynamic>> _reminders = [];

  @override
  void initState() {
    super.initState();
    _refreshReminders();
  }

  Future<void> _refreshReminders() async {
    final data = await SQLiteHelper.instance.getAllReminders();
    setState(() {
      _reminders = data;
    });
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _addReminder() async {
    if (_medicineController.text.isEmpty || _selectedTime == null) return;

    final formattedTime = _selectedTime!.format(context);

    await SQLiteHelper.instance.insertReminder({
      'name': _medicineController.text,
      'time': formattedTime,
    });

    _medicineController.clear();
    _selectedTime = null;
    _refreshReminders();
  }

  Future<void> _deleteReminder(int id) async {
    await SQLiteHelper.instance.deleteReminder(id);
    _refreshReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Intake Reminder')),
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
                  onPressed: _pickTime,
                  child: const Text('Pick Time'),
                ),
                const SizedBox(width: 10),
                Text(
                  _selectedTime == null
                      ? 'No Time'
                      : _selectedTime!.format(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addReminder,
              child: const Text('Add Reminder'),
            ),
            const Divider(),
            Expanded(
              child: _reminders.isEmpty
                  ? const Center(child: Text('No reminders added yet.'))
                  : ListView.builder(
                      itemCount: _reminders.length,
                      itemBuilder: (context, index) {
                        final item = _reminders[index];
                        return ListTile(
                          title: Text(item['name']),
                          subtitle: Text('Reminder at: ${item['time']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteReminder(item['id']),
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
