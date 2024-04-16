import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../base_model/note_class.dart';

class NoteService {
  static Database? _database;
  static const String tableName = 'notes';

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            color INTEGER,
            isFavourite INTEGER DEFAULT 0
          )
          ''',
        );
      },
    );
  }

  static Future<List<Note>> fetchNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM $tableName');
    return List.generate(maps.length, (i) {
      Color noteColor;
      if (maps[i]['color'] != null) {
        noteColor = Color(maps[i]['color']);
      } else {
        noteColor = Colors.white;
      }

      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        color: noteColor,
        isFavourite: (maps[i]['isFavourite'] == 1 ? true : false),
      );
    });
  }

  static Future<void> addOrUpdateNote(Note note) async {
    final db = await database;
    print(note.id);
    if (note.id != null && note.id != 0) {
      await db.rawUpdate(
        'UPDATE $tableName SET title = ?, content = ? ,color =?,isFavourite = ? WHERE id = ?',
        [
          note.title,
          note.content,
          note.color.value,
          note.isFavourite.value ? 1 : 0,
          note.id,
        ],
      );
    } else {
      int id = await db.rawInsert(
        'INSERT INTO $tableName (title, content, isFavourite) VALUES (?, ?, ?)',
        [note.title, note.content, note.isFavourite.value ? 1 : 0],
      );
      note.id = id;
    }
  }

  static Future<void> deleteNote(int? id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }
}
