import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:mixnteach/models/modelConstants.dart';

class tags {
  var id;
  var tagName;
  var mConstants = modelConstants();
  tags({this.id = 0, this.tagName = ''});

  Map<String, dynamic> toMap() {
    return {'tagName': this.tagName};
  }

  @override
  String toString() {
    return 'tags{id: $id, tagName: $tagName}';
  }
}

class tagsUtils extends tags {
  dbFunctionTags() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'teachApp.db'),
      onCreate: (db, version) {
        print("CREATINGGGGGGGGGGGG DATABASE");
        return db.execute(
          'CREATE TABLE IF NOT EXISTS tags(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tagName TEXT)',
        );
      },
      onOpen: (Database db) {
        print("CREATINGGGGGGGGGGGG DATABASE");
        return db.execute(
          'CREATE TABLE IF NOT EXISTS tags(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tagName TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertTags() async {
    final db = await dbFunctionTags();
    db.execute(
      'CREATE TABLE IF NOT EXISTS tags(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, tagName TEXT)',
    );
    await db.insert(
      mConstants.tagsTable,
      this.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted Tags successfully");
  }

  Future<List<tags>> getTags() async {
    final db = await dbFunctionTags();
    final List<Map<String, dynamic>> maps =
        await db.query(this.mConstants.tagsTable);
    return List.generate(maps.length, (i) {
      return tags(id: maps[i]['id'], tagName: maps[i]['tagName']);
    });
  }

  Future<void> updateTags(tags tag) async {
    final db = await dbFunctionTags();
    await db.update(
      this.mConstants.tagsTable,
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<void> deleteTags(int id) async {
    final db = await dbFunctionTags();
    await db.delete(
      this.mConstants.tagsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<String>> getTagsList() async {
    var tagLists = await getTags();
    var tagNames = <String>[];
    for (var i = 0; i < tagLists.length; i++) {
      tagNames.add(tagLists[i].tagName);
    }
    return tagNames;
  }
}
