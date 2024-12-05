import 'package:flutter/material.dart';

void main() {
  runApp(ReminderApp());
}

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReminderScreen(),
    );
  }
}

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> reminders = [
    {"title": "Buy groceries", "completed": false},
    {"title": "Call mom", "completed": false},
    {"title": "Finish Flutter project", "completed": false},
  ];

  void _addReminder() {
    showDialog(
      context: context,
      builder: (context) {
        String newReminder = "";
        return AlertDialog(
          title: Text("Add New Reminder"),
          content: TextField(
            onChanged: (value) {
              newReminder = value;
            },
            decoration: InputDecoration(hintText: "Enter reminder title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newReminder.isNotEmpty) {
                  setState(() {
                    reminders.add({"title": newReminder, "completed": false});
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _toggleCompletion(int index) {
    setState(() {
      reminders[index]["completed"] = !reminders[index]["completed"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminders"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Checkbox(
                value: reminders[index]["completed"],
                onChanged: (value) {
                  _toggleCompletion(index);
                },
              ),
              title: Text(
                reminders[index]["title"],
                style: TextStyle(
                  decoration: reminders[index]["completed"]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        child: Icon(Icons.add),
        tooltip: "Add Reminder",
      ),
    );
  }
}
