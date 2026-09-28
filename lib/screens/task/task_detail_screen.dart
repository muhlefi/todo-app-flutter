import 'package:flutter/material.dart';
import '../../providers/task_provider.dart';
import '../../theme/app_theme.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final provider = TaskProviderScope.of(context);
    final taskIndex = provider.tasks.indexWhere((t) => t.id == taskId);
    
    if (taskIndex == -1) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Task not found')),
      );
    }
    
    final task = provider.tasks[taskIndex];
    int completedSubtasks = task.subtasks.where((s) => s.isDone).length;
    double progress = task.subtasks.isEmpty ? (task.isDone ? 1.0 : 0.0) : (completedSubtasks / task.subtasks.length);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textDark), 
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: const Text('Delete Task'),
                  content: const Text('Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.black54))),
                    TextButton(
                      onPressed: () {
                        provider.deleteTask(task.id);
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task deleted!'), backgroundColor: Colors.redAccent));
                      }, 
                      child: const Text('Delete', style: TextStyle(color: Colors.redAccent))
                    ),
                  ],
                )
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.lightMint,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      task.category.toUpperCase(), 
                      style: const TextStyle(color: AppTheme.primaryGreen, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.5)
                    ),
                  ),
                  if (task.dueDate.day == DateTime.now().day && task.dueDate.month == DateTime.now().month && task.dueDate.year == DateTime.now().year)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
                      child: Text('Due Today', style: TextStyle(fontSize: 12, color: Colors.orange.shade800, fontWeight: FontWeight.w700)),
                    )
                ],
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                task.title, 
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.textDark, height: 1.3)
              ),
              const SizedBox(height: 24),
              // Time & Date
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.access_time_filled, color: AppTheme.textGray, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Time', style: TextStyle(fontSize: 12, color: AppTheme.textGray, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('${task.dueDate.hour.toString().padLeft(2, '0')}:${task.dueDate.minute.toString().padLeft(2, '0')}', style: const TextStyle(fontSize: 16, color: AppTheme.textDark, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.calendar_month, color: AppTheme.textGray, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date', style: TextStyle(fontSize: 12, color: AppTheme.textGray, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}', style: const TextStyle(fontSize: 16, color: AppTheme.textDark, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 36),
              
              // Progress Bar if subtasks exist
              if (task.subtasks.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                    Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.primaryGreen)),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                  ),
                ),
                const SizedBox(height: 36),
              ],
              
              // Description Box
              const Text('Description', style: TextStyle(color: AppTheme.textDark, fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  task.description.isEmpty ? 'No description provided.' : task.description, 
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade700, fontWeight: FontWeight.w500, height: 1.6)
                ),
              ),
              
              // Subtasks
              if (task.subtasks.isNotEmpty) ...[
                const SizedBox(height: 36),
                const Text('To-Do List', style: TextStyle(color: AppTheme.textDark, fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 16),
                ...task.subtasks.map((st) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildTodoItem(st.title, st.isDone, () => provider.toggleSubtaskStatus(task.id, st.id)),
                )),
              ],
              const SizedBox(height: 100), // bottom padding for floating button
            ],
          ),
        ),
      ),
      floatingActionButton: !task.isDone ? FloatingActionButton.extended(
        onPressed: () {
          provider.toggleTaskStatus(task.id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task marked as completed!'), backgroundColor: AppTheme.primaryGreen));
          Navigator.pop(context);
        },
        backgroundColor: AppTheme.primaryGreen,
        icon: const Icon(Icons.check, color: Colors.white, size: 24),
        label: const Text("Complete Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        elevation: 4,
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTodoItem(String label, bool isDone, VoidCallback onTap) {
    return Material(
      color: isDone ? AppTheme.lightMint : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isDone ? AppTheme.primaryGreen.withValues(alpha: 0.5) : Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Row(
            children: [
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: isDone ? AppTheme.primaryGreen : Colors.transparent,
                  border: Border.all(color: isDone ? AppTheme.primaryGreen : Colors.grey.shade400, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isDone ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label, 
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: isDone ? FontWeight.w500 : FontWeight.w600, 
                    color: isDone ? AppTheme.primaryGreen : AppTheme.textDark, 
                    decoration: isDone ? TextDecoration.lineThrough : null
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
