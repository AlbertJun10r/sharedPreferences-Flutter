import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_database.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
final TaskDatabase _taskDatabase = TaskDatabase.instance;

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _tasks = await _taskDatabase.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskDatabase.insertTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> toggleTaskStatus(int id) async {
    final task = _tasks.firstWhere((t) => t.id == id);
    task.completed = !task.completed;
    await _taskDatabase.updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await _taskDatabase.deleteTask(id);
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  String _selectedLanguage = 'Español';
  final List<String> languages = ['Inglés', 'Español', 'Francés'];

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

}
