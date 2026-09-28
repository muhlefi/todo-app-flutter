import 'package:flutter/material.dart';
import '../../providers/task_provider.dart';
import '../../theme/app_theme.dart';
import '../../models/task.dart' as model;
import 'dart:math';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'Design';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: const Text('Create New Task'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('What do you want to do?', style: TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87),
              decoration: const InputDecoration(hintText: 'e.g. Design UI for app', hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black26), border: InputBorder.none),
            ),
            const SizedBox(height: 32),
            const Text('Workspace', style: TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: ['Research', 'Design', 'Development'].map((cat) => _buildChip(cat, isSelected: _selectedCategory == cat)).toList(),
            ),
            const SizedBox(height: 32),
            const Text('Description', style: TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              maxLines: 3,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(hintText: 'Add description...', hintStyle: const TextStyle(color: Colors.black26), filled: true, fillColor: Colors.grey[50], border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
            ),
            const SizedBox(height: 32),
            const Text('Due Date', style: TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2000), lastDate: DateTime(2100));
                if (date != null) {
                  if (!context.mounted) return;
                  final time = await showTimePicker(context: context, initialTime: _selectedTime);
                  if (time != null) {
                    setState(() {
                      _selectedDate = date;
                      _selectedTime = time;
                    });
                  }
                }
              },
              child: Row(
                children: [
                  Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.calendar_today_outlined, color: Colors.black54)),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} ${_selectedTime.format(context)}', style: const TextStyle(fontSize: 13, color: Colors.black45)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () {
              if (_titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a title'), backgroundColor: Colors.redAccent));
                return;
              }
              final due = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
              final task = model.Task(id: Random().nextInt(10000).toString(), title: _titleController.text, description: _descController.text, category: _selectedCategory, dueDate: due);
              TaskProviderScope.of(context).addTask(task);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task Created!'), backgroundColor: AppTheme.primaryGreen));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
            child: const Text('Save Task', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, {required bool isSelected}) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(color: isSelected ? AppTheme.primaryGreen : Colors.grey[100], borderRadius: BorderRadius.circular(20)),
        child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontWeight: FontWeight.w600, fontSize: 14)),
      ),
    );
  }
}
