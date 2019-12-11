import 'package:extremecore/core.dart';

class LocalStorage {
  static Database database;
  static init() async {
    database = await openDatabase("db.sqlite", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE local_storage (key TEXT, value BLOB)');
    });
  }

  static save(key, value) async {
    if (database == null) await init();

    await database.execute("delete from local_storage where key = ?", [key]);
    await database.execute("insert into local_storage values(?,?)", [
      key,
      value,
    ]);
  }

  static load(String key) async {
    if (database == null) await init();

    List<Map> list = await database
        .rawQuery('SELECT * FROM local_storage where key = ?', [key]);

    if (list.length > 0) {
      return list[0]["value"];
    }
    return null;
  }
}

class LS extends LocalStorage {}
