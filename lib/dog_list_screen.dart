import 'package:flutter/material.dart';
import 'package:sql_database_flutter/add_dog_screen.dart';
import 'package:sql_database_flutter/database_helper.dart';

import 'dog.dart';

class DogListScreen extends StatefulWidget {
  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  late Future<List<Dog>> dogs;

  @override
  void initState() {
    super.initState();
    refreshDogList();
  }

  Future<void> refreshDogList() async {
    setState(() {
      dogs = DatabaseHelper.dogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog List'),
      ),
      body: Center(
        child: FutureBuilder<List<Dog>>(
          future: dogs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data!.length);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Dog dog = snapshot.data![index];
                  print(dog);
                  return ListTile(
                    title: Text(dog.name),
                    subtitle: Text('Age: ${dog.age}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        DatabaseHelper.deleteDog(dog?.id ?? 0);

                        refreshDogList();
                      },
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddDogScreen when floating action button is pressed.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDogScreen()),
          ).then((value) => refreshDogList());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
