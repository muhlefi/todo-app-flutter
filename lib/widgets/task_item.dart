import 'package:flutter/material.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../theme/app_theme.dart';
import '../screens/task/task_detail_screen.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = TaskProviderScope.of(context);
    final isToday = task.dueDate.year == DateTime.now().year && 
                    task.dueDate.month == DateTime.now().month && 
                    task.dueDate.day == DateTime.now().day;
    final timeStr = "${task.dueDate.hour.toString().padLeft(2, '0')}:${task.dueDate.minute.toString().padLeft(2, '0')}";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: task.id)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => provider.toggleTaskStatus(task.id),
            child: Container(
              margin: const EdgeInsets.only(top: 2, right: 16),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: task.isDone ? AppTheme.primaryGreen : Colors.transparent,
                border: Border.all(
                  color: task.isDone ? AppTheme.primaryGreen : Colors.black12, 
                  width: 1.5
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: task.isDone 
                  ? const Icon(Icons.check, size: 16, color: Colors.white) 
                  : null,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (isToday) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.lightMint,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Text(
                      timeStr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (task.subtasks.isNotEmpty) ...[
                      const SizedBox(width: 16),
                      const Icon(Icons.tune, size: 14, color: AppTheme.textGray),
                      const SizedBox(width: 4),
                      Text(
                        '${task.subtasks.where((s) => s.isDone).length}/${task.subtasks.length}',
                        style: const TextStyle(fontSize: 12, color: AppTheme.textGray, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ],
                ),
                if (task.subtasks.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ...task.subtasks.map((subtask) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => provider.toggleSubtaskStatus(task.id, subtask.id),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: subtask.isDone ? AppTheme.primaryGreen : Colors.transparent,
                              border: Border.all(
                                color: subtask.isDone ? AppTheme.primaryGreen : Colors.black12,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: subtask.isDone
                                ? const Icon(Icons.check, size: 14, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          subtask.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                            decoration: subtask.isDone ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ],
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
