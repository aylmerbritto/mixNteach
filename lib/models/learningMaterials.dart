import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:mixnteach/models/modelConstants.dart';

class learningMaterials {
  var id;
  var name;
  var tag;
  var materialType;
  var path;
  var date;
  var mConstants = modelConstants();
  learningMaterials({
    this.id = 0,
    this.name = '',
    this.tag = '',
    this.materialType = '',
    this.path = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'tag': this.tag,
      'materialType': this.materialType,
      'path': this.path,
    };
  }

  @override
  String toString() {
    return 'learningMaterials{id: $id, name: $name, tag: $tag,materialType: $materialType,path:$path}';
  }
}

class learningMaterialsUtils extends learningMaterials {
  dbFunction() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = await openDatabase(
      join(await getDatabasesPath(), 'teachApp.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS learningMaterials (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, tag TEXT DEFAULT noTag, date DATETIME DEFAULT CURRENT_TIMESTAMP, materialType TEXT, path TEXT )',
        );
      },
      onOpen: (db) {
        print("creating learning materials table");
        return db.execute(
          'CREATE TABLE IF NOT EXISTS learningMaterials (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, tag TEXT DEFAULT noTag, date DATETIME DEFAULT CURRENT_TIMESTAMP, materialType TEXT, path TEXT )',
        );
      },
      version: 1,
    );
    print(database);
    return database;
  }

  Future<void> insertLearningMaterial() async {
    final db = await dbFunction();
    db.execute(
      'CREATE TABLE IF NOT EXISTS learningMaterials (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, tag TEXT DEFAULT noTag, date DATETIME DEFAULT CURRENT_TIMESTAMP, materialType TEXT, path TEXT )',
    );
    await db.insert(
      mConstants.learningMaterialsTable,
      this.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted material");
  }

  Future<List<learningMaterials>> getLearningMaterials(
      {String tagName = ''}) async {
    try {
      final db = await dbFunction();
      if (tagName == '') {
        final List<Map<String, dynamic>> maps =
            await db.query(this.mConstants.learningMaterialsTable);
        return List.generate(maps.length, (i) {
          return learningMaterials(
            id: maps[i]['id'],
            name: maps[i]['name'],
            tag: maps[i]['tag'],
            materialType: maps[i]['materialType'],
            path: maps[i]['path'],
          );
        });
      } else {
        final List<Map<String, dynamic>> maps = await db.query(
            this.mConstants.learningMaterialsTable,
            where: 'tag = ?',
            whereArgs: [tagName]);
        return List.generate(maps.length, (i) {
          return learningMaterials(
            id: maps[i]['id'],
            name: maps[i]['name'],
            tag: maps[i]['tag'],
            materialType: maps[i]['materialType'],
            path: maps[i]['path'],
          );
        });
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> updateLearningMaterial(
      learningMaterials learningMaterial) async {
    final db = await dbFunction();
    await db.update(
      this.mConstants.learningMaterialsTable,
      learningMaterial.toMap(),
      where: 'id = ?',
      whereArgs: [learningMaterial.id],
    );
  }

  Future<bool> deleteLearningMaterial(id) async {
    final db = await dbFunction();
    print(id);
    await db.delete(
      this.mConstants.learningMaterialsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    print(await getLearningMaterials());
    return true;
  }
}
