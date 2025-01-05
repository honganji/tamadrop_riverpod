import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DBInstantiation {
  static Future<Database> openDatabase() async {
    return _openDatabase();
  }
}

Future<void> _createVideosTable(Database database) async {
  await database.execute('''
        CREATE TABLE videos (
          id TEXT PRIMARY KEY,
          path TEXT,
          created_at TEXT,
          thumbnail_file_path TEXT,
          title TEXT,
          volume INTEGER,
          length INTEGER
        )
      ''');
}

Future<void> _createPVMiddleTable(Database database) async {
  await database.execute('''
      CREATE TABLE playlist_videos (
        pid INTEGER,
        vid TEXT,
        FOREIGN KEY (pid) REFERENCES playlists (id),
        FOREIGN KEY (vid) REFERENCES videos (id),
        PRIMARY KEY (pid, vid)
      )
    ''');
}

Future<void> _createPlaylistsTable(Database database) async {
  await database.execute('''
      CREATE TABLE playlists (
        id TEXT PRIMARY KEY,
        name TEXT
      )
    ''');
}

Future<void> _insertInitialValues(Database database) async {
  await database.insert('playlists', {'name': 'all', 'id': Uuid().v4()});
}

FutureOr<void> _onCreate(Database database, int version) async {
  await _createVideosTable(database);
  await _createPlaylistsTable(database);
  await _createPVMiddleTable(database);
  await _insertInitialValues(database);
}

Future<Database> _openDatabase() async {
  // Get the database path
  final dbPath = await getDatabasesPath();

  // Set the database path
  final path = join(dbPath, 'tamadrop_database.db');

  // db instance to return
  // Open the database and define tables
  final db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await _onCreate(db, version);
    },
  );
  return db;
}
