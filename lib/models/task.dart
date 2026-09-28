class SubTask {
  String id;
  String title;
  bool isDone;

  SubTask({required this.id, required this.title, this.isDone = false});
}

class Task {
  String id;
  String title;
  DateTime dueDate;
  String category;
  String description;
  bool isDone;
  List<SubTask> subtasks;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.category = 'General',
    this.description = '',
    this.isDone = false,
    this.subtasks = const [],
  });
}
