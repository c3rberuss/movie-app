import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db _db = Db._internal();

  Database _database;

  Database get database => _database;

  factory Db() {
    return _db;
  }

  Db._internal();

  Future<void> openDb(String databaseName) async {
    _database = await openDatabase(
      join(await getDatabasesPath(), databaseName, '.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE watchlist (imdbID	TEXT PRIMARY KEY, Title	TEXT, Year	TEXT, Type	TEXT, Poster	TEXT )",
        );
      },
      version: 1,
    );
  }
}
