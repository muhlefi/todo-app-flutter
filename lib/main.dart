import 'package:flutter/material.dart';
import 'screens/main_layout.dart';
import 'theme/app_theme.dart';
import 'providers/task_provider.dart';

void main() {
  runApp(
    TaskProviderScope(
      notifier: TaskProvider(),
      child: const TaskApp(),
    ),
  );
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainLayout(),
    );
  }
}
