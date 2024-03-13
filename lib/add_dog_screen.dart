import 'package:flutter/material.dart';
import 'package:sql_database_flutter/database_helper.dart';

import 'dog.dart';

class AddDogScreen extends StatefulWidget {
  @override
  _AddDogScreenState createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  late String name;
  late int age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dog'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                age = int.parse(value);
              },
              decoration: InputDecoration(
                labelText: 'Age',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                DatabaseHelper.insertDog(Dog(name: name, age: age));
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
