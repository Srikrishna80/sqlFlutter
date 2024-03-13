import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dog.dart';

class DatabaseHelper {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertDog(Dog dog) async {
    final db = await database();
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Dog>> dogs() async {
    final db = await database();
    final List<Map<String, Object?>> dogMaps = await db.query('dogs');
    return [
      for (final {
            'id': id,
            'name': name,
            'age': age,
          } in dogMaps)
        Dog(id: id as int, name: name as String, age: age as int),
    ];
  }

  static Future<void> updateDog(Dog dog) async {
    final db = await database();
    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
  }

  static Future<void> deleteDog(int id) async {
    final db = await database();
    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
