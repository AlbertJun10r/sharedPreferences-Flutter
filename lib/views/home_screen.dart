import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_provider.dart';
import '../models/task.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
        actions: [
          Switch(
            value: taskProvider.isDarkTheme,
            onChanged: (value) => taskProvider.toggleTheme(),
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Idioma: ', style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: taskProvider.selectedLanguage,
                  onChanged: (newLanguage) {
                    taskProvider.setLanguage(newLanguage!);
                  },
                  items: taskProvider.languages.map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),
              ],
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  final task = Task(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  taskProvider.addTask(task);
                  _titleController.clear();
                  _descriptionController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: Text('Añadir Tarea'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskProvider.tasks[index];
                  return Card(
                    color: task.completed ? Colors.lightBlue[50] : Colors.white,
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(task.description),
                      leading: Icon(
                        task.completed
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task.completed ? Colors.green : Colors.grey,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => taskProvider.deleteTask(task.id!),
                      ),
                      onTap: () => taskProvider.toggleTaskStatus(task.id!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
