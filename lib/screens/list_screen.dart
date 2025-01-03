import 'package:flutter/material.dart';
import '../models/student.dart';
import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  final List<Student> students;

  ListScreen({required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student List')),
      body: students.isEmpty
          ? Center(child: Text('No students added yet!'))
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                child: Text(student.name[0].toUpperCase()),
              ),
              title: Text(student.name, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Age: ${student.age}, Course: ${student.course}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(student: student),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
