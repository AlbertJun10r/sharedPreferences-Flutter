import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './controllers/task_provider.dart';
import './views/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return MaterialApp(
      title: 'To-Do App',
      theme: taskProvider.isDarkTheme
        ? ThemeData.dark()
        : ThemeData.light().copyWith(primaryColor: Colors.blueAccent),
      home: HomeScreen(),
    );
  }
}
