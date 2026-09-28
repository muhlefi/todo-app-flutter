import 'package:flutter/material.dart';
import '../../providers/task_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/task_item.dart';
import '../../widgets/empty_state.dart';
import '../task/task_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = TaskProviderScope.of(context);
    final todayTasks = provider.todayTasks;
    final allTasks = provider.tasks;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person_outline, size: 28),
          onPressed: () {},
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, size: 28), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none, size: 28), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: allTasks.isEmpty
            ? const EmptyState(title: 'No Tasks', message: 'You have no tasks.\nTap + to add one.')
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today.', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(
                      '${DateTime.now().day} ${_getMonth(DateTime.now().month)} ${DateTime.now().year}',
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.black87, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 32),
                    
                    if (todayTasks.isNotEmpty) ...[
                      Row(
                        children: [
                          const Text('Today', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: AppTheme.lightMint, borderRadius: BorderRadius.circular(12)),
                            child: Text('${todayTasks.length}', style: const TextStyle(fontSize: 12, color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_up, color: Colors.black38),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTodayCard(context, todayTasks.first, provider),
                      const SizedBox(height: 36),
                    ],

                    Row(
                      children: [
                        const Text('Workspace', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                          child: Text('${allTasks.length}', style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_up, color: Colors.black38),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ...allTasks.map((task) => Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: TaskItemWidget(task: task),
                    )),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTodayCard(BuildContext context, task, TaskProvider provider) {
    return Material(
      color: AppTheme.lightMint,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: task.id))),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => provider.toggleTaskStatus(task.id),
                child: Container(
                  margin: const EdgeInsets.only(top: 2, right: 16),
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    color: task.isDone ? AppTheme.primaryGreen : Colors.transparent,
                    border: Border.all(color: task.isDone ? AppTheme.primaryGreen : AppTheme.primaryGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: task.isDone ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.primaryGreen, decoration: task.isDone ? TextDecoration.lineThrough : null)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('${task.dueDate.day} ${_getMonth(task.dueDate.month)} ${task.dueDate.year}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.primaryGreen)),
                        const SizedBox(width: 20),
                        Text('${task.dueDate.hour.toString().padLeft(2, '0')}:${task.dueDate.minute.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.primaryGreen.withValues(alpha: 0.8))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMonth(int m) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[m - 1];
  }
}
