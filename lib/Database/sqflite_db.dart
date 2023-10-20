import 'dart:developer';
import 'package:git_hub_api/model/db_model.dart';
import 'package:git_hub_api/model/github_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GithubRepositoryDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final dbpath = await getDatabasesPath();
    String path = join(dbpath, 'database.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
   CREATE TABLE github_repositories (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name TEXT,
     fullName TEXT,
     description TEXT,
     stargazersCount INTEGER,
     avatarUrl TEXT
   )
''');
  }

  Future insertGithubRepository(List<GithubRepository> allDataList) async {
    try {
      final db = await database;

      if (allDataList.isEmpty) return;

      bool doesTableExist = await isTableExists('github_repositories');

      if (doesTableExist) {
        await db.transaction((txn) async {
          for (GithubRepository repo in allDataList) {
            print(' name == ${repo.name} fullname == ${repo.fullName} des == ${repo.description} star ==  ${repo.stargazersCount}  avathar == ${repo.owner.avatarUrl}   ////////////////\\\\\\\\');
            await txn.insert(
              'github_repositories',
              {
                'name': repo.name,
                'fullName': repo.fullName,
                'description': repo.description,
                'stargazersCount': repo.stargazersCount,
                'avatarUrl': repo.owner.avatarUrl,
              },
            );
          }
        });
      } else {
        log('not existing');
      }

      log('data added successfully');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> dropTable() async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS github_repositories');

    print(await isTableExists('github_repositories'));
  }

  Future<List<Db>> getDataFromDb() async {
    try {
      final db = await database;

      bool doesTableExist = await isTableExists('github_repositories');
      if (!doesTableExist) {
        return [];
      }

      final alldata = await db.query('github_repositories');

      final dbData = alldata.map((e) => Db.fromJson(e)).toList();

      return dbData;
    } catch (e) {
      log(e.toString());

      throw 'failed get data from datbase';
    }
  }

  Future<bool> isTableExists(String tableName) async {
    final db = await database;
    List<Map<String, dynamic>> tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return tables.isNotEmpty;
  }
}
