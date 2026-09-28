import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Sharing UI Design - Basic',
      dueDate: DateTime.now(),
      category: 'Design',
      description: 'Make sure all Stakeholder available for the next meeting.',
    ),
    Task(
      id: '2',
      title: 'Research Product for UI8',
      dueDate: DateTime.now().add(const Duration(hours: 1)),
      category: 'Research',
    ),
    Task(
      id: '3',
      title: 'Create Action Plan for Product',
      dueDate: DateTime.now().add(const Duration(hours: 3)),
      category: 'Product',
      description: 'Action plan for phase 01',
      subtasks: [
        SubTask(id: '3-1', title: 'Research', isDone: true),
        SubTask(id: '3-2', title: 'Deffine'),
      ],
    ),
  ];

  List<Task> get tasks => _tasks;

  List<Task> get todayTasks {
    final now = DateTime.now();
    return _tasks.where((t) => t.dueDate.year == now.year && t.dueDate.month == now.month && t.dueDate.day == now.day).toList();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }
  }

  void toggleSubtaskStatus(String taskId, String subtaskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      final subIndex = _tasks[taskIndex].subtasks.indexWhere((s) => s.id == subtaskId);
      if (subIndex != -1) {
        _tasks[taskIndex].subtasks[subIndex].isDone = !_tasks[taskIndex].subtasks[subIndex].isDone;
        notifyListeners();
      }
    }
  }
}

class TaskProviderScope extends InheritedNotifier<TaskProvider> {
  const TaskProviderScope({
    super.key,
    required TaskProvider super.notifier,
    required super.child,
  });

  static TaskProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskProviderScope>()!.notifier!;
  }
}
