import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/MovieModel.dart';
import 'dart:io';
import 'dart:async';

class MovieDbProvider {
  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "moviesList.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE movie_list(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        movieID TEXT
      )""");
    });
  }

  Future<int> addItem(MovieModel item) async {
    final db = await init();

    return db.insert('movie_list', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<MovieModel>> fetchMovieList() async {
    final db = await init();
    final maps = await db.query("movie_list");

    return List.generate(maps.length, (i) {
      return MovieModel(
        movieId: maps[i]['movieID'].toString(),
      );
    });
  }

  Future<List<MovieModel>> getMovieById(String movieID) async {
    final db = await init();
    final maps = await db
        .query('movie_list', where: "movieID = ?", whereArgs: [movieID]);

    return List.generate(maps.length, (i) {
      return MovieModel(movieId: maps[i]['movieID'].toString());
    });
  }

  Future<int> deleteItem(String movieID) async {
    final db = await init();

    int result = await db
        .delete('movie_list', where: "movieID = ?", whereArgs: [movieID]);

    return result;
  }
}
