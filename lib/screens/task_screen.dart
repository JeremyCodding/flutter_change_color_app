import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> _tasks = [];
  TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJson = prefs.getStringList('tasks') ?? [];
    List<Map<String, dynamic>> tasks = tasksJson.map((taskJson) => jsonDecode(taskJson) as Map<String, dynamic>).toList();
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJson = _tasks.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList('tasks', tasksJson);
  }

  void _addTask(String task) {
    if(task != ''){
      setState(() {
        _tasks.add({'text': task, 'completed': false});
      });
      _saveTasks();
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed'];
    });
    _saveTasks();
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Enter a task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTask(_taskController.text);
              _taskController.clear();
            },
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: _tasks[index]['completed'] ? Colors.green : Colors.white,
                  child: ListTile(
                    title: Text(_tasks[index]['text']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            _toggleTaskCompletion(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTask(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}