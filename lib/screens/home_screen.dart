import 'package:flutter/material.dart';
import 'list_screen.dart';
import '../models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final String? studentData = prefs.getString('students');
    if (studentData != null) {
      final List decodedData = jsonDecode(studentData);
      setState(() {
        _students = decodedData.map((data) => Student.fromJson(data)).toList();
      });
    }
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(_students.map((s) => s.toJson()).toList());
    await prefs.setString('students', encodedData);
  }

  void _addStudent() {
    final String name = _nameController.text;
    final int? age = int.tryParse(_ageController.text);
    final String course = _courseController.text;

    if (name.isNotEmpty && age != null && course.isNotEmpty) {
      setState(() {
        _students.add(Student(name: name, age: age, course: course));
      });
      _saveStudents();
      _nameController.clear();
      _ageController.clear();
      _courseController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Form')),
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: _courseController,
                decoration: InputDecoration(labelText: 'Course'),
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _addStudent, child: Text('Add Student')),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListScreen(students: _students),
                    ),
                  );
                },
                child: Text('View Students'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
