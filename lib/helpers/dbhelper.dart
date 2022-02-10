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
    final path = join(directory.path, "watchList.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Watch_list (id INTEGER PRIMARY KEY AUTOINCREMENT, movieID TEXT, movieTitle TEXT, moviePoster TEXT, movieYear TEXT, isWatched INTEGER DEFAULT 0)');
      },
    );
  }

  Future<int> addItem(MovieModel item) async {
    final db = await init();

    return db.insert('Watch_list', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<MovieModel>> fetchMovieList() async {
    final db = await init();
    final maps = await db.query("Watch_list");

    return List.generate(maps.length, (i) {
      return MovieModel(
        movieId: maps[i]['movieID'].toString(),
        movieTitle: maps[i]['movieTitle'].toString(),
        moviePoster: maps[i]['moviePoster'].toString(),
        movieYear: maps[i]['movieYear'].toString(),
      );
    });
  }

  Future<List<MovieModel>> getMovieById(String movieID) async {
    final db = await init();
    final maps = await db
        .query('Watch_list', where: "movieID = ?", whereArgs: [movieID]);

    return List.generate(maps.length, (i) {
      return MovieModel(
        movieId: maps[i]['movieID'].toString(),
        movieTitle: maps[i]['movieTitle'].toString(),
        moviePoster: maps[i]['moviePoster'].toString(),
        movieYear: maps[i]['movieYear'].toString(),
      );
    });
  }

  Future<List<MovieModel>> getUnwatchMovie() async {
    final db = await init();
    final maps =
        await db.query("Watch_list", where: "isWatched = ?", whereArgs: [0]);

    return List.generate(maps.length, (i) {
      return MovieModel(
        movieId: maps[i]['movieID'].toString(),
        movieTitle: maps[i]['movieTitle'].toString(),
        moviePoster: maps[i]['moviePoster'].toString(),
        movieYear: maps[i]['movieYear'].toString(),
      );
    });
  }

  Future<List<MovieModel>> getWatchedMovie() async {
    final db = await init();
    final maps =
        await db.query("Watch_list", where: "isWatched = ?", whereArgs: [1]);

    return List.generate(maps.length, (i) {
      return MovieModel(
        movieId: maps[i]['movieID'].toString(),
        movieTitle: maps[i]['movieTitle'].toString(),
        moviePoster: maps[i]['moviePoster'].toString(),
        movieYear: maps[i]['movieYear'].toString(),
      );
    });
  }

  Future<int> updateToUnwatch(String movieID, MovieModel item) async {
    final db = await init();

    int result = await db.update('Watch_list', item.toMap(),
        where: "movieID = ? ", whereArgs: [movieID]);

    return result;
  }

  Future<int> updateToDone(String movieID, MovieModel item) async {
    final db = await init();

    int result = await db.update('Watch_list', item.toMap(),
        where: "movieID = ?", whereArgs: [movieID]);

    return result;
  }

  Future<int> deleteItem(String movieID) async {
    final db = await init();

    int result = await db
        .delete('Watch_list', where: "movieID = ?", whereArgs: [movieID]);

    return result;
  }
}
