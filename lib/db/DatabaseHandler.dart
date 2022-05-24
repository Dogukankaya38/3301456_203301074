import 'package:hospital_app/entity/MessageDto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE nots(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }
  Future<int> insertUser(MessageDto nots) async {
    int result = 0;
    final Database db = await initializeDB();
      result = await db.insert('nots', nots.toMap());
    return result;
  }
  Future<List<MessageDto>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('nots');
    return queryResult.map((e) => MessageDto.fromMap(e)).toList();
  }
}